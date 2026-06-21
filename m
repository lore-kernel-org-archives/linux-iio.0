Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2228030E;
	Sun, 21 Jun 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063259; cv=none; b=tiBPOHtSR3PrMHCFjtDK1RQ2hvtuJnbuEw9rTu2ibXtVcyrbTYfHhSVCAZjlxv7uL77wUveNuX94T++HQWjXxvkTHQN1JGqMNyVEUVRCs9pdU8d8vvJMtWzfPVp7B45pdHY0vD4d1sYTfeHIl7dLN6Z2OMcxMj6Iiim8/F9VOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063259; c=relaxed/simple;
	bh=Ds013w7o3QaaOPp/IpK7aiJP2nLZB0DgZqjXFfbtQ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swgsG/zDjw6zpFzp4n6SXCP4pEbgsjC17NSOODyBdOYcSHkHhQ5SYemPfJg8sMC3dStFIF4saEWXakkBxwqro+D8j4/+2Yud807eB2IYEXFJacL4Hu/X04mwZYGT4ZCValiEmvkAhKKHPG/YgS94xQZY6DEA+2KA/u1wMmGf0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmqpIAZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmqpIAZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B31F00A3F;
	Sun, 21 Jun 2026 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063258;
	bh=uC3ZTNbtlYKLqbdb+bG9ZesKDDZHUXkiuArgtv4QKOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OmqpIAZwJMuqvKZE9gUI6A5vRJ3pfNJpmzrA/Q6gHzhqvDCMA8ryzwIM0l6rOejAq
	 ZkAcs4310KG4Ooyt8eLy+yijw2SARaXJTpJuNyjlLd651sXbDifWsjO2yBKguZh1lj
	 1fBLRHDTRV0R3cMm9GDwiVjqxH8YqlEY/xHcbjGLruUK4q41KeJrAY/HqpwMFIUD0i
	 HfLBwqBNa/K4xHbt2iGgbOqCtmg42Te/TvmAoofgBvwaGLD/LR1UGdUDtK4Eer2IFX
	 RgWm38rxdNaNq7/iQq2I5xW1XSzU0kdlNORSMZ3Hj2Mtr2RKhuThIUup9lLPS5To8S
	 TcPXA8a6f99LQ==
Date: Sun, 21 Jun 2026 18:34:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260621183408.032e18b4@jic23-huawei>
In-Reply-To: <20260615172554.160910-9-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
	<20260615172554.160910-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 12:25:51 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add gyroscope functions to the icm42607 driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
There is another bit of sashiko stuff in here. Please
take a look
https://sashiko.dev/#/patchset/20260615172554.160910-1-macroalpha82%40gmail.com

I think it is correct about there being a path in which the
gyro ends up always enabled along side anything else after
the first read.

In general there seems to be a bit of mix on whether the caller
or the power management function should be responsible for the caching
of state.

I know you look at Sashiko so I could just have waited a bit, but
I was reviewing anyway so took a look and having done that might
as well highlight some stuff!

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index eb239987a1ce..23ca7529825c 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -218,6 +218,49 @@ int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
>  					  st->conf.temp_en, sleep_ms);
>  }
>  
> +int inv_icm42607_set_gyro_conf(struct inv_icm42607_state *st,
> +			       struct inv_icm42607_sensor_conf *conf,
> +			       unsigned int *sleep_ms)
> +{
> +	struct inv_icm42607_sensor_conf *oldconf = &st->conf.gyro;
> +	unsigned int val;
> +	int ret;
> +
> +	if (conf->mode < 0)
> +		conf->mode = oldconf->mode;
> +	if (conf->fs < 0)
> +		conf->fs = oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr = oldconf->odr;
> +	if (conf->filter < 0)
> +		conf->filter = oldconf->filter;
> +
> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> +		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK,
> +				 conf->fs);
> +		val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK,
> +				  conf->odr);
> +		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +		oldconf->fs = conf->fs;
> +		oldconf->odr = conf->odr;
> +	}
> +
> +	if (conf->filter != oldconf->filter) {
> +		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
> +				 conf->filter);
> +		ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
> +					 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
> +		if (ret)
> +			return ret;
> +		oldconf->filter = conf->filter;
> +	}
> +
> +	return inv_icm42607_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
> +					  st->conf.temp_en, sleep_ms);
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> new file mode 100644
> index 000000000000..ef73560b39d7
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

> +static int inv_icm42607_gyro_read_sensor(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec const *chan,
> +					 s16 *val)
> +{
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int reg;
> +	u8 data[2];
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM42607_REG_GYRO_DATA_X1;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM42607_REG_GYRO_DATA_Y1;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM42607_REG_GYRO_DATA_Z1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* enable gyro sensor */
> +	conf.mode = gyro_st->power_mode;
> +	conf.filter = gyro_st->filter;
> +	ret = inv_icm42607_set_gyro_conf(st, &conf, NULL);
The sashiko report is basically:

This turns it on, and runtime pm will turn it off but the
state cached ends up such that it is turned on again for
any runtime pm resume.

> +	if (ret)
> +		return ret;
> +
> +	/* read gyro register data */
> +	ret = regmap_bulk_read(st->map, reg, data, sizeof(data));
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be16(data);
> +	if (*val == INV_ICM42607_DATA_INVALID)
> +		return -EINVAL;
> +
> +	return 0;
> +}

