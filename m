Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124C327C08;
	Mon, 13 Apr 2026 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107225; cv=none; b=Z404tMCDPMAfp2A2kkPzAqvR6Fzq8C+j783b5fSe1PrPFNx23hGmU/y2H5+ws8icize0ciWvb/+KupKdkl+qJy1H0ytNDPfPK4g0HmumuHMXP14PZHKn+afuaVw3nr7Kfnxteqff84lAyLqREnPDKjnG0nSmhWIzEpKdkRrLJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107225; c=relaxed/simple;
	bh=79DRtTOlzoDf2ZnJLgYDR2eJU8iXE4MgH1kroF9+zIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwCf+0dTrynNbxhNdFXuCZ4whJ0OBdaBGZMZUKX+ASZxYiQE0RH/XKsMHT1D01ov/Jew30GhUoubE5dMxQk14uGr5Efg9yOWeeSwzjYWUKiXQUF2LqAZiwXidz/G1eNZE95FkIHShC201B8lyRU7VlNHHWlTxMr8kW3YjKRfmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRy1TCXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRy1TCXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD2C2BCAF;
	Mon, 13 Apr 2026 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776107224;
	bh=79DRtTOlzoDf2ZnJLgYDR2eJU8iXE4MgH1kroF9+zIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GRy1TCXRTdqkRFE+i/smjVDVq1ElhclE5CyesjNQMvs8Ay2F5kG3OtBSfAQ/UR4t1
	 VxnwESygaMQLNZ8Vfue/v586YUtEcHenLwzTmSNIVyk5CBq4hJBTo3Coy0sutEoFo+
	 XhYnNEcTlRu19eflfziv0r5Li0/unGO+78dntqwCUVUFCfTLypuMPp2TM/diQN5gVq
	 9JKPgw0YiLbmK6VKeY9qz+hZcbg5EtCByI1zcyCX7muh0/Mtox1bV3+RtwzoD+7sOF
	 L7DEraPjbUaPhVP8azzE8o4lVgSOguEli/lMnmrW6F38X/7Xh0j2vEuQkOBcq0kKb6
	 NITZoqRzghD6Q==
Date: Mon, 13 Apr 2026 20:06:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 2/9] iio: imu: inv_icm42607: Add Core for
 inv_icm42607 Driver
Message-ID: <20260413200547.75bfd672@jic23-huawei>
In-Reply-To: <20260330195853.392877-3-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
	<20260330195853.392877-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:58:46 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

I've avoided repeating a few things David raised, but there may
well be overlap on some things.  I'm not particularly keen on code
that doesn't build at the end of a patch or even provide the Kconfig
and makefile stuff to do so.  Maybe it's too much effort given how you have
this structured.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 424 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 300 +++++++++++++
>  2 files changed, 724 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..609188c40ffc
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -0,0 +1,424 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_H_
> +#define INV_ICM42607_H_
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>

Alphabetical order.  Though fine to have an IIO specific block at the end.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>

> +/* ODR values */
> +enum inv_icm42607_odr {
> +	INV_ICM42607_ODR_1600HZ = 5,
> +	INV_ICM42607_ODR_800HZ,
> +	INV_ICM42607_ODR_400HZ,
> +	INV_ICM42607_ODR_200HZ,
> +	INV_ICM42607_ODR_100HZ,
> +	INV_ICM42607_ODR_50HZ,
> +	INV_ICM42607_ODR_25HZ,
> +	INV_ICM42607_ODR_12_5HZ,
> +	INV_ICM42607_ODR_6_25HZ_LP,
> +	INV_ICM42607_ODR_3_125HZ_LP,
> +	INV_ICM42607_ODR_1_5625HZ_LP,
> +	INV_ICM42607_ODR_NB,

If just here as number, then no terminating comma as
we don't want to imply something might come after it.
Same for all the other enums.
> +};
> +
> +enum inv_icm42607_filter {
> +	/* Low-Noise mode sensor data filter */
> +	INV_ICM42607_FILTER_BYPASS,
> +	INV_ICM42607_FILTER_BW_180HZ,
> +	INV_ICM42607_FILTER_BW_121HZ,
> +	INV_ICM42607_FILTER_BW_73HZ,
> +	INV_ICM42607_FILTER_BW_53HZ,
> +	INV_ICM42607_FILTER_BW_34HZ,
> +	INV_ICM42607_FILTER_BW_25HZ,
> +	INV_ICM42607_FILTER_BW_16HZ,
> +
> +	/* Low-Power mode sensor data filter (averaging) */
> +	INV_ICM42607_FILTER_AVG_2X = 0,
> +	INV_ICM42607_FILTER_AVG_4X,
> +	INV_ICM42607_FILTER_AVG_8X,
> +	INV_ICM42607_FILTER_AVG_16X,
> +	INV_ICM42607_FILTER_AVG_32X,
> +	INV_ICM42607_FILTER_AVG_64X,
Bring these in when used.  For now these to me look like they should be broken
into two separate enums. I can't see how the will be used though so hard
to tell.

> +};
>

> +#define INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK		GENMASK(1, 0)
> +#define INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL		\
> +	FIELD_PREP(INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK, 1)

Define the value of the field to give that a name and use FIELD_PREP() inline.


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..6b7078387568
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
Most likely this should be more specific headers like
dev_printk.h etc  It is pretty rare it makes sense to include
device.h if following IWYU approach (which we do for IIO drivers
and is generally accepted across the kernel).
> +#include <linux/module.h>
Alphabetical order.
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>

