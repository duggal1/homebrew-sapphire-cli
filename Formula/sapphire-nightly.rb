class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/1320cd0673d9a33f9c5bdb61d2303081d47a329d.tar.gz"
  sha256 "8f8ae1e3e9b71c14c1edff7e0a36c277e8587cdf8c0dfd1980bec9fea6f9ae3f"
  license "FSL-1.1-MIT"
  version "1.1.7.nightly.389.1320cd0"

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
