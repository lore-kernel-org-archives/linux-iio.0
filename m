Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281E376BD6;
	Thu, 26 Mar 2026 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515471; cv=none; b=tE47kagfrCq3rKPDptd48FrPvGDq1HE/yzZ3mHTBxye1UnEwTDcw7bnzqv59FKfcVLumfzFPAJxJoTqvx/mcqzcNy7DaiQ5ET2QGLgM/oeZtV14Md1R3CyzKL4Kq+DLAK64k2CyoU+xPhBDozPlLGeMpAPZeFtPkTyTDOL/6c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515471; c=relaxed/simple;
	bh=Jf/Kgho5yKNB1JpDQZ0SBXpGw7aiHOZPL2qcAAMsm84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SELKje9WS0Tb2XCma6379XRkTvvE9U8si0e1Pq/Y3Seh2U/0xW3Iy1SVRI98CDBIeKlZP/CXkZ3GfXd/KI8yPrFfNUYJ4L9GoTv3nQ9TTOklp8o8EXjVroKikLyVuH8oSCN+h6eBdlxCa3ogwcS6BkcJrGKBmDsDJOKmuKGpbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAsIpyx2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAsIpyx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774515470; x=1806051470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jf/Kgho5yKNB1JpDQZ0SBXpGw7aiHOZPL2qcAAMsm84=;
  b=YAsIpyx24teEr3rEcgaCxP1SzItz3vhxBvw2vvtKxy77DSXuMovRJhID
   1Kgr+dhCHVBi6gvqfOrwSiH3U7o7HcNQYruD4XyXZYnYLwXCLTW+EDmn2
   bDzKwfLIYX13xb92V7+U7F5e07S/NAl9JwEoD+s37Au5gZebc1C1vaPTL
   kyWTG8ARZz8msKTyb6GYKQmr4NJsK/jh4yI7aOAACoioAAL1RJnIVGAjU
   sQ2lbCmsKwVc6H31ahwXqrXQ1g3SWkLg4zZ1tAPnWRlqTclXSXO8649uf
   3Jl4ZNvwpexODTGxvgYXP4h/PsM/fMeWAxkSBucvz5rtcFqG71HD4alXx
   g==;
X-CSE-ConnectionGUID: gmRh2EolSdKIGFwdc8aqWQ==
X-CSE-MsgGUID: WfsHozHVTdiQu6m03n6WqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75282900"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75282900"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:57:50 -0700
X-CSE-ConnectionGUID: hXyAlEKcREeJvCMr0KQavg==
X-CSE-MsgGUID: 9hQT/z6gQnK7U9KIwBg+gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="218349194"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:57:47 -0700
Date: Thu, 26 Mar 2026 10:57:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <acT1CDjDmR6s6iUu@ashevche-desk.local>
References: <20260325110942.65337-1-grondon@gmail.com>
 <acT0avRL4AZxgjg-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acT0avRL4AZxgjg-@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 10:55:06AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 25, 2026 at 11:09:42AM +0000, Gabriel Rondon wrote:

...

> > Changes in v2:
> > - Use -BIT() macro instead of -(1 << ...) to avoid potential UB and
> >   improve readability (Andy Shevchenko)
> 
> Not really (and LKP showed that), I suggested to use GENMASK().

But it will still cut the value, so you most likely would like to have
GENMASK_U16() or alike.

-- 
With Best Regards,
Andy Shevchenko


