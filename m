Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58135 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbbAZVP7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jan 2015 16:15:59 -0500
Message-ID: <54C6AE8C.6030909@kernel.org>
Date: Mon, 26 Jan 2015 21:15:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Varka Bhadram <varkabhadram@gmail.com>, linux-iio@vger.kernel.org
CC: lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH iio v2 1/3] imu: inv_mpu6050: use devm_iio_trigger_alloc
References: <1421897884-32663-1-git-send-email-varkab@cdac.in> <1421897884-32663-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1421897884-32663-2-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/15 03:38, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 926fcce..c827d21 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -116,9 +116,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  	int ret;
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
> -	st->trig = iio_trigger_alloc("%s-dev%d",
> -					indio_dev->name,
> -					indio_dev->id);
> +	st->trig = devm_iio_trigger_alloc(&indio_dev->dev,
> +					  "%s-dev%d",
> +					  indio_dev->name,
> +					  indio_dev->id);
>  	if (st->trig == NULL) {
>  		ret = -ENOMEM;
>  		goto error_ret;
> @@ -128,7 +129,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  				"inv_mpu",
>  				st->trig);
>  	if (ret)
> -		goto error_free_trig;
> +		goto error_ret;
>  	st->trig->dev.parent = &st->client->dev;
>  	st->trig->ops = &inv_mpu_trigger_ops;
>  	iio_trigger_set_drvdata(st->trig, indio_dev);
> @@ -141,8 +142,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  
>  error_free_irq:
>  	free_irq(st->client->irq, st->trig);
> -error_free_trig:
> -	iio_trigger_free(st->trig);
>  error_ret:
>  	return ret;
>  }
> @@ -151,5 +150,4 @@ void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
>  {
>  	iio_trigger_unregister(st->trig);
>  	free_irq(st->client->irq, st->trig);
> -	iio_trigger_free(st->trig);
>  }
> 

