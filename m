Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJUW7l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Oct 2018 18:59:41 -0400
Date: Sun, 21 Oct 2018 15:45:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] iio: adc: ina2xx: add in early -EINVAL returns in
 case statements
Message-ID: <20181021154503.5141163f@archlinux>
In-Reply-To: <3078823.PklSZE2rHu@pebbles>
References: <20181016161418.29213-1-colin.king@canonical.com>
        <3078823.PklSZE2rHu@pebbles>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 16 Oct 2018 20:26:57 +0200
Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de> wrote:

> On Dienstag, 16. Oktober 2018 18:14:18 CEST Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > Static analysis with CoverityScan is throwing warnings that specific
> > case statements are missing breaks.  Rather than adding breaks, add
> > return -EINVAL to the specific case statements to clarify the
> > error return paths. Fix also saves 50 bytes.
> >=20
> > Before:
> >    text	   data	    bss	    dec	    hex	filename
> >   21418	   4936	    128	  26482	   6772	drivers/iio/adc/ina2xx-adc.o
> >=20
> > After:
> >   dec	    hex	filename
> >   21370	   4936	    128	  26434	   6742	drivers/iio/adc/ina2xx-adc.o
> >=20
> > (gcc 8.2, x86-64)
> >=20
> > Detected by CoverityScan, CID#1462408 ("Missing break in switch")
> >=20
> > ---
> >=20
> > V2: use returns instead of break statements to keep with the
> > current style used in the switch statement.
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com> =20
>=20
> Reviewed-by: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>

Thanks, and applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Note however that I was confused when there appeared to be no sign off
in the patch from Colin after applying.  It ended up below an
additional cut line so git am dropped it.

All fixed up now.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/adc/ina2xx-adc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > index d1239624187d..bdd7cba6f6b0 100644
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,
> >  			*val2 =3D chip->shunt_resistor_uohm;
> >  			return IIO_VAL_FRACTIONAL;
> >  		}
> > +		return -EINVAL;
> >=20
> >  	case IIO_CHAN_INFO_HARDWAREGAIN:
> >  		switch (chan->address) {
> > @@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,
> >  			*val =3D chip->range_vbus =3D=3D 32 ? 1 : 2;
> >  			return IIO_VAL_INT;
> >  		}
> > +		return -EINVAL;
> >  	}
> >=20
> >  	return -EINVAL; =20
>=20
>=20
