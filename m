Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD332FA3C;
	Wed, 15 Jul 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123661; cv=none; b=ImBuPpUTn2j1WGhmVXzls0I3uSBUlLl/3EuBmEl+QLjlDwM7JmKtuzE9ggRwjH1xAanwX2Pi4qwFhemHVYIaWknlIG+7wy4VALc87yBiHJDIMlidZeJxQBRBaUIwN7IcNKa1psSLo1O15vOha+OvMUvj/l3pucmsHg8x+qUyTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123661; c=relaxed/simple;
	bh=JeydJ+N55+tDxhXIlWi6s28lPhVErrwyYgdDp1rLL2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6vQzClssksitnbw7etlxE2ZHDG33edikrPQnTB34ihjNnZfe94nBi2Y5fPRsYxfUC9Fg5/AbKXC6XD+j1y87utxkuomh+RAs94TBxCjcv8NUBgi8WIK30QvXCmUh74oaC4yl+qOVqJu6RcoOcJWnmvRY0rCVfETuGHC+GQ1d/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bt9qbYz2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bt9qbYz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784123659; x=1815659659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JeydJ+N55+tDxhXIlWi6s28lPhVErrwyYgdDp1rLL2o=;
  b=bt9qbYz2zPZ7qNWuX0sr5DFQMHIZabvl8SdIfqcPvKU5o+1fp8Tl+4Lx
   +VQVqOiLj2A0fGRpLuWUB9Ksn+lku1MqAu0pCnCgs87atPRG2s8nYPE/9
   oBP0leMhUgigBHigp0wsG4D/BPf7uslWh33QHKXMXDlxo/nqmxQiIJfNV
   Kp4bfH8cfbjhH1FcYWaM/Ijjs8LECvCRdLos5r75u7s/f3W91qUTTbrEt
   FcaIXjf6wAwRDQj48HocCa/cJdpmBrF8rnSxKwtkX9shWCRS+KeRfRXnn
   Fbltx0vyawUF7bgP+Ces9iMfbg4EMEhXF+PtwQZSXnXtGMI0E9S7utYk3
   Q==;
X-CSE-ConnectionGUID: u+6KRRMqS/Sa4ylTw+tCxQ==
X-CSE-MsgGUID: pvw/O423QVCisaie8QiZyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="87304300"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="87304300"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:54:18 -0700
X-CSE-ConnectionGUID: ey5lnSfASgOZooyT/nsmYQ==
X-CSE-MsgGUID: NfMhUaypTe24bfFB1gKONQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="252231575"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:54:15 -0700
Date: Wed, 15 Jul 2026 16:54:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
Message-ID: <aleRBRrht2PPuHWl@ashevche-desk.local>
References: <20260714165012.184651-1-colin.i.king@gmail.com>
 <alZs-uLJug_rnRnq@ashevche-desk.local>
 <aldfaM2aks7qOz2C@stanley.mountain>
 <aleL2gmDZDJRhjVo@ashevche-desk.local>
 <58361942-9082-4778-a3a6-cd0bc4034644@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58361942-9082-4778-a3a6-cd0bc4034644@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 02:34:50PM +0100, Colin King (gmail) wrote:
> On 15/07/2026 14:32, Andy Shevchenko wrote:
> > On Wed, Jul 15, 2026 at 01:22:32PM +0300, Dan Carpenter wrote:
> > > On Tue, Jul 14, 2026 at 08:08:10PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Jul 14, 2026 at 05:50:12PM +0100, Colin Ian King wrote:

...

> > > > In all patches like this it's always a bikeshedding possible of moving static
> > > > data outside of a function. I have no strong opinion in these cases (when the
> > > > data solely used by a single function), but in general it might give different
> > > > readability experience (it's harder to notice static data in the local function
> > > > definition block). So I leave this exercise to the maintainers of the respective
> > > > pieces of the code.
> > > 
> > > It's an interesting point...
> > > 
> > > At one point Smatch didn't track static variables and it used to
> > > generate occasional false positives.  And it's like you say, those
> > > little "static" qualifiers are hard to spot in a wall of declaration
> > > text.  I've never considered moving the declarations out of the
> > > function scope but it might be a good idea?
> > 
> > Maybe, as I said, I have no strong opinion here. I am all ears to hear
> > what others think.
> 
> For small arrays it's a moot point if this type of change is useful, so

Yep, it actually becomes a trade-off between generated code and existing data.
With a small difference that static const may be located in ROM (important for
the embedded devices with minimum available memory).

> I'm OK if it's not accepted. I appreciate the feedback.

Me too.

> > > But in this case since this data is const, the static vs not-static
> > > doesn't affect flow analysis or readability.
> > 
> > It doesn't affect flow analysis, but we also have David's point about
> > amount of data to be static may affect the code generation.

...

> > The main point I have is that stumbling over the 'static' in the definition
> > block might rise some additional questions and slow down the understanding of
> > the code (by reading).


-- 
With Best Regards,
Andy Shevchenko


