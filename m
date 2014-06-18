Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63702 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbaFROp6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 10:45:58 -0400
Message-ID: <53A1A718.8010806@linux.intel.com>
Date: Wed, 18 Jun 2014 07:50:00 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>
CC: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com, t.figa@samsung.com,
	myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com
Subject: Re: [PATCH 3/5] iio: light: cm36651: Use devm_* APIs
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com> <1403072503-29246-4-git-send-email-beomho.seo@samsung.com>
In-Reply-To: <1403072503-29246-4-git-send-email-beomho.seo@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/17/2014 11:21 PM, Beomho Seo wrote:
> This patch changes APIs from request_threaded_irq()
> and iio_device_register() to devm_* APIS.
> Using them make code simpler.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>   drivers/iio/light/cm36651.c |   11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 39fc67e..2fd9579 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -679,7 +679,8 @@ static int cm36651_probe(struct i2c_client *client,
>   		goto error_i2c_unregister_ara;
>   	}
>
> -	ret = request_threaded_irq(client->irq, NULL, cm36651_irq_handler,
> +	ret = devm_request_threaded_irq(&client->dev, client->irq,
> +					NULL, cm36651_irq_handler,
>   					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>   							"cm36651", indio_dev);
>   	if (ret) {
> @@ -687,16 +688,14 @@ static int cm36651_probe(struct i2c_client *client,
>   		goto error_i2c_unregister_ara;
>   	}
>
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
May not be correct. As this driver needs to disable some regulator in 
remove path, it is suggested not to use devm_xx here,

Thanks,
Srinivas

>   	if (ret) {
>   		dev_err(&client->dev, "%s: regist device failed\n", __func__);
> -		goto error_free_irq;
> +		goto error_i2c_unregister_ara;
>   	}
>
>   	return 0;
>
> -error_free_irq:
> -	free_irq(client->irq, indio_dev);
>   error_i2c_unregister_ara:
>   	i2c_unregister_device(cm36651->ara_client);
>   error_i2c_unregister_ps:
> @@ -711,9 +710,7 @@ static int cm36651_remove(struct i2c_client *client)
>   	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>   	struct cm36651_data *cm36651 = iio_priv(indio_dev);
>
> -	iio_device_unregister(indio_dev);
>   	regulator_disable(cm36651->vled_reg);
> -	free_irq(client->irq, indio_dev);
>   	i2c_unregister_device(cm36651->ps_client);
>   	i2c_unregister_device(cm36651->ara_client);
>
>

