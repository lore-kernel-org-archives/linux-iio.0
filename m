Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067330567F;
	Mon,  7 Sep 2026 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746105; cv=none; b=kCecukUX1me0WzlEZ/TCmwVHV7k3EOShC52qX18PU42srcuCtDFmS01WhH1WWZBy9LukNtfj3J7ReZ307DnYy4Ap0xd2YTNzT+EDc8jx7KimZIt8nqxwtAPh97XbmC+997GH0H4B/lQ6gpJnTUYuq6jewBntB8WlJDlcpfQf+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746105; c=relaxed/simple;
	bh=w0xK7uqCrLRGcFg/I67fSL47txfvrgCFbwW4qjTcbx0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=WFyJEg+2tXcB+MxQBb/izRDBZcjhO6vZhY5M7QrX2+Ez+mQWJDNNQ+KL9Xsp4q6u3tx+nL5C+5OqrhC6SldofrMiC75nrJO/mLbPl2yI56FjMhv+aIIrygH4DH1vRb3z1Xbvfp6JqNUQi5kN57k6ao2Lc0B7qhGTvDhna7haF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoesLFK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoesLFK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DB21F00AC4;
	Mon,  7 Sep 2026 01:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746103;
	bh=ra1kqhFpFfPGeG72A2RNltYIG79lkNeagvU2s/DfjTs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BoesLFK3I2sJGh7jTpZ4eRIg6cr7hQOuyR/5lcmG0bYRvDjpbIeWkDZm/+cBn2MzR
	 dwmeb32+qwAi4znXyas0hvB1/oY5bZ0mtgqsBiimADzl1l4IL+qan6wf//MNbqDPDG
	 GPM1fjgxdTNGY0NC4BL5INw1mWh6caZe2O+NOfyQyFNzJhWiU1QOiVN0vGPSXVy9xp
	 bSyQy5ie/sXszxZNI/iQDI53EhOx8nwCmMPVIDtI5y8VA1JjUqqJhmM4qfMQMWxIjj
	 L4eMZwCaOL+rNjvH4vMO36HKZr213Z75caOrOFfoq9qtU84M5tBEMuVxjZfKl0XQ4w
	 m0dH6wj51scBQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/8] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-5-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-5-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609182.3402141.7546313507051426644.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4786;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=w0xK7uqCrLRGcFg/I67fSL47txfvrgCFbwW4qjTcbx0=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhludesp0tccR3GTlqgJM+T1kh1Alul+K6a9k
 jajwj8cmNiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiAizD/9TqwXs+wdmYEy/YhTCr6PO8vJw2VXKsfGWRgRUJerXzpM
 O1mQzAI0Kq59W7gVkeHcQNM0ZOsxLoGQmb06ze79UenEFB2LKKeHAsXyb6v+iXxanJDsxkBCtBV
 ih27hdF2dYuWPrhiz0aFESUG2pwvQLBs6+o0RXh58h3uCR2G9j7ZA3+XLcyp6DiPcDvwiOQqrVC
 IL1skbJZjS5WOdHMN57PQptMDmLeIJTqBb2O3VQ5YqF8OpxRmHer9nXHKCcyPPXjTkCGkD60BGb
 baMBFnvfNcJrL0PyZkPqADWW+H4g9Pb6l5oI/j7aQSascgJIT3Ip4tT7Cp6YgX8XomGnAChlZI9
 v7pflgxPj6S6TeHuDVmug4t+mGt8vB4nzOt7e2oYnctMfNqBYL5uuUWo6gqJNJi3cdQFLGJcxOT
 GU7VRKAwAyrOS/UP9MqZ6p8CH5XPQPBNevwgXrf8V/Tcb2OZj6V3Z1blVWRcoTcB7AvLDL+FDKT
 TAevXwzi2uHmlmz5fG+wwdA6oIulSvbOyRWKHJMFdptQDC3LBzZ2d3KVG1UEi03N8U5ZHNdtDWP
 iwgMC4Y/Hwa2nHPbBf4IYFBhQNROSjLqKBm10DkiyeQMpncECEbchRLNM95ARMYPfPO7uD6rU37
 ZirHn3Wz2rMet0whhO1IvCLT6WRBZbiCESO4/Iw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
