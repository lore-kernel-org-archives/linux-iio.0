Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DD37F8A0;
	Fri, 15 May 2026 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869873; cv=none; b=b7osjfZNcoM1iUKM07w41iIx2sEIuzWnGUJ7MvJsyUpFLRMnE3X2TKbQDi+AEO1V3jrkQyWKKzuL1Mfj0dqu55ZIYK5yY5sH+5qhPCf2ZM7/yYWqQ1ZKezQIbH7KbMufBXZ0hn6jP3uqfVveuDUwl7EpOdOEe+weTXwJ+2deTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869873; c=relaxed/simple;
	bh=IIaeX4/HmJDDekNk9hp/2YTL5IRngsNl+EbSt49v2KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcV5rUvy4QSKmz1gOx1LEaaPMgO9/x3RCXAHxqcwRVqiaGTfH79ZnkyWIV9XhZ4usPfCcILnQVEdeKeCroHY3K0PYJ4MPwjfADevaX9BUr9a1TmDk4HqXm8JQHy3IziYi5iT4a8pT9OjVAU5oynbZA91uaxOhuyg3ZKmvMknu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRFj+s3+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRFj+s3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368A5C2BCB0;
	Fri, 15 May 2026 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869872;
	bh=IIaeX4/HmJDDekNk9hp/2YTL5IRngsNl+EbSt49v2KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iRFj+s3+dHm7RQ2Z9GIB4uybsFHCumaD/HASJvfaOk/NeZbQqeMKdPK36+pqEwCm3
	 HHf+uEoJBbossOeTiqMwTQASiWNyofbyK6bJkwshcd7zyv89sOhu/WtwYDRFktotro
	 bv66McWalv1TqRhoA4LQAwAlYoahuVLoZZcmnKssXt79n+FiM5wx5vh7VleK+6NSX7
	 +lma0g532JA1frXr5XTc48sWFgq1eKPv4pwz/mSosMdkPyffUuA2Zjj4U5/bBXwgxz
	 9US61oUFvH5S8r3Mptbxk++GxAKXf+TYO9ZrdmlO4SOkT74RJaFNbmY9Qw1smNzd1g
	 WzCxHaGhBmbgQ==
Date: Fri, 15 May 2026 19:31:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V7 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260515193102.123b664a@jic23-huawei>
In-Reply-To: <20260515130018.237378-4-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
	<20260515130018.237378-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 08:00:08 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Sashiko led you into the weeks with irq request return values.
It was less broken in v6 :(

As to it's other comments on checking for line high/low values (0x00 / 0xFF)
for whoami is something we don't normally bother with but you could if you like.
I'm fairly sure we've had both those values turn up as valid in some devices
in the past.

Otherwise just trivial stuff I noticed whilst having a fresh read through.
All stuff I might have tweaked whilst applying or just let through but
seeing as you are going to be doing a v8, please take a look.

Jonathan


> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 334 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 207 +++++++++++
>  2 files changed, 541 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..1916e0b08bca
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -0,0 +1,334 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_H_
> +#define INV_ICM42607_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +enum inv_icm42607_sensor_mode {
> +	INV_ICM42607_SENSOR_MODE_OFF,
> +	INV_ICM42607_SENSOR_MODE_STANDBY,
> +	INV_ICM42607_SENSOR_MODE_LOW_POWER,
> +	INV_ICM42607_SENSOR_MODE_LOW_NOISE,
> +	INV_ICM42607_SENSOR_MODE_NB
> +};
> +
> +/* gyroscope fullscale values */
> +enum inv_icm42607_gyro_fs {
> +	INV_ICM42607_GYRO_FS_2000DPS,
> +	INV_ICM42607_GYRO_FS_1000DPS,
> +	INV_ICM42607_GYRO_FS_500DPS,
> +	INV_ICM42607_GYRO_FS_250DPS,
> +	INV_ICM42607_GYRO_FS_NB
> +};
> +
> +/* accelerometer fullscale values */
> +enum inv_icm42607_accel_fs {
> +	INV_ICM42607_ACCEL_FS_16G,
> +	INV_ICM42607_ACCEL_FS_8G,
> +	INV_ICM42607_ACCEL_FS_4G,
> +	INV_ICM42607_ACCEL_FS_2G,
> +	INV_ICM42607_ACCEL_FS_NB
> +};
> +
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
> +	INV_ICM42607_ODR_NB
> +};
> +
> +enum inv_icm42607_filter_bw {
> +	/* Low-Noise mode sensor data filter (bandwidth) */
> +	INV_ICM42607_FILTER_BYPASS,
> +	INV_ICM42607_FILTER_BW_180HZ,
> +	INV_ICM42607_FILTER_BW_121HZ,
> +	INV_ICM42607_FILTER_BW_73HZ,
> +	INV_ICM42607_FILTER_BW_53HZ,
> +	INV_ICM42607_FILTER_BW_34HZ,
> +	INV_ICM42607_FILTER_BW_25HZ,
> +	INV_ICM42607_FILTER_BW_16HZ

That isn't a terminating entry so it should have a ,
Rules on this are a bit obscure - but basically _NB type entries
should never have a , anything else should - even if it's
a register field enum where we know all values are there.

> +};


