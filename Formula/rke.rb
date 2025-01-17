class Rke < Formula
  desc "Rancher Kubernetes Engine, a Kubernetes installer that works everywhere"
  homepage "https://rancher.com/docs/rke/latest/en/"
  url "https://github.com/rancher/rke/archive/v1.2.2.tar.gz"
  sha256 "c64d6616a6fe65ad0ef1cd65bff98145cbc4d1414377e500770638e5fccd83e1"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "d92779433a89164d07f0f0b74afe21ece4b756ad55835c92e6ebbbade1b8bf5d" => :catalina
    sha256 "2ec8244f28235afa18415036b3ce838c8110577a61d1df9398743c93e29b3fe8" => :mojave
    sha256 "d29c7e6d262b6228bafb5d7643e8166116839552f43e8c0e799d9fb9525c36b7" => :high_sierra
    sha256 "cb7f8a23056cd69dc801d5c05351b50edc342d35179c179b6c4f42b0a1a1ba59" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags",
            "-w -X main.VERSION=v#{version}",
            "-o", bin/"rke"
  end

  test do
    system bin/"rke", "config", "-e"
    assert_predicate testpath/"cluster.yml", :exist?
  end
end
