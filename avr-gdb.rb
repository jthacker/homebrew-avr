require 'formula'

class AvrGdb < Formula

    homepage 'http://www.gnu.org/software/gdb/'
    url "http://ftp.gnu.org/gnu/gdb/gdb-7.8.2.tar.gz"
    mirror "http://ftpmirror.gnu.org/gnu/gdb/gdb-7.8.2.tar.gz"
    sha256 "fd9a9784ca24528aac8a4e6b8d7ae7e8cf0784e128cd67a185c986deaf6b9929"

    depends_on 'avr-binutils'

    def install
        args = [
            "--target=avr",
            "--prefix=#{prefix}",

            "--disable-nls",
            "--disable-libssp",
            "--disable-install-libbfd",
            "--disable-install-libiberty",

            "--with-gmp=#{Formula["gmp"].opt_prefix}",
            "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
            "--with-mpc=#{Formula["libmpc"].opt_prefix}",
            "--with-cloog=#{Formula["cloog"].opt_prefix}",
            "--with-isl=#{Formula["isl"].opt_prefix}"
        ]

        mkdir 'build' do
            system "../configure", *args
            system "make"

            ENV.deparallelize
            system "make install"
        end

        # info conflicts with binutils
        info.rmtree
    end
end
