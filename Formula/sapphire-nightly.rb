class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/68a3f1c65fefe53b157012f9078d5ec6afc23bd7.tar.gz"
  sha256 "38489014c6efbf1b46acbb2e4c96a125d2e93f2f0b354b6affca7dd0848fd728"
  license "FSL-1.1-MIT"
  version "0.0.0-nightly-68a3f1c"

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
