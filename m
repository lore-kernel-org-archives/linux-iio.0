Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795045;
	b=f3/5ktHDTQq89b22AOdC/yylzQ9PCE21eP1WBfwxayLsuupquB66Q3VKORuj+8tPvBbw
	 Gx0yrNkt0FRBXPZprDXFRQdysXjQOfO9qvq8ek17s+DfyXC82RpKzEjHPuiTmvtiUAYWQ
	 U2Gny5DLnmKyF5hinXh7RU8SRVvHlx/YI/uvz9GSUwucmSBVseQoscvw/Trd+m47XmRKg
	 ZbLj/+vV1o27ThzPM86xoj28UI4EOawS/x5Hrvn7kzUeTPtDD/OqlpN/wSSdrvfsnXGqB
	 fhXp/idZj8k2xngqV21Wgn7zl7NKYYstuzPhaaILPR131GRwvTyTsh9i4F89RjhruKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795045;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/p+JFPSCLoZqNqzY8Xr6x+8qcMRi6OZN2NUOCbmiccY=;
	b=rdO+HpmPFaD+az1QTgFQ+Br0KrM6i1ea9VLdB3ALF3+JgYpfPfxOSWVZUAIUIEAf37QB
	 oyhBCNGxokU/tHnEKDk/m7qfMNyMzR1A6ZMuz9/ey+djt48R6sF1u6zG+ZJyzgd1Rvd0d
	 jw6qpKT3+bKG12VNqSh5o1ZwSHjC+7b99ZpLgZEszchSG4BJjUrHofwuOeyyxKud3R1mM
	 DstPr86grzfgvOMhyhcdKX/aPiPQodUFHQOoZ/FG48ThR6s/ByStWZzb+7WLo0a1l76BG
	 AoE+y1Z0Ymr/7pM6hsPGwreJ9/S7ONCGcWJ+abzIBB27uK5CapMBhNRlJtqbKyQ9/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JbpS0VvJ;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0186606A31C;
	Fri, 27 Nov 2026 15:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0186606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JbpS0VvJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795795045; x=1827331045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+01+EG9ZvJ1k9CcSpXuvtDcOK4UV1iH4HuybqANQEE=;
  b=JbpS0VvJi/oTe/4YVefpl7BRuA2BgfN5UJt7a28s42xwO7UBiBVM5vvv
   3uSJwtZibQ8eFyQoFJIvQdQupYGpdn52Vy2NIT7/tPBsIlGLQGBpzV8Hy
   xyLINiYCTjoXAhsZQxVK9lXFSJpn6tVsHYeEdRwQoeTXYfd2BB8UTbkX7
   PmDWsj+IIEozyk7gWWvpuuoAweo8/LQEE51d2slOuYWNR+vh/QMNl8gRH
   txUZBuB0vqtVxGns5rFfcTQ14sNsuANl4o5qmSCtpEWHUhh+pc923VUF7
   8lTppr7ffQCnAv6WwVD5T0dqoxDeRg4S1WuWZOK8X02EpM8x4gA/6c89G
   A==;
X-CSE-ConnectionGUID: F6QDf29JS7aiQyFXawCDAA==
X-CSE-MsgGUID: IRdKWV45Rs2grdr4//l8Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4728774"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4728774"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:57:24 -0800
X-CSE-ConnectionGUID: aHNZatWGQHWfQmmeyyrSQA==
X-CSE-MsgGUID: e6gJiaGOStW5EkBtqI3K+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="14187888"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:57:22 -0800
Date: Fri, 27 Nov 2026 17:57:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Joshua Crofts <crofts@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
Message-ID: <awmoX6cXt140LTDk@ashevche-desk.local>
References: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
 <3ec029d6-d53d-4cd9-8582-a15cfd3eb4d1@kernel.org>
 <036d044a-67ef-4716-aa0a-cdf3108c12e4@gmail.com>
 <awljZLpARRVUFqbI@ashevche-desk.local>
 <9291049f-987e-4402-b32c-12c33c7aaa33@gmail.com>
 <awly0_hYZ07aeRYV@ashevche-desk.local>
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
In-Reply-To: <awly0_hYZ07aeRYV@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 02:08:51PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 27, 2026 at 01:46:12PM +0200, Matti Vaittinen wrote:
> > On 27/11/2026 13:03, Andy Shevchenko wrote:

...

> > No. There is zero reason to use capitals in variable/member names when
> > intent is clear. It only hurts reading with zero real benefits.
> 
> It's clear for *you* or somebody else who is not the first day in IIO
> development, always put yourself into the position of unprepared reader.
> SI is known for much longer than computer even exist.

Correction: SI as a modern system is known from 1960 (updated in 2019),
but the early prototype was published in 1901 and extended in 1921. The
whole idea began in 1875 on conference in Paris for the standard metre
and kilogram.

-- 
With Best Regards,
Andy Shevchenko


