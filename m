Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdJHJ6C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 05:58:02 -0400
Date: Sun, 8 Oct 2017 10:57:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 1/3] iio: adc: ina2xx: Mask flag bits in bus voltage
 register
Message-ID: <20171008105757.1465d322@archlinux>
In-Reply-To: <adb12c57-0653-4343-b551-9427d292c5fd@rwthex-w2-a.rwth-ad.de>
References: <20171001194818.26017-1-stefan.bruens@rwth-aachen.de>
        <adb12c57-0653-4343-b551-9427d292c5fd@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 1 Oct 2017 21:48:16 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Lower bits of the INA219/220 bus voltage register are conversion
> status flags, properly mask the value.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

Hi, good to find this issue, but the 'right' fix is perhaps a little
more complex than present here.

Jonathan

> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index f387b972e4f4..361fb4e459d5 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -44,7 +44,6 @@
>  
>  #define INA226_MASK_ENABLE		0x06
>  #define INA226_CVRF			BIT(3)
> -#define INA219_CNVR			BIT(1)
>  
>  #define INA2XX_MAX_REGISTERS            8
>  
> @@ -79,6 +78,11 @@
>  #define INA226_ITS_MASK		GENMASK(5, 3)
>  #define INA226_SHIFT_ITS(val)	((val) << 3)
>  
> +/* INA219 Bus voltage register, low bits are flags */
> +#define INA219_OVF		BIT(0)
> +#define INA219_CNVR		BIT(1)
> +#define INA219_BUS_VOLTAGE_MASK	GENMASK(16, 3)
> +
>  /* Cosmetic macro giving the sampling period for a full P=UxI cycle */
>  #define SAMPLING_PERIOD(c)	((c->int_time_vbus + c->int_time_vshunt) \
>  				 * c->avg)
> @@ -170,6 +174,10 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  		else
>  			*val  = regval;
>  
> +		if ((chip->config->chip_id == ina219) &&
> +		    (chan->address == INA2XX_SHUNT_VOLTAGE))
> +			*val &= INA219_BUS_VOLTAGE_MASK;
> +

This first case is fine - up to the fact that it should really be
shifting it appropriately to not give a false impression of precision.
Also correctly unwinding the case below may require some changes here
as well as the scale will change.

>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> @@ -639,6 +647,10 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  		if (ret < 0)
>  			return ret;
>  
> +		if ((chip->config->chip_id == ina219) &&
> +		    (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_BUS_VOLTAGE))
> +			val &= INA219_BUS_VOLTAGE_MASK;
> +

For this I'm not sure this is the correct fix.   The driver should not be lying
about the available data when describing the channel. Right now the
channel description is:

#define INA219_CHAN_VOLTAGE(_index, _address) { \
	.type = IIO_VOLTAGE, \
	.address = (_address), \
	.indexed = 1, \
	.channel = (_index), \
	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
			      BIT(IIO_CHAN_INFO_SCALE) | \
			      BIT(IIO_CHAN_INFO_INT_TIME), \
	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
	.scan_index = (_index), \
	.scan_type = { \
		.sign = 'u', \
		.realbits = 16, \
		.storagebits = 16, \
		.endianness = IIO_LE, \
	} \
}
Reading the datasheet this should be
.realbits = 13,
.shift = 3,
I think

Userspace is then responsible for masking and shifting the
data to not give a false impression of it's precision.

Clearly this with probably have some knock on effects that
will also need fixing.


>  		data[i++] = val;
>  
>  		if (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_POWER)

