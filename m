Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757763C988D;
	Mon, 29 Jun 2026 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717676; cv=none; b=WSsHZHqUm1NK/tFWnPnHfcFUqDcRYAKSghKhJSWBUuTyS20EthHhfEiW3/zQqFXu0JKTSX5NRQZmZ3rmjKY3Ki3L36FSQ3H/M7OHTvge2TCHP+9EPI1LIOzRnlhZm6OcifeSKDgNVFErPm1f2BY8xsU/Z30MS4s26PQoL8BGBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717676; c=relaxed/simple;
	bh=5FlcyVDERtTSpIlODKLyVsLFJ7RaBMhfiwTqJFbHglc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyO5RlnVM+AnCEi6ZUO9XrtNXSIu97XIw4+7CBJPH0MK9x3SFLux6m3kvSuIExTcNaMuv/8Y/9Ub6Ja6d/SPhGof8sxgxFt8VeviX8e5S9bMc8GkWJqjNtL2Ye8o8SwMQO1p7gXBIor790i77WU3Kt+V0EMiSk7DycUlovicNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T74VGgT+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T74VGgT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782717672; x=1814253672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5FlcyVDERtTSpIlODKLyVsLFJ7RaBMhfiwTqJFbHglc=;
  b=T74VGgT+yLcf/IzQmvEQQWJYSSzyfwVAYgH7/UcowwYgngZbafelvykR
   xi2j9bvWE/Fn/iY+vj9JgkEgDRD/9XU0yY1+tWMmeuYLTATjGPBiUfvU9
   ziafuOV/jPNhL2v+xOGLHwHqS/LW9rbd9rv2888ziIIGObQg9v3BawLWh
   5EYk1WYY+MovM03YxyGWso78gAmfz7nHWryMmKMkZONLisnomf5cugEAI
   8r/4+2prnKAGStMU/kcMep6f/VNt63CWQvxHI1O1iAwMDID7+R7+7cRmD
   p6lLLsIbp/Gc0W9h7YEDNCoKHuXcsXi89Jr3ExzAjxwMr9BLuYrRKlU/c
   g==;
X-CSE-ConnectionGUID: cmm6rKRCTQWluoe/eRuCzw==
X-CSE-MsgGUID: 9+xq1D8eQNaO38TWv6WaOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87307281"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="87307281"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:21:11 -0700
X-CSE-ConnectionGUID: xFQf5RpMT/eTxhi2+wpCag==
X-CSE-MsgGUID: iNmOiPZISX2EkaMxk6j4FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="248515550"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:21:08 -0700
Date: Mon, 29 Jun 2026 10:21:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V15 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <akIc4vF06qtmIHFO@ashevche-desk.local>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
 <20260626161230.93069-6-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626161230.93069-6-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 26, 2026 at 11:12:26AM -0500, Chris Morgan wrote:

> Add power management support for the ICM42607 device driver.

...

> +/*
> + * Suspend delay assumed from other icm42600 series device, not
> + * documented in datasheet.
> + */
> +#define INV_ICM42607_SUSPEND_DELAY_MS			2000

Perhaps (2 * MSEC_PER_SEC) ?

...

> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel)
> +{
> +	unsigned int oldaccel, oldgyro;

> +	unsigned int sleepval_us = 0;

It's discouraged to have assignment here, as it's too far from the actual use
and makes code harder to maintain and prone to subtle errors. See also below.

> +	unsigned int val;
> +	s64 disable_wait;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_PWR_MGMT0, &val);
> +	if (ret)
> +		return ret;
> +
> +	oldaccel = FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
> +	oldgyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
> +
> +	if (gyro == oldgyro && accel == oldaccel)
> +		return 0;
> +
> +	/*
> +	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
> +	 * for a minimum of 45ms. So if we transition from an on state to an
> +	 * off state make sure at least 45ms have passed before power off and
> +	 * wait if it hasn't.
> +	 */
> +	if (!gyro && oldgyro) {
> +		disable_wait = ktime_us_delta(st->conf.gyro_stop,
> +					      ktime_get());

It's perfectly a single line.

		disable_wait = ktime_us_delta(st->conf.gyro_stop, ktime_get());

> +		disable_wait = clamp(disable_wait, 0,
> +				     INV_ICM42607_GYRO_STOP_TIME_US);

I would leave on a single line, or split logically, meaning moving 0 to the
next line:

		disable_wait = clamp(disable_wait,
				     0, INV_ICM42607_GYRO_STOP_TIME_US);

> +		fsleep(disable_wait);
> +	}

> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);


Perhaps

	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro) |
	      FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);

which is slightly better to read in my opinion.

> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If a state change occurs from off to on, sleep for the startup
> +	 * time of the sensor, unless a sleep_ms is specified. Since more
> +	 * than one sensor can be transitioned from off to on, select the
> +	 * maximum time from each of the sensors changing from off to on.
> +	 * The startup time for the temp sensor is considerably smaller
> +	 * than the startup time for the other sensors and one or more are
> +	 * required to be on for the temp sensor to function, so any start
> +	 * delay should be enough.
> +	 */

	sleepval_us = 0;

> +	if (accel && !oldaccel)
> +		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
> +
> +	if (gyro && !oldgyro) {
> +		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
> +		/* Track the earliest we can turn off the gyroscope. */
> +		st->conf.gyro_stop = ktime_add_us(ktime_get(),
> +						  INV_ICM42607_GYRO_STOP_TIME_US);
> +	}
> +
> +	fsleep(sleepval_us);

The problem is that the reaction to 0 is a gray area. Some architecture
implementations might even complain on that.

On x86, for instance, udelay(0) actually does some (supposed to be small) delay.

But I think due to above check for gyro == oldgyro && accel == oldaccel this
won't happen. Please, add a comment on top of fsleep().

> +	return 0;
> +}

...

> +	dev_set_drvdata(dev, st);

This will require device.h to be included and hence the rest related headers
can be dropped at the same time (like dev_printk.h).

-- 
With Best Regards,
Andy Shevchenko


