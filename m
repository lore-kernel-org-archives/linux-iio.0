Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:50346 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab0KVP4D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Nov 2010 10:56:03 -0500
Message-ID: <4CEA941D.8050302@cam.ac.uk>
Date: Mon, 22 Nov 2010 16:02:37 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: dac: ad5446: Enable driver support for
 AD5620/AD5640/AD5660 DA converters
References: <1290431172-30876-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290431172-30876-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/22/10 13:06, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Initial support for single channel, 12-/14-/16-Bit nanoDAC with On-Chip Reference
> 
Hi Michael,

A few comments inline, but all trivial requests for docs or suggestions
to improve (in my opinion) readability.  Nothing important hence...
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/Kconfig  |    6 +-
>  drivers/staging/iio/dac/ad5446.c |  126 ++++++++++++++++++++++++++++++++------
>  drivers/staging/iio/dac/ad5446.h |   35 ++++++++---
>  3 files changed, 138 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index 9c497cc..9191bd2 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -11,11 +11,11 @@ config AD5624R_SPI
>  	  AD5664R convertors (DAC). This driver uses the common SPI interface.
>  
>  config AD5446
> -	tristate "Analog Devices AD5444, AD5446 and AD5541A, AD5512A DAC SPI driver"
> +	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5541A/12A DAC SPI driver"
>  	depends on SPI
>  	help
> -	  Say yes here to build support for Analog Devices AD5444, AD5446
> -	  and AD5541A, AD5512A DACs.
> +	  Say yes here to build support for Analog Devices AD5444, AD5446,
> +	  AD5620, AD5640, AD5660 and AD5541A, AD5512A DACs.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5446.
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index ac3165b..4a5f7e1 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -23,6 +23,31 @@
>  
>  #include "ad5446.h"
>  
> +static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
> +{
> +	st->data16 = cpu_to_be16(AD5446_LOAD |
> +					(val << st->chip_info->left_shift));
> +}
> +
> +static void ad5542_store_sample(struct ad5446_state *st, unsigned val)
> +{
> +	st->data16 = cpu_to_be16(val << st->chip_info->left_shift);
> +}
> +
> +static void ad5620_store_sample(struct ad5446_state *st, unsigned val)
> +{
> +	st->data16 = cpu_to_be16(AD5620_LOAD |
> +					(val << st->chip_info->left_shift));
> +}
> +
> +static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
> +{
> +	val |= AD5660_LOAD;
> +	st->data24[0] = val >> 16;
> +	st->data24[1] = val >> 8;
> +	st->data24[2] = val;
Obviously it will have no actual effect, but for clarity when reading I'd prefer
to see these masked to the right length. & 0xFF;  Saves people checking what the
type of data24 is.
> +}
> +
>  static ssize_t ad5446_write(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf,
> @@ -43,18 +68,7 @@ static ssize_t ad5446_write(struct device *dev,
>  	}
>  
>  	mutex_lock(&dev_info->mlock);
> -	switch (spi_get_device_id(st->spi)->driver_data) {
> -	case ID_AD5444:
> -	case ID_AD5446:
> -			st->data = cpu_to_be16(AD5446_LOAD |
> -					(val << st->chip_info->left_shift));
> -			break;
> -	case ID_AD5542A:
> -	case ID_AD5512A:
> -			st->data = cpu_to_be16(val << st->chip_info->left_shift);
> -			break;
> -	}
> -
> +	st->chip_info->store_sample(st, val);
>  	ret = spi_sync(st->spi, &st->msg);
>  	mutex_unlock(&dev_info->mlock);
>  
> @@ -105,24 +119,76 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.storagebits = 16,
>  		.left_shift = 2,
>  		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5446] = {
>  		.bits = 14,
>  		.storagebits = 16,
>  		.left_shift = 0,
>  		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.store_sample = ad5446_store_sample,
>  	},
>  	[ID_AD5542A] = {
>  		.bits = 16,
>  		.storagebits = 16,
>  		.left_shift = 0,
>  		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.store_sample = ad5542_store_sample,
>  	},
>  	[ID_AD5512A] = {
>  		.bits = 12,
>  		.storagebits = 16,
>  		.left_shift = 4,
>  		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.store_sample = ad5542_store_sample,
> +	},
> +	[ID_AD5620_2500] = {
I see from the data sheet that these parts have slightly different numbers
(ad5620-1, ad5620-2),
but that what you have here is probably a clearer way of putting it. However,
I'd like to see a comment (perhaps in the header) explaining why you have used
these names, mainly to stop others thinking this is the way to handle the case
where this reference is controllable (unlike here).
> +		.bits = 12,
> +		.storagebits = 16,
> +		.left_shift = 2,
> +		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
Is there ever likely to be a signed dac supported by this driver?
If not I'd suggest a follow up patch to get rid of this element
and just hard code it where needed.

> +		.int_vref_mv = 2500,
> +		.store_sample = ad5620_store_sample,
> +	},
> +	[ID_AD5620_1250] = {
> +		.bits = 12,
> +		.storagebits = 16,
> +		.left_shift = 2,
> +		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.int_vref_mv = 1250,
> +		.store_sample = ad5620_store_sample,
> +	},
> +	[ID_AD5640_2500] = {
> +		.bits = 14,
> +		.storagebits = 16,
> +		.left_shift = 0,
> +		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.int_vref_mv = 2500,
> +		.store_sample = ad5620_store_sample,
> +	},
> +	[ID_AD5640_1250] = {
> +		.bits = 14,
> +		.storagebits = 16,
> +		.left_shift = 0,
> +		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.int_vref_mv = 1250,
> +		.store_sample = ad5620_store_sample,
> +	},
> +	[ID_AD5660_2500] = {
> +		.bits = 16,
> +		.storagebits = 24,
> +		.left_shift = 0,
> +		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.int_vref_mv = 2500,
> +		.store_sample = ad5660_store_sample,
> +	},
> +	[ID_AD5660_1250] = {
> +		.bits = 16,
> +		.storagebits = 24,
> +		.left_shift = 0,
> +		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
> +		.int_vref_mv = 1250,
> +		.store_sample = ad5660_store_sample,
>  	},
>  };
>  
> @@ -168,16 +234,34 @@ static int __devinit ad5446_probe(struct spi_device *spi)
>  
>  	/* Setup default message */
>  
> -	st->xfer.tx_buf = &st->data,
> -	st->xfer.len = 2,
> +	if (st->chip_info->storagebits == 24)
> +		st->xfer.tx_buf = &st->data24;
> +	else if (st->chip_info->storagebits == 16)
> +		st->xfer.tx_buf = &st->data16;
> +	else
> +		BUG();
> +
> +	st->xfer.len = st->chip_info->storagebits / 8;
>  
>  	spi_message_init(&st->msg);
>  	spi_message_add_tail(&st->xfer, &st->msg);
>  
> -	if (voltage_uv)
> -		st->vref_mv = voltage_uv / 1000;
> -	else
> -		dev_warn(&spi->dev, "reference voltage unspecified\n");
> +	switch (spi_get_device_id(spi)->driver_data) {
> +		case ID_AD5620_2500:
> +		case ID_AD5620_1250:
> +		case ID_AD5640_2500:
> +		case ID_AD5640_1250:
> +		case ID_AD5660_2500:
> +		case ID_AD5660_1250:
> +			st->vref_mv = st->chip_info->int_vref_mv;
> +			break;
> +		default:
> +			if (voltage_uv)
> +				st->vref_mv = voltage_uv / 1000;
> +			else
> +				dev_warn(&spi->dev,
> +					 "reference voltage unspecified\n");
> +	}
>  
>  	ret = iio_device_register(st->indio_dev);
>  	if (ret)
> @@ -217,6 +301,12 @@ static const struct spi_device_id ad5446_id[] = {
>  	{"ad5446", ID_AD5446},
>  	{"ad5542a", ID_AD5542A},
>  	{"ad5512a", ID_AD5512A},
> +	{"ad5620-2500", ID_AD5620_2500},
> +	{"ad5620-1250", ID_AD5620_1250},
> +	{"ad5640-2500", ID_AD5640_2500},
> +	{"ad5640-1250", ID_AD5640_1250},
> +	{"ad5660-2500", ID_AD5660_2500},
> +	{"ad5660-1250", ID_AD5660_1250},
>  	{}
>  };
>  
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index 24a9cda..f5cea9d 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -15,14 +15,17 @@
>  #define AD5446_NOP		(0x2 << 14) /* No operation */
>  #define AD5446_CLK_RISING	(0x3 << 14) /* Clock data on rising edge */
>  
> -#define RES_MASK(bits)	((1 << (bits)) - 1)
> +#define AD5620_LOAD		(0x0 << 14) /* Load and update Norm Operation*/

