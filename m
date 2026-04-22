Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575F3C2785;
	Wed, 22 Apr 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849874; cv=none; b=WrNp/ZwmzHpasUcrgEpGgvb/AzpvaCLAh+3QY6isKOkgWp+S2UKP7IHIppQdb6iDVxWO8ZKHwAdsNuuv0PZ5+BxYAa+kLnfNuA/aikM5RLLXLymGpRS85si0ca3EGEULtWnVR10hkRXVHdQkpKHIFPK5F2gnyhRfDYOBIT2pdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849874; c=relaxed/simple;
	bh=B50/TEkilQ3sCMQ9igw5kwn5vHfGfLh1ecWyUT2ugDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5xpMkAp+jacd8C+Os5INPL5jX1E2lNDEwkmrzL/urxmjCqsHhyq067Syxf2jn1oAdT+MjRjv8yQiqNqsTNHjmgy8Gxh1agif2e5LlmJTJ8L3wfq45IyHGUl+pqu69NipR4t1A1IRUPaiP1ju7C9sIhB06BRmmZTwg/8gDs7+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOS8R+4z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOS8R+4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849873; x=1808385873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B50/TEkilQ3sCMQ9igw5kwn5vHfGfLh1ecWyUT2ugDQ=;
  b=QOS8R+4zGfCVDhDNJEmoq5znxHicNCZiFAaDoF+2TsJfgdyQEHDhhcjj
   O3pVawFyv2KrY6I7wHNjgmOi+/3GBHTW841zYIK8pstzoQfxpQ1qbqjY7
   +FN29IXCBwPi2iPuD1t28Z4jWjEvRcj6nnHTEAVZtJ1VArmZ+JHNjhulm
   pB+bq/HYJX2wxG8Sz/bQXkS4RpGoXf8+rKvlWUQpyYW07PA4DiuN+NTbN
   ipDxL4MZ1Q0P0MPZDJLHgUFGTOjCPTlxZm4lXoTqIYcdbOOkGHLQzGcN8
   BOKA7iE178vttWJNtKNWwucPmxtU/r1tsXy1pPKcGBigQGDCQzyZlExnJ
   g==;
X-CSE-ConnectionGUID: 9MG0JOI6TcufdxiHVjgPtQ==
X-CSE-MsgGUID: 0wpOSyF7QcqBTB/nQg8lKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88874302"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88874302"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:24:32 -0700
X-CSE-ConnectionGUID: sJQ3sjYRQcSPe6csG185ow==
X-CSE-MsgGUID: QYApdIjPQQq2+TnEU0JncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231269896"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:24:30 -0700
Date: Wed, 22 Apr 2026 12:24:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
Message-ID: <aeiTzA73ePa_cNVh@ashevche-desk.local>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-4-joshua.crofts1@gmail.com>
 <aeiMPrBs4BJE0H_k@ashevche-desk.local>
 <CALoEA-w7T-15paJ2j2kGyaWjeK9FpHynS+vD0rpv1dBKEo3gcg@mail.gmail.com>
 <aeiTh6uw6yLW-D43@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeiTh6uw6yLW-D43@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 12:23:23PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 11:19:06AM +0200, Joshua Crofts wrote:
> > On Wed, 22 Apr 2026 at 10:52, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > "While at it, fix the indentation of the parameters in ...func...() call."
> > 
> > Indentation is fine, but the email client clipped it.
> > https://lore.kernel.org/linux-iio/20260421100722.1296-4-joshua.crofts1@gmail.com/
> 
> I was not clear enough. There are double quotes on purpose. They has to be
> interpreted as
> 
> Please also add to your commit message this sentence:
> 
> " ... the example of the sentence ... "

And to make it crystal clear, the double quotes should *not* appear
in the commit message from this example :-)

-- 
With Best Regards,
Andy Shevchenko


