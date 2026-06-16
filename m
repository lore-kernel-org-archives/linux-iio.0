Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295942849D;
	Tue, 16 Jun 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604791; cv=none; b=Y3l6jjnylV0p+S1WVr7YgqLvYd2KmoMB7PwTdHX15Rrc5hhefDy6b44dgbauJOgWNJgE7m+Oo6kNqtdYECqRD7RJJnaZFfbPnA0BN0v67DtMMXhlycC/N6eGRuHSwD4NG1YtoRpkCZw4qmMscPubEZyt6yqWe1GHiRyo2lQgpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604791; c=relaxed/simple;
	bh=6dFDHXNtHg0u97qJxf5xxtSXPyR/eEq69ffJ9TijGWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRofBywgmIdn4aLUK0X1fsgtK/su1ivoXvKPMkbfcH/1qplEzDgRBo6rJTEgimArbjPXiVknB2kZdla6lpQkvB9Qt2rv/+VDK9EWni/inZSuvQcWRwHirdd3AWN4pWZcIuSRt6Ru+9pTeLWw4w3XKcFIhlEEhmRkoe60TXtEThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEuNLQDI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEuNLQDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781604790; x=1813140790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6dFDHXNtHg0u97qJxf5xxtSXPyR/eEq69ffJ9TijGWM=;
  b=lEuNLQDIxITuV7A+MX0MPpYW4mz38TUpX2gTH4Tx/a4V1/7MJ2uUxSgC
   5suVo/jfLpQy4kQRFxMk9yNOPBrbTlFF1fDwCq7evCru7349bd7lXd5sf
   Ar9aqFgF0llV4tg5BN9IyNUQqAPjaQ2QWHZYceZEcDVkeZZ+XR5dFbQ/J
   OvjgN5rrPWBFkoIoonbvjMAIx2ZBHCuLNVO3L/rsek7XSzGaRcIMSJtwa
   BCeoxFGBxnimM9W7Dz4h4TDmhirVD69f5htLiAuzPPkI5nuJtQcs0ie+2
   dKKHMKptfxdik5YSuozLa8ZkfL5mVoR9+wPHAA04njLcuh0qmcdLnh3rz
   g==;
X-CSE-ConnectionGUID: P+WbCnxFS/isJf8zatELMA==
X-CSE-MsgGUID: dibGRqG9RhaM12xPfYgbuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82265959"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82265959"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:13:09 -0700
X-CSE-ConnectionGUID: 0lkZWENTT8qXrqKGdlIjgA==
X-CSE-MsgGUID: AGaXGqliSROjTFk6fKoyYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="245358499"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:13:06 -0700
Date: Tue, 16 Jun 2026 13:13:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Message-ID: <ajEhr0JIQwzRgoZa@ashevche-desk.local>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-9-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615172554.160910-9-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:25:51PM -0500, Chris Morgan wrote:

> Add gyroscope functions to the icm42607 driver.

...

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

Same comment as per previous patch. But looking at this, can you rather have
a helper that answers the below two questions? Something like

void _assign_conf(..., bool *write_odr, bool *write_filter)
{
	...
}
EXPORT_...

in the core driver? But wight both approaches and choose either existing one
(as in this patch series) or what I suggested.

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

...

> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	guard(mutex)(&st->lock);
> +
> +	odr = st->conf.gyro.odr;
> +
> +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_gyro_odr); ++i) {

Same comment, why pre-increment?

> +		if (i == odr)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(inv_icm42607_gyro_odr))
> +		return -EINVAL;
> +
> +	*val = inv_icm42607_gyro_odr[i][0];
> +	*val2 = inv_icm42607_gyro_odr[i][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int inv_icm42607_gyro_write_odr(struct iio_dev *indio_dev,
> +				       int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_gyro_odr); ++idx) {

Ditto.

> +		if (val == inv_icm42607_gyro_odr[idx][0] &&
> +		    val2 == inv_icm42607_gyro_odr[idx][1])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_gyro_odr))
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
> +	return inv_icm42607_set_gyro_conf(st, &conf, NULL);
> +}

Can be some of the code deduplicated between gyro and accel?

-- 
With Best Regards,
Andy Shevchenko


