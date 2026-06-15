Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47C79CD;
	Mon, 15 Jun 2026 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518622; cv=none; b=pNH+Oujn1W5SurlHC+mrFDBsllh/cM6du8mr3mhRr663g3GrOXKWTvb9SWME5wBQhypRhQH4JO5Za1rta9CmPJ1p+LRXWLYzpyDL/eD5q5mCAmVJ45ubumvUSFqQO41zKMqliRCgMY0DgowhjsD7pPBXeIdDgnluU1SvALVoF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518622; c=relaxed/simple;
	bh=XXMkBsrLlzm7PACAcqWagpci6o+3ijEXib9ykWCQBrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a05UzPP9Yv4/CtxQAtzNvAfiH+PEWVe4D+ZzJPxOiW5to0RKnXQA+e3gaLNFBKz+bj0K7EbAu+bsqENLQQJO/IudBoxU2XPiU3KpKy4WvurMQFrqFu4wKzkzh+qyIuhdEzEs85D994MxFS1ZVVDHhIs2KY2ZEug7QsCGjQMCI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuEe6N1l; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuEe6N1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781518620; x=1813054620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XXMkBsrLlzm7PACAcqWagpci6o+3ijEXib9ykWCQBrg=;
  b=XuEe6N1lmINd/QZGxyuImqwzSUwprIW/THb/BeJovgzL1z+DwyJnMWgy
   vB7YHk+/iVFGoV6vpIcRVXk8VxAQl82Mip1KSzlosGI4+NBWzbPege9WP
   9HhRZP5TWwwdR8dlmEolickXGU2SXhb6DMcPcc8igCmJ2ETMr/9jqeIRv
   rKFnnDXppZqogJ7sMem/V0FBggK3oKj7EHChnEQ/YoO/oIvkUvJ5aQ4Ea
   nZGqh2S31gmhGKwWdUqrYAWPsyAJhHmnejHDuR1oeiAiL2VLCTUJ9Cd8j
   ySusg6hHno+fplaE8p6zlyr1lcMsY5Y6GYMjDnMPfHrjn6a0MywFxAkqz
   g==;
X-CSE-ConnectionGUID: +r0PGNcAT8iYu/q5/vASGg==
X-CSE-MsgGUID: +gQoTVLPQn2VCRyZqiezPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="92574280"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="92574280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:17:00 -0700
X-CSE-ConnectionGUID: 3y16eREwQc20kMsYHhl8SA==
X-CSE-MsgGUID: vI651//AQWKzWscQSJ7eJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="249328888"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:16:57 -0700
Date: Mon, 15 Jun 2026 13:16:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>,
	hexlabsecurity@proton.me, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: clamp the device-reported FIFO
 sample count
Message-ID: <ai_RF9BG17SZ7Tiz@ashevche-desk.local>
References: <20260613-b4-disp-22362900-v1-1-c5e49f6af027@proton.me>
 <20260614144337.3b3dab1a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614144337.3b3dab1a@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 14, 2026 at 02:43:37PM +0100, Jonathan Cameron wrote:
> On Sat, 13 Jun 2026 03:13:19 -0500
> Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org> wrote:

...

> > Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> 
> This is hardening against broken devices. Nice to have, but not a fix and
> not back port material. In general we do harden against the simple cases
> but to catch the more complex interactions would require both a hard to do
> audit and significant extra code.

On top of that using min_t(u8, ...) is prone to more interesting errors,
so one basically should immediately raise a red flag here. As Jonathan
said, use min() or even clamp() as the Subject states.

	foo = clamp(bar, 0, GOO);
	if (!foo)
		return 0;

> So nice to have this but not a fix.


-- 
With Best Regards,
Andy Shevchenko