> +u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
> +{
> +	static u32 odr_periods[INV_ICM42607_ODR_NB] = {

Hopefully the compiler can figure it out, but better
as explicit const.

> +		/* Reserved values */
> +		0, 0, 0, 0, 0,
> +		/* 1600Hz */
> +		625000,
> +		/* 800Hz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100 Hz */
> +		10000000,
> +		/* 50Hz */
> +		20000000,
> +		/* 25Hz */
> +		40000000,
> +		/* 12.5Hz */
> +		80000000,
> +		/* 6.25Hz */
> +		160000000,
> +		/* 3.125Hz */
> +		320000000,
> +		/* 1.5625Hz */
> +		640000000,
> +	};
> +
> +	return odr_periods[odr];
> +}

> +
> +static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
> +				 const struct inv_icm42607_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = INV_ICM42607_PWR_MGMT0_GYRO(conf->gyro.mode) |
> +	INV_ICM42607_PWR_MGMT0_ACCEL(conf->accel.mode);
Align as 
	val = INV_ICM42607_PWR_MGMT0_GYRO(conf->gyro.mode) |
	      INV_ICM42607_PWR_MGMT0_ACCEL(conf->accel.mode);

Though as mentioned in David's review, prefer to see the FIELD_PREP()
inline.

> +	/*
> +	 * No temperature enable reg in datasheet, but BSP driver
> +	 * selected RC oscillator clock in LP mode when temperature
> +	 * was disabled.
> +	 */
> +	if (!conf->temp_en)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;

Could make this 
	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL,
			  !conf->temp_en);
Not particularly important though if you prefer the if.

> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_GYRO_CONFIG0_FS_SEL(conf->gyro.fs) |
> +	INV_ICM42607_GYRO_CONFIG0_ODR(conf->gyro.odr);

As above.  If it's the second line of a statement, it must be indented
to avoid readability issues. Fix all examples of this.


> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_ACCEL_CONFIG0_FS_SEL(conf->accel.fs) |
> +	INV_ICM42607_ACCEL_CONFIG0_ODR(conf->accel.odr);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_GYRO_CONFIG1_FILTER(conf->gyro.filter);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_ACCEL_CONFIG1_FILTER(conf->accel.filter);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG1, val);
> +	if (ret)
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
> +	const struct inv_icm42607_hw *hw = &inv_icm42607_hw[st->chip];
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != hw->whoami)
> +		dev_warn_probe(dev, -ENODEV,
> +			       "invalid whoami %#02x expected %#02x (%s)\n",
> +			       val, hw->whoami, hw->name);
> +
> +	st->name = hw->name;
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +	msleep(INV_ICM42607_RESET_TIME_MS);

fsleep() here as sleeping longer is probably fine and that function will
apply appropriate slack on the times.

> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &val);
> +	if (ret)
> +		return ret;
> +	if (!(val & INV_ICM42607_INT_STATUS_RESET_DONE))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "reset error, reset done bit not set\n");
> +
> +	ret = bus_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				 INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN,
> +				 INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42607_set_conf(st, hw->conf);
> +}
> +
> +static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(st->vddio_supply);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(3000, 4000);
David covered this, fsleep() preferred.

> +
> +	return 0;
> +}

> +
> +int inv_icm42607_core_probe(struct regmap *regmap, int chip,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct inv_icm42607_state *st;
> +	int irq, irq_type;
> +	bool open_drain;
> +	int ret;
> +
> +	if (chip < INV_CHIP_INVALID || chip >= INV_CHIP_NB)
> +		dev_warn_probe(dev, -ENODEV,
> +			       "Invalid chip = %d\n", chip);

Easily fits on one line shorter than 80 chars.

> +
> +	/* get INT1 only supported interrupt or fallback to first interrupt */

Why the fallback?  I suspect this is copied from a driver
that didn't (bug) support named interrupts from the start.  Given you are
doing so here, just insist on named one to simplify things.  I'd imagine
that if INT2 is ever supported, the device configuration will need to be
different.

> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0 && irq != -EPROBE_DEFER) {
> +		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
> +		irq = fwnode_irq_get(fwnode, 0);
> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
> +
> +	irq_type = irq_get_trigger_type(irq);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_FALLING;

Not used at this point.  Bring it in when you use it so we can understand
the default setting.


> +
> +	open_drain = device_property_read_bool(dev, "drive-open-drain");
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, st);
> +	mutex_init(&st->lock);
For new code
	ret = devm_mutex_init(&st->lock);
	if (ret)
		return ret;

Brings a very small advantage if someone is debugging locks.

> +	st->chip = chip;
> +	st->map = regmap;
> +	st->irq = irq;
> +
> +	ret = iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret) {
> +		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
> +		return ret;

return dev_err_probe();

> +	}
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get vdd regulator\n");
> +
> +	msleep(INV_ICM42607_POWER_UP_TIME_MS);
> +
> +	st->vddio_supply = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(st->vddio_supply))
> +		return PTR_ERR(st->vddio_supply);
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
> +
> +	return ret;

Looking forwards I would instead do:

	if (ret)
		return ret;

	return 0;

I think that makes it easier to add the additional pm stuff in later patches.

> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
