Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94D346E47;
	Fri, 17 Apr 2026 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410802; cv=none; b=QmP6NGkJ0uIL4GNmSD4D93idByan7Z4ZWmKDq7/OU6LoDDE+7/PT1HNHXXI3AnYatQGUsA1cQhmUZkGyGoUYBr/XuIUIazbR3ICgVq5JpVWXeXSi2u42wKGAYU2pzEpEDLFLbkCsgaoB137/22GJE49Nnqdb5YDhkXa0AjFEiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410802; c=relaxed/simple;
	bh=ZQO73fz/9U+hZh5vdIzK7ytVbeBO74HtbPvtlu+unD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvAsx90xiGLphHBcDJwPNB3oqJDl+xUvhZqM/1ZEBCePfUSQcekkAuN7h6OsP4XsUBlLNQQ81syRwRBP2/hyh2FYPvLH50BYBbK2krAB0b/2ENyb9ki2X3jWfOVNVYsIUeBuS6sBxPDAV9r82aygrRXs90ZU+wTTuFxqd41YpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk5MiGmG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk5MiGmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776410800; x=1807946800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQO73fz/9U+hZh5vdIzK7ytVbeBO74HtbPvtlu+unD0=;
  b=Nk5MiGmG4xnaQPS0s0JxtF8loAbmVXyZlaTv77jtkUMxeo+p4ZeYASEC
   hJiDA7cp0krSBKzXdsPRDI0cOyROX2CXyYGo2xPtIhGWaGvGD67f9SRUF
   owNzVXorknwkNezgwvnUcKRuyhEud/0XBegCejXSPiMmKoIl4rtBIwPub
   NiUNO0duHCEDhTTxm7TMWR/teflYStPUfJXuSz3GTQIN7egPC8Tt632MK
   kHarR+4+/dWE9zJmcVwR+2jb43SEueEs1Dp63DKeD+44CqgDEn2VuljKe
   3NViWMgxBzRb9q/8Ce4tr019X8jl/hvgMIrXQRGFRV6/F/Xp68O+VmDOk
   g==;
X-CSE-ConnectionGUID: SYqMEY+JS8u8rZTg5dNIjg==
X-CSE-MsgGUID: li6QtlUGSBuvuXzmvrCXfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88123751"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="88123751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:26:39 -0700
X-CSE-ConnectionGUID: AEL+EYUJQW2yQ/sUMvAXKg==
X-CSE-MsgGUID: bou218wZRUag0G7xbEYnRw==
X-ExtLoop1: 1
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:26:36 -0700
Date: Fri, 17 Apr 2026 10:26:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: ad9834: clean up includes
Message-ID: <aeHgqpuSOxgqP6hK@ashevche-desk.local>
References: <20260416093240.1294-1-joshua.crofts1@gmail.com>
 <aeHXi8-zYZu-9NPr@ashevche-desk.local>
 <CALoEA-yhUTYzHUkOqAQ+nunUrH=DqzCzMS=hW5ZxO5M46ETa8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yhUTYzHUkOqAQ+nunUrH=DqzCzMS=hW5ZxO5M46ETa8Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 09:13:27AM +0200, Joshua Crofts wrote:
> On Fri, 17 Apr 2026 at 08:47, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > I'm wondering why in previous round the tool haven't noticed what I did...
> 
> Yeah, the tool is pretty noisy unfortunately, even with tweaking it's
> not exactly 100%.

Yes, that's why one still needs to understand more about headers in the Linux
kernel to do such a "simple" change.

> > > +#include <linux/string.h>
> >
> > Hmm... What's used for here?
> 
> sysfs_streq() is defined in linux/string.h.

Oh, surprise surprise :-), thanks for pointing this out!

-- 
With Best Regards,
Andy Shevchenko


