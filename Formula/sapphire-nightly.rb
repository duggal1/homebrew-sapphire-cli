class SapphireNightly < Formula
  desc "Terminal-first AI assistant for software development (nightly)"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/92bbf5adea7848fea78defb3c6eed8236fa1fa4e.tar.gz"
  sha256 "6742cbe1f0dccfa10b39dd0f6f27671ac51a72c6447ec62a1bf8af2562f34501"
  license "FSL-1.1-MIT"
  version "1.1.7.nightly.418.92bbf5a"

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
