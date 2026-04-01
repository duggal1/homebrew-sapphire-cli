class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/2894793f37e8e50ea071f825f51f03f242da5e07.tar.gz"
  sha256 "4d95d0a0f5d4979f1dbc0e8f4e5bde78537a08e74ed4d9424f19539210889dbb"
  license "FSL-1.1-MIT"
  version "1.1.7.nightly.398.2894793"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/duggal1/Sapphire-cli/internal/version.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "."

    generate_completions_from_executable(bin/"sapphire", "completion")

    manpage = Utils.safe_popen_read(bin/"sapphire", "man")
    (man1/"sapphire.1").write(manpage)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sapphire --version")
  end
end
