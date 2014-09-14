Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55806 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbaINRrG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 13:47:06 -0400
Message-ID: <5415D498.90509@kernel.org>
Date: Sun, 14 Sep 2014 18:47:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH v2 01/11] iio:bma180: Enable use of device without IRQ
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net> <1408488206-2633-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1408488206-2633-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/08/14 23:43, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied.
> ---
>  drivers/iio/accel/bma180.c | 54 +++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index a077cc8..f5e26fb 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -529,7 +529,6 @@ static int bma180_probe(struct i2c_client *client,
>  {
>  	struct bma180_data *data;
>  	struct iio_dev *indio_dev;
> -	struct iio_trigger *trig;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -553,29 +552,31 @@ static int bma180_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bma180_info;
>  
> -	trig = iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
> -	if (!trig) {
> -		ret = -ENOMEM;
> -		goto err_chip_disable;
> -	}
> +	if (client->irq > 0) {
> +		data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> +			indio_dev->id);
> +		if (!data->trig) {
> +			ret = -ENOMEM;
> +			goto err_chip_disable;
> +		}
>  
> -	ret = devm_request_irq(&client->dev, client->irq,
> -			iio_trigger_generic_data_rdy_poll,
> -			IRQF_TRIGGER_RISING, BMA180_IRQ_NAME, trig);
> -	if (ret) {
> -		dev_err(&client->dev, "unable to request IRQ\n");
> -		goto err_trigger_free;
> -	}
> +		ret = devm_request_irq(&client->dev, client->irq,
> +			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
> +			BMA180_IRQ_NAME, data->trig);
> +		if (ret) {
> +			dev_err(&client->dev, "unable to request IRQ\n");
> +			goto err_trigger_free;
> +		}
>  
> -	trig->dev.parent = &client->dev;
> -	trig->ops = &bma180_trigger_ops;
> -	iio_trigger_set_drvdata(trig, indio_dev);
> -	data->trig = trig;
> -	indio_dev->trig = trig;
> +		data->trig->dev.parent = &client->dev;
> +		data->trig->ops = &bma180_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +		indio_dev->trig = data->trig;
>  
> -	ret = iio_trigger_register(trig);
> -	if (ret)
> -		goto err_trigger_free;
> +		ret = iio_trigger_register(data->trig);
> +		if (ret)
> +			goto err_trigger_free;
> +	}
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  			bma180_trigger_handler, NULL);
> @@ -595,9 +596,10 @@ static int bma180_probe(struct i2c_client *client,
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
> -	iio_trigger_unregister(trig);
> +	if (data->trig)
> +		iio_trigger_unregister(data->trig);
>  err_trigger_free:
> -	iio_trigger_free(trig);
> +	iio_trigger_free(data->trig);
>  err_chip_disable:
>  	bma180_chip_disable(data);
>  
> @@ -611,8 +613,10 @@ static int bma180_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	iio_trigger_unregister(data->trig);
> -	iio_trigger_free(data->trig);
> +	if (data->trig) {
> +		iio_trigger_unregister(data->trig);
> +		iio_trigger_free(data->trig);
> +	}
>  
>  	mutex_lock(&data->mutex);
>  	bma180_chip_disable(data);
> 
