Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002180;
	b=XWejAg1JgOR378QbmMj6Xmhl15A9BaUAr7jtVR9ur9J6vBKCFCQHGf+5u31F7S0Cd4Hm
	 rYVR3Uv3kbIF7rs/87ztoz0iTm8/8ylmCuOEHWnJwzA1ypr9y9O/UvumLoJU4kVJSaUh0
	 Uxi2ntdGsXcwGLBqqu6poNC1MhQffA7tz0usTrWgVdnHXBZZcX1+jJVTD47IGLhzeptwD
	 /tRSNiwEOzWg+vJD0Itkz6stH7VR9UK8Z9mWKFvAIN/STsMpwR4houem6ZYNKLNqrfvzF
	 b7o4sxRcVEyON2tQYsXkHCy9h7fWGBkYla/bCGixRaThTg8YBoZGgo553CQ+QrFMAkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002180;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VORScU2WHgaL037zp43a03zarHnZ2cJzdDZEn2yZjRE=;
	b=jBuKo4TA/OnNwNi/r1TukOw6+kcExeGVYm2va4C8A2r11H0T/sMzd2ljMGCwRT9jysv7
	 h6064jL4FI1XDQgdaheNG8HHWeK2U8pe87wvn9kIHeBp6Vz36WvxNZ4vrpSATE93rCzVp
	 P1khTZdmvq6DICOj/bQCy2iR/7ol2m6mYiGyIhAVYy4832o+ZcZNUACrpDWBUd15+P55m
	 Cjjw8WPXUNRJ81sJj2i6rX22Nzf2gptXmv8OkajdllE5UB/zxbUuSuc8oPvuWWSpw9bbo
	 IqCZyU4ZDIzcoB+YQDpEtlFtc7X4/VtxHzNRsjbIO7uwM+JhJ2pRxJXOpKp/nuLH5Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nwH0xTng;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D6606A325;
	Wed, 18 Nov 2026 11:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203D6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nwH0xTng
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795002180; x=1826538180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBO9QjAow4o/fgG2YjmhL68OmznGMdsdtfPmDQPdgS8=;
  b=nwH0xTngFNtghLmjS/EXnEcF9z9KrG9xw0738gHHVU6XqP7akvCL8xhA
   iF5LjRMBDiX7iTJMtCFOb9OecM7/KkHau9ksObBONq5IT/iPwU3JGIjRs
   mGzgxBt4ErkqumazZ9EJhk0MvDNptcZCID3QpbfPLBUbmwfKcnYpysm1Z
   HSCuZp4xe/TOfo1L+mfuge2BTq7nWPRxGvQntPprPu3XMR8g8A5XSYURx
   E+oM6+7msqv3ezXnp8YqSURowionVZRSB6A6czoXK9NdAsclN7+BIzBaq
   CfC/++VpNKhkwhK3KfhII2dMOmTUGHTPcKzC1NcdLaWy8WW3ohShq3onE
   w==;
X-CSE-ConnectionGUID: SoliBCCZTOKXOnKAfOJl+g==
X-CSE-MsgGUID: RHmgP3MJQ7G+R0w1TCFLdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3700861"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3700861"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:43:00 -0800
X-CSE-ConnectionGUID: vchMld+ERSWReNBbTDd71w==
X-CSE-MsgGUID: h2tT4UyrQo+/53HNN+VgDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9914885"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:42:57 -0800
Date: Wed, 18 Nov 2026 13:42:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <av2PPiin8mJiJD_q@ashevche-desk.local>
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
 <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
 <820865f9-2ef5-4316-abbe-5c44c7df55ce@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820865f9-2ef5-4316-abbe-5c44c7df55ce@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 12:31:59PM +0200, Matti Vaittinen wrote:
> On 17/11/2026 16:21, Andy Shevchenko wrote:
> > + Cc: Matti (even he is not listed as maintainer) for possible another pair of
> > eyes and/or having an answer why this was missed at the time of the driver
> > submission (from my perspective this patch is correct).
> 
> Thanks for the heads-up Andy. Unfortunately, I have never worked with this
> IC, and I don't think we have it in the ROHM Finland office (but I'll check
> this just in case. It'd be nice to have this covered in my test setup).
> 
> What comes to missing this in reviews... Well, I suppose the reviewers are
> just humans, or if they're not, then they might have concentrated on other
> important things, like styling, instead of the real functionality.
> 
> On my own behalf, I was away for 1.5 months when the series was applied, and
> I only looked at the GTS-helpers usage when I did my shallow and badly
> belated review. (Furthermore, I am 100% human, so I might have just missed
> this even if I had all the time in the world to do the review).

Yeah, I don't know how ROHM is big, but in other companies usually there is
an internal mailing list is set for reviews. Maybe that helps?

-- 
With Best Regards,
Andy Shevchenko