> +/* Sleep times required by the driver */
> +#define INV_ICM42607_POWER_UP_TIME_US			100000
> +#define INV_ICM42607_RESET_TIME_MS			1
> +#define INV_ICM42607_ACCEL_STARTUP_TIME_MS		20
> +#define INV_ICM42607_GYRO_STARTUP_TIME_MS		60
> +#define INV_ICM42607_GYRO_STOP_TIME_MS			150
> +#define INV_ICM42607_TEMP_STARTUP_TIME_MS		14
> +#define INV_ICM42607_SUSPEND_DELAY_MS			2000

Can we have spec references for these?  We often hit problems later
with devices that are a little bit slow and no one is sure if it's because
the sleeps are wrong or device is actually out of spec. Hence
it is useful to be able to quickly check these.

> +
> +typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> +
> +extern const struct regmap_config inv_icm42607_regmap_config;
> +
> +int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
> +			    inv_icm42607_bus_setup bus_setup);
> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..9784709319b9
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "inv_icm42607.h"
> +
> +static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
> +				 const struct inv_icm42607_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK,
> +			 conf->gyro.mode);
> +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK,
> +			  conf->accel.mode);

As below - I'm fine with these going on one line (first is 80 chars, second just over)

> +	/*
> +	 * No temperature enable reg in datasheet, but BSP driver
> +	 * selected RC oscillator clock in LP mode when temperature
> +	 * was disabled.
> +	 */
	/*
	 * No temperature enable reg in datasheet, but BSP driver selected 
	 * RC oscillator clock in LP mode when temperature was disabled.
	 */

Basically go up to 80 chars. Here I think keeping RC oscillator on one line
is a good idea though.


> +	if (!conf->temp_en)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK,
> +			 conf->gyro.fs);
It's under 80 chars on one line so don't wrap.

> +	val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK,
> +			  conf->gyro.odr);

As is this.

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
> +	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
> +			 conf->gyro.filter);

Whilst this one and next are a tiny bit over 80 chars, if you want to I don't
mind those being a little long as single lines.

> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
> +			 conf->accel.filter);
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
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != st->hw->whoami)
> +		dev_warn(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> +			 val, st->hw->whoami, st->hw->name);
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(1000);

Do we need an explicit sleep here, or is the idea just to save on
a read that can't succeed in the poll that follows?  I'd be tempted
to drop this if it's not absolutely needed just to avoid explaining it.
This isn't fast path code. If we need to leave the device alone after
reset for a bit then a datasheet reference is needed.

> +
> +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> +				       INV_ICM42607_RESET_TIME_MS * 100,
> +				       INV_ICM42607_RESET_TIME_MS * 1000);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "reset error, reset done bit not set\n");
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

> +int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct inv_icm42607_state *st;
> +	int irq;
> +	int ret;
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
Trivial but if fwnode is only used here (I didn't check later patches) then
put the dev_fwnode() inline.

I've never really understood why we don't have device_ variant of that - perhaps
because it's hard to come up with a clear name.

> +	if (!(irq > 0))
> +		return dev_err_probe(dev, -EINVAL, "Unable to get INT1 interrupt\n");

I assume this is in response to sashiko saying fwnode_irq_get_byname() can in some
corner cases (where I suspect things are broken enough the system probably won't boot)
return 0.   If we are actually going to defend against that then you need
to special case it.  New sashiko review correctly reports this breaks probe
deferal if say the interrupt chip driver hasn't loaded yet.

	if (irq < 0) {
		return dev_err_probe(dev, irq, ...);
	if (irq == 0)
		/* Odd corner case... */
		return dev_err_probe(dev, -EINVAL, ...);

However I'm deeply suspicious of whether the code paths that return 0 can happen in
practice.  Given you have a suitable DT, can you try seeing if you can actually make
it return 0 by messing around with the interrupt mappings?


> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;

