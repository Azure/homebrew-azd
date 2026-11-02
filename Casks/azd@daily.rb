cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.38.0-beta.1-daily.7027084"

  sha256 arm: "37a52d7fb4c5d6a75881a62709b83c440b23e031b924edd1f3a7d9c9c32113c0",
         intel: "849d71cee49466673aa644b55ddbf121055afc87657202cb448c2b2339b84180",
         arm64_linux: "4e437573ad5e95fbbe0a490aa99fc1eff20291b67dd4b6bb537f01acf170f1d9",
         x86_64_linux: "fb90bf3dfcdacbbf4d3f26d3a268426c61ff1b2f749b755b0e16e7ce57094dc5"

  # File extension differs between mac (.zip) and linux (.tar.gz)
  on_macos do
    # Daily releases are staged in a different storage location to keep the repo
    # releases focused on supported releases.
    url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/#{version}/azd-darwin-#{arch}.zip"
    binary "azd-darwin-#{arch}", target: "azd"
  end

  # File extension differs between mac (.zip) and linux (.tar.gz)
  on_linux do
    # Daily releases are staged in a different storage location to keep the repo
    # releases focused on supported releases.
    url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/#{version}/azd-linux-#{arch}.tar.gz"
    binary "azd-linux-#{arch}", target: "azd"
  end

  name "Azure Developer CLI (Daily)"
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"

  conflicts_with cask: "azd"

  postflight_steps do
    # Set .installed-by.txt to "brew" to configure azd behavior for homebrew-managed installs
    write_file ".installed-by.txt", "brew"
  end

  caveats <<~EOS
    The Azure Developer CLI collects usage data and sends that usage data to Microsoft in order to help us improve your experience.
    You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use.

    Read more about Azure Developer CLI telemetry: https://github.com/Azure/azure-dev#data-collection

    azd may download binaries to ~/.azd/bin and, depending on how azd was used on this machine,
    may download binaries to other users' home directories in their .azd/bin directory.
    These binaries will need to be removed manually upon uninstall.
    To remove such binaries from your home directory, run 'rm -rf ~/.azd/bin'.
  EOS
end

