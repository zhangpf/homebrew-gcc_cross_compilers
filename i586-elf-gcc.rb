require 'formula'

class I586ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url "http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2"
  sha256 "5f835b04b5f7dd4f4d2dc96190ec1621b8d89f2dc6f638f9f8bc1b1014ba8cad"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "isl"
  depends_on 'i586-elf-binutils'

  def install
    binutils = Formula.factory 'i586-elf-binutils'


    ENV['CC'] = '/usr/local/opt/gcc/bin/gcc-5'
    ENV['CXX'] = '/usr/local/opt/gcc/bin/g++-5'
    ENV['CPP'] = '/usr/local/opt/gcc/bin/cpp-5'
    ENV['LD'] = '/usr/local/opt/gcc/bin/gcc-5'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i586-elf',
                             '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i586-elf", prefix/"i586-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
