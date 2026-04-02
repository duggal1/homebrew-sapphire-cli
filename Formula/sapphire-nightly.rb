class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/9e2e59476283416814cb5ada72c267d665f4f863.tar.gz"
  sha256 "3fffe9a1e10f393c53861bfd2d5c456c9aa2d9471be2afebdf9aff3928028a2e"
  license "FSL-1.1-MIT"
  version "1.1.7.nightly.420.9e2e594"

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
