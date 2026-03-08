Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2173502A9;
	Sun,  8 Mar 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004228; cv=none; b=NMSDMQG/OtusIaWu9weMtebG+HRLiPZ2MreO8oTC5b5/m8wpbT0zVsLI0vxs7m0xCpbrDxu12KMUUxtGUR2PYRnnDA1V4RotpvYfOkzDiSqvRTLiHjhRHbU/cIY8IoZA3Fr3yaBEM1z77xyqbCCtc5Ba3yTRY+VnHW+Bkvydhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004228; c=relaxed/simple;
	bh=G9luDTUzM3QNzWaa5YRnGaH77j7XxMhOHFThrDbmNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQBH0M927+voLjLkN4GPIXRx5AA5bVxhSKWYb3H5++GPkjf4wqFuXQe/5Umx+EBs8URAvI/TASygTwNQkZjEU1i97qMgOV5/WSkmuYrX7WEfsj49DmNgMVB/FWdd6pJ8IeiMoVdReAIVFPP1oqTYJ8aHTdNtWRR+Bb0ZGW1dyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdMCngBg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdMCngBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773004228; x=1804540228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G9luDTUzM3QNzWaa5YRnGaH77j7XxMhOHFThrDbmNm4=;
  b=NdMCngBgtai/aH8q8VOzzPQb8TNT5In46sJcBO48wVrAuIpJfoUcqAxs
   FGVZ59zHB0upZWkeyRe46Vkiu9xYXsBl+qACt9u8XXMcPOX89Yvl7fSkz
   nTbA0dY9Ir4iqRmwp3bnXYaaP6b2bzUJqUxMY90OtGo04xUzJWQaa/Kw9
   UMm0u+4A+6cibhPZM9vyvGY5n6H3oKnUKXyUTaJvFOw6eMEis6HpNeexb
   s1JcUgPdK1xRxx8SB/kU27F3J62SVe5T0/Sr+g7Bp98Iq0c9VTwxBHbuz
   +kXVhz8HQPNFHyYHK7FlwkFq4Z5OjuAd5jO+PkxWLDD6hmvdbsrFg7fK3
   Q==;
X-CSE-ConnectionGUID: gxjuz3QVQgiWpQ/QkrHhrA==
X-CSE-MsgGUID: OWkOOPQOT+WrtUbzs6PFdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74001463"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74001463"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:10:28 -0700
X-CSE-ConnectionGUID: o1tyLDNyR7GxKs3qCygCrg==
X-CSE-MsgGUID: 6wMrMScmRfesCar36XOmxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219689596"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:10:25 -0700
Date: Sun, 8 Mar 2026 23:10:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: adc: ad799x: make rx_buf static
Message-ID: <aa3lvjkTOHQm2p36@ashevche-desk.local>
References: <20260308182811.33471-1-architanant5@gmail.com>
 <20260308182811.33471-2-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308182811.33471-2-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 08, 2026 at 11:58:08PM +0530, Archit Anant wrote:
> Currently, rx_buf is dynamically allocated using kmalloc() every time
> ad799x_update_scan_mode() is called. This can lead to memory leaks if
> the scan mask is updated multiple times.
> 
> Drop the dynamic allocation and replace it with a static, buffer
> using IIO_DECLARE_BUFFER_WITH_TS().This eliminates the allocation

Missing space after period.

> overhead, prevents leaks, and removes the need for manual kfree()
> on driver removal.

Code wise LGTM.

-- 
With Best Regards,
Andy Shevchenko


