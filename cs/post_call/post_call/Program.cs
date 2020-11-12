using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Media.Imaging;
using Config.Net;
using post_call.Classes;
using post_call.Interfaces;

using Clipboard = System.Windows.Clipboard;

namespace post_call
{
	internal static class Program
	{
		private const string _CMD_COPY_TO_CLIPBOARD	= "copy_to_clipboard";
		private const string _CMD_SAVE_TO_FILE		= "save_to_file";
		private const string _CMD_UPLOAD_TO_WEB		= "upload_to_web";
		
		private static ImgurHandler imgurHandler;
		
		private static IConfig config;
		private static Dictionary<string, Task> commands;
		
		[STAThread]
		public static void Main(string[] _args)
		{
			if (_args.Length < 2) return;
			
			var filename = _args[0];
			if (!File.Exists(filename))
			{
				Console.WriteLine("File does not exist!");
				return;
			}
			
			InitValues(filename);

			foreach (var commandName in _args)
			{
				if (commandName == filename) continue;

				// cheap workaround for async stuff in a console app, be ashamed of yourself, jo.
				if (commandName == _CMD_UPLOAD_TO_WEB)
				{
					UploadToWeb(filename).GetAwaiter().GetResult();
					continue;
				}
				
				commands[commandName].RunSynchronously();
			}
		}

		#region Commands
		
		private static void CopyToClipboard(string _filename)
		{
			Console.WriteLine("Trying to copy to clipboard...");

			BitmapSource bSource = new BitmapImage(new Uri(_filename));
			Clipboard.SetImage(bSource);
					
			Console.WriteLine("Success!");
		}

		private static void SaveToFile(string _filename)
		{
			Console.WriteLine("Trying to save to file...");
			
			var dateString = ((config.UseAmericanDates) ? "MM-dd-yyyy hh-mm-ss tt" : "dd-MM-yyyy hh-mm-ss tt");
			var fileExportName = "ScreenGrabber - " + DateTime.Now.ToString(dateString) + ".png";
			
			if (!config.ShowFileSaveDialog)
			{
				var picturesDir = Environment.GetFolderPath(Environment.SpecialFolder.MyPictures)+ @"\ScreenGrabber\";
				if (!Directory.Exists(picturesDir))
					Directory.CreateDirectory(picturesDir);

				var fileExportPath = picturesDir + fileExportName;
				File.Copy(_filename, fileExportPath);

				if (config.OpenExplorerAfterSave) OpenImageInExplorer(fileExportPath);
				
				return;
			}
			
			using (var sFile = new SaveFileDialog())
			{
				sFile.InitialDirectory	= Environment.GetFolderPath(Environment.SpecialFolder.MyPictures);
				sFile.AddExtension		= true;
				sFile.DefaultExt		= "png";
				sFile.FileName			= fileExportName;
				sFile.Filter			= "|All files *.*";
				sFile.Title				= "Select where to save the screenshot";

				var result = sFile.ShowDialog();
				if (result == DialogResult.Cancel)
				{
					Console.WriteLine("Failure: User cancelled save dialog");
					return;
				}

				File.Copy(_filename, sFile.FileName);

				if (config.OpenExplorerAfterSave) OpenImageInExplorer(sFile.FileName);
			}
			
			Console.WriteLine("Success!");
		}

		private static async Task UploadToWeb(string _filename)
		{
			Console.WriteLine("Trying to upload to Imgur...");

			var imageUrl = await imgurHandler.UploadToImgur(_filename);
			Process.Start(imageUrl);
			
			Console.WriteLine("Success!");
		}
		
		#endregion
		
		#region Helpers

		private static void OpenImageInExplorer(string _filename)
			=> Process.Start("explorer.exe", $"/select, \"{_filename}\"");

		#endregion
		
		#region Init
		
		private static void InitValues(string _filename)
		{
			config = new ConfigurationBuilder<IConfig>()
				.UseIniFile($@"{Directory.GetCurrentDirectory()}\post_call_config.ini")
				.Build();
			
			imgurHandler = new ImgurHandler(config.ImgurClientId);

			commands = new Dictionary<string, Task>()
			{
				{ _CMD_COPY_TO_CLIPBOARD,	new Task( () => CopyToClipboard(_filename)) },
				{ _CMD_SAVE_TO_FILE,		new Task( () => SaveToFile(_filename)) },
				{ _CMD_UPLOAD_TO_WEB,		new Task( () => UploadToWeb(_filename).Wait() ) },
			};
		}
		
		#endregion
	}
}