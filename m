Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:25:17 +0100
Subject: RE: [PATCH 08/16] staging:iio:adc:ad799x set the device name only
 once.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AC0@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-9-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x_core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 304d9ae..879b9d8 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -879,7 +879,6 @@ static int
> __devinit ad799x_probe(struct i2c_client *client,
>       indio_dev->dev.parent =3D &client->dev;
>       indio_dev->name =3D id->name;
>       indio_dev->info =3D st->chip_info->info;
> -     indio_dev->name =3D id->name;
>
>       indio_dev->modes =3D INDIO_DIRECT_MODE;
>       indio_dev->channels =3D st->chip_info->channel;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
