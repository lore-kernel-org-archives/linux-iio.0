Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304995;
	b=FO7kKonUon8PSRMMouvqd//MMP3XkfjbIobZuBv85rOXCigOBD17vMOdajb6BdoDOMRW
	 HUU0GGgMT5PK9vCvEgbm32tCxs80fJLhsXPi9SQwP5sZZiIb3mq067zEY3KqBcp6859IU
	 Qy4P54z6QQNO0VWRemPqcSlbMdXhGHY2Y8frCixzZrUDZXRIbWGsjSxf1vgQwDW2bIqmO
	 OV1E9P9GPPMX6XnZnMGft7DCpn1ryCGV68CwnfwqeOkz4cwbx69XSyUserM+z3sKb/S32
	 Bx1g2v56ohyZj1EncEH9AotYsEWUOzbVt9VIOdfC4Yi72JjX98HRcQ6clH6pnmhWYfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304995;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6HF1e9lepwhm1oE7j1dSMudJRnOrQXs2jFeaqj+2q6I=;
	b=SAxl0ciolzx+41PkGAwzNPnRmMpPdPe6+g+pxEpaVqpHJiPSTawIOvm0Kl/z0mF480r8
	 xT7U/plPBjyKHuSMNQH0TpzMlaL1qgP9ihXDZfdTsYxHmX5iiuASmG2NUZCcx5Zb0uL8x
	 Dp3f+rhaNM7pxdPwJVqfGFj77U5w4/bxgrfPiBEGVz/aI1hyXvMgsnoWhWD+TqpLT96Y/
	 FDDiRtsLITNrx8+cxUoziUXrZBhcntIsZl5pPskY+kpcfE5Wcj2ndyTDEZkGmmRaSgIVP
	 ftwnJZE3OJgJCGiyc9J9ekn2joCTf0RoNz11Nuw3szM4FZd5FhcoFxFX+3U1nIbt9vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B9xJj9KR;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB8606A31C;
	Tue, 10 Nov 2026 10:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52CB8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B9xJj9KR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794304993; x=1825840993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SW0TvQEc6Yt3Uny33u1kgn0MUL8IkLv6JB5i6nB7eEs=;
  b=B9xJj9KRDXed/TIiLtywANYQT8apNIErtfmiIf7weJeJMjorBDux+3fK
   X5NBNw1Tavm1sicgvWWWxxnaifULQKBpt8VZYysdcPiWkc+WKniJalQ+p
   x2iKvDiQKYzEI4yIce33am4hYMU73fxyWRHPElAtRhLqW70qG3RkPri5I
   qrjBMoe5jw0Xxn5U4HodoGvCcDd9SZCGbsMe6zpzDBgdawMOgh8P70cwm
   Y5Vi7ABI53fvPBXrQJqoe4hQ3Tqq0E/uvYbr6e5Tds92zoVZyh3rjIXv1
   39u1CFDGo8o2q0JQ9u37oRjhEO0ACwQ+SyBc397E9FtCXKhOfSlIR1ARE
   A==;
X-CSE-ConnectionGUID: 2xkQFPVKRNSMgIY4PtU5tA==
X-CSE-MsgGUID: FqMweGwfR8Ol+4sdgQuLog==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2950786"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2950786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:03:13 -0800
X-CSE-ConnectionGUID: /BglLhclScWTLf4GGUpTtA==
X-CSE-MsgGUID: eYcR2an0SdarUAmISfnQ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8436949"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:03:09 -0800
Date: Tue, 10 Nov 2026 12:03:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, crofts@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v3] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <avLr27SlZWwFnpYY@ashevche-desk.local>
References: <20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com>
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
In-Reply-To: <20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 05:29:42AM +0000, Akhilesh Patil wrote:
> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> ---

> Link to v2: 
> https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 

And where is changelog?

-- 
With Best Regards,
Andy Shevchenko


