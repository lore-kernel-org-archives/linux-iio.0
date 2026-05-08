Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBD37EFFB;
	Fri,  8 May 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225781; cv=none; b=RBhpf5NGKjx0U/V+2WIcVW66IGseh9b9tdcWBTAyhFV3/VhUN2lx2bwXG8P509a0go1JBld7TXf7gOAoH1wfoYK1MG5l2fZ0mnerszPn934/RSQLGxO53t3FCempofLgympXg+21tJ8cZ79d7VBQCM+9OTsnMJZW+spslZh62GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225781; c=relaxed/simple;
	bh=92NHJZrm4nSQbtvZ04B64UF3WHH35WrjCCKCAKEwN0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3+bqIEiDE8Ftzz1RZbvvcrVwlRx3lsVk2mFwhqllyNvqk2Z4ARC3oCCqx0zMyty866r0/98Ak2fW3DR/6zcWFAaxbjv0dE55obrOPHvJSUR/MIPqhL5utRA5/SJoV7dF5qIzQoCCFWD85Y+HnAGviVLmxmmhGXTd2amqMUnTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th45LUNM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th45LUNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778225781; x=1809761781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=92NHJZrm4nSQbtvZ04B64UF3WHH35WrjCCKCAKEwN0c=;
  b=Th45LUNMIh9wJ21toKNm4L0FRCe630y4+57GVv8Fx/qBTu8lrFgr9ykC
   SJUhONc7vW2io7//AHwjQV+Hjr1YXQltJmRfcBrSoE6c/9rQuq76TJYyj
   CrtxPXfPcykBSlj6p7BVeMXfDa6ALYD1GLyifjMleXl1BfAgTXo0zWAd4
   eO5hDhQId1fWJmfOpHKcoaHwxOgmRaOvhWUP0/J2uRsVZbZ7YWf/aJJXd
   POzFvY44e/pvPf9BaSRaajxyO/QNByOofWoyak7aUPsGDAiGggiDsgSEn
   lbR99Ms0ro6gLHYfUFkPPaJG/8s0Knj9pkKOh0VVp3cctA3V+qxJyIYs/
   w==;
X-CSE-ConnectionGUID: BMOgi5ghRRK2+lWd42U83g==
X-CSE-MsgGUID: Jz1bcSZ9Qm6fLU64Qpc0WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79090362"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79090362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:36:16 -0700
X-CSE-ConnectionGUID: I03iT46oTxiqzi1GV3IJtA==
X-CSE-MsgGUID: BzNv+5fFTWOsLVO/xd9RhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232165134"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:36:11 -0700
Date: Fri, 8 May 2026 10:36:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, m32285159@gmail.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0)
 in scd30_i2c_command()
Message-ID: <af2SaesfmLw-AG0d@ashevche-desk.local>
References: <20260506181533.409-1-sozdayvek@gmail.com>
 <20260507152800.9062-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507152800.9062-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:28:00PM +0500, Stepan Ionichev wrote:
> scd30_i2c_command() takes an opaque "response" buffer plus its size.
> At the start of the function the code already checks if response is
> NULL (via the rsp local), but the response-decoding loop after the
> i2c transfer always dereferences rsp without re-checking. With the
> current callers in scd30_core.c this is harmless, since write
> commands pass response=NULL together with size=0 (so the loop body
> is never entered).
> 
> The (response=NULL, size>0) combination has no useful meaning: there
> is nowhere to put the bytes that come back from the chip. Treat it
> as an invalid argument and bail out at the top of the function with
> -EINVAL, instead of silently doing the i2c transfer and dereferencing
> a NULL pointer in the decode loop.
> 
> smatch flagged the inconsistency:
> 
>   drivers/iio/chemical/scd30_i2c.c:104 scd30_i2c_command() error: we
>     previously assumed rsp could be null (see line 77)
> 
> No functional change for the existing callers, which only ever use
> (response=NULL, size=0) for writes and (response!=NULL, size>0) for
> reads.

Is this analysis AI assisted?

> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Move the check to the top of the function and return -EINVAL on
>   the (response=NULL, size>0) combination, as suggested by Jonathan
>   Cameron. Drop the v1 "if (!rsp) return 0" deeper in the function.

Do not reply to the same email thread with a new patch version.

...

Code wise LGTM, thanks.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


