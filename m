Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:33:16 +0100
Subject: RE: [PATCH 11/16] staging:iio:adc:ad7606 trivial code style fix.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AD1@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-12-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad7606_core.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7606_core.c
> b/drivers/staging/iio/adc/ad7606_core.c index 7ea5232..02b0a5b 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c +++
> b/drivers/staging/iio/adc/ad7606_core.c @@ -329,9 +329,8 @@ static int
> ad7606_request_gpios(struct ad7606_state *st)
>       }
>
>       ret =3D gpio_request_array(gpio_array, ARRAY_SIZE(gpio_array));
> -     if (!ret) {
> +     if (!ret)
>               st->have_os =3D true;
> -     }
>
>       ret =3D gpio_request_one(st->pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
>                              "AD7606_RESET");

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
