Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:40:54 +0100
Subject: RE: [PATCH 15/16] staging:iio:adc:ad7606 remove unused chip info
 elements.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AE1@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-16-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-16-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> These are now handled through the chan_spec arrays and no one
> is using them anymore.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad7606.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7606.h
> b/drivers/staging/iio/adc/ad7606.h index 0d1bb26..35018c3 100644 ---
> a/drivers/staging/iio/adc/ad7606.h +++
> b/drivers/staging/iio/adc/ad7606.h @@ -50,8 +50,6 @@ struct
> ad7606_platform_data {
>
>  struct ad7606_chip_info {
>       const char                      *name;
> -     u8                              bits;
> -     char                            sign;
>       u16                             int_vref_mv;
>       struct iio_chan_spec            *channels;
>       unsigned                        num_channels;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
