Return-Path: <guenter.roeck@ericsson.com>
Subject: Re: [PATCH V3] hwmon: ad7314 driver (ported from IIO).
From: Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Device-drivers-devel@blackfin.uclinux.org"
 <Device-drivers-devel@blackfin.uclinux.org>
In-Reply-To: <1317315004-1498-1-git-send-email-jic23@cam.ac.uk>
References: <4E849EC4.5070603@cam.ac.uk>
	 <1317315004-1498-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Sep 2011 10:25:19 -0700
Message-ID: <1317317119.3888.164.camel@groeck-laptop>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Thu, 2011-09-29 at 12:50 -0400, Jonathan Cameron wrote:
> Currently dropped power down mode support.
> 
> V3:
> Guenter's suggestions
> - typos
> - DIV_ROUND_NEAREST use
> - Actually register hwmon driver.
> 
> V2: Fixes:
> - messed up use of cache aligned store fixed.
> - correct output format to be milli degrees.
> - add documentation file.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Applied to -next, with one other minor update.

> ---
>  Documentation/hwmon/ad7314 |   25 ++++++
>  drivers/hwmon/Kconfig      |   10 +++
>  drivers/hwmon/Makefile     |    1 +
>  drivers/hwmon/ad7314.c     |  185 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 221 insertions(+), 0 deletions(-)
> 
[ ... ]

> +
> +static const struct spi_device_id ad7314_id[] = {
> +	{ "adt7301", adt7301 },
> +	{ "adt7302", adt7302 },
> +	{ "ad7314", ad7314 },
> +	{}
> +};

MODULE_DEVICE_TABLE(spi, ad7314_id);

Thanks,
Guenter
