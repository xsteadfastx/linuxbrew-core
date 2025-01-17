class Gdbgui < Formula
  include Language::Python::Virtualenv

  desc "Modern, browser-based frontend to gdb (gnu debugger)"
  homepage "https://www.gdbgui.com/"
  url "https://files.pythonhosted.org/packages/06/af/2953018117f73a9bcfd0939c7e801b36cff03590f1b52dd7451d8102a021/gdbgui-0.14.0.1.tar.gz"
  sha256 "4f1482b3bafb04d1d1d0b0ac140bb89befdf5456482ed1533734cd5ab1ca0656"
  license "GPL-3.0-only"
  revision 1

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "c5694285a5e01534c2ddd9f38794ee56bf900763d432eeb8459f79dd5b116a56" => :catalina
    sha256 "a82a2f379f9354730b72f5cea442f2627d8c3fd76c0d11ea9dd977a6bdfff6b9" => :mojave
    sha256 "56fcf6ea4eec7533a22aa1a957d05046fa7a4df4c923b7c6bbeea7706fa13f04" => :high_sierra
    sha256 "9a2552397942169548d4e3239b36a263b02064b35bc426ff56f094df95d4c513" => :x86_64_linux
  end

  depends_on "gdb"
  depends_on "python@3.9"

  resource "Brotli" do
    url "https://files.pythonhosted.org/packages/2a/18/70c32fe9357f3eea18598b23aa9ed29b1711c3001835f7cf99a9818985d0/Brotli-1.0.9.zip"
    sha256 "4d1b810aa0ed773f81dceda2cc7b403d01057458730e309856356d4ef4188438"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e/click-7.1.2.tar.gz"
    sha256 "d2b5255c7c6349bc1bd1e59e08cd12acbbd63ce649f2588755783aa94dfb6b1a"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/67/d0/639a9b5273103a18c5c68a7a9fc02b01cffa3403e72d553acec444f85d5b/dnspython-2.0.0.zip"
    sha256 "044af09374469c3a39eeea1a146e8cac27daec951f1f1f157b1962fc7cb9d1b7"
  end

  resource "eventlet" do
    url "https://files.pythonhosted.org/packages/2a/df/943d5aa7029b47dd3eb41e1ea48f843d3441d24b7e0b76a0b3af4df35a83/eventlet-0.25.2.tar.gz"
    sha256 "4c8ab42c51bff55204fef43cff32616558bedbc7538d876bb6a96ce820c7f9ed"
  end

  resource "Flask" do
    url "https://files.pythonhosted.org/packages/32/57/3c33fe153ea008e9e0202eb028972178337c55777686aac03f41ade671f8/Flask-0.12.5.tar.gz"
    sha256 "fac2b9d443e49f7e7358a444a3db5950bdd0324674d92ba67f8f1f15f876b14f"
  end

  resource "Flask-Compress" do
    url "https://files.pythonhosted.org/packages/a0/96/cd684c1ffe97b513303b5bfd4bbfb4114c5f4a5ea8a737af6fd813273df8/Flask-Compress-1.5.0.tar.gz"
    sha256 "f367b2b46003dd62be34f7fb1379938032656dca56377a9bc90e7188e4289a7c"
  end

  resource "Flask-SocketIO" do
    url "https://files.pythonhosted.org/packages/5d/94/6f55de2fd72f1d7f7eb17cd6045a50581e7c66d53580fc93fd607a5cd630/Flask-SocketIO-2.9.6.tar.gz"
    sha256 "f49edfd3a44458fbb9f7a04a57069ffc0c37f000495194f943a25d370436bb69"
  end

  resource "gevent" do
    url "https://files.pythonhosted.org/packages/5a/79/2c63d385d017b5dd7d70983a463dfd25befae70c824fedb857df6e72eff2/gevent-1.5.0.tar.gz"
    sha256 "b2814258e3b3fb32786bb73af271ad31f51e1ac01f33b37426b66cb8491b4c29"
  end

  resource "gevent-websocket" do
    url "https://files.pythonhosted.org/packages/98/d2/6fa19239ff1ab072af40ebf339acd91fb97f34617c2ee625b8e34bf42393/gevent-websocket-0.10.1.tar.gz"
    sha256 "7eaef32968290c9121f7c35b973e2cc302ffb076d018c9068d2f5ca8b2d85fb0"
  end

  resource "greenlet" do
    url "https://files.pythonhosted.org/packages/20/5e/b989a19f4597b825f44125345cd8a8574216fae7fafe69e2cb1238ebd18a/greenlet-0.4.16.tar.gz"
    sha256 "6e06eac722676797e8fce4adb8ad3dc57a1bb3adfb0dd3fdf8306c055a38456c"
  end

  resource "itsdangerous" do
    url "https://files.pythonhosted.org/packages/68/1a/f27de07a8a304ad5fa817bbe383d1238ac4396da447fa11ed937039fa04b/itsdangerous-1.1.0.tar.gz"
    sha256 "321b033d07f2a4136d3ec762eac9f16a10ccd60f53c0c91af90217ace7ba1f19"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/64/a7/45e11eebf2f15bf987c3bc11d37dcc838d9dc81250e67e4c5968f6008b6c/Jinja2-2.11.2.tar.gz"
    sha256 "89aab215427ef59c34ad58735269eb58b1a5808103067f7bb9d5836c651b3bb0"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz"
    sha256 "29872e92839765e546828bb7754a68c418d927cd064fd4708fab9fe9c8bb116b"
  end

  resource "monotonic" do
    url "https://files.pythonhosted.org/packages/19/c1/27f722aaaaf98786a1b338b78cf60960d9fe4849825b071f4e300da29589/monotonic-1.5.tar.gz"
    sha256 "23953d55076df038541e648a53676fb24980f7a1be290cdda21300b3bc21dfb0"
  end

  resource "pygdbmi" do
    url "https://files.pythonhosted.org/packages/30/01/9523d5ed7bccf7f94927b3dc7a616c9b4a8dfe57df89e67571d32d87717a/pygdbmi-0.10.0.0.tar.gz"
    sha256 "0706b81404a77f78f8b51db43205e94a7ac8fd7ce87b6eac2681baadeff85826"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/e2/07/25bd93c9c0175adfa5fb1513a20b25e7dd6c9a67c155e19b11b5f3662104/Pygments-2.7.1.tar.gz"
    sha256 "926c3f319eda178d1bd90851e4317e6d8cdb5e292a3386aac9bd75eca29cf9c7"
  end

  resource "python-engineio" do
    url "https://files.pythonhosted.org/packages/e7/f5/64651d4ef2fc8921de33c010a8531916a5bdabd87cd0da66ea6b56c52239/python-engineio-3.13.2.tar.gz"
    sha256 "36b33c6aa702d9b6a7f527eec6387a2da1a9a24484ec2f086d76576413cef04b"
  end

  resource "python-socketio" do
    url "https://files.pythonhosted.org/packages/6e/e2/515be319ec39bdf9d3344fb591b60f787b52e413fbb0cb3b5362d83bf037/python-socketio-4.6.0.tar.gz"
    sha256 "358d8fbbc029c4538ea25bcaa283e47f375be0017fcba829de8a3a731c9df25a"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "Werkzeug" do
    url "https://files.pythonhosted.org/packages/c3/1d/1c0761d9365d166dc9d882a48c437111d22b0df564d6d5768045d9a51fd0/Werkzeug-0.16.1.tar.gz"
    sha256 "b353856d37dec59d6511359f97f6a4b2468442e454bd1c98298ddce53cac1f04"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/gdbgui -v").strip
    port = free_port

    fork do
      # Work around a gevent/greenlet bug
      # https://github.com/cs01/gdbgui/issues/359
      ENV["PURE_PYTHON"] = "1"
      exec bin/"gdbgui", "-n", "-p", port.to_s
    end
    sleep 3

    assert_match "gdbgui - gdb in a browser", shell_output("curl -s 127.0.0.1:#{port}")
  end
end
