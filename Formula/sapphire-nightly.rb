class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/5d9aabb0ace8bc27d74205bc906a5b3766b74450.tar.gz"
  sha256 "8fa45057cdada5597e87875dacc8ba2d4ec1bd4e7cdd2dfa61df51c4aeb5ef1d"
  license "FSL-1.1-MIT"
  version "0.0.0-nightly-5d9aabb"

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
