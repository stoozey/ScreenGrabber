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
		private static IConfig config;
		private static Dictionary<string, Task> commands;
		
		[STAThread]
		public static void Main(string[] _args)
		{
			if (_args.Length < 2) return;
			
			var filename = _args[0];
			InitValues(filename);

			foreach (var commandName in _args)
			{
				if (commandName == filename) continue;

				commands[commandName].RunSynchronously();
			}
		}

		private static void CopyToClipboard(string _filename)
		{
			Console.WriteLine("Trying to copy to clipboard...");
			
			if (!File.Exists(_filename))
			{
				Console.WriteLine("File does not exist!");
				return;
			}
					
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
				
				if (!config.OpenExplorerAfterSave) return;
				Process.Start("explorer.exe", fileExportPath);
				
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

				if (!config.OpenExplorerAfterSave) return;
				Process.Start("explorer.exe", sFile.FileName);
			}

			Console.WriteLine("Success!");
		}

		private static void UploadToWeb(string _filename)
		{
			Console.WriteLine("Trying to upload to Imgur...");
					
			if (!File.Exists(_filename))
			{
				Console.WriteLine("File does not exist!");
				return;
			}
			
			ImgurHandler.UploadToImgur(_filename);

		}
		
		private static void InitValues(string _filename)
		{
			config = new ConfigurationBuilder<IConfig>()
				.UseIniFile($@"{Directory.GetCurrentDirectory()}\post_call_config.ini")
				.Build();
			
			ImgurHandler.ClientId = config.ImgurClientSecret;

			commands = new Dictionary<string, Task>()
			{
				{ "copy_to_clipboard",	new Task( () => CopyToClipboard(_filename)) },
				{ "save_to_file",		new Task( () => SaveToFile(_filename)) },
				{ "upload_to_web",		new Task( () => UploadToWeb(_filename)) },
			};
		}
	}
}