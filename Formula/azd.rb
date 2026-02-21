class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.23.6/azd-darwin-amd64.zip"
      sha256 "fbef0c14cbd145664781f2acfcfd3e21a1b3bf4230ee29b2bc6c796608c39d35"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.23.6/azd-darwin-arm64.zip"
      sha256 "9fefa69e12545743c3cbc5d9a7344e99cd75e2da65babec96d6ca0b2fb067c82"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.23.6/azd-linux-amd64.tar.gz"
      sha256 "01f3a3fc47aafa9fae028a522c3da8da7c6f131228e5cad5b80c01de2b747369"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.23.6/azd-linux-arm64.tar.gz"
      sha256 "e49f5c2ba38538a0c5ec2be46e9cb77faf29a41e0699c3d5fdd634d02104d648"
    end
  end

  version "1.23.6"
  
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

