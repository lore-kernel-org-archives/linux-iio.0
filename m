Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56866 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbcCTLDr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 07:03:47 -0400
Subject: Re: [PATCH v7 1/1] iio:pressure:ms5611: fix missing regulator_disable
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1458215358.git.gregor.boirie@parrot.com>
 <34b395320abc2c3d3c11c342ffc9ed37867c8474.1458215358.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE8391.7010708@kernel.org>
Date: Sun, 20 Mar 2016 11:03:45 +0000
MIME-Version: 1.0
In-Reply-To: <34b395320abc2c3d3c11c342ffc9ed37867c8474.1458215358.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/16 11:55, Gregor Boirie wrote:
> Ensure optional regulator is properly disabled when present.
> 
> Fixes: 3145229f9191 ("iio:pressure:ms5611: power regulator support")
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
I've applied this to the togreg branch of iio.git. Decided to do this
rather than fixes as the worst that happens is a regulator gets left
on.  As this support is relatively new and before that it always got
left on, I'm not considering this to important.

Feel free to argue otherwise!

Jonathan
> ---
>  drivers/iio/pressure/ms5611.h      |  3 +++
>  drivers/iio/pressure/ms5611_core.c | 41 +++++++++++++++++++++++++++++---------
>  2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index d725a307..ccda63c 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -16,6 +16,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mutex.h>
>  
> +struct regulator;
> +
>  #define MS5611_RESET			0x1e
>  #define MS5611_READ_ADC			0x00
>  #define MS5611_READ_PROM_WORD		0xA0
> @@ -57,6 +59,7 @@ struct ms5611_state {
>  					  s32 *temp, s32 *pressure);
>  
>  	struct ms5611_chip_info *chip_info;
> +	struct regulator *vdd;
>  };
>  
>  int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 37dbc04..c4e6586 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -387,24 +387,45 @@ static const struct iio_info ms5611_info = {
>  static int ms5611_init(struct iio_dev *indio_dev)
>  {
>  	int ret;
> -	struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
> -	                                           "vdd");
> +	struct ms5611_state *st = iio_priv(indio_dev);
>  
>  	/* Enable attached regulator if any. */
> -	if (!IS_ERR(vdd)) {
> -		ret = regulator_enable(vdd);
> +	st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
> +	if (!IS_ERR(st->vdd)) {
> +		ret = regulator_enable(st->vdd);
>  		if (ret) {
>  			dev_err(indio_dev->dev.parent,
> -			        "failed to enable Vdd supply: %d\n", ret);
> +				"failed to enable Vdd supply: %d\n", ret);
>  			return ret;
>  		}
> +	} else {
> +		ret = PTR_ERR(st->vdd);
> +		if (ret != -ENODEV)
> +			return ret;
>  	}
>  
>  	ret = ms5611_reset(indio_dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_regulator_disable;
> +
> +	ret = ms5611_read_prom(indio_dev);
> +	if (ret < 0)
> +		goto err_regulator_disable;
> +
> +	return 0;
>  
> -	return ms5611_read_prom(indio_dev);
> +err_regulator_disable:
> +	if (!IS_ERR_OR_NULL(st->vdd))
> +		regulator_disable(st->vdd);
> +	return ret;
> +}
> +
> +static void ms5611_fini(const struct iio_dev *indio_dev)
> +{
> +	const struct ms5611_state *st = iio_priv(indio_dev);
> +
> +	if (!IS_ERR_OR_NULL(st->vdd))
> +		regulator_disable(st->vdd);
>  }
>  
>  int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
> @@ -436,7 +457,7 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
>  					 ms5611_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(dev, "iio triggered buffer setup failed\n");
> -		return ret;
> +		goto err_fini;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -449,7 +470,8 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
>  
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> -
> +err_fini:
> +	ms5611_fini(indio_dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ms5611_probe);
> @@ -458,6 +480,7 @@ int ms5611_remove(struct iio_dev *indio_dev)
>  {
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	ms5611_fini(indio_dev);
>  
>  	return 0;
>  }
> 

