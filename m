Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0836C588
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911777; cv=none; b=VgSFMw8Zq7CQskuiW/WIjzIi869GSx679DuJfkBDhR2G246E/siWo2SCNSL+QkVS8X8KS//kdLDoLP1GJm25CayQ9aGodSTY2JOQwLv6Q4L/di6axMKn12qLWHZJBETeeMLfGtdFR2BLaGmsCkrd5TsVe7l+nszlt8X5/xxNf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911777; c=relaxed/simple;
	bh=zfKI8AxOYKqATlsoQTkFRVKSX7Z34bdU8eL9t7g4Wmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuLs7Cogr5o1469Nvio4KUJJ2Jb9ovgVzb4ggV0HhRk8RtQZUl8yDjgdttOt9K3GD1bqeodEpKpIoU9u0LyQvym2+o4FUlik40eXiHWRhheFBrIT8AuBdTkFkb3/wNsL27OK558EPTih9/fpJYpObfmpK6iUilqonkLUmrJXcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMoMfqvk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMoMfqvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911776; x=1805447776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfKI8AxOYKqATlsoQTkFRVKSX7Z34bdU8eL9t7g4Wmc=;
  b=ZMoMfqvkF4I1gHmQs6wS4qQaJmus/nfe2hLFKMgGUAPQP5iDbPaYnXw6
   +S5xbrH/xx0SIsNwCRwfHXz+mZLV698rkLz4IIpmezj6XbmCZJu8Ew28F
   sEEc/WcEiaPvbIDdO7YHoI4kP6T2wuXXYVJR3UyuhR4hqGwp1I7y/bNi7
   fV1pkFPnd4OvApFSdeRKjp7VHyuHOy2YbXRNzPd373ldIjSCOucCTwInK
   uNIOO9IMkx2dqy2+3j+vJq4G61IspLZzslmHo7uRdi96O0bmUMQVrifbs
   Z0Ah+bCUw1DPMkMLOAcu/g71n6dPB+yB/w//Uu2wwQbMRk8qZiNB7UFny
   Q==;
X-CSE-ConnectionGUID: TnkjwgWSQMaXAwWn0FTmAQ==
X-CSE-MsgGUID: NXYIUeP9Rg+lA6ahTnpIdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85606381"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85606381"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:16:15 -0700
X-CSE-ConnectionGUID: HiEiO0YzQLWUXDvKGNLHdw==
X-CSE-MsgGUID: /HP93zPFRCa2AdmKtCWEdg==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:16:13 -0700
Date: Thu, 19 Mar 2026 11:16:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: remove redundant OR with
 zero
Message-ID: <abu-21Hi5eXkuGkQ@ashevche-desk.local>
References: <20260319085741.109359-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319085741.109359-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 12:57:42PM +0400, Giorgi Tchankvetadze wrote:
> The expression 'ADC5_GEN3_CHAN_CONV_REQ | 0' is redundant because
> OR-ing any value with zero does nothing. Remove the pointless '| 0'
> to simplify the code.

Have you read the comment above?

...

>  	 * Use channel 0 by default for immediate conversion and to indicate

^^^

>  	 * there is an actual conversion request
>  	 */

I believe this is done for clarity. No need to have this patch, but I won't
object going it in, since the comment still stays. I leave it to Jonathan,
but I'm not going to give any tag here.

-- 
With Best Regards,
Andy Shevchenko


