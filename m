Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbdGOMZt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 08:25:49 -0400
Date: Sat, 15 Jul 2017 13:25:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 5/8] iio: adc: ti-ads1015: avoid getting stale result
 after runtime resume
Message-ID: <20170715132545.437ede29@kernel.org>
In-Reply-To: <1499877124-21658-6-git-send-email-akinobu.mita@gmail.com>
References: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
        <1499877124-21658-6-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 01:32:01 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This driver assumes that the device is operating in the continuous
> conversion mode which performs the conversion continuously.  So this driver
> doesn't insert a wait time before reading the conversion register if the
> configuration is not changed from a previous request.
> 
> This assumption is broken if the device is runtime suspended and entered
> a power-down state.  The forthcoming request causes reading a stale result
> from the conversion register as the device is runtime resumed just before.
> 
> Fix it by adding a flag to detect that condition and insert a necessary
> wait time.
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Another one that wants to be near the head of the series as a fix
that we want to get into stable.

Good catch.

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 984d4bb..f5f256a 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -177,6 +177,12 @@ struct ads1015_data {
>  	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
>  
>  	unsigned int *data_rate;
> +	/*
> +	 * Set to true when the ADC is switched to the continuous-conversion
> +	 * mode and exits from a power-down state.  This flag is used to avoid
> +	 * getting the stale result from the conversion register.
> +	 */
> +	bool conv_invalid;
>  };
>  
>  static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
> @@ -255,9 +261,10 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (change) {
> +	if (change || data->conv_invalid) {
>  		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
>  		usleep_range(conv_time, conv_time + 1);
> +		data->conv_invalid = false;
>  	}
>  
>  	return regmap_read(data->regmap, ADS1015_CONV_REG, val);
> @@ -625,6 +632,8 @@ static int ads1015_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> +	data->conv_invalid = true;
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
>  		goto err_buffer_cleanup;
> @@ -676,8 +685,13 @@ static int ads1015_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct ads1015_data *data = iio_priv(indio_dev);
> +	int ret;
>  
> -	return ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
> +	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
> +	if (!ret)
> +		data->conv_invalid = true;
> +
> +	return ret;
>  }
>  #endif
>  

