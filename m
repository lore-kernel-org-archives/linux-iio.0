Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:39091
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab1IZHk0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 26 Sep 2011 03:40:26 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:39:17 +0100
Subject: RE: [PATCH 16/16] staging:iio:adc:ad7887 stop using IIO_CHAN macro.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272ADC@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-17-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-09-23:
> It's going away.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad7887_core.c |   26 ++++++++++++++++++-------
>  - 1 files changed, 18 insertions(+), 8 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7887_core.c
> b/drivers/staging/iio/adc/ad7887_core.c index 71af6cb..37e6cc9 100644
> --- a/drivers/staging/iio/adc/ad7887_core.c +++
> b/drivers/staging/iio/adc/ad7887_core.c @@ -71,14 +71,24 @@ static const
> struct ad7887_chip_info ad7887_chip_info_tbl[] = {
>        * More devices added in future
>        */
>       [ID_AD7887] = {
> -             .channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 12, 16, 0), 0),
> -
> -             .channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 12, 16, 0), 0),
> -
> +             .channel[0] = {
> +                     .type = IIO_VOLTAGE,
> +                     .indexed = 1,
> +                     .channel = 1,
> +                     .info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
> +                     .address = 1,
> +                     .scan_index = 1,
> +                     .scan_type = IIO_ST('u', 12, 16, 0),
> +             },
> +             .channel[1] = {
> +                     .type = IIO_VOLTAGE,
> +                     .indexed = 1,
> +                     .channel = 0,
> +                     .info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
> +                     .address = 0,
> +                     .scan_index = 0,
> +                     .scan_type = IIO_ST('u', 12, 16, 0),
> +             },
>               .channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
>               .int_vref_mv = 2500,
>       },

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



