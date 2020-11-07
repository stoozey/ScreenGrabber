using System;
using System.IO;
using System.Windows;
using System.Windows.Media.Imaging;
using Config.Net;
using post_call.Interfaces;

namespace post_call
{
	internal static class Program
	{
		
		
		[STAThread]
		public static void Main(string[] _args)
		{
			var config = new ConfigurationBuilder<IConfig>()
				.UseIniFile($@"{Directory.GetCurrentDirectory()}\config.json")
				.Build();
			
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
			}
			
			Console.WriteLine("Invalid arguments were given.");
		}
	}
}