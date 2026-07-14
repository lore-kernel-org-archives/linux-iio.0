Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D97382299;
	Tue, 14 Jul 2026 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028346; cv=none; b=XcMix5tHsAmShhtj+dYFQboRk1jhP/tvsfMyVCPpj7izsqFwwQB3gJdtbjo+JBnwkEJYgkrvOVJtHb/7jGIn+NCch8CsWpHt/S08UF0GgGGGYBxDxM9nj/MxmfW+6oQB5PwgfaY6P2vt/IAIo9puQamGP09RO6TOQaLNG8BUclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028346; c=relaxed/simple;
	bh=l8UMWjNryveDRS7zhIlOAJJ2D2SnHH72oo1FcLXgOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9EHiwJVkIGfGvXcDTGRvMn4AdNd9XIv41uDWQJ7SzGnBtJ4k3xTK5oc69kTTrpk7wqo4zkNqiQD+q0HZ/xi1ys4VzHaSN96j60OD701CC7KbcOCNfokuJ2D7IKm+CmnvOfqI04JN8Fem4lMOj0b+j1P8Gfk/j7iPAqEPpkUKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX2Cwu+q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX2Cwu+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028345; x=1815564345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l8UMWjNryveDRS7zhIlOAJJ2D2SnHH72oo1FcLXgOCM=;
  b=mX2Cwu+quAYjtLOxXM2bG6jBQhdQl8Uyx0BO68FpCAP9FRCaHFjd4tBq
   mZbsekV+PVwzQO37htXvhesUG+26XUwNau4XxFqgQPg9UFMgK7m/e+0Lz
   7ZDxRpNqBx8hZ2R27BwZzBrG1nrOTrEvCe+0RmJDBaDPvIFXhNo03Dxh8
   /3Guh9v/c2+E7Cl9MuyrY2yxM3OcFAjCOgV186ADU4WZoGDV6R7BuoulT
   xrAZ5H8Do9z2yhTzQwvjwotPctZOOqvQsqk1O8LWEQl1h/xjEimbRmyDR
   Ir2P3AKVgN8V8x/OLRDHFdEQiOpUHHJP7WfQrX4g4xzx4AF1gaWAopMqF
   Q==;
X-CSE-ConnectionGUID: tipLsSUtT/OoaepYzoH2+A==
X-CSE-MsgGUID: 76u2As8tQTm9dt76ir7/iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102071235"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102071235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:25:45 -0700
X-CSE-ConnectionGUID: Eg7MM2WISMqp9OmKRxpZvQ==
X-CSE-MsgGUID: F+IxOinpT4KWs09Z869aKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254706973"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:25:42 -0700
Date: Tue, 14 Jul 2026 14:25:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v16 06/10] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <alYcsxAKDtGi1sVA@ashevche-desk.local>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-7-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713215842.69097-7-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 04:58:36PM -0500, Chris Morgan wrote:

> Add power management support for the ICM42607 device driver.

...

> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel)
> +{
> +	unsigned int oldaccel, oldgyro;
> +	unsigned int sleepval_us;
> +	unsigned int val;
> +	s64 disable_wait;
> +	int ret;
> +
> +	ret = inv_icm42607_get_pwr_mgmt0(st, &oldgyro, &oldaccel);
> +	if (ret)
> +		return ret;
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
> +		disable_wait = ktime_us_delta(st->conf.gyro_stop, ktime_get());
> +		disable_wait = clamp(disable_wait,
> +				     0, INV_ICM42607_GYRO_STOP_TIME_US);

I would go with this slightly longer line

		disable_wait = clamp(ktime_us_delta(st->conf.gyro_stop, ktime_get()),
				     0, INV_ICM42607_GYRO_STOP_TIME_US);

> +		fsleep(disable_wait);
> +	}
> +
> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro) |
> +	      FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
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
> +	sleepval_us = 0;
> +	if (accel && !oldaccel)
> +		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
> +
> +	if (gyro && !oldgyro) {
> +		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
> +		/* Track the earliest we can turn off the gyroscope. */
> +		st->conf.gyro_stop = ktime_add_us(ktime_get(),
> +						  INV_ICM42607_GYRO_STOP_TIME_US);
> +	}

> +	/* Only sleep if sleepval_us is greater than 0 in case some
> +	 * platforms have issues with a 0 delay. The 0 delay can happen
> +	 * if one or both sensors is shut down.
> +	 */

/*
 * Use the same style for mutli-line comment
 * in all comments.
 */

> +	if (sleepval_us > 0)
> +		fsleep(sleepval_us);
> +
> +	return 0;
> +}

...

> +EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
> +	SYSTEM_SLEEP_PM_OPS(inv_icm42607_suspend, inv_icm42607_resume)

> +	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend,
> +		       inv_icm42607_runtime_resume,
> +		       NULL)

Hmm... perhaps just a single line as well?

	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend, inv_icm42607_runtime_resume, NULL)

> +};

-- 
With Best Regards,
Andy Shevchenko


