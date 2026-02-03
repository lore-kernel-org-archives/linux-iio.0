Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9E32E733;
	Tue,  3 Feb 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117609; cv=none; b=I4lexJ8F+Zuwyk+N42eU8RFvfWnFcoY0gUmqE+se2s5+QTQe6F8pl9xmYq+7SZwPu7OlmVgIogT9iXABRStg4bkaEEL0s9xhxPZ+KDIY5cj+cIFA1YJzwYq6ny8qgO7El0utwBHMcPDiBm9YCKCTuFCXPfWkl5SOOqTgQlvGYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117609; c=relaxed/simple;
	bh=FJ5t3nyhYf2EANIlLZGsb7iAMhA2n5Tsa6WhTGI8Yco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEIX52eBmio0el2Sz5wGG46WTaRh97BpU+h3YQWh18zjZuPH2m0SJERVAwHa4GUWlD8WB6tizVKJhzFchETHdV/miLJyu0gZOPWK8uw2xSEuXGwzrlyBn52VUxU2CAoXgz+mdWXcU/rTq300PTpJxma5IB5nmy1UH8zV/LHdXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U11n+ey0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U11n+ey0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770117608; x=1801653608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FJ5t3nyhYf2EANIlLZGsb7iAMhA2n5Tsa6WhTGI8Yco=;
  b=U11n+ey0GUCZkrhE7NnX+8c/0iY8l8fqn+Xam6tiFaSYxW0GNvKM9jSb
   DzpsxltobDkd6OXAtoYcbY1XaQg4SsNOjF/i2WRx9uuz4oRsueqsEkLCT
   lkfSRhvtL8YauqcLKMwVwc4/brYfsuJkm9KMb+T6aux7r6wGUdyjmTaTO
   953P8rVzPMvSxDNfXMoxDuBp8g2WIxcjxONh68Y9LUqWWen5NBDgU4H7k
   bKRiF+zTbJBfYMCWqgX0KdHP8WsHVLg1sLxhxQmt6YvKreKH3sCSIKpOO
   Q82534RLcn//oFQkmM18mJOkgAeYo2vgH1TeEOzOQG7CxoXKPl7wqIGbe
   g==;
X-CSE-ConnectionGUID: L5/j1w4bTdK31rRofVe/kQ==
X-CSE-MsgGUID: qxM6VjfJSx62YORUrWATKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="74910551"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="74910551"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:20:07 -0800
X-CSE-ConnectionGUID: +bwax/rIRMGUZ5//ogkTtw==
X-CSE-MsgGUID: GMTtS7TVS+ym2Hi6eHOJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209610570"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:20:05 -0800
Date: Tue, 3 Feb 2026 13:20:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in viio_trigger_alloc()
Message-ID: <aYHZ4l8h_x6IdinI@smile.fi.intel.com>
References: <20260131092333.247931-1-salah.triki@gmail.com>
 <20260131124416.19576731@jic23-huawei>
 <b06bee455950f59ea3f2cdcd37ec4f6d1be68b39.camel@gmail.com>
 <20260202205217.3534d14e@jic23-huawei>
 <aYHZcmZUZApdmE5I@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYHZcmZUZApdmE5I@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 01:18:14PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 02, 2026 at 08:52:17PM +0000, Jonathan Cameron wrote:
> > On Mon, 02 Feb 2026 10:12:10 +0000
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > > On Sat, 2026-01-31 at 12:44 +0000, Jonathan Cameron wrote:

...

> > > Andy already fixed it for the main iio_dev allocation:
> > > 
> > > https://lore.kernel.org/linux-iio/20251112145735.2075527-3-andriy.shevchenko@linux.intel.com/
> 
> Right, and this thread makes me check the status and the series wasn't applied.
> Now I need to go to that thread to see why.

And there it was mentioned as being applied... Confused.

-- 
With Best Regards,
Andy Shevchenko


