Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B148F854;
	Tue, 13 Oct 2026 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924660; cv=none; b=dgth+s3UYTjI6DYvuhk3K7NA9rrm6YUYJgQlXh5gHdRKd52f1/3qsv2n9g/GI5L9F/5F1kjPAdjbDW8Ww9niAYK2F6SoDk4R5GfnN254eZjhLJ6NdPqyoYuxT+TzwgSQCtcwTN7iTdIB22f2LsBnXixkEk8NXAo6GpVa1ChBYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924660; c=relaxed/simple;
	bh=xYltfeedV2QbilRvLRrX1ztgmK5WAaTuJsRZS5mP9yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX/R6zJFP2Zqh8OTzXuXDrv8qszM59N44g+w6QKlCEDUjM6ynupfwX26StotOvOp9yNnQNxEIV7NLpEhmdLNEJz/9Xdfap2ZwE9Q80ZX2bcyP5O7L4czrMOm/LRPoMXiWUpFKIjb35Hhr9Z4hV7hCfXhFTtMqeVJ2GcBgirdi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxJuHOsq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxJuHOsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791924659; x=1823460659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYltfeedV2QbilRvLRrX1ztgmK5WAaTuJsRZS5mP9yM=;
  b=fxJuHOsqQAvhyeNULSUHYKh93yyPRV+HKGMjf6YBicdbFHT19XgT8OQk
   laQjIDjZvGsauaCnQKq02hHnjZaflhyPVsOPIRdYXmgFs8pQVsE/JLIx2
   Fn1CmIfncyCRQEdBOje0BJq75xeatepMteqb+vBoN97+uVreNsejTG+ic
   jVElfZnxQ+1IqSub24uhmY8aqHMG/ciQl+hz/WuvrvfHcSZgVl/nqZvUR
   pbH848gR194whgsaz7N1XVvtRXwFs2YELR8Dfe1uJPQuwjdhWrnDOh898
   /MtFHjLvxkH6sJIhqrE6tkNAJJH8NT2GCdhetdPJxXHNC1qdg5X9+J5e2
   A==;
X-CSE-ConnectionGUID: 14KlwI5jQY+6hPc5t9nyLA==
X-CSE-MsgGUID: HwVqGe6YTuaI6Z2LMiWP9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="550420"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="550420"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:50:58 -0700
X-CSE-ConnectionGUID: 9FHqfzppRWCwhaTPQexoQQ==
X-CSE-MsgGUID: J+UQZ1/WSdarrjZb3EwIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1698739"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:50:56 -0700
Date: Tue, 13 Oct 2026 23:50:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: development@redaril.me
Cc: Peter Rosin <peda@lysator.liu.se>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: afe: iio-rescale: Add platform IDs
Message-ID: <as6ZrXFDWKLqPPvn@ashevche-desk.local>
References: <20261008-iio_rescale_platform_ids-v1-1-019f1c144022@redaril.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-iio_rescale_platform_ids-v1-1-019f1c144022@redaril.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 08, 2026 at 11:27:59PM +0200, Fabio Forni via B4 Relay wrote:

> When a rescaler is probed starting from a `struct swnode`,

How? Pure platform devices can't be probed from struct swnode.

> device_get_match_data() will always set rescale->cfg to NULL,
> because device_get_match_data() is unimplemented for software nodes.
> 
> This commit makes the probe function fall back to platform IDs when

Read Submitting Patches documentation on imperative mode (search for
'This patch').

> it couldn't fetch the rescaler configuration from the match table.

...

> +static const struct platform_device_id rescale_platform_ids[] = {
> +	{ .name = "current-sense-amplifier",
> +	  .driver_data = CURRENT_SENSE_AMPLIFIER, },

Drop trailing inner commas and make these one-liners (yes, long ones).

	{ .name = "current-sense-amplifier", .driver_data = CURRENT_SENSE_AMPLIFIER },

> +	{ .name = "current-sense-shunt",
> +	  .driver_data = CURRENT_SENSE_SHUNT, },
> +	{ .name = "voltage-divider",
> +	  .driver_data = VOLTAGE_DIVIDER, },
> +	{ .name = "temperature-sense-rtd",
> +	  .driver_data = TEMP_SENSE_RTD, },
> +	{ .name = "temperature-transducer",
> +	  .driver_data = TEMP_TRANSDUCER, },
> +	{ }
> +};


>  static int rescale_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct iio_dev *indio_dev;
>  	struct iio_channel *source;
>  	struct rescale *rescale;
> +	const struct platform_device_id *id;

Keep reversed xmas tree order, please.

>  	int sizeof_ext_info;
>  	int sizeof_priv;
>  	int i;

...

>  	rescale->cfg = device_get_match_data(dev);
> +	if (!rescale->cfg) {
> +		id = platform_get_device_id(pdev);
> +		if (!id)
> +			return dev_err_probe(dev,
> +					     -EINVAL,

ENODATA

> +					     "missing or invalid device configuration");
> +
> +		rescale->cfg = &rescale_cfg[id->driver_data];
> +	}

And it's better to make it a helper, actually we have drivers [1] that do
something similar, I would recommend you considering adding that helper
directly into platform driver core. But at least local one is a good start.

[1] for example, drivers/pinctrl/intel/pinctrl-intel.c.

-- 
With Best Regards,
Andy Shevchenko


