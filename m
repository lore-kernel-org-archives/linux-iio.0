Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2122512E6;
	Fri, 23 Jan 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156335; cv=none; b=IOGjoxj8fGa5xHgCQy7QtKVXcF3zgSUaQNNKwShK20sa1X8RICHHoRo05F2PuKDS/oazgb87wO46QtwNSJ1tvjZkClwrWDhddeA6n2vhTxIF5P/Kj9cuWV/BxsttsjVKnUbCNxrHC5CtuMKSTYmcQ+yri8UAEKJ499rWCbI3S8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156335; c=relaxed/simple;
	bh=tu44K5e1Zcjyk4Y44dFZYYfzCc+xHPyrKTTcRGtHzlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPnZWI2F45wDywLKDkcBHXkwwB8zaMlv+QVjjfF7oFHH0a3gbX3h/pe6X1brjnW7bMlSiGe7xPDOYREbiGNEXSWWelu/D+CdvyQdBpZmPBOWBCeKmX79dJ2T7+hCpeFhHmYL4X7S3HnrPGSJi0QjYo5a+NNlHoy/H2dsn0yiZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6SrI0VW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6SrI0VW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769156334; x=1800692334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tu44K5e1Zcjyk4Y44dFZYYfzCc+xHPyrKTTcRGtHzlw=;
  b=I6SrI0VWAppcLdHnkMGf+iXAmXVTkZzdboZjQdvjHfO0oLBmFZIwUt95
   gYf6KQ/dLt2HUhUgOQbhOuY2XbGE1lJxCKg6So1YGGHeX0dlAVFoSH33o
   VGcPKlNR3CWeDyGDwlhdXmz3ARpIVISpEVby1zz+6pN+QM3L5hz2/b5rA
   YnrRkJvf4qQpmfHYCC14JVEvsWCcEhh0xDsPUdakGZCAeCaCvbbBWrMwy
   R3gSLGbHdecGKo41xknu4M6UM2S5SoCb1cdlqMxbIrZISa6q/khFx3NUt
   LRwCvavIizuxdc4odYqG1pNeXkl5cpTDR472OjHIDUCthVXlWiEBQfwQ/
   A==;
X-CSE-ConnectionGUID: NXzsk4wNT9e+XMC5yy0B8Q==
X-CSE-MsgGUID: aiqoFeiPRAmjoKypTNuuYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70458891"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70458891"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:18:53 -0800
X-CSE-ConnectionGUID: qf44/gOgQg23kWQXC/Yh+Q==
X-CSE-MsgGUID: cqbEYycRRk230P7eilXEfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211969615"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:18:50 -0800
Date: Fri, 23 Jan 2026 10:18:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: ad9467: check for backend capabilities
Message-ID: <aXMu6DMwRXjsjk6J@smile.fi.intel.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
 <20260121-b4-ad9467-optional-backend-v4-4-18d2c0d450cc@vaisala.com>
 <aXDNZWSWpuDPzdwv@smile.fi.intel.com>
 <24ab3315-8f83-4d52-b6be-abd31e58d0c8@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ab3315-8f83-4d52-b6be-abd31e58d0c8@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 09:10:20AM +0200, Tomas Melin wrote:
> On 21/01/2026 14:58, Andy Shevchenko wrote:
> > On Wed, Jan 21, 2026 at 12:08:33PM +0000, Tomas Melin wrote:

...

> >> static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
> > 
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	guard(mutex)(&st->lock);
> > 
> > I would leave this as is. Yes, practically we don't need to cover
> > iio_backend_has_caps() with mutex to access the data, but it just makes code
> > slightly more maintainable in my opinion. If anything appears here, it would
> > probably mean some kind of if (...) do_blablabla(...); pattern that will need
> > a mutex.
> 
> I have no strong opinion on this. Current option was chosen as it seemed
> cleaner in the sense that it a) takes the mutex only when needed and b)
> check for caps does not require the mutex to be held. Based on this I
> still suggest keeping as is but will change if you insist.

If you want your way, do not use guard()(). guard()() inside branches is
unintuitive and not the common way of doing it. Most likely you wanted
scoped_guard(). So, to me, guard() indented to more than 1 tab is suspicious
(I don't say it's forbidden or wrong).

> >> -	return ad9467_calibrate(st);
> >> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> >> +		guard(mutex)(&st->lock);
> >> +		return ad9467_calibrate(st);
> >> +	}
> >> +	return 0;
> >>  }

-- 
With Best Regards,
Andy Shevchenko


