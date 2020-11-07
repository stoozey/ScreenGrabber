using Config.Net;

namespace post_call.Interfaces
{
	public interface IConfig
	{
		[Option(Alias = "api_imgur_client_id")]
		string ImgurClientId { get; }
		//string api_imgur_client_secret { get; }
	}
}