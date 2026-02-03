Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA482DB797;
	Tue,  3 Feb 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117982; cv=none; b=MSb/ujkpXOZP9p0fOgWMGzbiRQiQg2L5Exqv32EcUs9RO+FY+sR7YMR2MmzPLE508KO3vIjFAATK6l1HuG2v2Rqy0jPa8/m2EubAlinzCF/6eRhwjVDYzWKYNQucvdukcqOmEPAZdUNB7Y8RLjMYWq2p31OspxSsAC+5z+EZMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117982; c=relaxed/simple;
	bh=PXuRoEp+q48DXpZjLuTgpRgqybEHTarUKiAQ6ciBgF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcZ5FVMcGpyT7a/TZnyyIdqTvdR0t5JdaFr0KY1SkXxA8LOua1ad7VeZOQLXU0qtc68szqc1lQR8VaWYPYl8KcW4ONlTmz2YXIiBvLvwOy2BHyjIyUUymyUyG9MjdohMvQDX5XZFOYEqu/UFDqgVuSSUIVkvX7hEcRhCwNIFvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2soV7AB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2soV7AB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770117981; x=1801653981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PXuRoEp+q48DXpZjLuTgpRgqybEHTarUKiAQ6ciBgF4=;
  b=j2soV7ABDZLk7DChtbdSxmV1zCPwnZ8iNEayawVhKGCu4XjqX1HE0s+c
   vBrHss8u03a+cfqvnm46Vsv5QQrxtEIrq53bnRFPzlf4tc7emcw7+sIjq
   G67l5P1veqpKES8PUiCLJatqHje6+5oN/RGIj2GYl4FjHZGVwrfE4QgpR
   oxOpIdCOFRTP3RaQrepPr5sPXZtJmusNSFa+4QtUY6OiGkDMXEfn7O548
   WcIuYyvbGrB0vQ7rZAdGO8ojS9raJsBUlKIQMYO4CUBC9E8mKV/rk+R1s
   P8hhpMY7C0wFeIwcVMxIOJTZ1Ow4J/iWR5rU9mwHFjW8cYZBcLEN/o/wx
   w==;
X-CSE-ConnectionGUID: 8mjqR0gkQ/Cysfs9OUJz4g==
X-CSE-MsgGUID: Nwy0baw/SP+4updvz0Ec1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88861477"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88861477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:26:20 -0800
X-CSE-ConnectionGUID: 6GnxSa/8T3igudpH78nW6w==
X-CSE-MsgGUID: QhDcBrkJTzaV5W/LFtfhmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="213955865"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:26:18 -0800
Date: Tue, 3 Feb 2026 13:26:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in viio_trigger_alloc()
Message-ID: <aYHbVx_SHxvtWRdw@smile.fi.intel.com>
References: <20260131092333.247931-1-salah.triki@gmail.com>
 <20260131124416.19576731@jic23-huawei>
 <b06bee455950f59ea3f2cdcd37ec4f6d1be68b39.camel@gmail.com>
 <20260202205217.3534d14e@jic23-huawei>
 <aYHZcmZUZApdmE5I@smile.fi.intel.com>
 <aYHZ4l8h_x6IdinI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYHZ4l8h_x6IdinI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 01:20:02PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 01:18:14PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 02, 2026 at 08:52:17PM +0000, Jonathan Cameron wrote:
> > > On Mon, 02 Feb 2026 10:12:10 +0000
> > > Nuno Sá <noname.nuno@gmail.com> wrote:
> > > > On Sat, 2026-01-31 at 12:44 +0000, Jonathan Cameron wrote:

...

> > > > Andy already fixed it for the main iio_dev allocation:
> > > > 
> > > > https://lore.kernel.org/linux-iio/20251112145735.2075527-3-andriy.shevchenko@linux.intel.com/
> > 
> > Right, and this thread makes me check the status and the series wasn't applied.
> > Now I need to go to that thread to see why.
> 
> And there it was mentioned as being applied... Confused.

Ah, I have some leftovers, need to clean my local tree. Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


