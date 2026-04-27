Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97283CD8C9;
	Mon, 27 Apr 2026 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298904; cv=none; b=AwAS+39WXdjA8NfIYRpHb9ctbD5FW6TiJHHqeb/bgHTeD5WUsgk41iJk6dYDdgpHbRwmejQK5bqyQAHz+DJnl8M9z/HmDWEY/hB446lXhOpE7oH4ilHqaU786EQhIoByf3z1i7A/8V+ZJpKU7XanwU9349THyvdtvYzbhw972ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298904; c=relaxed/simple;
	bh=jAO5cLk3TEjotVwYima79o1qK3z5XTXzUH9IFQ8dsBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=equ4d9tiUIKZ4DcIqRltnNrVgqYpySKXXFkvZmbs6hTJpAAdXBsG9O7XV+3wQ7c5wD5sGrBrfFrIu9ewnompzRMiiAtFKsPr4OXF5rMYKAhCnpTTMHLO1iHhWj825PsL4x6WwPgy3tUt3+C9C2x2pryKzjUZvn/Wuxd2W1zCMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2Qfc2Qr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2Qfc2Qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777298904; x=1808834904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jAO5cLk3TEjotVwYima79o1qK3z5XTXzUH9IFQ8dsBo=;
  b=K2Qfc2QrPDbTatJYe7yKIvyWG0MPHwjOBMu/HPjqTU8KEkRIfxfgZJG1
   n012+p42ORaCoPsa6M3CE8nMZ5sEkoD7WZ50S5Sykh/++mK2pITzpwtYU
   h0OnLAQrafaZzEfXHdG3/tx017EUhUq9nje/S4weimTm/0WSE7D0SAiQl
   elQ6LVaJgniIABx5GNHu2G7btc7TKyHq2Ax5sNUAvURgxpTJfRb/NV7Er
   0gLn3VuYrJWbQsY880hPjAKSNhWxeqdwE/LP0uMKkv8fxKFRtaGqbobXH
   9HcNY7tuSW604RiOLAuiQoe4KkY1p6iOdsLQPqnjeIfy7LSId8TyCQFi9
   w==;
X-CSE-ConnectionGUID: ghJgSBWKRWKue+rmWInafA==
X-CSE-MsgGUID: owYGEN7LQCSzv2XGw21XxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95748900"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="95748900"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:08:23 -0700
X-CSE-ConnectionGUID: 73rH3C44SuiNeD1Q3GuLZA==
X-CSE-MsgGUID: +qwOXb0NTgS5A0tafG3GWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="233922321"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:08:20 -0700
Date: Mon, 27 Apr 2026 17:08:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iio: adc: hx711: introduce hx711_chip_info
 per-variant structure
Message-ID: <ae9t0WuhKgcPkfIt@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-5-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427100950.33936-5-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 03:39:35PM +0530, Piyush Patle wrote:
> Add struct hx711_chip_info to hold per-variant static configuration:
> device name, IIO channel spec array, IIO info ops pointer, and channel
> count. Store a chip_info pointer in hx711_data and populate indio_dev
> fields from it at probe time instead of hardcoding them.
> 
> Use device_get_match_data() to look up the chip_info pointer from the
> of_device_id table. Guard against a NULL return so that the driver
> fails cleanly if probed via the platform name match path without
> associated match data.
> 
> No functional change for existing HX711 users.

All the above is fine, but I missed the answer to the question "why?"
You need to add that this is preparatory change to add more HW support
or something alike along these words.

...

> +static const struct hx711_chip_info hx711_chip = {
> +	.name		= "hx711",
> +	.channels	= hx711_chan_spec,
> +	.iio_info	= &hx711_iio_info,
> +	.num_channels	= ARRAY_SIZE(hx711_chan_spec),

The array_size.h inclusion should go with this patch.

> +};

...

>  	struct device *dev = &pdev->dev;
>  	struct hx711_data *hx711_data;
> +	const struct hx711_chip_info *chip_info;

Preserve reversed xmas tree order.

>  	struct iio_dev *indio_dev;
>  	int ret;
>  	int i;

...

> +	chip_info = device_get_match_data(dev);
> +	if (!chip_info)
> +		return dev_err_probe(dev, -ENODEV, "missing match data\n");

Since we are here, it's not match data, it's driver data. "missing driver data".

> +	hx711_data->chip_info = chip_info;

+ Blank line.

>  	/*

-- 
With Best Regards,
Andy Shevchenko


