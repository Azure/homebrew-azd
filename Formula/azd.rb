class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.31.1/azd-darwin-amd64.zip"
      sha256 "f98d220ba83dfc4da4b85bfd1936545da05dfc616e446f43462e8990dd38b324"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.31.1/azd-darwin-arm64.zip"
      sha256 "f0cabf95fa389386914faa8c14f2c5e49b9520eee27c3d56db7fc20ecd80ed24"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.31.1/azd-linux-amd64.tar.gz"
      sha256 "1a9350ec48a0b353f14dbed0b80c49bd55fe6be957dd0dbe5c79ac07bb098493"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.31.1/azd-linux-arm64.tar.gz"
      sha256 "0e1079915d50fa1cc48f4cdceac9309791f23ba5538e4862b01ed4b087273cdb"
    end
  end

  version "1.31.1"
  
  license "MIT"

  def install
    if OS.mac?
      if Hardware::CPU.intel?
        bin.install "azd-darwin-amd64" => "azd"
      elsif Hardware::CPU.arm?
        bin.install "azd-darwin-arm64" => "azd"
      end
    elsif OS.linux?
      if Hardware::CPU.intel?
        bin.install "azd-linux-amd64" => "azd"
      elsif Hardware::CPU.arm?
        bin.install "azd-linux-arm64" => "azd"
      end
    end

    (bin/".installed-by.txt").write "brew"
  end

  def caveats
    caveat = <<~EOS
      The #{desc} collects usage data and sends that usage data to Microsoft in order to help us improve your experience.
      You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use.

      Read more about #{desc} telemetry: https://github.com/Azure/azure-dev#data-collection

      azd may download binaries to ~/.azd/bin and, depending on how azd was used on this machine,
      may download binaries to other users' home directories in their .azd/bin directory.
      These binaries will need to be removed manually upon uninstall.
      To remove such binaries from your home directory, run 'rm -rf ~/.azd/bin'.

    EOS
    caveat
  end

  test do
    version_output = shell_output "#{bin}/azd version"
    assert_equal 0, $CHILD_STATUS.exitstatus
    assert_match "azd version", version_output
  end
end

