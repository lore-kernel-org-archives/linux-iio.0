Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B043DEDA;
	Fri,  2 Oct 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927607; cv=none; b=erVwxorbdaqJj6e3Zf2ZUJC30TY+3bFQvRYMw20qTyAtkQ0fKV0TrQlYL0gr8bpmVNjQ6ewo0ZUqzMxqHQ4fbqg7Ah++WpS1JnlKNbuiq42jp8Mtv9CRr1jV2xk4Z/+4MPQyowiHjQzb/Mb2lkglYm/9Zo1pEvOYoE1Pp/PB/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927607; c=relaxed/simple;
	bh=OfplhBT++WQsNhZIkkqJQlDrbFhJnMQOYEBvuh5N+d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrPNYJDUTMp3OPoCHP+l+wY69CgbO+ZNSxoBNmdPkvQJFtGI7isb0SiNUdu0ZU1ABN1Y04+WRCGIgeVuDNnUFieDjAlq6jDMfF42rfqgjbR1ihihi20ubHFwkDScMO/K/RSFuQzlQEsdO6lFKTNJzVqOswNgCtekDh/yVfhyeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSU6gF8m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSU6gF8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790927606; x=1822463606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OfplhBT++WQsNhZIkkqJQlDrbFhJnMQOYEBvuh5N+d0=;
  b=TSU6gF8mh8/ENfYSIcNtu5n0T2xiaUH9Ct6VI9NnYuaE9MBGgNo+FejH
   LmlaFezsK1atcKDWxuK40OhTycuTeDGLaVgw0LvJ12UKYQLxJmZjMES7R
   PZL381DXns+dHLzJb1QsL6NB0uxdsqIRlsAk18/C6sT8Uh7WSscWPe7Di
   LN3E57Ypaw9Hrmb05oF+YCy4oKw8XKkuKioiqEmMAYKC4ZYa+uZLWK3Gw
   PJUywICbnsBIzRwSeU0JZuKfqUMz7ArcfZJiQ9T7PQmbMmuHbTbT3qBXY
   3mFbsg+BUppDA0tFVqJB2MXhkjhQyfdfDpNzGfQDTwCHUkHkSKvl7hX7t
   g==;
X-CSE-ConnectionGUID: lYvGdoGSS/abDyNfNrdNUA==
X-CSE-MsgGUID: GWjJYSVFQGmL1YCgl5tMWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90904756"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90904756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:53:25 -0700
X-CSE-ConnectionGUID: eQy9liTuRqmN7AUTTXl6rw==
X-CSE-MsgGUID: Fyl2DyfpRi+yjO5idWO8Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314178670"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:53:22 -0700
Date: Fri, 2 Oct 2026 10:53:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v11 2/5] iio: pressure: dps310: read buffered samples
 from the hardware FIFO
Message-ID: <ar9i8D9OTQpD80Lw@ashevche-desk.local>
References: <20261002072526.250081-1-zoone.rupert@gmail.com>
 <20261002072526.250081-3-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002072526.250081-3-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 10:25:23AM +0300, Rupesh Majhi wrote:
> DPS310 has a 32-entry FIFO shared by both measurements. Drain it from a
> work item and push what it held, so buffered capture needs no trigger.
> Nothing in tree wires the interrupt pin, so the work rearms itself at
> half the FIFO fill time.
> 
> Each entry carries one measurement, so a pressure entry is compensated
> with the temperature ahead of it. Pressure read before a session's first
> temperature is held until one arrives rather than dropped, so the first
> push can wait a temperature period.
> 
> FIFO entries are not timestamped, so postenable refuses the timestamp
> channel unless a trigger is attached.
> 
> Tested on a DPS310 on a BeagleBone Black.

...

> +{
> +	u8 val[3];
> +	s32 raw;
> +	int rc;
> +
> +	/* Entries come out of the pressure registers whichever made them */
> +	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
> +	if (rc < 0)
> +		return rc;
> +
> +	raw = get_unaligned_be24(val);
> +	if (raw == DPS310_FIFO_EMPTY_VAL)
> +		return DPS310_FIFO_EMPTY;
> +
> +	*value = sign_extend32(raw, 23);
> +
> +	return raw & DPS310_FIFO_TAG_PRS ? DPS310_FIFO_PRESSURE :
> +					   DPS310_FIFO_TEMP;

Make it a single line (yes, 83 characters).

> +}

...

