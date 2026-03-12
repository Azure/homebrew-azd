class AzdATPrerelease < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002092/azd-darwin-amd64.zip"
      sha256 "ca0a5080bde1ab0d4fcc9a345b7d936e844943d20b72915fd5d1b4519ba07b6b"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002092/azd-darwin-arm64.zip"
      sha256 "3b1b6bf7f58db76d2830d862ed6d766b8f2eb4d7bfcaef30364c6a854b6d371a"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002092/azd-linux-amd64.tar.gz"
      sha256 "4485b22161dc6d34a0504610b7025877862b9255fb8b643fc74ec0e17df8f1ea"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002092/azd-linux-arm64.tar.gz"
      sha256 "b5bd05b6100dcf723e2a1ecf93d1838d56124e5e9d072cf4b42907ab176de578"
    end
  end

  version "1.24.0-beta.1-daily.6002092"
  
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

