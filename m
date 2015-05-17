Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59080 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbEQJ14 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 05:27:56 -0400
Message-ID: <55585F1B.3060601@kernel.org>
Date: Sun, 17 May 2015 10:27:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>,
	srinivas.pandruvada@linux.intel.com, irina.tirdea@intel.com,
	octavian.purdila@intel.com, linux-iio@vger.kernel.org
CC: adriana.reus@intel.com
Subject: Re: [PATCH 2/2] iio: gyro: bmg160: decouple buffer and triggers
References: <1431523809-13824-1-git-send-email-vlad.dogaru@intel.com> <1431523809-13824-3-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1431523809-13824-3-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 14:30, Vlad Dogaru wrote:
> Make it possible to use buffering with an external trigger, such as one
> based on sysfs or hrtimer.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Thanks,

Glad to see these sort of restrictions being relaxed.

Jonathan
> ---
>  drivers/iio/gyro/bmg160.c | 56 +++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index d36af62..460bf71 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -737,17 +737,6 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static int bmg160_validate_trigger(struct iio_dev *indio_dev,
> -				   struct iio_trigger *trig)
> -{
> -	struct bmg160_data *data = iio_priv(indio_dev);
> -
> -	if (data->dready_trig != trig && data->motion_trig != trig)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 400 1000 2000");
>  
>  static IIO_CONST_ATTR(in_anglvel_scale_available,
> @@ -809,7 +798,6 @@ static const struct iio_info bmg160_info = {
>  	.write_event_value	= bmg160_write_event,
>  	.write_event_config	= bmg160_write_event_config,
>  	.read_event_config	= bmg160_read_event_config,
> -	.validate_trigger	= bmg160_validate_trigger,
>  	.driver_module		= THIS_MODULE,
>  };
>  
> @@ -984,6 +972,27 @@ static irqreturn_t bmg160_data_rdy_trig_poll(int irq, void *private)
>  
>  }
>  
> +static int bmg160_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct bmg160_data *data = iio_priv(indio_dev);
> +
> +	return bmg160_set_power_state(data, true);
> +}
> +
> +static int bmg160_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct bmg160_data *data = iio_priv(indio_dev);
> +
> +	return bmg160_set_power_state(data, false);
> +}
> +
> +static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
> +	.preenable = bmg160_buffer_preenable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.predisable = iio_triggered_buffer_predisable,
> +	.postdisable = bmg160_buffer_postdisable,
> +};
> +
>  static int bmg160_gpio_probe(struct i2c_client *client,
>  			     struct bmg160_data *data)
>  
> @@ -1100,16 +1109,16 @@ static int bmg160_probe(struct i2c_client *client,
>  			data->motion_trig = NULL;
>  			goto err_trigger_unregister;
>  		}
> +	}
>  
> -		ret = iio_triggered_buffer_setup(indio_dev,
> -						 iio_pollfunc_store_time,
> -						 bmg160_trigger_handler,
> -						 NULL);
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"iio triggered buffer setup failed\n");
> -			goto err_trigger_unregister;
> -		}
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 iio_pollfunc_store_time,
> +					 bmg160_trigger_handler,
> +					 &bmg160_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"iio triggered buffer setup failed\n");
> +		goto err_trigger_unregister;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -1132,8 +1141,7 @@ static int bmg160_probe(struct i2c_client *client,
>  err_iio_unregister:
>  	iio_device_unregister(indio_dev);
>  err_buffer_cleanup:
> -	if (data->dready_trig)
> -		iio_triggered_buffer_cleanup(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
>  	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
> @@ -1153,9 +1161,9 @@ static int bmg160_remove(struct i2c_client *client)
>  	pm_runtime_put_noidle(&client->dev);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	if (data->dready_trig) {
> -		iio_triggered_buffer_cleanup(indio_dev);
>  		iio_trigger_unregister(data->dready_trig);
>  		iio_trigger_unregister(data->motion_trig);
>  	}
> 

