Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7F3DD50D;
	Mon, 27 Apr 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313535; cv=none; b=kAFM8F6qrE5Im1ZXWc3nr/X0kCSHlL+pynxQYJZDNuZj44ZblD3DQWJoeIgE+0Lpr3Mn6bdjXHBDALQP0PvaV7JQDsWqxr4+ajCOrr/czi8Ccog06tkDifXDbljh2c6Z2NdVR/m7Ca8OYYvu/Op4ixjleQpVk4Q6jjfe0nfc+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313535; c=relaxed/simple;
	bh=ry1fojsDAvftrlsV/qTkIMsqqLpi72mpJRuw1npCvfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMDZfgbHsnfy0eM/hnCzVq5izCJCdpG7dozzclggFmXWtV/gG17qx4nHnaqdO4ebOmCpj91vY8kHgqEhWaX/4u1P95VnShdfWekzfaTAir+4ba8XI3ORx5x6OzKDc5zZTEqdjqR70Kn2JC0pQYKPNdAVgatWVzYmD1zu8wHXqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bokPEa0W; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bokPEa0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777313533; x=1808849533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ry1fojsDAvftrlsV/qTkIMsqqLpi72mpJRuw1npCvfo=;
  b=bokPEa0WXruaz8ZKtyRgjBkd8j5SAL9fRqF0HEahfnnElKn/V7oOc7LA
   oXEO075ENQita2T0pp/kvCD5MNIc0TbO39B6Ul+IKTMZW/LNK5h5S0LAV
   t3poQ6qVWTOQN+ldvdiIwfARcCGQlY+AmAxikLUsXXv9lOPaYUpaVm8pM
   dBukkv+AIbsq9UKmdAMfB3pw9edRlDa9rAzmoMYQjCwWfUaYOmHxbBZWR
   /nVQ7TBy5cuGLpRbqPfjSgTgrWYdYZ1I4f915s2JiufO+ncnUn6UBaguQ
   RfeC1oLm3RnfMMZZwxIfcmsE28chSgciCZUyvOMKR+7ULcvxNoGiPpAe1
   Q==;
X-CSE-ConnectionGUID: fgzFjatATCaB2mFuKmGf4w==
X-CSE-MsgGUID: 3SEjXdHpSsa2+BgC1Jua9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78090108"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78090108"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:12:13 -0700
X-CSE-ConnectionGUID: a96afGoLTemSyHo/ilxS8A==
X-CSE-MsgGUID: 1Y44pcpYRZOok+SRXX8c7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="264116049"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:12:10 -0700
Date: Mon, 27 Apr 2026 21:12:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 00/11] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <ae-m9-yTveKKClww@ashevche-desk.local>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:30:07PM +0100, Rodrigo Alencar via B4 Relay wrote:
> This is the first series of three on updating the AD5686 driver.
> 
> A bigger patch series was sent before ("Extend device support for AD5686 driver"),
> but this is not exactly a v2:
> 
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> This one adds a number of cleanups and fixes, like:
> - Refactor include headers (IWYU);
> - Remove redundant register definition;
> - Drop enum chip id in favor of per-device chip_info structs;
> - Fix internal voltage reference control for single-channel devices;
> - Acquire lock when doing power down control;
> - Fix powerdown control for dual-channel devices;

I have only a few nit-picks, in general LGTM, thanks!


-- 
With Best Regards,
Andy Shevchenko


