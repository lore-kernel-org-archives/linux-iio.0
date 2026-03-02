Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4402AD03;
	Mon,  2 Mar 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463812; cv=none; b=Q+92LGI4vbOnA9JxDc/d+U/LkQPz7VQBkhVcXwO1lgZbEXYl+6kdYCJtHKhiQRYeldmTy5HRCyYSYxcIpUCDrMQsOHxl9nooSwnVspnbbVN5VclpyO5EYi2/qqS4bOE7bvpni+3lI35v6uHl88v+r1TAqxf6Cv3ov1qmJ0T85EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463812; c=relaxed/simple;
	bh=1YZWehKHT5luPR2wDWEMMNpGo9Tec1+8Vpddc8KxwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi2L0qaUfh0f/FsSyFyg5N06PHyTVyguzG1cvlqKGGWbGO+dSITbbhsQ09Afwcfo77ClPWP/HMvy0YY3qkRVP3dKsbjqhAs/4xwDWozpZPShzaI97/0TDgeaX68HbvnP54bPNEWXwXsawZeAD4ugXCuhPkl4jYiQZfS+tIb2oSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWTL7ytC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWTL7ytC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772463809; x=1803999809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1YZWehKHT5luPR2wDWEMMNpGo9Tec1+8Vpddc8KxwKY=;
  b=ZWTL7ytCh0KrlJ4AyiYkP6AFOu4ZLOeLUwUEM1CiXF2EFh+wUMec3kw/
   oizUF9Xon042tADK2il2GFKNMaopAa8SWO2m5R4dfXXGtkTbEy3L4aR0P
   nNr7Ez+mj9lBWtBllKOB+xAG8EE2snxPBC/T9ans14OigARd836O3Lr7E
   NxdkjryT+NEHpc1sthqnEWUFExGkJc2T4e2p1N/UZEhZ3m/9KIWYorowL
   a2QpQM/Hvhifio+BMggvX7XZs2wADIb8ZL2lm8fL5e+ZVzVi+brFyqSiG
   ZONRkapQTqAEX29LqN1dOG+ulfXSApZxkG7kpzA5HSO4SisTXcHSAj19L
   A==;
X-CSE-ConnectionGUID: wC0VctPWRYqE77XWK76hMA==
X-CSE-MsgGUID: b2uxhdkDQnq3UNm8imyIrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="98941175"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="98941175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 07:03:28 -0800
X-CSE-ConnectionGUID: 2dsJr5LxTVy0rwCIr1p1Cw==
X-CSE-MsgGUID: 2e6RBVenQRG3lq/8qU2U1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="214879659"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 07:03:18 -0800
Date: Mon, 2 Mar 2026 17:03:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always
 written as 0
Message-ID: <aaWms6mg9MFBqzv7@ashevche-desk.local>
References: <20260227124305.55271-1-antoniu.miclaus@analog.com>
 <84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
 <aaVCuE8rwFikaL5c@ashevche-desk.local>
 <2e4acc5f-2079-4160-a4d3-6453b48eef03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4acc5f-2079-4160-a4d3-6453b48eef03@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 08:54:52AM -0600, David Lechner wrote:
> On 3/2/26 1:56 AM, Andy Shevchenko wrote:
> > On Sat, Feb 28, 2026 at 10:50:00AM -0600, David Lechner wrote:
> >> On 2/27/26 6:43 AM, Antoniu Miclaus wrote:

...

> >>> +					    !!(fifo_samples & BIT(8))));
> >>
> >> Technically, this works, but in terms of understanding the code I think
> >> fifo_samples >= BIT(8) would make more sense.
> >>
> >> fifo_samples is a count, not bit flags.
> > 
> > I even would prefer to see in such a case
> > 
> > 	fifo_samples > (BIT(8) - 1)
> > 
> > that it will define the maximum that fits the HW, or plain number
> > 
> > 	fifo_samples > 127
> 
> Now that I looked at the dataheet, I get Jonathan's point.
> 
> The reason this is here is that we are filling in a 9-bit value
> using 8-bit registers, so the MSB goes in a different register.
> 
> So actually, it would probably make the most sense to write
> it as `fifo_samples >> 8`.

I agree based on the above justification.

-- 
With Best Regards,
Andy Shevchenko


