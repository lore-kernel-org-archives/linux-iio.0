Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABC26E708;
	Mon, 16 Feb 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230812; cv=none; b=T0uP5iePC60uklRI1or13zv2RhgkbdaRz/XZ/tOfMdS53b2NVHYH8QECUBOCS78FEtvNDB3dYysfiwvdKFUb8WTWP3PpxinG/dPiRRI0uIOg1U/uMSJifyuCoaIkUvrIE0Yjn3EflGVpdURZAxHAsTyz4DuSPR3lEh4/pVbgz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230812; c=relaxed/simple;
	bh=opSHu61CFet3/Jz7C6WOB9/DKeY943oc7etfnT3xRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAoGHgB0/4fO54rRSSFPHHxUkP1vYzOihbpKeHbX2pDCxDJdmWE8U6iO0WJ1ldhJYYpqFEQmAscM9zlZiDlc8BtvTguUuuQzKivTttzNFVvlhd7ZleqFycO0YIJmAsY0oTxXl5ZPj+6pfoEKjBmAxdCYoQgALafTAS91LVxEC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zex4eqHY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zex4eqHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771230811; x=1802766811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opSHu61CFet3/Jz7C6WOB9/DKeY943oc7etfnT3xRog=;
  b=Zex4eqHYBzlstZRRkVPhbxQxFRVUh9KWOAFHJXFuqJFhdCNzRj8SjYeP
   3Xz24ColNWHsccau06w2g6GugYYJQ1i1drb1d/vR5W7m+JTvgFhVr3pRf
   556N1MiJF6bTk0ScFuPMg6DPkXROgxYXel0kbSbSBiiRRgdH4nLVu1nHQ
   7FoVxIcTUrLIxzw/M5Ql5bO0NlXHeeTmRv8NQmZIXrmk3OqeHRHCxbRpu
   x9uBroqbgsimBLED7Mbm4Bvfr6dhjCtiFxNNdoRNNlbPtuuz9btmEKEF7
   cXbcG3f/rBQ4TEHG6TTYi5WrlQEDgHQcLGuMj9/3QFah6XjWP7nYnlQhX
   Q==;
X-CSE-ConnectionGUID: cHgrVCLFSSetX0qrkk/MIw==
X-CSE-MsgGUID: ooMoi9RtT02GXaffweOODQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="94939045"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="94939045"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 00:33:30 -0800
X-CSE-ConnectionGUID: COGWUH/AS6WJslnnuo/UUw==
X-CSE-MsgGUID: JULINY6OQueQBMbpd4t75w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="212784577"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 00:33:28 -0800
Date: Mon, 16 Feb 2026 10:33:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <aZLWVcdoKrI_ICD2@smile.fi.intel.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
 <20260216015454.61836-2-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216015454.61836-2-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 15, 2026 at 08:54:52PM -0500, Neel Bullywon wrote:
> Use guard() and scoped_guard() to replace manual mutex lock/unlock
> calls. This simplifies error handling and ensures RAII-style cleanup.
> 
> guard() is used in read_raw, write_raw, trig_reen, trigger_set_state,
> suspend, and resume. Case blocks using guard() in read_raw and
> write_raw are wrapped in braces at the case label level to ensure
> clear scope for the cleanup guards.
> 
> scoped_guard() is used in remove and runtime_suspend where a short
> mutex-protected scope is needed for a single function call.
> 
> The trigger_handler function is left unchanged as mixing guard() with
> goto error paths can be fragile.

...

> -	mutex_lock(&data->mutex);
> -	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> -	mutex_unlock(&data->mutex);
> +	scoped_guard(mutex, &data->mutex)
> +		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);

Wonder if we can move this to a helper:

static int bmc150_magn_set_power_mode_locked(data, mode) // locked or unlocked, dunno with proper naming
{
	guard(mutex)(&data->mutex)
	return bmc150_magn_set_power_mode(data, mode, true);
}

...

> -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> -					 true);
> -	mutex_unlock(&data->mutex);
> +	scoped_guard(mutex, &data->mutex)
> +		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> +						 true);
>  	if (ret < 0) {
>  		dev_err(dev, "powering off device failed\n");
>  		return ret;
>  	}

Ditto.


...

>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&data->mutex);
> -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> -					 true);
> -	mutex_unlock(&data->mutex);
>  
> -	return ret;
> +	guard(mutex)(&data->mutex);
> +	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> +					  true);

Ditto.

>  }
>  
>  static int bmc150_magn_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&data->mutex);
> -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> -					 true);
> -	mutex_unlock(&data->mutex);
>  
> -	return ret;
> +	guard(mutex)(&data->mutex);
> +	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> +					  true);

Ditto.

>  }

-- 
With Best Regards,
Andy Shevchenko


