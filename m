Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085E3BFE2B;
	Wed,  6 May 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053052; cv=none; b=Kpkj4yJiEm0sxmx1mBM5XQDL5XWGcvTMSIuFnJNkndv5p2GC85P9YNLuTI8OhGIDGsB3sG9JMisrJWIFGUFpNh464nNOJRfUaqebnfWnnHDkwmltI71F/FyyV4qTXKiGcDId8p3IrGwRcxLhbprn6wpKrWNq8F6NmvJ+hzn1DEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053052; c=relaxed/simple;
	bh=tukaqwJYVujpvieSif8lcxDtZnIJvlW9fGnMUI+N/ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWHFcQHjpvIrhNVIPSt0m7YCqAdtOnQ5lFgv6kJnQFSPT9KUHOZh0MZnWv9bRb1jFcj3tRx0LuhbMRSbw3eP4VV531HsbsQJNd/qEI3tgC2HathBVO1weB6RRvWFQ5byZag0IB4FeGNH9byscX6Cqfyu2MdozOzJEXEPlSPpL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbL05X/z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbL05X/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778053051; x=1809589051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tukaqwJYVujpvieSif8lcxDtZnIJvlW9fGnMUI+N/ao=;
  b=SbL05X/zY82FYyhv+fmBZYCoEAt3v28F3K4b5TVUffOVRxjjnV+Blx40
   caQfSgV+lPkhv0Umh/1ue5Htmvp4T8GtEEO6+UXXb7g7t0PODl3jSyXex
   rs8XjrfWqRtIYnJte2jOORd76pji2pbuMwTjpVSlErpd0S0bWdo+cBKzI
   pECXzils0ze3hdUl4FwI1Bwc9izh/4rfdhuiaMr8ZYKy/wkXg3XZq5atT
   SC8CnmfCCqxnANQlIJx3gMCbJ0DINQZR8sdXubYuSZbz1l8RlsPN7bqgU
   1+4Rz+/bPv7TPm4vs+UIQaNGo5TIMvz+j9bcAes5tmk5ah+KIJvlgg+lc
   Q==;
X-CSE-ConnectionGUID: 9tDHax/dT6unKoovlekaog==
X-CSE-MsgGUID: b8w/2SxvT425jH/7F6NoQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78956378"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78956378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:37:29 -0700
X-CSE-ConnectionGUID: L+IqCuxIQIS3IRi3jXjR/g==
X-CSE-MsgGUID: HAlDCHQESZKLg2ABoB4Sag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240049863"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:37:26 -0700
Date: Wed, 6 May 2026 10:37:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <afrvsw4cTU05oV2Q@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-3-sanjayembedded@gmail.com>
 <20260426150830.7ab41ad3@jic23-huawei>
 <F6B75893-D8A8-4072-BB26-83F630805700@gmail.com>
 <20260505173859.19b79034@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505173859.19b79034@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 05:38:59PM +0100, Jonathan Cameron wrote:
> On Sun, 03 May 2026 16:53:27 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> > On 26 April 2026 7:38:30 pm IST, Jonathan Cameron <jic23@kernel.org> wrote:
> > >On Sun, 26 Apr 2026 14:47:03 +0530
> > >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> > >> +	if (msg->length == 0)
> > >> +		return;  
> > >
> > >I know Andy suggested your bring these into the helpers, but to me
> > >it's obscuring flow as it looks at the caller like it was added
> > >to the pending list when it wasn't..  And we end up with multiple
> > >checks on msg_length where we had one before.
> > >
> > >One option would be to have it return a bool to indicate whether
> > >it was added to the pending list or not.
> > >
> > >Andy, would that work for you?

I don't remember if I answered anything to this, but returning bool is fine...

...

> > If we convert this change to sub-function then suggested use_irq would be
> > shifted to sub-function; then how would you suggest to handle that bool ?
> > - keep msg->length as it is
> > - in sub function __ssp_do_transfer(data, msg), should we pass additional
> > parameter to bool for further execution?
> Pass in any additional parameters you need. If it becomes too long then 
> this was a bad idea and you should ignore me ;)

...however, the coding style (or some documentation) suggests against bool
parameters to the functions.

> > Or any better alternative to handle both ?
> > 
> > >Then we only have a simple check on return value from that to decide
> > >to increment the counter and exit on error.

-- 
With Best Regards,
Andy Shevchenko


