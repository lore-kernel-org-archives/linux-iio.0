Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60363 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaH3JcI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Aug 2014 05:32:08 -0400
Message-ID: <54019A17.7060600@kernel.org>
Date: Sat, 30 Aug 2014 10:32:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: linux-iio@vger.kernel.org, 'Ge Gao' <ggao@invensense.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Remove casting the return value
 which is a void pointer
References: <005901cfc33d$46e99bd0$d4bcd370$%han@samsung.com>
In-Reply-To: <005901cfc33d$46e99bd0$d4bcd370$%han@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/08/14 04:56, Jingoo Han wrote:
> Casting the return value which is a void pointer is redundant.
> The conversion from void pointer to any other pointer type is
> guaranteed by the C programming language.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 0c6517c94a9d..b75519deac1a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -673,8 +673,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  	st->client = client;
> -	pdata = (struct inv_mpu6050_platform_data
> -			*)dev_get_platdata(&client->dev);
> +	pdata = dev_get_platdata(&client->dev);
>  	if (pdata)
>  		st->plat_data = *pdata;
>  	/* power is turned on inside check chip type*/
> 
