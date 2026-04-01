class Sapphire < Formula
  desc "Terminal-first AI assistant for software development"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/b2f7f0b6c30ae3022ee22e09b9519f453454f941.tar.gz"
  sha256 "e3af06b2f13585f1e29dfd351ed3853150cf797e0a382da20216b38c80c51626"
  license "FSL-1.1-MIT"
  version "1.1.7.main.395.20260401213145"

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
