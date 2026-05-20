Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5171356762;
	Wed, 20 May 2026 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295753; cv=none; b=IlXeFZOhFrbm+yENgUwaqMpG/a1ggPFhf8U57Qj6j+GEs8aoI705FbptqOYMe9zn6FroYX1kl+enM0BXGTUarlxNSHDEJiguVCPiptSevdtSdvirksot/YZ8WXUz5ZVZDBQdRymlC++w1MjxjmV8nPZBJTEtrbda0UCdWqv5r0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295753; c=relaxed/simple;
	bh=IqFbB5E/mcqriC9G7m12Xanx0cKnvei5h0SH8wa6fN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYlB0MtEk0YEeSEasUXz63Mz9GDMqTk9J2OL5e/ujvhgGB0G8ZS6hj0fv0laMbxB5YSGqLD0TyiWnTc6pL0arQtyX9Mrm9pWt4Qu9zK0Ium2kMNe9rhhlP4WgekfrXZmhTk9T1pDCrKCiUeeoF2TW7Z0oE/3kKSQ7YLowX6YmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRtD7X3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRtD7X3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD7C1F000E9;
	Wed, 20 May 2026 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779295751;
	bh=2EYGOyHOoy1RVuJWBWnb5bN4dRtWTtSSDwlqhTkXu7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VRtD7X3c3QzEtK90eKxbGHYpUFqgqd1tglBN9Y6o69TruAlm27IqMfMajz/YX5C65
	 bVG+FFjHJmrdwKt/XjvGprimjp7JsTIbtU+CJzTwViR8/48hAJROJ82YmUdaTN6hvy
	 1NYnqf+4nAUq8z50j3whNiKgpCIfR1YZt3HPlPVuiD/ehDXeQy0m6nqRTEYdIsEtgj
	 fVZcg6NVwIpmvgT8+ru/7Qff6TKx3Epq4j8J0DH9EZjhnA2mWy/liVI+L5GYr9LsI2
	 rWkzM4GTxJkB56Kl8y1B49f65+95zrsP9ZQ15b9PwY7bjZRkz75DF8SUVZbvk1t6EM
	 aD/G0vV4H6SlA==
Date: Wed, 20 May 2026 17:49:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V8 03/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260520174902.3e19117e@jic23-huawei>
In-Reply-To: <20260518200526.458421-4-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:05:18 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Mainly the interrupt names thing - which is probably a case for
a precursor fix for the existing binding.

Otherwise really small stuff I'd not have bothered you with if we
weren't already looking like we'll need a v9

Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 332 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 197 +++++++++++
>  2 files changed, 529 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..6c5e7d9b08b7
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> +
> +typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> +
> +extern const struct regmap_config inv_icm42607_regmap_config;
> +
> +int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
Trivial but I'd wrap the line above after first ,

Still prefer staying under 80 chars if it doesn't hurt readability and here
it doesn't.

> +			    inv_icm42607_bus_setup bus_setup);
> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..b270d48335ba
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -0,0 +1,197 @@
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

Give the includes another quick check. I'd expect at least
dev_printk.h in here. There may be others missing to following
the approximate include what you use approach preferred for kernel
drivers.

> +#include "inv_icm42607.h"

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

Can we tweak that to unknown whoami

It might well be valid afterall!

> +			 val, st->hw->whoami, st->hw->name);
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
There is some moaning here from sashiko. I think it's wrong but take a look.

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
> +	struct inv_icm42607_state *st;
> +	int irq;
> +	int ret;
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");

Sashiko raises a valid point on this one.  The binding has interrupt-names as optional
even if we have interrupts. The binding could document a default but doesn't. 

Can you check the other drivers sharing that binding and either 'fix' the binding
or add a default - I'd guess INT1 - but this wouldn't be the first time a driver
has gotten written against a board that wires INT2 only and that's there for
the default choice.

Note that sashiko's fallback is a bad idea if we don't have a default in the binding!


> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Unable to get INT1 interrupt\n");



