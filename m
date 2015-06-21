Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44086 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbFUN5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:57:04 -0400
Message-ID: <5586C2AE.0@kernel.org>
Date: Sun, 21 Jun 2015 14:57:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, irina.tirdea@intel.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magn: bmc150: decouple buffer and trigger
References: <1434097899-13984-1-git-send-email-vlad.dogaru@intel.com> <1434097899-13984-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1434097899-13984-2-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/15 09:31, Vlad Dogaru wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Applied to the togreg branch of iio.git. Pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 69 +++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index d4c1788..a0e64f1 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -588,17 +588,6 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int bmc150_magn_validate_trigger(struct iio_dev *indio_dev,
> -					struct iio_trigger *trig)
> -{
> -	struct bmc150_magn_data *data = iio_priv(indio_dev);
> -
> -	if (data->dready_trig != trig)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
>  						struct device_attribute *attr,
>  						char *buf)
> @@ -659,7 +648,6 @@ static const struct iio_info bmc150_magn_info = {
>  	.attrs = &bmc150_magn_attrs_group,
>  	.read_raw = bmc150_magn_read_raw,
>  	.write_raw = bmc150_magn_write_raw,
> -	.validate_trigger = bmc150_magn_validate_trigger,
>  	.driver_module = THIS_MODULE,
>  };
>  
> @@ -682,7 +670,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  					   pf->timestamp);
>  
>  err:
> -	iio_trigger_notify_done(data->dready_trig);
> +	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -827,6 +815,27 @@ static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static int bmc150_magn_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct bmc150_magn_data *data = iio_priv(indio_dev);
> +
> +	return bmc150_magn_set_power_state(data, true);
> +}
> +
> +static int bmc150_magn_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct bmc150_magn_data *data = iio_priv(indio_dev);
> +
> +	return bmc150_magn_set_power_state(data, false);
> +}
> +
> +static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
> +	.preenable = bmc150_magn_buffer_preenable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.predisable = iio_triggered_buffer_predisable,
> +	.postdisable = bmc150_magn_buffer_postdisable,
> +};
> +
>  static int bmc150_magn_gpio_probe(struct i2c_client *client)
>  {
>  	struct device *dev;
> @@ -932,16 +941,6 @@ static int bmc150_magn_probe(struct i2c_client *client,
>  			goto err_poweroff;
>  		}
>  
> -		ret = iio_triggered_buffer_setup(indio_dev,
> -						 &iio_pollfunc_store_time,
> -						 bmc150_magn_trigger_handler,
> -						 NULL);
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"iio triggered buffer setup failed\n");
> -			goto err_trigger_unregister;
> -		}
> -
>  		ret = request_threaded_irq(client->irq,
>  					   iio_trigger_generic_data_rdy_poll,
>  					   NULL,
> @@ -951,14 +950,24 @@ static int bmc150_magn_probe(struct i2c_client *client,
>  		if (ret < 0) {
>  			dev_err(&client->dev, "request irq %d failed\n",
>  				client->irq);
> -			goto err_buffer_cleanup;
> +			goto err_trigger_unregister;
>  		}
>  	}
>  
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 iio_pollfunc_store_time,
> +					 bmc150_magn_trigger_handler,
> +					 &bmc150_magn_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"iio triggered buffer setup failed\n");
> +		goto err_free_irq;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "unable to register iio device\n");
> -		goto err_free_irq;
> +		goto err_buffer_cleanup;
>  	}
>  
>  	ret = pm_runtime_set_active(&client->dev);
> @@ -976,12 +985,11 @@ static int bmc150_magn_probe(struct i2c_client *client,
>  
>  err_iio_unregister:
>  	iio_device_unregister(indio_dev);
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
>  err_free_irq:
>  	if (client->irq > 0)
>  		free_irq(client->irq, data->dready_trig);
> -err_buffer_cleanup:
> -	if (data->dready_trig)
> -		iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
>  	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
> @@ -1000,14 +1008,13 @@ static int bmc150_magn_remove(struct i2c_client *client)
>  	pm_runtime_put_noidle(&client->dev);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	if (client->irq > 0)
>  		free_irq(data->client->irq, data->dready_trig);
>  
> -	if (data->dready_trig) {
> -		iio_triggered_buffer_cleanup(indio_dev);
> +	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
> -	}
>  
>  	mutex_lock(&data->mutex);
>  	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
