Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84392D9EF3;
	Tue, 17 Feb 2026 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323844; cv=none; b=E3du+oLCPeY4v+yQ3N61yzpXL8yWZRkqDfAwuxC/MZ2Hx1EB6jIk069VgfbKotberFYuC6mJgh6tHjkvRC5YRzTz5QqQprJFePHtj1yVhDmd3wwv6W4Ss7ALzXNBQNgJL84KoQX6yJiBSxCX/bitIv/j33Q2lV2fatXSA/gAwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323844; c=relaxed/simple;
	bh=INOJ2+R9uiSZUmDJitQybAXGoo4V43qy2CnRK6bnWMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwp2xTM3pThYFAW4iDfZDrl1/hH2VrAzlrAAJo/VSepYrpEE2QUbRS37KK6S6LqE9ngLHgiq48z6dWmVUYfHtCg7GmbtY6JYL+tSU3JhUbu4bvxt8S7LLAWqoKkm9xqLBcZvna+QTRba7anmq+q0DSE+LamM9DsgmM1ufjDXdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCbZs0gF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCbZs0gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323844; x=1802859844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=INOJ2+R9uiSZUmDJitQybAXGoo4V43qy2CnRK6bnWMc=;
  b=SCbZs0gF0SmwpuFk081ylbJOo4DtKyMY13LTWw3jvNS5yAhJa5ZleWMh
   g8JIVapVcXkNZQRkFpEBf1SnQ+w7P8QblhbKyVU+mEVR7ukb3cEK5J2U2
   WHNdDEbQNw13fnBo6OUBrfF60WFkcpnD91EhzMRKbvXUjs7gzlmPS2Ltk
   VCzXXzxkUNp++fXE7dgHC0uHuSouOMcta8uRbxd/Ewond7oWgvYYsar39
   zJqMikE8qEyGhS4L3+5XlARqcY8x470RRiEYvKwsX4oBnSY7vAM8pSxWw
   dGmdiMCPKh4m7wCNtnCj4L4VlIw3vKpNKLZJXS49Ccxq8l3f1cl/x4LJQ
   g==;
X-CSE-ConnectionGUID: Xu+LOoNPTjOVXH2I9AmdaQ==
X-CSE-MsgGUID: n8X/lW0IT7CVG0KBpt89wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099235"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:24:03 -0800
X-CSE-ConnectionGUID: 94Y5LjbnTQa34VNdSgV6xQ==
X-CSE-MsgGUID: 6EVV6jNyQqK++qdHJ6MGnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851786"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.123])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:24:01 -0800
Date: Tue, 17 Feb 2026 12:23:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZRBv-3mKHhMOItr@smile.fi.intel.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com>
 <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
 <aZQovkDI3G9-B_Zr@smile.fi.intel.com>
 <aZQu0rFzPaDWnUfx@smile.fi.intel.com>
 <DGH4C3R3V451.1B4RFJPLVQCI7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGH4C3R3V451.1B4RFJPLVQCI7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 03:10:37AM -0600, Ethan Tidmore wrote:
> On Tue Feb 17, 2026 at 3:03 AM CST, Andy Shevchenko wrote:
> > On Tue, Feb 17, 2026 at 10:37:18AM +0200, Andy Shevchenko wrote:

...

> Ignore my previous statement about sending v4 shortly now. No, I don't
> have the HW, but I will be happy to integrate your series into this
> cleanup.

Just have sent it.

-- 
With Best Regards,
Andy Shevchenko


