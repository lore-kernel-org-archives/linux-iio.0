Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
Date: Sun, 22 May 2016 09:56:41 +0200
Message-ID: <CAMuHMdWbavoKYVF_RXtJYoW1x2ms1j3VSC-bFoaQmqKU1V3R4A@mail.gmail.com>
Subject: Re: [PATCH] Staging: iio: Fix sparse endian warning
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	driverdevel <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Ksenija, Greg,

On Wed, Mar 23, 2016 at 12:06 PM, Ksenija Stanojevic
<ksenija.stanojevic@gmail.com> wrote:
> Fix following sparse warning:
> warning: cast to restricted __be16

Please include line number information so we know which line sparse
complains about.

> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7606_spi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/a=
dc/ad7606_spi.c
> index d873a51..825da07 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -21,7 +21,8 @@ static int ad7606_spi_read_block(struct device *dev,
>  {
>         struct spi_device *spi =3D to_spi_device(dev);
>         int i, ret;
> -       unsigned short *data =3D buf;
> +       unsigned short *data;
> +       __be16 *bdata =3D buf;
>
>         ret =3D spi_read(spi, buf, count * 2);
>         if (ret < 0) {
> @@ -30,7 +31,7 @@ static int ad7606_spi_read_block(struct device *dev,
>         }
>
>         for (i =3D 0; i < count; i++)
> -               data[i] =3D be16_to_cpu(data[i]);
> +               data[i] =3D be16_to_cpu(bdata[i]);

This patch is completely bogus:

drivers/staging/iio/adc/ad7606_spi.c: In function =E2=80=98ad7606_spi_read_=
block=E2=80=99:
drivers/staging/iio/adc/ad7606_spi.c:34: warning: =E2=80=98data=E2=80=99 is=
 used uninitialized
in this function

Hence please revert commit 87787e5ef727ff15f7c552cc48823b469f2eb41b
Author: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Date:   Wed Mar 23 12:06:34 2016 +0100

    Staging: iio: Fix sparse endian warning

BTW, what version of sparse are you using?
My (Ubuntu) version of sparse didn't complain about the original, neither d=
oes
the one I've just cloned from the master repository
(v0.5.0-44-g40791b94c56b1a6d)?

Hence I have no idea if fixing this by keeping the assignment of buf to dat=
a
is warned about....

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
