Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FD32AAB5;
	Sun, 31 May 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229523; cv=none; b=RQ5hmGnoeRqbohNbzILZyUa8zBNcyLsQvRHToZLt+1vk0Q6hnf4J3N3MpDBBy3JAXUbIJmvDdW5qD0i6xqrgHxx0XX2hsq/AqTrzJk+Oq6pEC5rfAnR2juH2/QNyMlkdr6vXi01D4pE6Suopa5EZgN9PDULIbO/u1fC4GTPA+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229523; c=relaxed/simple;
	bh=rgHWHt5DY8XLQO5FBRgy9lWxPQqOmnIE7dwyb/SCwcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejP7RnK7xW1uNWiXT5IgGt7UxhpZUO7+DLG4HwfYR1L/iDfjWBJ5RgAhneElG2GtByazU1kHgtTHwxZlxvMZkLt3f6EpfQqHpIKp4cBJYvYPxqgGrXrx4viL2A1lgT6tfnnxrIV8QPNoRlSgOeAy2sdpf8or3ZuUo6isgCp05xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuI9zv7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuI9zv7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2301F00893;
	Sun, 31 May 2026 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229521;
	bh=leqiPf+NTSbTmkKH37kvObGoIRcbRTHncXBrq9GqQm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BuI9zv7cJ5hxS8TPOfZweXKlE2BJ/HZlvUxZ8xqhyPvBaTZR7ryjgoNOv903e/ddr
	 RDn9gCnRj0gLy91NP3OWoN4lAPNgEOL8fsTbnKKVeHVlOiAqmMjaPkeVwJNGeeJW0E
	 s5YuR8zJkLDRwy3BovverP4SGGT9Ra7DGqjmnR1RMKT/4Zz9Yasu0Mu83JZZNsIw7+
	 wUrwx92bC2jIjvCDBWy7iU0Fa1qTkQDKpPIf1I87aDi5K0xZ0fjHFJRHTN8ssuimD9
	 k8v3q86f1lVfKXXMNcDHEJMtaf38lAwEIsPQhElCx8oACCtZReZFsMWnyzb4aiIrbZ
	 1wXfAP/HrdCnQ==
Date: Sun, 31 May 2026 13:11:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V9 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260531131154.047f33ce@jic23-huawei>
In-Reply-To: <20260530031739.109063-4-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
	<20260530031739.109063-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 22:17:30 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
https://sashiko.dev/#/patchset/20260530031739.109063-1-macroalpha82%40gmail.com
Again has some feedback.  I've commented on them below to say whether I agree
or not. Also a few other minor things inline.

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 336 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 206 +++++++++++
>  2 files changed, 542 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..4801ece28058
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
> +				 const struct inv_icm42607_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
> +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
> +	/*
> +	 * No temperature enable reg in datasheet, but BSP driver selected RC
> +	 * oscillator clock in LP mode when temperature was disabled.
> +	 */
> +	if (!conf->temp_en)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
> +	val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs);
> +	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, conf->gyro.filter);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, conf->accel.filter);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG1, val);
> +	if (ret)

Sashiko points out that this is overwriting whatever is the 
INV_ICM42607_ACCEL_CONFIG1_AVG_MASK field.  That isn't set at all yet, which is fine
but I'd be tempted to make it clear what intent is here. Either explicitly set it
to 0 as
	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, 0);
or use regmap_update_bits as sashiko suggests.

> +		return ret;
> +
> +	st->conf = *conf;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_icm42607_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> +			      inv_icm42607_bus_setup bus_setup)
> +{
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != st->hw->whoami)
> +		dev_warn(dev, "Unknown whoami %#02x expected %#02x (%s)\n",
> +			 val, st->hw->whoami, st->hw->name);
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(INV_ICM42607_RESET_TIME_MS * 1000);
> +
> +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> +				       INV_ICM42607_RESET_TIME_MS * 100,
> +				       INV_ICM42607_RESET_TIME_MS * 10000);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "reset error, reset done bit not set\n");
> +
> +	/* Sync the regcache again after a reset. */
> +	ret = regcache_sync(st->map);

I haven't checked sashiko's feedback on this but it seems plausible as
there is a check in regcache_sync on whether the cache is dirty and no obvious
path for it to get to that state here.


> +	if (ret)
> +		return ret;
> +
> +	ret = bus_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42607_set_conf(st, st->hw->conf);
> +}

> +int inv_icm42607_core_probe(struct regmap *regmap,
> +			    const struct inv_icm42607_hw *hw,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct inv_icm42607_state *st;
> +	int irq;
> +	int ret;
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Unable to get INT1 interrupt\n");

Sashiko comments on this and is correct that this only works on
device tree with interrupt-names.  Which is intentional!


> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, st);

Really small thing. Is this used yet?  I think this should be in a later
patch. Probably patch 5.

> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->hw = hw;
> +	st->map = regmap;
> +	st->irq = irq;
> +
> +	ret = iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to retrieve mounting matrix %d\n", ret);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get vdd regulator\n");
> +
> +	st->vddio_supply = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(st->vddio_supply))
> +		return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
> +				     "Failed to get vddio regulator\n");
> +
> +	ret = inv_icm42607_enable_vddio_reg(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, inv_icm42607_disable_vddio_reg, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */
> +	ret = inv_icm42607_setup(st, bus_setup);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-42607x device driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");

