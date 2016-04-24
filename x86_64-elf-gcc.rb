require 'formula'

class X8664ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url "http://ftpmirror.gnu.org/gcc/gcc-5.3.0/gcc-5.3.0.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.bz2"
  sha256 "b84f5592e9218b73dbae612b5253035a7b34a9a1f7688d2e1bfaaf7267d5c4db"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "isl"
  depends_on 'x86_64-elf-binutils'

  def install
    binutils = Formula.factory 'x86_64-elf-binutils'

    ENV['CC'] = '/usr/local/opt/gcc/bin/gcc-5'
    ENV['CXX'] = '/usr/local/opt/gcc/bin/g++-5'
    ENV['CPP'] = '/usr/local/opt/gcc/bin/cpp-5'
    ENV['LD'] = '/usr/local/opt/gcc/bin/gcc-5'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-elf','--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"x86_64-elf", prefix/"x86_64-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