Don't think the next 3 are used. Get rid of them until they are needed
(or is there a follow up patch using them on it's way?)
> +#define AD5620_PWRDWN_1k	(0x1 << 14) /* Power-down: 1kOhm to GND */
> +#define AD5620_PWRDWN_100k	(0x2 << 14) /* Power-down: 100kOhm to GND */
> +#define AD5620_PWRDWN_TRISTATE	(0x3 << 14) /* Power-down: Three-state */
>  
> -struct ad5446_chip_info {
> -	u8				bits;		/* number of DAC bits */
> -	u8				storagebits;	/* number of bits written to the DAC */
> -	u8				left_shift;	/* number of bits the datum must be shifted */
> -	char				sign;		/* [s]igned or [u]nsigned */
> -};
> +#define AD5660_LOAD		(0x0 << 16) /* Load and update Norm Operation*/

Same with these.
> +#define AD5660_PWRDWN_1k	(0x1 << 16) /* Power-down: 1kOhm to GND */
> +#define AD5660_PWRDWN_100k	(0x2 << 16) /* Power-down: 100kOhm to GND */
> +#define AD5660_PWRDWN_TRISTATE	(0x3 << 16) /* Power-down: Three-state */
> +
> +#define RES_MASK(bits)	((1 << (bits)) - 1)
>  
>  struct ad5446_state {
>  	struct iio_dev			*indio_dand please also check if these ev;
> @@ -33,7 +36,17 @@ struct ad5446_state {
>  	unsigned short			vref_mv;
>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
> -	unsigned short			data;
> +	unsigned short			data16;
> +	unsigned char			data24[3];
Given only one of the two above can be used for a given chip how about using a union?
That will make it explicit that only one is used, and possibly save a bit of bloat
(if not now, perhaps if the structure is extended in future).
> +};
> +
Would prefer the comments to be kernel doc, but if not, please just check these
lines are not too long. (they look suspicious).
> +struct ad5446_chip_info {
> +	u8				bits;		/* number of DAC bits */
> +	u8				storagebits;	/* number of bits written to the DAC */
> +	u8				left_shift;	/* number of bits the datum must be shifted */
> +	char				sign;		/* [s]igned or [u]nsigned */
> +	u16				int_vref_mv;	/* AD5620/40/60: Internal Vref voltage */
> +	void (*store_sample)		(struct ad5446_state *st, unsigned val);
>  };
>  
>  enum ad5446_supported_device_ids {
> @@ -41,6 +54,12 @@ enum ad5446_supported_device_ids {
>  	ID_AD5446,
>  	ID_AD5542A,
>  	ID_AD5512A,
> +	ID_AD5620_2500,
> +	ID_AD5620_1250,
> +	ID_AD5640_2500,
> +	ID_AD5640_1250,
> +	ID_AD5660_2500,
> +	ID_AD5660_1250,
>  };
>  
>  #endif /* IIO_ADC_AD5446_H_ */

