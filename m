Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdGOM27 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 08:28:59 -0400
Date: Sat, 15 Jul 2017 13:28:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 6/8] iio: adc: ti-ads1015: use
 devm_iio_triggered_buffer_setup
Message-ID: <20170715132856.4ccb34d0@kernel.org>
In-Reply-To: <1499877124-21658-7-git-send-email-akinobu.mita@gmail.com>
References: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
        <1499877124-21658-7-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 01:32:02 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Use devm_iio_triggered_buffer_setup to simplify the error path in the
> probe() and remove() function.
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index f5f256a..821e649 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -620,9 +620,9 @@ static int ads1015_probe(struct i2c_client *client,
>  		return PTR_ERR(data->regmap);
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -					 ads1015_trigger_handler,
> -					 &ads1015_buffer_setup_ops);
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +					      ads1015_trigger_handler,
> +					      &ads1015_buffer_setup_ops);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>  		return ret;
> @@ -636,7 +636,7 @@ static int ads1015_probe(struct i2c_client *client,
>  
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
> -		goto err_buffer_cleanup;
> +		return ret;
>  	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
>  	pm_runtime_enable(&client->dev);
> @@ -644,15 +644,10 @@ static int ads1015_probe(struct i2c_client *client,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to register IIO device\n");
> -		goto err_buffer_cleanup;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -err_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
>  }
>  
>  static int ads1015_remove(struct i2c_client *client)
> @@ -666,8 +661,6 @@ static int ads1015_remove(struct i2c_client *client)
>  	pm_runtime_set_suspended(&client->dev);
>  	pm_runtime_put_noidle(&client->dev);
>  
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
>  	/* power down single shot mode */
>  	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
Hmm. This does technically change the remove order to not quite be
the reverse of probe.. So I'm not keen from the 'obviously
right' angle rather than because I actually think there is any
problem with doing this.

Jonathan
>  }

