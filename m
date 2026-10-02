Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560044F548;
	Fri,  2 Oct 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930073; cv=none; b=lrVAQqCkGgM80N/efSDejYhPS155J8A5TOX4xywpHkFesSP6kuO8pUfw73lBkVsI0IMwVwYFsJz1+HOG6zKEgiOh5hUGBBIBusmqKc9qD3vYolnqUFF7G6RhvCrUhvrniuzmilaHwl/tSI8ZFsoDEg/1W/i6BYwKSwPhPaTmq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930073; c=relaxed/simple;
	bh=9KlofZvJbEKRfC9/pPIiIB0BQQWbJgdRDIvxhFmb7jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuJE7Y917dBgGIAOoB+B2UoMdi/bBdRVCq6ei6PFqtlyeKyX38z5U6QmDHGdUJgWjAtJHtLZ6cU9BKyfnWmWrMr3ejxv8VuATvuodhq3ZXmvOXb/+M0JYhMfC5RkZuf1RszBsnSyz33ymf1bPJ4Ti2QaKGWLDkAFc+5VSG7ngJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dk3zUdNZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dk3zUdNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790930072; x=1822466072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9KlofZvJbEKRfC9/pPIiIB0BQQWbJgdRDIvxhFmb7jg=;
  b=dk3zUdNZDTOsvDB0ZcBEBaOb0ZGFlvIZpnKrNlF+IWonw5MsoZnr0Kpt
   kdPDo9cJ9gnvbWoeCi0/DZzr42JVudu2xj8dAcAlRTahIP/sEcXCy6wDd
   1eNrDtSQaO6lZBZV9UN17lmk/l8mEmt6TuGzOai7sse50Ia/iAX/yuKQe
   zEZw2kOCs0LPDIgUcJloL/Zo3A+KzV4nF8sHYyomZS7nwzpePcuRQNB2d
   y0lLDzfPbOxdMn2OUFNcNhoNNrK4sNBmaWYfNK9mjxcd92uGVl14Y7Y3w
   5kyYePJrYSy8oKueEJnTbvDoEM6nx3k2jSRXlNOStaLISKaxlUPNKzHXv
   g==;
X-CSE-ConnectionGUID: RBYVs5ssSbSROUGiRYyPGA==
X-CSE-MsgGUID: 2eEJ5CjXRauejP8ERvCj1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102369776"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102369776"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:34:31 -0700
X-CSE-ConnectionGUID: D+ozLVgTQLWiIdHdGnSY6Q==
X-CSE-MsgGUID: oWQTTd30TXKky1l7gTyKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="304166086"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:34:27 -0700
Date: Fri, 2 Oct 2026 11:34:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: aspeed: Use syscon phandle for trimming
 data when available
Message-ID: <ar9skaV0Vii8oX6G@ashevche-desk.local>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
 <20261001-ast27xx-adc-upstream-v2-2-2f9c15cc0064@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-2-2f9c15cc0064@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 05:50:37PM +0800, Billy Tsai wrote:
> aspeed_adc_set_trim_data() locates the SCU holding the ADC's
> reference-voltage trimming data with of_find_node_by_name(NULL,
> "syscon"), a global search that matches the first device-tree node
> named "syscon" regardless of which SCU instance it actually is.
> 
> On AST2700, which splits its SCU into "syscon0" (soc0) and "syscon1"
> (soc1), both nodes share the same node name "syscon" and only differ
> by label and unit address, so the lookup always resolves to syscon0
> even though the ADC's trimming data lives in syscon1.
> 
> Use the new "aspeed,trim-syscon" phandle property when present to look
> up the correct regmap directly, falling back to the old global by-name
> search when the property is absent so existing device trees keep
> working.

...

> -	syscon = of_find_node_by_name(NULL, "syscon");
> -	if (syscon == NULL) {
> -		dev_warn(data->dev, "Couldn't find syscon node\n");
> -		return -EOPNOTSUPP;
> +	scu = syscon_regmap_lookup_by_phandle_optional(data->dev->of_node, "aspeed,trim-syscon");

Do not dereference of_node, use dev_of_node(), it will help in the future
if we want to reorganise firmware nodes in the struct device.

> +	if (!scu) {
> +		/*
> +		 * No "aspeed,trim-syscon" phandle: either a single-SCU SoC, or a DTB
> +		 * predating the property. Fall back to the old global
> +		 * by-name lookup for backward compatibility.
> +		 */

So, why not doing

	struct device_node *np;
	const char *propname;
	...
	np = dev_of_node(data->dev);
	propname = "aspeed,trim-syscon";
	if (of_property_present(np, propname)) {
		scu = syscon_regmap_lookup_by_phandle(np, propname);
		...
	}
	...

?

> +		syscon = of_find_node_by_name(NULL, "syscon");
> +		if (syscon == NULL) {
> +			dev_warn(data->dev, "Couldn't find syscon node\n");
> +			return -EOPNOTSUPP;
> +		}
> +		scu = syscon_node_to_regmap(syscon);
> +		of_node_put(syscon);
>  	}
> -	scu = syscon_node_to_regmap(syscon);
> -	of_node_put(syscon);
>  	if (IS_ERR(scu)) {
>  		dev_warn(data->dev, "Failed to get syscon regmap\n");
>  		return -EOPNOTSUPP;

-- 
With Best Regards,
Andy Shevchenko


