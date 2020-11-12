using Config.Net;

namespace post_call.Interfaces
{
	public interface IConfig
	{
		[Option(Alias = "api_imgur_client_id")]
		string ImgurClientId { get; }

		[Option(Alias = "use_american_dates")]
		bool UseAmericanDates { get; }

		[Option(Alias = "open_explorer_after_save")]
		bool OpenExplorerAfterSave { get; }
		
		[Option(Alias = "show_file_save_dialog")]
		bool ShowFileSaveDialog { get; }
	}
}