using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using Imgur.API.Authentication;
using Imgur.API.Endpoints;

namespace post_call.Classes
{
	public class ImgurHandler
	{
		private readonly string clientId;

		public ImgurHandler(string _clientId)
		{
			//imgur = new Imgur(_clientId);
			clientId = _clientId;
		}

		public async Task<string> UploadToImgur(string _filename)
		{
			var apiClient	= new ApiClient(clientId);
			var httpClient	= new HttpClient();
			
			using var fileStream = File.OpenRead(_filename);

			var imageEndpoint	= new ImageEndpoint(apiClient, httpClient);
			var imageUpload		= await imageEndpoint.UploadImageAsync(fileStream);

			return imageUpload.Link;
		}
	}
}