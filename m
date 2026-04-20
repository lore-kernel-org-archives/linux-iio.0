Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5639DBE5;
	Mon, 20 Apr 2026 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705627; cv=none; b=dJDjNF1foMVdUOLxsDkbhMJqi+clLL/y80x86vTQP4FLWpnq22VPlpA1G0JNgFEATpmNfPr+Tc/zATdXeVyXSZi71CmJWcVjZ/u61s0Xi/jnV+Wf1WjNFR7+gPTUfpabo3fWiQwhuyoG8e2W/7QtD1Uw30HPeRG26dqsfB8u+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705627; c=relaxed/simple;
	bh=DdAtdtnYbX+/5deRUggzoTROtG7TSfAo2e1DT3shFoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU63g4/1nLU09qDbVrANRjlyyJgSa+SZUT2m9+4+/lCPU63jgw8ZsJnnb7hZzsD3MpEMk0Su2W4T2UUVo93zoH4b8lzFr6RYJouhl4izKbmhaEp6e7gYMJRydjUXuevaXukg/azB44KDrChMPnH88KM8YpLTi5RVm/YclnEL2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC8YS52Q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC8YS52Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776705625; x=1808241625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DdAtdtnYbX+/5deRUggzoTROtG7TSfAo2e1DT3shFoU=;
  b=iC8YS52QNxWsFKRDKnolgxwMDNPDQcs2tCikUHBN6WvFplklFU/Ed2/a
   ZrKZQSrd2iSMZA0HC4yI6VMFFYY2tK9P4x2d1DU5pHnH9CMUlB8jAyE/P
   ehBn4dLUeFlR/sNAVOuOlWkTpqRAVEBKhWpohzn4FAYOUiClkffxsCLIw
   Z3onDsAh+rLciZ/zKMwRbKOQmnWc1skQLJJz9zFegtyS+KzsQ8BT25ORz
   ghg62VzjRp/f8gw7EdzJkvj2Z8Q5bJ8hCzh3JzhtgpoxlDq0RsuGaeYZQ
   MyIoCLaBVKE4yR1+qnxBE02PoWNhO7h2KjEN1wyaXtO+i4+iW0cWYdPyt
   A==;
X-CSE-ConnectionGUID: DXF310iyTDe/wOGkrzPxzA==
X-CSE-MsgGUID: k+Q34cCnRHeFtp3MW0gr2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88329116"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="88329116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:20:23 -0700
X-CSE-ConnectionGUID: DXRAPS1JS8+n1gyEfDbXQQ==
X-CSE-MsgGUID: rJ6ZI/NZSQKu32ArzL553A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236148315"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:20:21 -0700
Date: Mon, 20 Apr 2026 20:20:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: magnetometer: ak8975: replace usleep_range()
 with fsleep()
Message-ID: <aeZgUyqcxK6O4-0m@ashevche-desk.local>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420110804.1353-3-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 11:08:02AM +0000, Joshua Crofts wrote:
> Replace usleep_range() calls with fsleep(), passing the minimum value
> required by the sensor for hardware delays.
> 
> fsleep() automatically selects the optimal sleep mechanism, simplifying
> driver code and time management.

...

> -	usleep_range(500, 1000);
> +	fsleep(500);

Seems code is inconsistent in usage of blank lines before return statements.
I would add one while at it.

>  	return 0;

...

>  	/* After mode change wait at least 100us */
> -	usleep_range(100, 500);
> +	fsleep(100);
>  
>  	return 0;

(Left for the context for the above.)

-- 
With Best Regards,
Andy Shevchenko


