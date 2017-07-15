Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbdGOMYR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 08:24:17 -0400
Date: Sat, 15 Jul 2017 13:24:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 4/8] iio: adc: ti-ads1015: enable conversion when
 CONFIG_PM is not set
Message-ID: <20170715132414.4080c158@kernel.org>
In-Reply-To: <1499877124-21658-5-git-send-email-akinobu.mita@gmail.com>
References: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
        <1499877124-21658-5-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 01:32:00 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The ADS1015 device have two operating modes, continuous conversion mode
> and single-shot mode.  This driver assumes that the continuous conversion
> mode is selected by runtime resume callback when the ADC result is
> requested.
> 
> If CONFIG_PM is disabled, the device is always in the default single-shot
> mode and no one begins a single conversion.  So the conversion register
> doesn't contain valid ADC result.  Fix it by changing the continuous mode
> in probe function.  This also adds a helper function to set conversion
> mode as there are a fair number of users.
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Two patches please.  First one is a fix to make it work without config_pm
second can do the refactor (and can be applied after the first one
has gone to stable and worked it's way back to our upstream).

Good catch,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 1edf323..984d4bb 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -556,6 +556,13 @@ static void ads1015_get_channels_config(struct i2c_client *client)
>  	}
>  }
>  
> +static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
> +{
> +	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> +				  ADS1015_CFG_MOD_MASK,
> +				  mode << ADS1015_CFG_MOD_SHIFT);
> +}
> +
>  static int ads1015_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -613,6 +620,11 @@ static int ads1015_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
> +
> +	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
> +	if (ret)
> +		return ret;
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
>  		goto err_buffer_cleanup;
> @@ -648,9 +660,7 @@ static int ads1015_remove(struct i2c_client *client)
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	/* power down single shot mode */
> -	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				  ADS1015_CFG_MOD_MASK,
> -				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
> +	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
>  }
>  
>  #ifdef CONFIG_PM
> @@ -659,9 +669,7 @@ static int ads1015_runtime_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  
> -	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				  ADS1015_CFG_MOD_MASK,
> -				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
> +	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
>  }
>  
>  static int ads1015_runtime_resume(struct device *dev)
> @@ -669,9 +677,7 @@ static int ads1015_runtime_resume(struct device *dev)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  
> -	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				  ADS1015_CFG_MOD_MASK,
> -				  ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
> +	return ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
>  }
>  #endif
>  

