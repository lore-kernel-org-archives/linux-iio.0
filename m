Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995052C11F1;
	Tue, 16 Jun 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604285; cv=none; b=JlqAexm3lB3nN/f3uPY1fhU1HO1HFwt2qQEo0aIjmY3SXAtSbAQDSCPuWjUFJTC6dmx+pKl7cTez9Er2y3od5wV/O16q1MrPs6ETDTCKw7L4MomFBArQOAnusMVCztLgSvp36lnTTPX2+1y9Xe2bkfia0sAUMVESIm2kV13svuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604285; c=relaxed/simple;
	bh=3Ykr0UXG7WHwZgqC5hSi/MM9Gsz/j2L9I9r42E8jsFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPdFMshIwJTiM1MHcmuavfrwKl0uLXqrbw2Xb/jO7XQ/IX7k7dW8vlvmjABRYQQazGMnTvF4u6lh1o/a8DZw+dhSYGhKiZeAT3F6BSxOcYmjBpWCwdc/p/8SFzGPujREDmiw0ER9aEtc9kdJOhN+NWfkkxj39gZRFIFnQjA5BgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ca33k5Ar; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ca33k5Ar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781604283; x=1813140283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Ykr0UXG7WHwZgqC5hSi/MM9Gsz/j2L9I9r42E8jsFE=;
  b=ca33k5ArwDlI43a/UFZwZT3snWt/ORYZvgk5qNrTbbz4SU1Lv5fGRnfX
   St3jprZ+u9fgkQH3cA9WvGDayKHcVliLNWWfiJjEpXSYq0RwP+ChVryoi
   PFFWpDG08aGmBL202Wk58HnVhLMfcVrc4/+BU3MNYr5RECaaIzv6Mi1bY
   hGLG9DbhD7C9ajkUGK03QeDBH+NimYVrdjmSBF8QqZwRw566sNVkh4TQd
   yVVWdQQZwMmKjoDSCGQjlM7k0ASwPTH5pGjbgq18NTUhYiYmZ9XFDvkZv
   +gNOmJMIJpl4MfwZnzb4111cmjNPhTzqiUybLpQFdn87ngTBL51hx21Wm
   g==;
X-CSE-ConnectionGUID: Z2I2naBtR3meTRSAk1En9A==
X-CSE-MsgGUID: ZgYX44ZySm+VNgfwImVS9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82428029"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82428029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:04:42 -0700
X-CSE-ConnectionGUID: vS8pse/1T+WzO7ekmQCHLw==
X-CSE-MsgGUID: KQsZrstoQSG4L7181eZ2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="271792857"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:04:38 -0700
Date: Tue, 16 Jun 2026 13:04:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V13 7/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <ajEftPsZVtmKS6dr@ashevche-desk.local>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-8-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615172554.160910-8-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:25:50PM -0500, Chris Morgan wrote:

> Add icm42607 accelerometer sensor for icm42607.

...

> +static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
> +				       int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	guard(mutex)(&st->lock);
> +
> +	odr = st->conf.accel.odr;
> +
> +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {

Same comment stays. Why pre-increment?

> +		if (i == odr)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;
> +
> +	*val = inv_icm42607_accel_odr[i][0];
> +	*val2 = inv_icm42607_accel_odr[i][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
> +					int val, int val2)
> +{
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	int ret;
> +
> +	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_accel_odr); ++idx) {

Ditto.

> +		if (val == inv_icm42607_accel_odr[idx][0] &&
> +		    val2 == inv_icm42607_accel_odr[idx][1])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;
> +
> +	conf.odr = idx;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	return inv_icm42607_set_accel_conf(st, &conf, NULL);
> +}

...

> +int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
> +				struct inv_icm42607_sensor_conf *conf,
> +				unsigned int *sleep_ms)
> +{
> +	struct inv_icm42607_sensor_conf *oldconf = &st->conf.accel;
> +	unsigned int val;
> +	int ret;
> +
> +	if (conf->mode < 0)
> +		conf->mode = oldconf->mode;

Also as per below.

> +	if (conf->fs < 0)
> +		conf->fs = oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr = oldconf->odr;

> +	if (conf->filter < 0)
> +		conf->filter = oldconf->filter;

This conditional is not immediately used below...

> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> +		val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->fs);
> +		val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->odr);
> +		ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +		oldconf->fs = conf->fs;
> +		oldconf->odr = conf->odr;
> +	}

...you can move it here.

> +	if (conf->filter != oldconf->filter) {
> +		if (conf->mode == INV_ICM42607_SENSOR_MODE_LOW_POWER) {
> +			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, conf->filter);
> +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> +						 INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, val);
> +		} else {
> +			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
> +					 conf->filter);
> +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> +						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
> +		}
> +		if (ret)
> +			return ret;
> +		oldconf->filter = conf->filter;
> +	}
> +
> +	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
> +					  st->conf.temp_en, sleep_ms);
> +}

-- 
With Best Regards,
Andy Shevchenko


