class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/a024c0eeaec7a3b136340f3136d5b78fec2ac4b3.tar.gz"
  sha256 "06240ca5ab0023aa7ca3fa78bf6c8512ec20b30ecaa864d9c2d500e66fb6dd98"
  license "FSL-1.1-MIT"
  version "0.0.0-nightly-a024c0e"

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
