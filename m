Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA774746B8;
	Wed, 30 Sep 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758936; cv=none; b=XODBPRAwEktcpEZP3U2adg6wqN5WzsfD14X4bk/kRLI2BpM94XnoodwS2BSr4mzp56VeatfFqGH/wIIBsH4SKqrSEUPfEL4B7q+7UdHec+3L71qw6HGetmPHkGjM1JH9WKIeoC+TCRlWap8hvQq62p33lBE+lSNTEHvzMNpWyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758936; c=relaxed/simple;
	bh=Ew1WxtNcrBtE4dHpQVsIXAKlOJ/cgl+s1++eBQPHSUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWaV/W3LP3u9eVkv2S1ED1nNznnFCOKEQAoKnCuBfiMj0/lFtBhmIARzCMsyN4a2BSxJ4tC6iJJ/Wqlq9NSREX9wTrDc1CxgDKcWEcoOylOUKMxqR2rpy7DQNewQqwYBULW1a4xIn5+O8He4HHv587eLTpkwwgbNh6vIqqc6VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuIV5d6P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuIV5d6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790758934; x=1822294934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ew1WxtNcrBtE4dHpQVsIXAKlOJ/cgl+s1++eBQPHSUg=;
  b=CuIV5d6P4PwqLyVVLomOV7iEgVdSv0iimhp0+FObzhqE4mJVYLr0fTMK
   Ee3q9mYjPq+ac4N/yD4LXcUWnFSLFlhpOECEhC8wQt+4U1x6Z1Q/l8eRh
   nXvWxqhbKGDbLONMDbpPgq8MfSnX8/Wq8GDJ2H5Nvye7RPdZyGCPiTymB
   8u2kugiwyxONoeimrYSejjylUMie5V3y7p/c3H6N5qLQ4pVlygFdEYN4i
   JkCtpu0aas8RovBvb+KBWTrITMFnK6tY71EC1fm4rQWz2Q739tPBM8Qyo
   gC694XBYTLtsqoWJSU4kccCfN2mMOcpXFlNgZeWnCcRbXhcGb24YOvZSG
   A==;
X-CSE-ConnectionGUID: gHGu5GeXQMuy1jRQeeQoHg==
X-CSE-MsgGUID: WnbN7jW/ToCttrSeRmSAzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102864198"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102864198"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:02:13 -0700
X-CSE-ConnectionGUID: XkM4w9CDRpyjaln9w7WgFQ==
X-CSE-MsgGUID: LQ2bovg5Q1mo12UEML5pEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275768116"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:02:11 -0700
Date: Wed, 30 Sep 2026 12:02:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] iio: pressure: dps310: read buffered samples from
 the hardware FIFO
Message-ID: <arzQEQxVA0BzzwPM@ashevche-desk.local>
References: <20260928211127.641828-1-zoone.rupert@gmail.com>
 <20260928211127.641828-2-zoone.rupert@gmail.com>
 <arriSm8L567yqOjV@ashevche-desk.local>
 <20260930082952.878967-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930082952.878967-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 11:29:52AM +0300, Rupesh Majhi wrote:
> On Tue, Sep 29, 2026 at 12:55:22AM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 29, 2026 at 12:11:25AM +0300, Rupesh Majhi wrote:
> > > +/* Returns which measurement the entry came from, or a negative error */
> > > +static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value)
> > > +	__must_hold(&data->lock)
> >
> > Hmm... Don't you want to also add lockdep annotations?
> 
> All __must_hold() functions here are static and called only from
> dps310.c, which is opted into context analysis since patch 10 of v8, so
> clang checks every caller. If you still want lockdep_assert_held() I
> would add it to all 20 in a separate patch, as 12 are already applied.

__must_hold() is not a function, it's a compiler attribute.
And to be precise the clang compiler attribute. It's a no-op in GCC.

-- 
With Best Regards,
Andy Shevchenko


