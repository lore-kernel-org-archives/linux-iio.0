Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAB33AD99
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308550; cv=none; b=AmCH4QmKov1+gBLh2vsFI9G5XKAjJ1J+hNABMihv2k3vU+OYAQIM2lDj5t3+XokSCmsrTImkvEBvXiun9Xvusndt+oBFqgrgukQToiwQPF0AopUqxyX8oW6T+PQ8QXxwTM53hifg5S+DLbzUxpBnm1TpzcJwqi85sJ03tVBIeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308550; c=relaxed/simple;
	bh=LrRJyq6VQySVl718hq4Y+k08CQJyzUJ7fs3zZEZlLSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io/LEC9MvkBYsUIOzxH/JN2OYZie2m/ZAkDGYov7nocIm7++LDusIowjbCtJS6npnNK3lH9G9DteebL7a78t2NNC74c8IwLBYhLIAEuEmXIlWEWt24dTg3PzvdpPAO4hrpe6/bBSlVgSbDsbRsMQBGmipiQAd2YIloxYhvJlx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlRQdQzy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlRQdQzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773308549; x=1804844549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LrRJyq6VQySVl718hq4Y+k08CQJyzUJ7fs3zZEZlLSU=;
  b=NlRQdQzyMpEBJjQpuRY2j5UZbGfwArG7Rz96vUQKvg7DA9q4D+xlVbwY
   nByscWzVbGaDWlDDqB1cjkI01YPzpZAoXYW9f6wn32KH/CNtoNHGdLCqw
   WUIVY5SD6PAB4xJnf2Z/mRFfERjZecNCAZm8GVTkozTWQH9hM/Vp44a6i
   Som9RIiPWyssxstyqs7l6SL9tH0XlRCY5cGYWexrDQF2ia5rdeB4rn4Ua
   5hxPOuwWJwHTfuyD0azbjtNh3bF3cQzIbn68iVt+8oftiOrEOFBVT/zod
   sF9acT+U+5IF0NUjLTaVUvKfx8e9EmjMS9/ccSCGw2Vm9zH6xCnX4qKus
   g==;
X-CSE-ConnectionGUID: PUXWYVQbS7uqKM6N7DERVA==
X-CSE-MsgGUID: B2SiEUIgRHeewsGzOVfxUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74583757"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74583757"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:42:29 -0700
X-CSE-ConnectionGUID: /SO9ZloWSTSHZxcOZSpezQ==
X-CSE-MsgGUID: nIxZNAc/TluDa4VxxV6HRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220716281"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:42:26 -0700
Date: Thu, 12 Mar 2026 11:42:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4130: Adjust indentation so statements start
 on tabstop
Message-ID: <abKKgPUkoKQ39Ho0@ashevche-desk.local>
References: <20260311072156.35057-3-giorgitchankvetadze1997@gmail.com>
 <abGPhYz-5OLeYg07@ashevche-desk.local>
 <CAE7dp2pO+Dx654ybH47uu7FTyoNfTHaEB8ihxiMFjQYONrODhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7dp2pO+Dx654ybH47uu7FTyoNfTHaEB8ihxiMFjQYONrODhg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 09:49:27AM +0400, Giorgi Tchankvetadze wrote:
> On Wed, Mar 11, 2026 at 7:51 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> 
> > No need to touch this. I was against that static_assert() in the first place,
> > and still against it. In my opinion it brings no real value as I can craft a
> > layout that will have the same members and sizeof, but different types.
> >
> > In my opinion it's better to just remove it completely.
> 
> I adjusted the indentation only to address the checkpatch warnings.

checkpatch is not AR (action required) tool, it's recommendation one and
sometimes even it brings false positives or (rarely) harmful recommendations
like in this case (because it doesn't understand well what's going on in
this piece). You may experiment with clang-format on the other hand and see
when it gives better result. Note, we have a specific clang-format
configuration in the kernel source tree.

> If the consensus is that static_assert doesn't add meaningful
> guarantees and should
> be removed, I'm happy to send a follow-up patch dropping it.

-- 
With Best Regards,
Andy Shevchenko


