class AzdATPrerelease < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6000022/azd-darwin-amd64.zip"
      sha256 "66da7e57712cf749041ebf4dc1d07a2e71392535450f0a2b8e289d36137f0340"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6000022/azd-darwin-arm64.zip"
      sha256 "a67ffe8297c4fc351b8b4d8e12428e1e9d8fc2503ea63daac53c35f4594204be"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6000022/azd-linux-amd64.tar.gz"
      sha256 "151375deb485cca7e0a6f1e512dcf13bbf62447b8203636043a940ff1d68bab1"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6000022/azd-linux-arm64.tar.gz"
      sha256 "fc292276ebf6382f2886740843b07fcf70aa97f5fca3e6607383faddbc395531"
    end
  end

  version "1.24.0-beta.1-daily.6000022"
  
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

