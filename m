Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262123D7E6;
	Tue, 14 Apr 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151674; cv=none; b=G4Ky/7L1Yd/bjXFmWiCE2XYkjb2bs0E7vtonabcMiRyHtiUr3wwVVbUImW2ICnR1s2moYxzPC4wynA4+QjWYf62Q+Y6JXYxITMzhv8su63IDsOv021ZwAm9rcG2Eu8ixIE9hDH6TGtqhkwQhgwWNjOay01n2e/ADVpoUgDwLiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151674; c=relaxed/simple;
	bh=OrL4fLIPOAJQRF/8trMm3nGYmhwKr8Y8N/DjIs8ACVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgXmkLDoS9zQ/h1R607vpbHUQqqP2WCG2/1tCYwKmwStGYANn62TzOZqcSXlsf5bdWLcOFQGkG/6bOJMkgpBQHb6Z2/wM9+9/UC5f05Ybb7Cos+V2dcj+Br5ydoqtwyCGuA05nfySMO8Qhap23hdb8kn8kk0J1HNvsbtiPo8ZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLJKX3El; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLJKX3El"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776151673; x=1807687673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OrL4fLIPOAJQRF/8trMm3nGYmhwKr8Y8N/DjIs8ACVA=;
  b=kLJKX3El2Dzxjwt7Jth/Hfzo73OMYcE8Q0hJPfHy47bRguZjS+OnSg7a
   T+JBjwsPoceXftr5TfQc81wkD1SXzmUi6BsbGNTaw4BLDT7Q4PPl/NDew
   hhs3JzY3SH1tqcLCW7RoNzo/8XlN9UvnXiL99Ny746gbxG4Vy6IZlzOhr
   eE2KaNJ1gV+W41Q9wIYskDvFLOhXMowPZmjE4hz4vUbK6/trzlTkMjQY7
   +yhoTkTlSooVvt9BZjxi53h8dzdLDYi3FH7vxe+6vu+0vBgfo0icTPy29
   A/VAQ75v3Z8SsR7uzPU9FrKQfkhG/nS+9zYsNrJwrwOmqAdYuLTfk8epW
   g==;
X-CSE-ConnectionGUID: 2BDEuj2tT2m3nlRdk1zPsg==
X-CSE-MsgGUID: FpHiJ65mRSmROt5gIa6tvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="88482392"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88482392"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:27:52 -0700
X-CSE-ConnectionGUID: 10eG/dRxRMKxZb0Oct5wGw==
X-CSE-MsgGUID: FtcF+fR9R/KrICiFL4syhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234414280"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:27:49 -0700
Date: Tue, 14 Apr 2026 10:27:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise
 math
Message-ID: <ad3sckiwifI5ZQYU@ashevche-desk.local>
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com>
 <adokoNfP-Ueg4yQ7@stanley.mountain>
 <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 11, 2026 at 12:47:42PM +0200, Joshua Crofts wrote:
> On Sat, 11 Apr 2026 at 12:38, Dan Carpenter <error27@gmail.com> wrote:

...

> > > +     u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
> >                                                            ^
> > This extra i char is something I really dread as a vim user.  :P
> 
> Damn, that's embarrassing... Should I wait 24 hours before submitting a fix
> even if it's this trivial? Thanks.

Yes, please slow down as you also missed a tag.

-- 
With Best Regards,
Andy Shevchenko


