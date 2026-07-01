Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602636F8E3;
	Wed,  1 Jul 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928183; cv=none; b=II7iq4irEXNjZunWCr6DHswThdH60mj37OvihgLJ4r03fVHRCChioqXHL01udU4CJk14lm0WzqUn4XY4WPnfqRrF4nCZ0IPVJWwJoRqlMr8DHnxfZoVF5mCOYofGdYTN2ADW8t98AP8bmQ41exjQbUaMAfPj0+0QDDvvfMMV900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928183; c=relaxed/simple;
	bh=dp9g2wmUCEAAE6z4BbJXh6ajdXsDATOZb1lUNSVaRiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqdJHrgAEts8l0SDxvD7GDeE5VCutAEbnSLvRjRdQsPDJcUUdyadPuoPnR4UdyxTQy/P4Oz+ly3miviRSzF7UryE9bR3RNOXoMTYQXnK/w5PATKkUb1S3D5DRvaR+OrEV/l+KZaomL5dS7pRCibLcjFU8JMQIjEgGgzlN89lVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2HEDy/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2HEDy/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6631F000E9;
	Wed,  1 Jul 2026 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782928181;
	bh=cWgW8tPzYqQw7V7ZEE2/IYZ2xw4J9H1FYQMhPzUfZjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m2HEDy/qWIxH9POklfS67abIVibu/0cT6Td00PP35OhmSAGETJxSnXb+6xx+OJ83X
	 P84GLnxPAW+eUNbpp4V7m5oYebNSp5QRM/Ww5h6WwnXhRX4WBLhIQfmb5bZml6+dNO
	 wSXH7LoA99Yq8zV6QQ3iogxUgAK7isRbPqh1WLs/uC+KxiGrVarhtH9vyAEkM02zkG
	 MjKb0BJPZXB9AHdtx5dHmTUB8T090bvYRvtFLaJ5EdPvMhDEkS/dC0j7YXHLZUQkm5
	 vkRHAGDNiBnoJdMe/wWZQ/pT9oakEdRyAFR6e0OOrb+hfXtioYvooO5OKyCipBDII1
	 LBU+G7sDVk2pQ==
Date: Wed, 1 Jul 2026 18:49:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anas Khan <anxkhn28@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Remi Buisson <remi.buisson@tdk.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: fix typos in comments
Message-ID: <20260701184935.3f1029e3@jic23-huawei>
In-Reply-To: <20260701162659.43310-1-anxkhn28@gmail.com>
References: <20260701151811.22130-1-anxkhn28@gmail.com>
	<20260701162659.43310-1-anxkhn28@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Jul 2026 21:56:59 +0530
Anas Khan <anxkhn28@gmail.com> wrote:

> Fix several comment misspellings across drivers/iio/imu/, found with
> codespell and manual review. The corrected words are coefficient,
> temperature, sensitivity, access, chosen, and buses.
> 
> Signed-off-by: Anas Khan <anxkhn28@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Andy can confirm, but generally adding more typo fixes that Andy
has not reviewed would be a reason to drop his RB tag.

Changes look fine, but I'll wait on a reply from Andy to apply
this.

Thanks,

Jonathan

> ---
> v2: expand from the single adis16480 temperature fix (v1) to cover all
>     comment typos in drivers/iio/imu/, as requested by Andy Shevchenko.
>     The Reviewed-by is carried over as the changes remain trivial typo
>     fixes.
>  drivers/iio/imu/adis16480.c                        | 4 ++--
>  drivers/iio/imu/bmi160/bmi160_core.c               | 2 +-
>  drivers/iio/imu/fxos8700_core.c                    | 2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 2 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 543d5c4bfb11..c7163540cd02 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -111,7 +111,7 @@
>  
>  #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
>  
> -/* Each filter coefficent bank spans two pages */
> +/* Each filter coefficient bank spans two pages */
>  #define ADIS16480_FIR_COEF(page) (x < 60 ? ADIS16480_REG(page, (x) + 8) : \
>  		ADIS16480_REG((page) + 1, (x) - 60 + 8))
>  #define ADIS16480_FIR_COEF_A(x)			ADIS16480_FIR_COEF(0x05, (x))
> @@ -1468,7 +1468,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
>  			 * We need to perform the padding to have the buffer
>  			 * elements naturally aligned in case there are any
>  			 * 32-bit storage size channels enabled which are added
> -			 * in the buffer after the temprature data. In case
> +			 * in the buffer after the temperature data. In case
>  			 * there is no data being added after the temperature
>  			 * data, the padding is harmless.
>  			 */
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 4abb83b75e2e..2c0d21eb853a 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2016, Intel Corporation.
>   * Copyright (c) 2019, Martin Kelly.
>   *
> - * IIO core driver for BMI160, with support for I2C/SPI busses
> + * IIO core driver for BMI160, with support for I2C/SPI buses
>   *
>   * TODO: magnetometer, hardware FIFO
>   */
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 281ebfd9c15a..9d2eb6fbab4a 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -2,7 +2,7 @@
>  /*
>   * FXOS8700 - NXP IMU (accelerometer plus magnetometer)
>   *
> - * IIO core driver for FXOS8700, with support for I2C/SPI busses
> + * IIO core driver for FXOS8700, with support for I2C/SPI buses
>   *
>   * TODO: Buffer, trigger, and IRQ support
>   */
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 68a395758031..91b7f1ecba55 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -186,7 +186,7 @@ static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
>   * smallest latency but this is not as simple as choosing the smallest watermark
>   * value. Latency depends on watermark and ODR. It requires several steps:
>   * 1) compute gyro and accel latencies and choose the smallest value.
> - * 2) adapt the choosen latency so that it is a multiple of both gyro and accel
> + * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
>   *    ones. Otherwise it is possible that you don't meet a requirement. (for
>   *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
>   *    value of 4 will not meet accel latency requirement because 6 is not a
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> index 1c796d4b2a40..95fa934a42b4 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -190,7 +190,7 @@ struct inv_icm45600_sensor_state {
>  #define INV_ICM45600_REG_IREG_ADDR			0x7C
>  #define INV_ICM45600_REG_IREG_DATA			0x7E
>  
> -/* Direct acces registers */
> +/* Direct access registers */
>  #define INV_ICM45600_REG_MISC2				0x007F
>  #define INV_ICM45600_MISC2_SOFT_RESET			BIT(1)
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index 47394594d17a..6b858fdfd1c6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -106,9 +106,9 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
>  		return ret;
>  
>  	/*
> -	 * Sensor sentivity
> +	 * Sensor sensitivity
>  	 * 1 uT = 0.01 G and value is in micron (1e6)
> -	 * sensitvity = x uT * 0.01 * 1e6
> +	 * sensitivity = x uT * 0.01 * 1e6
>  	 */
>  	switch (st->chip_type) {
>  	case INV_MPU9150:

