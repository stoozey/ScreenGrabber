using System;
using System.Diagnostics;
using System.IO;
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
		
		[STAThread]
		public static void Main(string[] _args)
		{
			InitValues();
			
			var filename = _args[1];
			switch (_args[0])
			{
				case "copy_to_clipboard":
				{
					CopyToClipboard(filename);
				} return;
				
				case "save_to_file":
				{
					SaveToFile(filename);
				} return;

				case "copy_and_save_to_file":
				{
					SaveToFile(filename);
					CopyToClipboard(filename);
				} return;

				case "upload_to_web":
				{
					UploadToWeb(filename);
				} return;
			}
			
			Console.WriteLine("Invalid arguments were given.");
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
			
			using (SaveFileDialog sFile = new SaveFileDialog())
			{
				//sFile.InitialDirectory = "";
				sFile.Title = "Select where to save the screenshot";
				sFile.AddExtension = true;
				sFile.DefaultExt = "png";
				sFile.Filter = "|All files *.*";
				
				var _dateString = ((config.UseAmericanDates) ? "MM-dd-yyyy hh-mm-ss tt" : "dd-MM-yyyy hh-mm-ss tt");
				sFile.FileName = "ScreenGrabber - " + DateTime.Now.ToString(_dateString);

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
					
			//ImgurHandler.PublishToImgur(_filename);
			ImgurHandler.UploadToImgur(_filename);

		}
		
		private static void InitValues()
		{
			config = new ConfigurationBuilder<IConfig>()
				.UseIniFile($@"{Directory.GetCurrentDirectory()}\post_call_config.ini")
				.Build();
			
			ImgurHandler.ClientId = config.ImgurClientSecret;
		}
	}
}