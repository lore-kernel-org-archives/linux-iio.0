Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9E2580D7;
	Sun, 10 May 2026 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408207; cv=none; b=eCDCXzL4/0uyyfMNdMwpt6zfMRlhwuvoaXH9jTn50HFTWo2cOlu8XIJY9rG/gyPOtsC6OB4wN1morwQNnDgK7FP3mM9hvhjhaCol6qS6sO/JQPd4iPo06+/i8mXmSVgnSBSqocdqTPUAtohKqn7Jnzw2pLrWTt2XGQzhWBx5apM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408207; c=relaxed/simple;
	bh=NSZcIrEI5KqrFRC51UF8O9U+w1Zt1O6xeh5AmGhP5HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7TbFua0Qr8kILAWdP2R7eJ7ILb1xuHlzJfHFlA7KRzm28lzt9uf0TZNA651uYFK7YWZf7dBxmSvJGL4DVqxT5fEOGvod4CM2D48s2BmqbBtAmd1KbwHbmHhyy/ksIuQ+f6d7NuCr5ee3JclfxZSm41ZB7TKFyuCDkkEGRpjHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2tatPCv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2tatPCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778408205; x=1809944205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSZcIrEI5KqrFRC51UF8O9U+w1Zt1O6xeh5AmGhP5HU=;
  b=l2tatPCv8N8BhvYQcAcNY29tpVhSnCn7nJtxdJuC4bpb6+Y36oO0Jr9R
   waRtfJfTcOdNnnrMQuGP5RkIHFM3oeeJUR5WAbKpQnOeHXWe2zwNyr4VG
   rHNYaRyqoERsKysUOGSF8exoa2LMXuef2JNAdL6hc26AZJu8h+tKhrEB6
   3DG+z67Gng60DwaZRTIwX1SkCgLbswvCDyyeY/fMkxPUdlWS1lfNO0WH0
   jbCNNXUC9M0r5/4Rmdbp2sbENVNNsrusyVjePeulk0RIDiU5Gy+HzIyH5
   wdKjhvna4XvsWG22r14hnIDggyqIs83tah+Uv34XtervzknfyfpVcywdY
   A==;
X-CSE-ConnectionGUID: Fg+7xDMWTrCVQK+wAIATLQ==
X-CSE-MsgGUID: cmnvIU28SnO+dD/Zhg6iZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79346293"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79346293"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:16:45 -0700
X-CSE-ConnectionGUID: jmfGPtcbTeGaw6mwaoWsbQ==
X-CSE-MsgGUID: YidRGXVBTYax3+MZqzECKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237415101"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:16:44 -0700
Date: Sun, 10 May 2026 13:16:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	mike.looijmans@topic.nl, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads1298: Fix incorrect timeout comment
Message-ID: <agBbCCWdkh7rJdxb@ashevche-desk.local>
References: <20260509071910.12345-1-shofiqtest@gmail.com>
 <20260510084530.3986-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510084530.3986-1-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 11:45:30AM +0300, Md Shofiqul Islam wrote:
> At the lowest supported data rate of 250Hz, one conversion period is
> 4ms, not 40ms. The 50ms timeout is deliberately conservative to allow
> for kernel scheduling latency, which can be significant under load or
> on slow machines.
> 
> Fix the comment to state the correct conversion time, use "lowest sample
> rate" for clarity, and explain that the extra margin exists to absorb
> scheduling latency so that no one is tempted to shrink the timeout to
> match the conversion period.

...

> -	/* Cannot take longer than 40ms (250Hz) */
> +	/* One conversion takes at most 4ms at the lowest sample rate (250Hz).
> +	 * Use 50ms to allow for kernel scheduling latency.
> +	 */

/*
 * This is wrong style of multi-line comments in the IIO
 * subsystem. Use this example on how to fix it.
 */

-- 
With Best Regards,
Andy Shevchenko