> accelerometer with built-in temperature sensor. This device is almost
> identical to the existing Invensense ICM-42607-P IMU, but lacks
> gyroscope. The device supports I2C, SPI and I3C, implement only I2C
> support. Provide basic support for raw sensor reads via sysfs. There is
> also a built-in temperature sensor but it can not be turned off.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
>
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index fa85cf738cc0..a183a8566617 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -368,6 +368,7 @@ struct inv_icm42607_sensor_state {
>  #define INV_ICM42607_REG_WHOAMI				0x75
>  #define INV_ICM42607P_WHOAMI				0x60
>  #define INV_ICM42607_WHOAMI				0x67
> +#define INV_ICM42370P_WHOAMI				0x0D

I'd put this in alpha numeric order.  Either that or by WHOAMI value.
Neither is true currently.

>  
>  /*
>   * Timings as listed in section 3 of datasheet, all values listed in datasheet
> @@ -392,6 +393,7 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
>  extern const struct regmap_config inv_icm42607_regmap_config;
>  extern const struct inv_icm42607_hw inv_icm42607_hw_data;
>  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> +extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
>  extern const struct dev_pm_ops inv_icm42607_pm_ops;
>  
>  const struct iio_mount_matrix *
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 7eb486ff673b..e77d72e0f7bc 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -92,6 +92,17 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
>  	},
>  };
>  
> +/* Chip initial default configuration */
> +static const struct inv_icm42607_conf inv_icm42370_default_conf = {
> +	.gyro = { },

Don't specificy it.  C will fill it in anyway with 0s.


> +	.accel = {
> +		.mode = INV_ICM42607_SENSOR_MODE_OFF,
> +		.fs = INV_ICM42607_ACCEL_FS_4G,
> +		.odr = INV_ICM42607_ODR_100HZ,
> +		.filter = INV_ICM42607_FILTER_BW_25HZ,
> +	},
> +};
> +
>  const struct inv_icm42607_hw inv_icm42607_hw_data = {
>  	.whoami = INV_ICM42607_WHOAMI,
>  	.name = "icm42607",


> @@ -617,16 +635,38 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(dev);
>  
> -	/* Initialize IIO device for Accel */
> -	st->indio_accel = inv_icm42607_accel_init(st);
> -	if (IS_ERR(st->indio_accel))
> -		return PTR_ERR(st->indio_accel);
> +	switch (st->hw->whoami) {
> +	case INV_ICM42607_WHOAMI:
> +	case INV_ICM42607P_WHOAMI:

It is almost never good design to match against whoami values.
Doing so scales really badly as a driver ends up supporting more and
more devices.

Instead encode what they mean in additional properties in the chip
info structure.

> +		/*
> +		 * Invensense, ICM42607 and ICM42607P both have accelerometer
> +		 * and gyroscope functionality.
> +		 */
> +		st->indio_accel = inv_icm42607_accel_init(st);
> +		if (IS_ERR(st->indio_accel))
> +			return PTR_ERR(st->indio_accel);

This first bit is in btoh paths, so drop it out of this switch.

> +
> +		st->indio_gyro = inv_icm42607_gyro_init(st);

Add a has_gyro flag or something like that to chip_info.

> +		if (IS_ERR(st->indio_gyro))
> +			return PTR_ERR(st->indio_gyro);
> +
> +		break;
> +	case INV_ICM42370P_WHOAMI:
> +		/*
> +		 * Invensense, ICM42370P has only accelerometer functionality.
> +		 * Thus, set the gryo property to NULL.
> +		 */
> +		st->indio_accel = inv_icm42607_accel_init(st);
> +		if (IS_ERR(st->indio_accel))
> +			return PTR_ERR(st->indio_accel);
>  
> -	/* Initialize IIO device for Gyro */
> -	st->indio_gyro = inv_icm42607_gyro_init(st);
> -	if (IS_ERR(st->indio_gyro))
> -		return PTR_ERR(st->indio_gyro);
> +		st->indio_gyro = NULL;

st should be zeroed anyway so shouldn't be any reason to do this.

>  
> +		break;
> +	default:
> +		/* No WHOAMI value matched */
> +		return dev_err_probe(dev, -ENODEV, "Failed to find a matching WHO_AM_I value\n");
> +	}
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");

Thanks

Jonanthan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
