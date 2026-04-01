class Sapphire < Formula
  desc "Terminal-first AI assistant for software development"
  homepage "https://github.com/duggal1/Sapphire-cli"
  url "https://github.com/duggal1/Sapphire-cli/archive/e3e1150d4dd7ab907687e108580e64dbdab63243.tar.gz"
  sha256 "86f991037209565e47b9dea5bed04daa54d0926f91d85cd74cb1f4162771383b"
  license "FSL-1.1-MIT"
  version "1.1.7.main.390.20260401120403"

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
