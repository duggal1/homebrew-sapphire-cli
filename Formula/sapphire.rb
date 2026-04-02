class Sapphire < Formula
  desc "Terminal-first AI assistant for software development"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/fecd8e7c0dcbe4e6e25e494f1aa3069e8b269fcb.tar.gz"
  sha256 "9f7e4ff60369e870a714a3c79d6b7f5ec1802408b45b3435c9a17718f0cd0f14"
  license "FSL-1.1-MIT"
  version "1.1.7.main.401.20260402131727"

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
