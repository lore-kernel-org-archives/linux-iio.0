Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF63DA7FD;
	Mon, 15 Jun 2026 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519317; cv=none; b=rFdeBGsHJOi4nQcf6FNFKZFH4lTKZAYV1s6/ERrgnkGoAaObf4O9y3QkpXbDLWt70bYDOpq41xC/3eEYT21cxH1k2h6kWHUkkPLJbu/r/VQX9SHc0CfXZ3rIMUst286Ncs7i4hNKqiTlwN6jnhorR1pXYRVWlTFj0ZnTEVrE3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519317; c=relaxed/simple;
	bh=cjmYWfC1zuAZ0CEHetrNd9YiohGW7mbOzZNdkkXbyUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlpXBXNEHzENonEm1t1YouYVuzSoOYyMhUMW1GwitQhkyo8SC0qnJ135+LB4HsVAsIaaX28Tqii0quMeZbyx0AB7b5uN63ucigj0gUaqROAJj06VTsSM22/JIDHQmd5Hcm3+P+fH1NCb0geWAdt5W3We23Ae4XfebiDaUe4umCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/CxWoJo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/CxWoJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781519315; x=1813055315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjmYWfC1zuAZ0CEHetrNd9YiohGW7mbOzZNdkkXbyUo=;
  b=f/CxWoJo+ZKZcekHfx99M8qXSq3+V5tB+jakfPq8EuMYuqWFJFJMh4l1
   Ue0MDOZ0r3rOUHLkmv4g/NoQjcaL6r+lYAFu/qbjf6i+iYeNT+dB/GjgW
   98njBGvyq4c8hhkFpm48PAR6rMjltTUwOScR8bqFrckYqkKxrU1YJDsst
   Fb9xU9lPyclCOwKdhw+761W0hwlfKJBqjjunAY4hzyu5eu/f6VdacocQ1
   GHjFmle0omZ7AOVUb1vpnLnIMZ9OpR6QPOZPBPI3eAj4etcLc+7AettjG
   o56JmwatE9M95BXfUlh4/ixagaRQZp2oj32Erw7z/zxlfRw9rSJTwCIRP
   Q==;
X-CSE-ConnectionGUID: zdTv42NxSES1T2ifet68WQ==
X-CSE-MsgGUID: E5viAEppQFi4fKAv2QgKqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93371798"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="93371798"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:28:35 -0700
X-CSE-ConnectionGUID: 8KEZcgDwST6M1JTXFdyAjg==
X-CSE-MsgGUID: j6gxE4dnTQeRTw5bK8cP2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="244527019"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:28:32 -0700
Date: Mon, 15 Jun 2026 13:28:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V12 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <ai_Tzbl3sZlyrh2M@ashevche-desk.local>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-6-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611202607.85376-6-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 03:26:02PM -0500, Chris Morgan wrote:

> Add power management support for the ICM42607 device driver.

...

> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel,
> +				      bool temp, unsigned int *sleep_ms)
> +{
> +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> +	bool oldtemp = st->conf.temp_en;
> +	unsigned int sleepval_ms;
> +	unsigned int val;
> +	int ret;
> +
> +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> +		return 0;

This validation seems weak, see below why.

> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> +	/*
> +	 * Note that temp being enabled here doesn't affect PM since
> +	 * per 10.25 of the datasheet the clock will be off by default
> +	 * if both the gyro and accel modes are off.
> +	 */
> +	if (!temp)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	st->conf.gyro.mode = gyro;
> +	st->conf.accel.mode = accel;
> +	st->conf.temp_en = temp;

> +	sleepval_ms = 0;
> +	if (temp && !oldtemp)
> +		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
> +
> +	if (accel != oldaccel)
> +		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
> +
> +	if (gyro != oldgyro)
> +		sleepval_ms = max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);

Does it mean that it might be more than a single conditional to become true?
If so, the last code wins, which is most likely buggy approach. Can you put
a comment, and possible convert this to if-else-if, to clarify what's going
on here?

> +	if (sleep_ms)
> +		*sleep_ms = sleepval_ms;
> +	else if (sleepval_ms)
> +		fsleep(sleepval_ms * USEC_PER_MSEC);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


