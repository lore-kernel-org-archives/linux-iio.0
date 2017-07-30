Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754232AbdG3RAZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Jul 2017 13:00:25 -0400
Date: Sun, 30 Jul 2017 18:00:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 04/11] iio: adc: ti-ads1015: avoid getting stale
 result after runtime resume
Message-ID: <20170730180022.5ba51f78@kernel.org>
In-Reply-To: <1501427575-31045-5-git-send-email-akinobu.mita@gmail.com>
References: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
        <1501427575-31045-5-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 31 Jul 2017 00:12:48 +0900
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
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index fcfa570..8905f0d 100644
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
> @@ -630,6 +637,8 @@ static int ads1015_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> +	data->conv_invalid = true;
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
>  		goto err_buffer_cleanup;
> @@ -685,10 +694,15 @@ static int ads1015_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct ads1015_data *data = iio_priv(indio_dev);
> +	int ret;
>  
> -	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> +	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
>  				  ADS1015_CFG_MOD_MASK,
>  				  ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
> +	if (!ret)
> +		data->conv_invalid = true;
> +
> +	return ret;
>  }
>  #endif
>  

