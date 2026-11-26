Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685142;
	b=i/WfMLNDB0xyLwHh/n8q+Z6Nm//KmE4sHdUHbKivEOt2VYQBYS/ts1zFFI7X2FbbeWKg
	 0LLsjjw+rscgVQi853p/FEI+RYwB7E/5U1gK3fD4WcZJQ57iKJf12egJViV0Is3lUnGBw
	 ld9cZFR1JjkCOHwLfxwrJEn/pTmot4eA8g7iMBsLOwWMMe08ssM1CCi2xQGa9x4EzovJQ
	 GSLGpIRGluJGoIT1mrIKcucmzrJlfkBF047R56o/WkfEJoY0PJfI/C+qFEVJ1CAfMg+7o
	 99Xu+t5GDKDCbbvRErim2zDoHyL1JkQR93LYTaLGuCMXo0xXdriF5x45EqAUVSmsGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685142;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7kHgHxT5Ek5JU2p4PufIw+wkxobKZgF3oxjmlTkBiYg=;
	b=bT+5btE3beiyAEEvBTtjCOmUzbZHkRDZlitZcvmmuhTKop7vjU0mZqLs59j9dD9Ye3hY
	 +U726TEMRUWyqeYzzwM7qUtlbD7URYsTNQUfpicWT1rpbk76R5+awdcrBIS1zE6Bu1GdV
	 T6+e5DN10rnKBS5q8GUCVW5L3GGxy3BI5QQR9v5xri+hGRTMhvYdcTjz0l9h+iHCcz2M0
	 +khEMY5at5t8FK0axkgcGjKS42WNMsTCM4hvGYrvGLgQLme2YrX8fEyzzz7w2jeYpruoq
	 Dn2zQ99aWW8wIo1h20EtbiyG9fUzPeNdPQ/mGs7MKFCGumTpLthtDJ4an5XfFF+wLOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LpDBL6+g;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B8606A31C;
	Thu, 26 Nov 2026 09:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E19B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LpDBL6+g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795685142; x=1827221142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ybeAPc6iqgpJgd3cizVcIIkQO1XvmRAvYnQ9+k9Udpg=;
  b=LpDBL6+gbaQM4Bnknj4K6FHUtsdwZoUJF9sMwJAodzcCAlZOr7za7PoM
   +zf6xgmcimf7cO9SfZjvJqUftRVvWfpOXNAHPGABbGOpqGKGtaKoe8erp
   dBW1mNcNGbzl8rxaikjFSQ3LuFV97VCHcv58ADFJxcszMSrmk5yiafkMY
   oTY0TCWf18hu/l86WeNXHjn7d7Qf9zyMS8gTcT/ZNeJsUKInp5x31Mx36
   tG1DiOS3XFlxM341AaRUmXnZ2xa49qzYQW1YPMAMAkdMVPG/J7qn4MtyL
   Yr0pwJt+p8LhHz11uku4hpW1sFXkwklavDEHIwIlM9oIbrKX+IFvh1xEW
   w==;
X-CSE-ConnectionGUID: 1iZrSU94SsmTTqyqVMueBQ==
X-CSE-MsgGUID: 9ZHHJgYtQ6GLTOKcxyvLqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4495442"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4495442"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 01:19:59 -0800
X-CSE-ConnectionGUID: 44vbINN+RtGDU9xp6IlDfg==
X-CSE-MsgGUID: 1VYzEzlGRwOeRjYwiYz21g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="11995726"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 01:19:57 -0800
Date: Thu, 26 Nov 2026 11:19:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: iasnezhkov@gmail.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: guard fwnode_xlate with info_exist_lock
Message-ID: <awf5uvVpYC72orT_@ashevche-desk.local>
References: <20261125234827.94791-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125234827.94791-1-iasnezhkov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 11:48:27PM +0000, Ilia Snezhkov via B4 Relay wrote:
> 
> __fwnode_iio_channel_get() dereferences indio_dev->info->fwnode_xlate
> and invokes it without holding info_exist_lock. Concurrent
> iio_device_unregister() clears indio_dev->info under info_exist_lock,
> allowing a NULL dereference or callback execution during provider
> teardown.
> 
> Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
> matching the rest of inkern.c, return -ENODEV if indio_dev->info is
> NULL, and bounds-check the translated index against
> indio_dev->num_channels before indexing indio_dev->channels.

Sounds legit.

> Found and drafted with an AI coding assistant.

Move this to the comment block after the '---' line below.

> Fixes: acd8256723f2 ("iio: inkern: Add of_xlate function to struct iio_info")
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
> ---

...

>  	indio_dev = dev_to_iio_dev(idev);
> +	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	channel->indio_dev = indio_dev;

More naturally the new code line looks better when placed here.

> -	if (indio_dev->info->fwnode_xlate)
> -		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
> -	else
> -		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
> +		if (!indio_dev->info)
> +			index = -ENODEV;
> +		else if (indio_dev->info->fwnode_xlate)
> +			index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
> +		else
> +			index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +		if (index >= indio_dev->num_channels)
> +			index = -EINVAL;
> +		if (index >= 0)
> +			channel->channel = &indio_dev->channels[index];
> +	}

-- 
With Best Regards,
Andy Shevchenko


