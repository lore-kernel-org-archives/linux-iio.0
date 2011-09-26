Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:24:20 +0100
Subject: RE: [PATCH 03/16] staging:iio:adc:ad799x fix incorrect setting of
 configuration register on single channel read.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272ABE@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-4-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> It is a bit mask whereas current code treats it as a straight value.

That's a NAK.
See MODE 2 - COMMAND MODE: Table 26. Address Pointer Byte.

On the AD7998 and AD7997 the channel is a straight value and not a mask.

>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad799x_core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 975a3f7..3b5f8be 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -123,7 +123,8 @@ static int
> ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
>               break;
>       case ad7997:
>       case ad7998:
> -             cmd =3D (ch << AD799X_CHANNEL_SHIFT) | AD7997_8_READ_SINGLE=
;
> +             cmd =3D ((1 << ch) << AD799X_CHANNEL_SHIFT) |
> +                     AD7997_8_READ_SINGLE;
>               break;
>       default:
>               return -EINVAL;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
