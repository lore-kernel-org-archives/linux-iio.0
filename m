Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60138 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbaFROsP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 10:48:15 -0400
Message-ID: <53A1A788.2030109@linux.intel.com>
Date: Wed, 18 Jun 2014 07:51:52 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>
CC: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com, t.figa@samsung.com,
	myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com
Subject: Re: [PATCH 4/5] iio: light: gp2ap020a00f: Use devm_* APIs
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com> <1403072503-29246-5-git-send-email-beomho.seo@samsung.com>
In-Reply-To: <1403072503-29246-5-git-send-email-beomho.seo@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/17/2014 11:21 PM, Beomho Seo wrote:
> This patch changes APIs from request_threaded_irq()
> and iio_device_register() to devm_* APIs. Using them make simpler.
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>   drivers/iio/light/gp2ap020a00f.c |   10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 221ed16..1745c6a 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1562,7 +1562,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>   	}
>
>   	/* This needs to be requested here for read_raw calls to work. */
> -	err = request_threaded_irq(client->irq, NULL,
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>   				   &gp2ap020a00f_thresh_event_handler,
>   				   IRQF_TRIGGER_FALLING |
>   				   IRQF_ONESHOT,
> @@ -1581,10 +1581,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>   	err = iio_trigger_register(data->trig);
>   	if (err < 0) {
>   		dev_err(&client->dev, "Failed to register iio trigger.\n");
> -		goto error_free_irq;
> +		goto iio_uninit_buffer;
>   	}
>
> -	err = iio_device_register(indio_dev);
> +	err = devm_iio_device_register(&client->dev, indio_dev);
Same here. driver remove needs to do some shutdown, so devm_xx is 
probably not a good idea.

Thanks,
Srinivas
>   	if (err < 0)
>   		goto error_trigger_unregister;
>
> @@ -1592,8 +1592,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>
>   error_trigger_unregister:
>   	iio_trigger_unregister(data->trig);
> -error_free_irq:
> -	free_irq(client->irq, indio_dev);
>   error_uninit_buffer:
>   	iio_triggered_buffer_cleanup(indio_dev);
>   error_regulator_disable:
> @@ -1613,9 +1611,7 @@ static int gp2ap020a00f_remove(struct i2c_client *client)
>   	if (err < 0)
>   		dev_err(&indio_dev->dev, "Failed to power off the device.\n");
>
> -	iio_device_unregister(indio_dev);
>   	iio_trigger_unregister(data->trig);
> -	free_irq(client->irq, indio_dev);
>   	iio_triggered_buffer_cleanup(indio_dev);
>   	regulator_disable(data->vled_reg);
>
>

