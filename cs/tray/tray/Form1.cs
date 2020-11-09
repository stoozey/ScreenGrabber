using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Input;
using GlobalHotKey;
using tray.Classes;

namespace tray
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var success = RegisterHotKey(Handle, GetType().GetHashCode(), 0x0000, 0x2C);
            if (success) return;

            ShowError(
                "Something is already hooked to the printscreen button.\nPlease close that application and restart this to use the shortcut."
            );
        }

        #region Helper stuff

        private void ShowError(string _message)
        {
            MessageBox.Show(
                _message,
                "Whoops",
                MessageBoxButtons.OK,
                MessageBoxIcon.Exclamation
            );
        }

        #endregion

        #region Hotkey stuff

        [DllImport("user32.dll")]
        public static extern bool RegisterHotKey(IntPtr hWnd, int id, int fsModifiers, int vlc);
        //[DllImport("user32.dll")]
        //public static extern bool UnregisterHotKey(IntPtr hWnd, int id);

        protected override void WndProc(ref Message m)
        {
            if (m.Msg == 0x0312)
            {
                TakeScreenshot();
            }

            base.WndProc(ref m);
        }

        #endregion

        #region Tray button stuff

        private void TryStartProgram(string _filename, string _argument = null, bool _allowInfiniteOpen = false)
        {
            if ((!_allowInfiniteOpen) && (App.IsProcessOpen(Path.GetFileNameWithoutExtension(_filename)))) return;

            if (!File.Exists(_filename))
            {
                ShowError($"ScreenGrabber:\nTried to run \"{_filename}\", but the file did not exist!\nConsider re-installing ScreenGrabber, go to Info > Website.");

                return;
            }

            switch (_argument == null)
            {
                case true: Process.Start(_filename); break;
                case false: Process.Start(_filename, _argument); break;
            }
        }

        private void RunGrabClient(string _argument = null)
            => TryStartProgram($@"{Directory.GetCurrentDirectory()}\data\grab_client.exe", _argument);

        private void TakeScreenshot()
            => TryStartProgram($@"{Directory.GetCurrentDirectory()}\data\grab_client.exe");

        private void takeScreenshotToolStripMenuItem_Click(object sender, EventArgs e)
            => TakeScreenshot();
        // CHANGE TO SETTINGS APP
        private void settingsToolStripMenuItem_Click(object sender, EventArgs e)
            => RunGrabClient("rm_settings");

        private void twitterToolStripMenuItem_Click(object sender, EventArgs e)
            => Process.Start("https://twitter.com/stoozey_");

        private void applicationWebsiteToolStripMenuItem_Click(object sender, EventArgs e)
            => Process.Start("https://stoozey.itch.io/screengrabber");

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
            => Close();

        #endregion

    }
}
