Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57089 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762378Ab3JQVuQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:50:16 -0400
Message-ID: <526069C7.8030902@kernel.org>
Date: Thu, 17 Oct 2013 23:50:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 06/11] staging:iio:hmc5843: Rename _configure() to
 _set_mode()
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net> <1381961954-25596-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-7-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 23:19, Peter Meerwald wrote:
> and be consistent with other setter functions in that first argument
> is hmc5843_data
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 5204b9a..d7ace70 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -131,12 +131,18 @@ struct hmc5843_data {
>  };
>  
>  /* The lower two bits contain the current conversion mode */
> -static s32 hmc5843_configure(struct i2c_client *client,
> -				       u8 operating_mode)
> +static s32 hmc5843_set_mode(struct hmc5843_data *data, u8 operating_mode)
>  {
> -	return i2c_smbus_write_byte_data(client,
> -					HMC5843_MODE_REG,
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_write_byte_data(data->client, HMC5843_MODE_REG,
>  					operating_mode & HMC5843_MODE_MASK);
> +	if (ret >= 0)
> +		data->operating_mode = operating_mode;
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
>  }
>  
>  static int hmc5843_wait_measurement(struct hmc5843_data *data)
> @@ -495,7 +501,7 @@ static void hmc5843_init(struct hmc5843_data *data)
>  {
>  	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
>  	hmc5843_set_rate(data, HMC5843_RATE_DEFAULT);
> -	hmc5843_configure(data->client, HMC5843_MODE_CONVERSION_CONTINUOUS);
> +	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
>  	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
>  		HMC5843_RANGE_GAIN_DEFAULT);
>  }
> @@ -562,7 +568,7 @@ static int hmc5843_remove(struct i2c_client *client)
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	 /*  sleep mode to save power */
> -	hmc5843_configure(client, HMC5843_MODE_SLEEP);
> +	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
>  
>  	return 0;
>  }
> @@ -570,9 +576,10 @@ static int hmc5843_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int hmc5843_suspend(struct device *dev)
>  {
> -	hmc5843_configure(to_i2c_client(dev), HMC5843_MODE_SLEEP);
> +	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
>  
> -	return 0;
> +	return hmc5843_set_mode(data, HMC5843_MODE_SLEEP);
>  }
>  
>  static int hmc5843_resume(struct device *dev)
> @@ -580,9 +587,7 @@ static int hmc5843_resume(struct device *dev)
>  	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
>  
> -	hmc5843_configure(data->client, data->operating_mode);
> -
> -	return 0;
> +	return hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
>  }
>  
>  static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_suspend, hmc5843_resume);
> 
