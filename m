Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1464616249-3523805-1-git-send-email-arnd@arndb.de>
References: <1464616249-3523805-1-git-send-email-arnd@arndb.de>
Date: Mon, 30 May 2016 15:54:16 +0200
Message-ID: <CAMuHMdUxaSwoabbFP0Q4gOGoE5bq0RkOUPoyF7Z_XF6e9=GsBg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: fix ad7606_spi regression
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ioana Ciornei <ciorneiioana@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org, driverdevel <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 30, 2016 at 3:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> As pointed out by Geert Uytterhoeven, the patch was incorrect
> and breaks the driver, which was fortunately pointed out by
> this gcc warning:
>
> drivers/staging/iio/adc/ad7606_spi.c: In function =E2=80=98ad7606_spi_rea=
d_block=E2=80=99:
> drivers/staging/iio/adc/ad7606_spi.c:34: warning: =E2=80=98data=E2=80=99 =
is used uninitialized in this function
>
> The effect of the patch is that the data is copied into
> a random memory location (from the uninitialized pointer)
> instead of being byteswapped in place.
>
> This adds the initialization for the 'data' variable back
> to restore the original behavior.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Fixes: 87787e5ef727 ("Staging: iio: Fix sparse endian warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
