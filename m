Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:27710
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab1IZHkT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 26 Sep 2011 03:40:19 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:40:19 +0100
Subject: RE: [PATCH 10/16] staging:iio:adc:ad7606 add local define for
 chan_spec structures.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AE0@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-11-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-09-23:
> IIO_CHAN is being phased out and in this case things are so
> simple it makes sense to have a local one parameter equivalent.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad7606_core.c |   82 +++++++++++--------------
>  ------- 1 files changed, 28 insertions(+), 54 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7606_core.c
> b/drivers/staging/iio/adc/ad7606_core.c index 17cdafb..7ea5232 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c +++
> b/drivers/staging/iio/adc/ad7606_core.c @@ -233,69 +233,43 @@ static
> const struct attribute_group ad7606_attribute_group = {
>       .is_visible = ad7606_attr_is_visible,
>  };
> +#define AD7606_CHANNEL(num)                          \
> +     {                                               \
> +             .type = IIO_VOLTAGE,                    \
> +             .indexed = 1,                           \
> +             .channel = num,                         \
> +             .address = num,                         \
> +             .scan_index = num,                      \
> +             .scan_type = IIO_ST('s', 16, 16, 0),    \
> +     }
> +
>  static struct iio_chan_spec ad7606_8_channels[] = {
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              0, 0, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              1, 1, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              2, 2, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              3, 3, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              4, 4, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              5, 5, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              6, 6, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              7, 7, IIO_ST('s', 16, 16, 0), 0),
> +     AD7606_CHANNEL(0),
> +     AD7606_CHANNEL(1),
> +     AD7606_CHANNEL(2),
> +     AD7606_CHANNEL(3),
> +     AD7606_CHANNEL(4),
> +     AD7606_CHANNEL(5),
> +     AD7606_CHANNEL(6),
> +     AD7606_CHANNEL(7),
>       IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>
>  static struct iio_chan_spec ad7606_6_channels[] = {
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              0, 0, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              1, 1, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              2, 2, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              3, 3, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              4, 4, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              5, 5, IIO_ST('s', 16, 16, 0), 0),
> +     AD7606_CHANNEL(0),
> +     AD7606_CHANNEL(1),
> +     AD7606_CHANNEL(2),
> +     AD7606_CHANNEL(3),
> +     AD7606_CHANNEL(4),
> +     AD7606_CHANNEL(5),
>       IIO_CHAN_SOFT_TIMESTAMP(6),
>  };
>
>  static struct iio_chan_spec ad7606_4_channels[] = {
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              0, 0, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              1, 1, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              2, 2, IIO_ST('s', 16, 16, 0), 0),
> -     IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -              (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -              3, 3, IIO_ST('s', 16, 16, 0), 0),
> +     AD7606_CHANNEL(0),
> +     AD7606_CHANNEL(1),
> +     AD7606_CHANNEL(2),
> +     AD7606_CHANNEL(3),
>       IIO_CHAN_SOFT_TIMESTAMP(4),
>  };

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



