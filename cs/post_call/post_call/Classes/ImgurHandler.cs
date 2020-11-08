using System;
using System.IO;
using System.Net;
using System.Net.Http;
using Imgur.API.Authentication;
using Imgur.API.Endpoints;

namespace post_call.Classes
{
	public class ImgurHandler
	{
		public static string ClientId;

		private static HttpClient client;
		private static ApiClient apiClient;
		
		public static async void PublishToImgur(string _filename)
		{
			client		= new HttpClient();
			apiClient	= new ApiClient(ClientId);
			
			Console.WriteLine("Starting...");

			var fileStream = File.OpenRead(_filename);
			Console.WriteLine("1...");
			var imageEndpoint = new ImageEndpoint(apiClient, client);
			Console.WriteLine("2...");
			var imageUpload = await imageEndpoint.UploadImageAsync(fileStream);
			
			Console.WriteLine("Upload complete");
			Console.WriteLine(imageUpload.Link);
		}
	}
}