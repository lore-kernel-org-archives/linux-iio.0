Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701386;
	b=1UtphgD7KK4HJdXXPfYnVagqDYi4EfMpq51p5fgq9AtUDI/vOHRnSD3sRnbf1sB6cJ9e
	 XFhWH8jjVywXOkNY+Ygkp6kZoNA900TVFCg5EVg/pN2hQol8Kk5MReB7X5q3yl9zu2HrL
	 QPD58z7OAJYS8BTZ3+/rGvP1oRDATiaCz+Ldq+LSN3fIIs+gzdUHC7SWraNSVHzaA7YPJ
	 gRTAMQSLvudCrYkBDC67Tb5BpGPbQY26HGRBHWzntxvmip1Mu/iZAHunhY3M79D37B64w
	 pSYbV47skaovGHdtLPV+kqReV4LQ4S94DuIext386iSdcQxNeVevpZmJltUbBtwjaaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701386;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=q8JFyquRieTUbfjjGw4jNjS6JFuSKqEwBfnEBnYPCjI=;
	b=GBPt6I/GsX1gNoTh940F2SrAuVw/6lGZapv+Fy+LdSW8TVK3tOuCNKCS0aQ/MGakf2dg
	 bG8hABO7EFggQ8xer90IprB39rxjBl4bmmLGd8o3J5cKF6eaoa92v/53fjgK6MGcBk9Vn
	 7j7HFfWdlBnoylBY7limhS9IDPU3LZbTt7Y6jG9QdFOvyscjJkE80v5TnB3rWTJNCNnNv
	 X28yTcdPTq9j1sXtjrPxVJEJd0C3hVyHt4b0un1/8eFXTegfXkxf3N3XRyFC8/3z990Wf
	 DhvyypctTBfM/fDWly/BVjA0NvlwSJKnBTTdiii7Wy9tJQdrF8shg+sNk+JbNocWwMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UxnsblkG;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE9606FAEB;
	Tue,  3 Nov 2026 10:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FE9606FAEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UxnsblkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793701384; x=1825237384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gz/He+lzr6/0WjYdMg04Fv+kmVWNBx73IrzLorPrJ9Q=;
  b=UxnsblkGPOPWnqo7QFQy62mkT6A+ACJLeK9Ple+f09hkV/e9paF++1Xs
   gtNuasTLoOIFcOEFPMNyBfUFA++yWnbUyqxzCzL4IwiWPUfdoljuoQ3iE
   2KxGotKK6G2pgnRGpZZw4G5ZtLVq99RJcI6MUy48x9kfrwy+njtcOO1yl
   ePbQu4hkkZxY0VnQWGbNquFLCDJiXrESOTsdFhohhHabSGaAgKyIRcHxF
   rf+yLpj6g8VeWAGB/Qh3iV4Hk9MfszMUMvKLQuu9eApxDhVjSPsXOQyz+
   FSslG+F1HG0w811xsLuPKq3zFkqwpBpcKgQfGKCiQEWpDr215g/wnHBd7
   g==;
X-CSE-ConnectionGUID: 4fWFUA91SY+AYQ6bD4hxuw==
X-CSE-MsgGUID: Fc+eUJeTR6SZSbL7giDPZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2416220"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2416220"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:23:03 -0800
X-CSE-ConnectionGUID: oqSdF9x9Ta6UmmvaUf9ynw==
X-CSE-MsgGUID: utErKMwtQ32G6xpG5JZamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6380048"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:23:01 -0800
Date: Tue, 3 Nov 2026 12:22:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v6] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <aum2ArpHeJAZIVfl@ashevche-desk.local>
References: <20261101173736.1792283-1-tristmd@gmail.com>
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
In-Reply-To: <20261101173736.1792283-1-tristmd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 01, 2026 at 05:37:36PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> times to read channel configuration but does not validate the returned
> object type or array bounds:
> 
>   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
>      firmware returns a different type, accessing rez->package.count
>      and rez->package.elements on a non-package object produces
>      unpredictable values.
> 
>   2. The loop bounds use rez->package.count directly without capping
>      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
>      than expected causes writes past the fixed-size labels[],
>      shunts[], and active_channels[] arrays.
> 
>   3. The bipolar and sample rate DSM calls access elements[0] without
>      verifying package.count >= 1.
> 
> Use acpi_evaluate_dsm_typed() with ACPI_TYPE_PACKAGE to validate the
> return type at evaluation time.  Cap loop iterations to
> PAC1934_MAX_NUM_CHANNELS, and verify package count >= 1 before
> accessing elements[0].

...

> -	for (i = 0; i < rez->package.count; i += 2) {
> +	count = min(rez->package.count, PAC1934_MAX_NUM_CHANNELS * 2);
> +	for (i = 0; i + 1 < count; i += 2) {

Wouldn't

	count = min(rez->package.count & ~1, PAC1934_MAX_NUM_CHANNELS * 2);
	for (i = 0; i < count; i += 2) {

work?

-- 
With Best Regards,
Andy Shevchenko


