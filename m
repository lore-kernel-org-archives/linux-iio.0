Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9F3A381D;
	Fri, 24 Apr 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030432; cv=none; b=mw1jkCz/juDih0VuEE2ApDtzLHGfP+c8stOAgcQ01+FTMe1BDuNdnMua1WGi1Vzq0mwyUFgWwuTXiUxC3xWrKZhO6Ob/8RTGY3921RX0KFuKwjgWvePx0BdGjy6mhmf51K1EhpIP1dLiO8dvD3dL3GsvdgTsBGQok7NLw8XKaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030432; c=relaxed/simple;
	bh=jL1lUIm8KENXdh5O2xpy0sLdRZp2UuUavNbLcZuLeVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4sxaTzj30PZlLaMDALXSQGjAxAQAvmV8UDwZi4/j0fKmEshMx67l6i1XbNKxp99Rw4+Y+g5sdNYYbPt1zZeLY+WiJShc3FN3KzUv3B0kTjwEy6isDMDyxKAz1o9zffBWzMk4a2w77zoYa2Usg1m6NsdZMXtmHHgTcEaeYdK4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0OK1Nib; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0OK1Nib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777030430; x=1808566430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jL1lUIm8KENXdh5O2xpy0sLdRZp2UuUavNbLcZuLeVM=;
  b=e0OK1Nib0QWV4s1WA/DFBLIx2mn95cpJNocB6cs4vjyZsa2Sppxt66GW
   hN2Rz2AQjoXa4c5wW677YCOdP/OzWqOFb7HC6HEtxkKuNXBqc65JEKzkC
   ILf0+RLEleYbm+Vdti12I83yIGyGsQ6z9agb/F9wAyHHQPeuYJmsAUMOg
   Zyx6Xss05XTXT4WtiVRyih0B0hKmvRCuDbFqr9h5wJZI0fMmPT9yjQ3nB
   /4wykfbKjgNEh8PO+pQnsla/VamTCuJJzmRJuBpMpXKODWChYfx11GJtT
   S/onhAyJh3hWV6P1WBE+zRpHNdSy5reEPsRUYD/FkPFbvRaKns6WzKPNm
   Q==;
X-CSE-ConnectionGUID: VJLMi+w0SzShtFe/NQ/gSA==
X-CSE-MsgGUID: 7R+z7UNBRSy1cVQhwJPDRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77038499"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77038499"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:33:50 -0700
X-CSE-ConnectionGUID: M3kqN9S8R6K+g11NTi4qPQ==
X-CSE-MsgGUID: E3JRzQf0QDe18vunD3Ak6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="233235700"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:33:46 -0700
Date: Fri, 24 Apr 2026 14:33:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
Message-ID: <aetVGYQcq1NAJb7k@ashevche-desk.local>
References: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
 <aesyzOMUl2Iyjgjz@ashevche-desk.local>
 <20260424113600.4e76fdb7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424113600.4e76fdb7@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 11:36:00AM +0100, Jonathan Cameron wrote:
> On Fri, 24 Apr 2026 12:07:24 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Apr 24, 2026 at 12:18:10PM +0400, Giorgi Tchankvetadze wrote:

...

> > WRT to the kmalloc() use, wouldn't it be simply better to use
> > i2c_master_send_dmasafe() and kill that kmalloc() dance in the driver?
> 
> That sounds backwards. IIRC i2c_master_send_dmasafe() needs a heap allocation
> to ensure a DMA safe buffer.  See i2c_get_dma_safe_msg_buf() and
> the check on I2C_M_DMA_SAFE.

Ah, I thought it's opposite, but looking at the usage it seems like it's host
controller driver responsibility to use DMA or not for the transfer.

Why do we need to have kmalloc() here at all? I don't understand that.

> This function is just overly flexible.

-- 
With Best Regards,
Andy Shevchenko


