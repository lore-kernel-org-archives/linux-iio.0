Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E293FC5C1
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564249; cv=none; b=cRVf7SLsthT5uyvFUq+DNmqjSU9DtBPh5BDpvdMr4T/zbd+gM6y38srdxiGnMANsXp7dgUCNy7agVbc535vOw1HTAJcKteXzQzJhZza62mmmm8Tqm4Vwdq3GEqeW54DJF0xtdGIWPvrBrxNfRp4DSmIHjQNP0p9zH1uXOqJKmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564249; c=relaxed/simple;
	bh=THjuVxH9mOLTAjFIZYfTTd11rM7LsJpO37/E36bSYXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMIZxmuO4141O90GX6P2ZMIUydF5cOh+Tnegzp7FPixmxrFbAkHUJwXz65YykAe403OF9NxdM9VQZaef0n44o31mu5hnHsFkdLsMTmYXKZAEG0YZvZpfie2/lTsvsw2+RmFBwR+Oy7vOK0jVjkA9GM0YFiYNCc3FHeRNn6M37Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5g5AERC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5g5AERC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780564247; x=1812100247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=THjuVxH9mOLTAjFIZYfTTd11rM7LsJpO37/E36bSYXQ=;
  b=Z5g5AERCHjt3U+EoU5rM5J55QhyXbos6dLMi/dl1msNl3Vk7zodqDmz/
   4EMIABEbQ2wYXiAAi5DqqOMJZgQV8AFojBIY0RGIins8h+CULuwQRFdtZ
   SwMbq48yI0idWX3NqsAKynnBWzvPP2prg6Ed8dYCkSR8y1JAWvNo35Ehm
   rnnEF6RtoT3RmSCRyue3eGo61ydlyaJ/voctgG7Bv0nrV6G2E0IYAnPj0
   dM6pHbH4BoWvlMudDLJXTiXw5mWqfZWNc4ZMbcJZRK3/G20x4U5DpE/Fd
   JWjT4XV3R1xGID307Kq/kCyGcQX/FL/sFlvheaPpn+Gt2iQB1alrnsZ2L
   w==;
X-CSE-ConnectionGUID: umU9tTLnTDORZyxdwT+h3g==
X-CSE-MsgGUID: NuYM3HXQSAiskn7ioo0z7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85276940"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85276940"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:10:47 -0700
X-CSE-ConnectionGUID: 2PAIhQztTkSB8XufQUQK4g==
X-CSE-MsgGUID: y69uexidSIWwrWS5rPXsAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244612927"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:10:45 -0700
Date: Thu, 4 Jun 2026 12:10:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <aiFBEn_DKx5f6ekv@ashevche-desk.local>
References: <20260604084307.640053-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604084307.640053-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 09:43:07AM +0100, Jonathan Cameron wrote:
> iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> to userspace if the data passed in is not a multiple of 8 bytes and the
> timestamp is enabled.  Use memset() to zero it after resizing.

...

>  				   indio_dev->scan_bytes, GFP_KERNEL);
>  		if (!bb)
>  			return -ENOMEM;
> +		memset(bb, 0, indio_dev->scan_bytes);

May I suggest different approach, id est use __GFP_ZERO instead of hunting
correct pointers?

With Best Regards,
Andy Shevchenko


