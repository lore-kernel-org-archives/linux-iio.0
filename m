Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CB1A9FBA;
	Thu,  5 Feb 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308950; cv=none; b=ct4H3kA+USbu1ellgg9FKq+e+OQeqc0J8kfNiU6LnIgKoy5V3yuLYuq66VeBsEHUswRxszIP6vj0lIfiWx/3V9QZBikCw5e2ohZTQWUPB58Z5pbvVYC3W6Azc5bwX9a+v4jCCJbZ5l9EVT3pmsP8wcnepzPtge5/wJ36Vjkq3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308950; c=relaxed/simple;
	bh=TZX6NrZY5TOwBpFPXF1IrRcOTy9dWUfiUv4Vf/Yq8+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3e6VjsKE264rxEuWFXfBlp2jQRDTYjABncv1MaCarhGpxjH6YAksRwR4rlDvHwZx+T0rU9On4h/8o0g1X1K01I1pqDuMza35ieQ76e+s23XaexOCKS/ci4lvNZRB5PjYz6tOBaGaBE+X65yt0Oi4M5SQQzKDcNMU772dB1yrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JW7AC9Fg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JW7AC9Fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770308950; x=1801844950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZX6NrZY5TOwBpFPXF1IrRcOTy9dWUfiUv4Vf/Yq8+s=;
  b=JW7AC9Fgq2cM0FCvLoQ405ujfIXIKox31nt9/UtiZ4slJPXKsIKI5unw
   d1iv5JHwpI139gQZnRwaou0cVd2EDDhgqN5Wx01wxCwUzhi+l5cno/BHo
   dqFOZup4cWjVcCg/7nMB/W7olNByW3p6ZYnmEiDMA9kk2qBW+pwsR5gdo
   GTOIac6UOj8BATXC29GRD9xWYSVt3J84MWSa6HFhnc6vuPRWrxlb/gQnd
   3zX47mS2kHSs3xc64i60TwqNchyyeVl3wJzV9BjwC7y5W1DS+q+S+q8i1
   S9QipjQ0j3up8nbr3jybHeDZjnh4dM7YMyo0UhDIG4v7UOi6yb/xfxiTU
   g==;
X-CSE-ConnectionGUID: 27zAsgKfSh292ALanQBO1g==
X-CSE-MsgGUID: 25sBaqzISkycZicC0XIWkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="96966417"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="96966417"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:29:09 -0800
X-CSE-ConnectionGUID: aV5U95fLRimb5VW/u2mn5Q==
X-CSE-MsgGUID: 5/lss6iMTUyaEN9Lv62GYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210487977"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:29:06 -0800
Date: Thu, 5 Feb 2026 18:29:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	David Lechner <dlechner@baylibe.com>
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration
 with devm helper
Message-ID: <aYTFUMe3jUO_bGCr@smile.fi.intel.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 05:12:13AM -0800, Harshit Mogalapalli wrote:
> Convert the iio registration to use devm_* helpers so the probe no
> longer needs a separate cleanup path and remove callback can also drop
> the unregister. After this there is no need for having a remove
> callback, so remote it.
> 
> No functional change intended.

...

> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);

Do you still need spi_set_drvdata() or analogue in the ->probe()?

-- 
With Best Regards,
Andy Shevchenko


