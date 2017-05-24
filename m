Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966209AbdEXTxk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:53:40 -0400
Date: Wed, 24 May 2017 20:53:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH v2 3/3] iio: adc: Fix polling of INA219 conversion ready
 flag
Message-ID: <20170524205335.166b7085@kernel.org>
In-Reply-To: <7cc7733c6bc8407bb4d5233e9407c0d8@rwthex-w2-b.rwth-ad.de>
References: <20170524000907.7788-1-stefan.bruens@rwth-aachen.de>
        <7cc7733c6bc8407bb4d5233e9407c0d8@rwthex-w2-b.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 24 May 2017 02:09:07 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> While the INA226 has a conversion ready flag (CVRF) in the R/W Mask/Enable
> register with read-to-clear semantics, the corresponding bit of the INA219
> (CNVR) is part of the bus voltage register. The flag is cleared by reading
> the power register.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Again, looks good to me, but I would like input form Marc or Andrew
who are more familiar with these devices than me!

Ping me in a week or two if nothing is happening and I look to have
lost these!

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ina2xx-adc.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 232c0b80d658..68884d26b50c 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -44,6 +44,7 @@
>  
>  #define INA226_MASK_ENABLE		0x06
>  #define INA226_CVRF			BIT(3)
> +#define INA219_CNVR			BIT(1)
>  
>  #define INA2XX_MAX_REGISTERS            8
>  
> @@ -592,6 +593,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	int bit, ret, i = 0;
>  	s64 time_a, time_b;
>  	unsigned int alert;
> +	int cnvr_need_clear = 0;
>  
>  	time_a = iio_get_time_ns(indio_dev);
>  
> @@ -603,22 +605,30 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	 * we check the ConVersionReadyFlag.
>  	 * On hardware that supports using the ALERT pin to toggle a
>  	 * GPIO a triggered buffer could be used instead.
> -	 * For now, we pay for that extra read of the ALERT register
> +	 * For now, we do an extra read of the MASK_ENABLE register (INA226)
> +	 * resp. the BUS_VOLTAGE register (INA219).
>  	 */
>  	if (!chip->allow_async_readout)
>  		do {
> -			ret = regmap_read(chip->regmap, INA226_MASK_ENABLE,
> -					  &alert);
> +			if (chip->config->chip_id == ina226) {
> +				ret = regmap_read(chip->regmap,
> +						  INA226_MASK_ENABLE, &alert);
> +				alert &= INA226_CVRF;
> +			} else {
> +				ret = regmap_read(chip->regmap,
> +						  INA2XX_BUS_VOLTAGE, &alert);
> +				alert &= INA219_CNVR;
> +				cnvr_need_clear = alert;
> +			}
> +
>  			if (ret < 0)
>  				return ret;
>  
> -			alert &= INA226_CVRF;
>  		} while (!alert);
>  
>  	/*
> -	 * Single register reads: bulk_read will not work with ina226
> -	 * as there is no auto-increment of the address register for
> -	 * data length longer than 16bits.
> +	 * Single register reads: bulk_read will not work with ina226/219
> +	 * as there is no auto-increment of the register pointer.
>  	 */
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>  			 indio_dev->masklength) {
> @@ -630,6 +640,18 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  			return ret;
>  
>  		data[i++] = val;
> +
> +		if (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_POWER)
> +			cnvr_need_clear = 0;
> +	}
> +
> +	/* Dummy read on INA219 power register to clear CNVR flag */
> +	if (cnvr_need_clear && chip->config->chip_id == ina219) {
> +		unsigned int val;
> +
> +		ret = regmap_read(chip->regmap, INA2XX_POWER, &val);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	time_b = iio_get_time_ns(indio_dev);

