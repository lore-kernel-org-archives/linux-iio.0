Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58141 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684AbbAZVRR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jan 2015 16:17:17 -0500
Message-ID: <54C6AEDC.90001@kernel.org>
Date: Mon, 26 Jan 2015 21:17:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Varka Bhadram <varkabhadram@gmail.com>, linux-iio@vger.kernel.org
CC: lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH iio v2 3/3] imu: inv_mpu6050: cleanup on error check
References: <1421897884-32663-1-git-send-email-varkab@cdac.in> <1421897884-32663-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1421897884-32663-4-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/15 03:38, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
Applied etc.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index ab8c85a..844610c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -120,29 +120,28 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  					  "%s-dev%d",
>  					  indio_dev->name,
>  					  indio_dev->id);
> -	if (st->trig == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	if (!st->trig)
> +		return -ENOMEM;
> +
>  	ret = devm_request_irq(&indio_dev->dev, st->client->irq,
>  			       &iio_trigger_generic_data_rdy_poll,
>  			       IRQF_TRIGGER_RISING,
>  			       "inv_mpu",
>  			       st->trig);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
> +
>  	st->trig->dev.parent = &st->client->dev;
>  	st->trig->ops = &inv_mpu_trigger_ops;
>  	iio_trigger_set_drvdata(st->trig, indio_dev);
> +
>  	ret = iio_trigger_register(st->trig);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
> +
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  
>  	return 0;
> -
> -error_ret:
> -	return ret;
>  }
>  
>  void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
> 

