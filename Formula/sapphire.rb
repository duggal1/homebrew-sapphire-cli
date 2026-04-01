class Sapphire < Formula
  desc "Terminal-first AI assistant for software development"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/ae0ae763322db23d4540c94fbfb8d5fd9e3e5802.tar.gz"
  sha256 "184d2cbfb8576a381ec52cf668c4c36997029daae625d60504c1c845d3b8c4ed"
  license "FSL-1.1-MIT"
  version "1.1.7.main.391.20260401130123"

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
