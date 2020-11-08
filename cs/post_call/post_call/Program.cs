using System;
using System.IO;
using System.Windows;
using System.Windows.Media.Imaging;
using Config.Net;
using post_call.Classes;
using post_call.Interfaces;

namespace post_call
{
	internal static class Program
	{
		private static IConfig config;
		
		[STAThread]
		public static void Main(string[] _args)
		{
			InitValues();
			
			switch (_args[0])
			{
				case "copy_to_clipboard":
				{
					Console.WriteLine("Trying to copy to clipboard...");
					
					var filename = _args[1];
					if (!File.Exists(filename))
					{
						Console.WriteLine("File does not exist!");
						return;
					}
					
					BitmapSource bSource = new BitmapImage(new Uri(filename));
					Clipboard.SetImage(bSource);
					
					Console.WriteLine("Success!");
				} return;

				case "upload_to_imgur":
				{
					Console.WriteLine("Trying to upload to Imgur...");
					
					var filename = _args[1];
					if (!File.Exists(filename))
					{
						Console.WriteLine("File does not exist!");
						return;
					}
					
					ImgurHandler.PublishToImgur(filename);
				} return;
			}
			
			Console.WriteLine("Invalid arguments were given.");
		}

		private static void InitValues()
		{
			config = new ConfigurationBuilder<IConfig>()
				.UseIniFile($@"{Directory.GetCurrentDirectory()}\config.json")
				.Build();
			
			ImgurHandler.ClientId = config.ImgurClientId;
		}
	}
}