> +static unsigned int dps310_fifo_push_held(struct dps310_data *data)
> +	__must_hold(&data->lock)
> +{
> +	unsigned int pushed = 0;
> +	unsigned int i;
> +
> +	for (i = 0; i < data->fifo_held; i++) {

	for (unsigned int i = 0; i < data->fifo_held; i++) {

> +		if (!dps310_fifo_push_scan(data, data->fifo_temp_raw,
> +					   data->fifo_hold[i]))
> +			pushed++;
> +	}
> +
> +	data->fifo_held = 0;
> +
> +	return pushed;
> +}

...

> +/*
> + * Read the batch out before compensating it, so a pressure entry pairs with
> + * the temperature preceding it rather than the last one in the batch.
> + *
> + * Returns scans pushed.
> + */
> +static int dps310_fifo_drain(struct dps310_data *data)
> +	__must_hold(&data->lock)
> +{
> +	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
> +					 data->iio->active_scan_mask);
> +	u8 kind[DPS310_FIFO_DEPTH];
> +	s32 raw[DPS310_FIFO_DEPTH];
> +	unsigned int pushed = 0;
> +	unsigned int cnt, i;
> +	int rc;
> +
> +	for (cnt = 0; cnt < DPS310_FIFO_DEPTH; cnt++) {

Ditto.

> +		rc = dps310_fifo_read_entry(data, &raw[cnt]);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (rc == DPS310_FIFO_EMPTY)
> +			break;
> +
> +		kind[cnt] = rc;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {

Ditto.

> +		if (kind[i] == DPS310_FIFO_TEMP) {
> +			data->fifo_temp_raw = raw[i];
> +			data->fifo_temp_valid = true;
> +
> +			if (pressure_enabled)
> +				pushed += dps310_fifo_push_held(data);
> +			else if (!dps310_fifo_push_scan(data, raw[i], 0))
> +				pushed++;
> +			continue;
> +		}
> +
> +		if (!pressure_enabled)
> +			continue;
> +
> +		if (!data->fifo_temp_valid) {
> +			dps310_fifo_hold(data, raw[i]);
> +			continue;
> +		}
> +
> +		if (!dps310_fifo_push_scan(data, data->fifo_temp_raw, raw[i]))
> +			pushed++;
> +	}
> +
> +	return pushed;
> +}

...

> +static void dps310_fifo_work(struct work_struct *work)
> +{
> +	struct dps310_data *data = container_of(to_delayed_work(work),
> +						struct dps310_data, fifo_work);
> +	int rc;
> +
> +	mutex_lock(&data->lock);
> +	rc = dps310_fifo_drain(data);
> +	mutex_unlock(&data->lock);

What's wrong with scoped_guard()?

> +	if (rc < 0)
> +		dev_dbg(&data->client->dev, "FIFO drain failed: %d\n", rc);
> +
> +	schedule_delayed_work(&data->fifo_work,
> +			      msecs_to_jiffies(data->drain_interval_ms));
> +}

...

> +static int dps310_buffer_postenable(struct iio_dev *iio)
> +{
> +	struct dps310_data *data = iio_priv(iio);
> +	int rc, prs_rate, tmp_rate;
> +
> +	/* An attached trigger drives the capture instead, FIFO stays off */
> +	if (iio_device_get_current_mode(iio) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	/* Entries are not timestamped and the drain timer is no substitute */
> +	if (iio_scan_timestamp_enabled(iio))
> +		return -EINVAL;

> +	mutex_lock(&data->lock);

Refactor this to make one use guard()() and the inner one to use kfree().

> +	rc = dps310_get_pres_samp_freq(data, &prs_rate);
> +	if (rc)
> +		goto err_unlock;
> +
> +	rc = dps310_get_temp_samp_freq(data, &tmp_rate);
> +	if (rc)
> +		goto err_unlock;
> +
> +	data->drain_interval_ms = dps310_fifo_interval(prs_rate, tmp_rate);
> +
> +	rc = dps310_fifo_hold_alloc(data, prs_rate, tmp_rate);
> +	if (rc)
> +		goto err_unlock;
> +
> +	/* Drop whatever accumulated before enable */
> +	rc = dps310_fifo_hw_flush(data);
> +	if (rc)
> +		goto err_hold;
> +
> +	rc = dps310_fifo_set_enable(data, true);
> +	if (rc)
> +		goto err_hold;
> +
> +	schedule_delayed_work(&data->fifo_work,
> +			      msecs_to_jiffies(data->drain_interval_ms));
> +
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +
> +err_hold:
> +	kfree(data->fifo_hold);
> +err_unlock:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}

-- 
With Best Regards,
Andy Shevchenko


