class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/2bdfb07c05ce56f580fd0ad5630e3b3114e82484.tar.gz"
  sha256 "10cccce74b439f8bbbeb64e27ca3659f4ca6a3e5837cc5141d5ce075d7585730"
  license "FSL-1.1-MIT"
  version "0.0.0-nightly-2bdfb07"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/duggal1/Sapphire-cli/internal/version.Version="
    system "go", "build", *std_go_args(ldflags: ldflags), "."

    generate_completions_from_executable(bin/"sapphire", "completion")

    manpage = Utils.safe_popen_read(bin/"sapphire", "man")
    (man1/"sapphire.1").write(manpage)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sapphire --version")
  end
end
