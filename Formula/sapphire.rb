class Sapphire < Formula
  desc "Terminal-first AI assistant for software development"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/0760a85eb53500d34ce9613abe8579b25d73dd5e.tar.gz"
  sha256 "4fe28d3fa7034752ccd65e6d7f80a85fdd402e621d3089efa29d41f2966131e1"
  license "FSL-1.1-MIT"
  version "1.1.7.main.422.20260517195137"

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
