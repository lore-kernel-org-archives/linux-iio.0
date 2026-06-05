Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95D3E3D9D;
	Fri,  5 Jun 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675728; cv=none; b=KcyCCgYmytdQiJO6++ewJl5nUphzh6ZKmoa+iG/eM51oYtOXYQTfLOdGkFXPDp9xDIkus5TQe+tVVfL0oKSzekKA1QDX9z1ouDOohMnAPaYo/gZfve5vnea1+E+aOcm4GMORUGKfBPvhSlJbwYQSZKbXLuoxdEMavxJg5ARh0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675728; c=relaxed/simple;
	bh=20ZpNWixaCv9XSjspQ/3hLi4OcsGjY0zsVqGZZY8vMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKTN+XgqKRVhcPeA5v90FcnlZhuCmBOAOjihUBU1EYBQsT93LI0gma58ZkrSp4SNEwyATB6buDk3wVXEYaRHAoWkIQIL1WsoTcKcqFrieH6rwUsrmvOCIPBi5IejIyAL9pntpqwAuQHUjybOP4DwhfKrR8jI7HcvqqvTRwS6tZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jspIjfVd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jspIjfVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780675722; x=1812211722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=20ZpNWixaCv9XSjspQ/3hLi4OcsGjY0zsVqGZZY8vMA=;
  b=jspIjfVdX0YS2uKVSmOP+lwHdw7snO07L/VAyyATScrmRU8PnF1HJcbz
   yDEwNvseNW/aGoaC+QYwP3LHB604mAhkg+DJ3kOC/LPo335jXFLCJtqRq
   7gTulZ/1E2g5vmIVicPMPtGuXzytgojJ2OHG0wy5UXEsyfAgz1rN933h8
   N2NXlG85jw6/b0/d9AFXDSnlGHbFXWJi55iijGYsvEd4Jp436JmidSbT1
   cVS2A3cIqMVC9e5U4LRsHFo/u7i0u2YD+v/1vAv9ZHSC/y35uATxV8bCq
   mwi+iqZeKHc4GrL81kaIZJyBsAo69wGpkFUKEGbNlIz0Yj14eerUfT/oR
   g==;
X-CSE-ConnectionGUID: RCWqBjCZTjW2mT8ugjTkRA==
X-CSE-MsgGUID: cNItdRs2Q0OYCMjHysXdDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="106952492"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="106952492"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 09:08:41 -0700
X-CSE-ConnectionGUID: B5g7jFl9TR6h0VRsHMOv0Q==
X-CSE-MsgGUID: ZHnxMt/uRNakWuNPER3XDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249978644"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 09:08:38 -0700
Date: Fri, 5 Jun 2026 19:08:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V10 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <aiL0g8d0Y_JeAC5c@ashevche-desk.local>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
 <20260604201832.60656-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604201832.60656-4-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 03:18:25PM -0500, Chris Morgan wrote:

> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.

...

> +#ifndef INV_ICM42607_H_
> +#define INV_ICM42607_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>

I haven't found users for these two.

+ bits.h // BIT() / GENMASK()

> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>


> +#include <linux/regulator/consumer.h>

No users for this one.

+ types.h // for bool

...

> +enum inv_icm42607_sensor_mode {
> +	INV_ICM42607_SENSOR_MODE_OFF,
> +	INV_ICM42607_SENSOR_MODE_STANDBY,
> +	INV_ICM42607_SENSOR_MODE_LOW_POWER,
> +	INV_ICM42607_SENSOR_MODE_LOW_NOISE,

Are those enums map 1:1 to HW bits or bitfields? If so, assign explicitly each
of them.

> +	INV_ICM42607_SENSOR_MODE_NB

Is this a terminator like NUMBER_OF ?

> +};

...

> +/* ODR values */
> +enum inv_icm42607_odr {
> +	INV_ICM42607_ODR_1600HZ = 5,

See above. This one is problematic. No one should rely on Linux/C enums when
it's about HW bits. All HW related stuff has to be explicit.

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

...

> +struct inv_icm42607_sensor_conf {
> +	int mode;
> +	int fs;
> +	int odr;
> +	int filter;

All of them are supposed to be signed? Why?

> +};

...

> +struct inv_icm42607_hw {
> +	uint8_t whoami;

What's wrong with u8?

> +	const char *name;
> +	const struct inv_icm42607_conf *conf;
> +};

...

> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

IWYU, please.

...

> +/**
> + *  inv_icm42607_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.

If you do kernel-doc, validate it. Return section is missing here.

> + */

...

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

dev_warn_probe() ?

> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;

> +	fsleep(INV_ICM42607_RESET_TIME_MS * 1000);

USEC_PER_MSEC (needs time.h)

> +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> +				       INV_ICM42607_RESET_TIME_MS * 100,
> +				       INV_ICM42607_RESET_TIME_MS * 10000);

These are weird, as in the first case it's actually 1/10th of _RESET_TIME_MS.
Perhaps you need to reconsider what you use as that constant. Personally I
prefer to see just plain values with the multipliers (to convert to µs).

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "reset error, reset done bit not set\n");
> +
> +	/* Sync the regcache again after a reset. */
> +	regcache_mark_dirty(st->map);
> +	ret = regcache_sync(st->map);
> +	if (ret)
> +		return ret;
> +
> +	ret = bus_setup(st);

Hmm... This is bad name with potential of name collision in the future (in case
driver bus code wants to have the same name for the function).

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

...

> +int inv_icm42607_core_probe(struct regmap *regmap,
> +			    const struct inv_icm42607_hw *hw,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct inv_icm42607_state *st;
> +	int ret;
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->hw = hw;
> +	st->map = regmap;
> +
> +	ret = iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "failed to retrieve mounting matrix %d\n", ret);

Remove duplicate ret printing.

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

> +	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */
> +	ret = inv_icm42607_setup(st, bus_setup);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Just

	return inv_icm42607_setup(st, bus_setup);

? Or is it going to be extended in the next changes?

> +}

-- 
With Best Regards,
Andy Shevchenko


