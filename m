Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237535B63C;
	Sat,  3 Oct 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041245; cv=none; b=fwm3I1SNEM+L03KXBCB+b1r2ogk0/3yphxgvXzAfuxod96RprkoV3F3ICFpR1kQONjaKPYQuPxAMXy04kUbwQM0ZdEw0MXxG//4cacQR4MEK0GRwvODNbgyi5p3XjcmrvkOAJYp+5KS8NEKrtPEfB+Kp6Jsw4m2PGWHAkd7F5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041245; c=relaxed/simple;
	bh=uyopUVqZceOyKr4dw61Ai/PDYs0DgDRUXKKW5TsHp+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGuPnkwluLD4GOwUt+DGGKqfjwsPtMCuzewzvPZgpaDTLEBOFE8QTliNw9uwNlwge3PAfkSosjTZA5uEZgIA2FUxs62xCDExZbJY6Ai2SOR5QGXQJ+77AT2NhSqsDbyQBp70vaTyaBrg2DzinaUQhEbt74TD5YTQ3r0pM8OW4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzRlYgwr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzRlYgwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791041243; x=1822577243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uyopUVqZceOyKr4dw61Ai/PDYs0DgDRUXKKW5TsHp+4=;
  b=RzRlYgwrgHGTCS5hBtpIiPmbIwX22QptaXiZ0rQb8cYkYDsm99jUxbtU
   Fj/sTbbKe01eTHkRfMtJ9Y90jTiCOUEe7d8RyzokkQL5O3YkagrNuRyQX
   +YNbs73BHR9Iix07VvEcxNIQKJon75K+QwiqpLDRdLMPmRkWhzLneejQv
   AUAVRvrIZZiT4Kxi9Jhg8faGxB+973QMw7piBJyq0M7AkNYg70D2Ykarb
   mITsZzYru8ko02Mh+yL0+8XISNNlocWYnoxlxs+MPrDSYKXRAu9SnoVU1
   tEuLM/st0+VMNOwf5Y6BOBUpv309VEDYbmOY8MmwYHtlCvEZPCDTsbyCZ
   Q==;
X-CSE-ConnectionGUID: K9DJUHYBRq+jmAdIXSbLOw==
X-CSE-MsgGUID: 2c4+/afqQ62aetj5tsG34A==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="79338043"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="79338043"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:27:23 -0700
X-CSE-ConnectionGUID: X0ySsU+zR2mUPm2frMoLVA==
X-CSE-MsgGUID: BkUa+ODwROejzliVQLambw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="276011389"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:27:20 -0700
Date: Sat, 3 Oct 2026 18:27:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, gregkh@linuxfoundation.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, error27@gmail.com,
	narcisaanamaria12@gmail.com
Subject: Re: [PATCH 0/3] staging: iio: accel: adis16203: fix axis mapping and
 cleanups
Message-ID: <asEe1eE5-FQnnQhM@ashevche-desk.local>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
 <20261002153302.5c64819d@jic23-hlaptop>
 <CALoEA-z6Q3YyYZfLyRixk9dPy8mn+mmVJVUrjoCZb6T7FXcDSA@mail.gmail.com>
 <CANpqX3Z5_RHPHFCCovZ1jXiQcYgkB5uJVzAKX02udzt2+KDcyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpqX3Z5_RHPHFCCovZ1jXiQcYgkB5uJVzAKX02udzt2+KDcyw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 07:58:55AM +0300, Abdelnasser Hussein wrote:

...

> However, the important thing for me is that I still learned a lot from
> Joshua's and Andy's reviews on this patch.

Yep, at least I don't consider that was wasted time for me. The learning
effect, if it's delivered and accepted, has its own value.

-- 
With Best Regards,
Andy Shevchenko


