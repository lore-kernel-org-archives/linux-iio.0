Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8233C183;
	Thu, 22 Jan 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094950; cv=none; b=TEYA5kkjUzq8wSsu2zWP1U1+OKHetgYXIqrnEUQCjDUxtT1jxtieuyhd9wWLe+ip0as1SWAqahXldiKslH1biT5BTYszF/AuO2k2vSuFjB+EsW8GA5n/g6v/T/MByjHVO1boJJb/83dExycPr1zDMTqJn9YdxYMJCARHAOWBP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094950; c=relaxed/simple;
	bh=E3pssJeSpEjSCVPHmUhZ5NoUXtg4mXfjIev+q+aekaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdklJ7Z/7xUK9hNEz+MElntdn+ffjW4ill7OT6fwMPe8Z5NK+pQWS/oQjmWiWXbza2rBrjQc2feqfSYYdfp8fqj9R8pVse422hzWym7FKYw4dTBv28KhkTgbCyjw05hL0+74jurqwgtY/xuEBDA4gtruJisMKqgLIBtJYSebk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYtcdzPi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYtcdzPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094949; x=1800630949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E3pssJeSpEjSCVPHmUhZ5NoUXtg4mXfjIev+q+aekaU=;
  b=XYtcdzPiiKjrTcD4xpd4HORZFNAJHDeMMWvaCjY44H5Q01nw6+Muax12
   TnBO89vwf2bhUtc9Uw37gEP8VI0UDDUmHCA220tqvMNK4YXkVrG32JIbA
   yv220aucupNTabAKsHHlc74FHYXYnSJxWgw39gcpRGwkkFnnkhsyZ/+4Y
   2bhJVtJOdjphBRw1c4ftxvxkYE7QueYhdPjblmujxiJ/dpxqqELVcdKg3
   EL/8C4ATXBppY9wPGpDShOuZpv2VlhylgC4kwS11kyTfGCAfjwAkDyCOi
   lB/zQQ6fhU3bdG80FYubz8NFHobuhK0+u8mDdsiPrV57Nldk5FDgrkMjA
   g==;
X-CSE-ConnectionGUID: g9o0F4JMQLmpA6la4q0iWQ==
X-CSE-MsgGUID: ftHForvpTEemx0iMfWSulA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70386696"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70386696"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:15:49 -0800
X-CSE-ConnectionGUID: 5gfogVnZT7i+B5A0aZZLDQ==
X-CSE-MsgGUID: PYn+/KX0SR+Edhv2kBfioA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206809486"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:15:45 -0800
Date: Thu, 22 Jan 2026 17:15:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
Message-ID: <aXI_HnvDNbX68-lq@smile.fi.intel.com>
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXI-ZV4uAd5GyFLz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 05:12:42PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 08:26:33PM +0530, Archit Anant wrote:

...

> > -	freqreg = (u64)freq * (u64)(1 << 27);
> > -	do_div(freqreg, st->mclk_hz / 4);
> > +	freqreg = div64_ul((u64)freq * (u64)(1 << 27),
> > +			   st->mclk_hz / 4);
> 
> It can be one line to begin with.
> Then drop that ugly castings and explicit big shifts.
> 
> 	freqreg = div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);
> 
> Now you can see That 4 is only 2 bits, so this can be written in
> simpler way:
> 
> 	freqreg = div64_ul(BIT_ULL(29) * freq, st->mclk_hz);
> 
> which may give a better precision at the end of the day.

It also might be worth to add a comment on top to explain (with given context
I don't know if there is already one on top of the function, though).

And I think we want AD people to comment on this and maybe explain better
the calculations done (and why the original code drops precision, was it
deliberate?).

-- 
With Best Regards,
Andy Shevchenko


