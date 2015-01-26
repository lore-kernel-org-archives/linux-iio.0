Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58138 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbbAZVQW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jan 2015 16:16:22 -0500
Message-ID: <54C6AEA5.2090203@kernel.org>
Date: Mon, 26 Jan 2015 21:16:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Varka Bhadram <varkabhadram@gmail.com>, linux-iio@vger.kernel.org
CC: lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH iio v2 2/3] imu: inv_mpu6050: use devm_request_irq
References: <1421897884-32663-1-git-send-email-varkab@cdac.in> <1421897884-32663-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1421897884-32663-3-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/15 03:38, Varka Bhadram wrote:
> This patch use the devres API for requesting an IRQ.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
Applied to the togreg branch of iio.git > testing for
autobuilders.

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index c827d21..ab8c85a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -124,10 +124,11 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> -	ret = request_irq(st->client->irq, &iio_trigger_generic_data_rdy_poll,
> -				IRQF_TRIGGER_RISING,
> -				"inv_mpu",
> -				st->trig);
> +	ret = devm_request_irq(&indio_dev->dev, st->client->irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       IRQF_TRIGGER_RISING,
> +			       "inv_mpu",
> +			       st->trig);
>  	if (ret)
>  		goto error_ret;
>  	st->trig->dev.parent = &st->client->dev;
> @@ -135,13 +136,11 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  	iio_trigger_set_drvdata(st->trig, indio_dev);
>  	ret = iio_trigger_register(st->trig);
>  	if (ret)
> -		goto error_free_irq;
> +		goto error_ret;
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  
>  	return 0;
>  
> -error_free_irq:
> -	free_irq(st->client->irq, st->trig);
>  error_ret:
>  	return ret;
>  }
> @@ -149,5 +148,4 @@ error_ret:
>  void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
>  {
>  	iio_trigger_unregister(st->trig);
> -	free_irq(st->client->irq, st->trig);
>  }
> 

