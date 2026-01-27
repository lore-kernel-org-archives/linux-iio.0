Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC4342511;
	Tue, 27 Jan 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510375; cv=none; b=H/woCjG1XZTu2DsIz8OM4I05TUU3rUucGpLqIjB3a/tmo8HxDzm+N+V2xdOUm1ELBp+Rnqc7+XD106zTrx3056VOMZPkM2preB/no5fzUWItGnl8APZbY4dd+Rvzcruz/yIQV1ApPON96q/3SFMPlr2t0K1v2lzVsnOHyAEQDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510375; c=relaxed/simple;
	bh=ZzDd73Ng2R6n+Cihacwa8im9RBVNxVzfCxKK5la1Ruw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZtyX4Fri1P+2cw0pQ6uYlbCoS3MRvRbR6+P7E0NiAqZpTpBxJqs2bmkem7Um9XMwmdqFW2XpB3T6fx6+DIisSgPiwcRg9nUiuYWW3VTfWGRFQlIYKhCYdKufAbUi3dr2t+aMBCN0yaN8NIxqBG32Z1VmR4a35Lo+2PJisOilB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4EWu9aG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4EWu9aG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769510374; x=1801046374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzDd73Ng2R6n+Cihacwa8im9RBVNxVzfCxKK5la1Ruw=;
  b=i4EWu9aG+VT/Ilf8tBM5veVUmFEXBn7NSPnneho6eYBvEiXwbzuJzzSJ
   8A6g8l/eNZTSRmIFtu5KUvWcewTMx9vzbv6p9wuZdQL0EP2EvCsC1bpM+
   9CCmP16/xir1WhZJ+NrTI6Qgq8gIhRFpULHZUNRzfktexSUX/WDdjswsn
   qdXvvHYzEcRPlkyKNrWh6fqYiVJCMKhswD4Er+TJjm/YVq1YNoxzFa8y0
   wSPJfGSVCuJrJwe6B9IyUSpkj+ZNLbTJ+xJ+Pfhd3MVTGVWEjAh4hILh0
   aosFCpmmBH6Fm2vBzEuEiwJB297Zp3ozYf96c4BdVUQLsDFkzgOwaHQLV
   A==;
X-CSE-ConnectionGUID: Lbs7WgeBTSmHUmeMlIaQ2w==
X-CSE-MsgGUID: eQHvjUSnTciuKJFynRu9kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70420793"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70420793"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:39:34 -0800
X-CSE-ConnectionGUID: puYNiABrR0iPPznUl3txCg==
X-CSE-MsgGUID: 5S0ziBPTSIW+kc9fWBSz4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207070933"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:39:30 -0800
Date: Tue, 27 Jan 2026 12:39:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 5/8] iio: dac: ds4424: convert to regmap
Message-ID: <aXiV35CoH6f8FPUT@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127060939.3914006-6-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 07:09:36AM +0100, Oleksij Rempel wrote:
> Refactor the driver to use the regmap API.
> 
> Replace the driver-specific mutex and manual shadow buffers with the
> standard regmap infrastructure for locking and caching.
> 
> This ensures the cache is populated from hardware at probe, preventing
> state desynchronization (e.g. across suspend/resume).
> 
> Define access tables to validate the different register maps of DS44x2
> and DS44x4.

...

> +static const struct regmap_access_table ds44x4_table = {
> +	.yes_ranges = ds44x4_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ds44x4_ranges),

+ array_size.h

> +};

...

> +		ret = regmap_read(data->regmap, DS4424_DAC_ADDR(chan->channel),
> +				  &regval);
>  		if (ret < 0) {
> -			pr_err("%s : ds4424_get_value returned %d\n",
> -							__func__, ret);
> +			pr_err("%s : regmap_read returned %d\n",
> +						__func__, ret);

This should be dev_err() to begin with. Perhaps you want a new patch for that.

>  			return ret;
>  		}

...

> +	/* Bulk read all channels starting at 0xf8.
> +	 * This populates the regmap cache with current HW values.
> +	 */

/*
 * Use proper style for multi-line
 * comments.
 */

...

> +	if (ret)
> +		return dev_err_probe(&indio_dev->dev, ret, "Failed to seed cache\n");

Why not physical device? I assume during probe we use physical device, when we
do IIO callbacks, we use IIO device.

...

>  static int ds4424_suspend(struct device *dev)
>  {
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ds4424_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Disable all outputs, bypass cache so the '0' isn't saved */
> +	regcache_cache_bypass(data->regmap, true);
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +		ret = regmap_write(data->regmap, DS4424_DAC_ADDR(i), 0);
> +		if (ret) {
> +			dev_err(dev, "Failed to zero channel %d: %d\n", i, ret);

%u for 'i'.

> +			regcache_cache_bypass(data->regmap, false);
>  			return ret;
> +		}
>  	}
> +	regcache_cache_bypass(data->regmap, false);
> +
> +	regcache_cache_only(data->regmap, true);
> +	regcache_mark_dirty(data->regmap);
> +
> +	return 0;
>  }

...

>  	usleep_range(1000, 1200);

Side note: Perhaps fsleep() in the future...

> +	ret = ds4424_init_regmap(client, indio_dev);
> +	if (ret < 0)

Do we need ' < 0' part?

> +		goto fail;
> +
> +	ret = ds4424_verify_chip(indio_dev);
> +	if (ret < 0)

Ditto.

> +		goto fail;

-- 
With Best Regards,
Andy Shevchenko


