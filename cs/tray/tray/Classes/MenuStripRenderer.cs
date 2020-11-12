using System.Drawing;
using System.Windows.Forms;

namespace tray.Classes
{
    public class MenuStripRenderer : ToolStripProfessionalRenderer
    {
        public MenuStripRenderer() : base(new MenuStripColors()) { }
    }

    public class MenuStripColors : ProfessionalColorTable
    {
        public override Color MenuItemSelected => Color.FromArgb(255, 40, 42, 54);
    }
}
