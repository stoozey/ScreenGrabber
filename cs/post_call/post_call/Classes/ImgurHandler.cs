using System;
using System.Collections.Specialized;
using System.IO;
using System.Net;
using System.Xml.Linq;


namespace post_call.Classes
{
	public class ImgurHandler
	{
		public static string ClientId;

		public static void UploadToImgur(string _filename)
		{
			using (var w = new WebClient())
			{
				var values = new NameValueCollection
				{
					{ "oauth_consumer_key", "f39da0f79c4e379edfefe79ccab29c8a" },
					{ "photo", Convert.ToBase64String(File.ReadAllBytes(_filename)) }
				};

				var response = w.UploadValues("https://up.flickr.com/services/upload", values);

				Console.WriteLine(XDocument.Load(new MemoryStream(response)));
			}
		}
	}
}