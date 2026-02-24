Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E814368298;
	Tue, 24 Feb 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924680; cv=none; b=rebVlJyZMyAQrhz2taXaDO/N6Tm9oUiYBgbsPeaqSqODzngWINf2bWGO09Hea9t6tpHbk3ykQeilLUtSmcdiJeVoFQHiZDpTpxHnhnMOZd/9kiaIdi/nBoAeJaTjbGX2xD9xLlSKc6YHpfKX2WHI+LRcKP1houeZ37VZiIxORmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924680; c=relaxed/simple;
	bh=BqzYHCGEBIC2+T+zwP6izKiSG5yKfkLkxfZhIW4aYMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C68ZAKr4nP5oyty58tkgXH0LJQj2iGFHgSXp9DCIpsDIt1939dPzusHX+qIQgVMqHOwAqjpbr0YMjpMIheACxX2i8JOYOoLMnKHzkFA5vj+kJb9Ln/V0Z0JGYf1TpEvykec52hxMKA9VtH0HfnOsym0d8FFdCPUcofvEGo2ZUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zd26jz9i; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zd26jz9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771924680; x=1803460680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BqzYHCGEBIC2+T+zwP6izKiSG5yKfkLkxfZhIW4aYMw=;
  b=Zd26jz9i4j7dt8cNGhxwUNYQBszihtml0/tOpkZicqzNLkQhX4uhp4Xg
   n39qS/zZ5Kqjs83qMiTMdG6d19hHPIOlDsOB8gWd3PEpD93zuoc0qC9Qa
   oKO5jsegeNxWElrwJemE9ZGtQZdUqFqz0tB4qMCbvs7oO6r4QPvzo8RQr
   gBTN4b4Wq+vZ9HnulwLx6Ac/OgpDzQSvkf+Jig3nxDY8PdqLGOoRqQB2q
   y/kAzXTVV08EH/KoHQVI45TO5ah3gl1ohgKs3+ovBDBA5e9sAeMxP+kCA
   9tfwQ3mDzwFw5pJQPF+CVgOZE/DDt284/ZnhlEaD30Nx7zm8iZOcjON43
   A==;
X-CSE-ConnectionGUID: POWgVsxoSlin1ESPLELuyA==
X-CSE-MsgGUID: tVOJ5zBSTESW39TYJWO3ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84390136"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="84390136"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:18:00 -0800
X-CSE-ConnectionGUID: Zz476hdbTnS4fvcG5/NCTw==
X-CSE-MsgGUID: Jkj5gisRRqe4jXbGSj7uyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="213127124"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:17:57 -0800
Date: Tue, 24 Feb 2026 11:17:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <aZ1sw9SDp5mrDr8R@smile.fi.intel.com>
References: <20260220132912.2392102-1-andriy.shevchenko@linux.intel.com>
 <20260222165411.427e6a9c@jic23-huawei>
 <aZtT3pDS9X6pGVnT@smile.fi.intel.com>
 <20260223210035.47341770@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260223210035.47341770@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 09:00:35PM +0000, Jonathan Cameron wrote:
> On Sun, 22 Feb 2026 21:07:10 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Feb 22, 2026 at 04:54:11PM +0000, Jonathan Cameron wrote:
> > > On Fri, 20 Feb 2026 14:25:19 +0100
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >   
> > > > Use devm_add_action_or_reset() instead of devres_alloc() and
> > > > devres_add(), which works the same. This will simplify the
> > > > code. There is no functional changes.
> > > > 
> > > > While at it, inline devm_iio_kfifo_allocate() into its only user.
> > > > 
> > > > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > > Nice.  Applied  
> > 
> > Thanks!
> > 
> > One minor thing though. The iio_kfifo_alloc()/free() uses variable name 'r'
> > while devm_iio_kfifo_alloc() uses 'buffer'. I was thinking again and now
> > I probably would go with 'buffer' in devm_iio_kfifo_release() as well
> > to have a symmetry with the devm_*_alloc(). If you think it worth changing,
> > may you fold it? (AFAIU the applied patch is still in the pending/testing
> > queue that is okay for rebase, squash, et cetera.)
> > 
> Ok.  Whilst looking at this I noticed there was a stray docs
> reference to devm_iio_kfifo_alloc() Which doesn't exist any more so
> I updated that to refer to iio_kfifo_alloc() which is what is called.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


