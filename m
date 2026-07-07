Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728841D4F0;
	Tue,  7 Jul 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429948; cv=none; b=d2eYu/7gERKBGNbWb4xA9FommBHQs6hQB+coh3+ukarQIa4GvWpKKPj1KCzyeVaLDs6s2+gIzfGk/G5nzNANxGWAtkpfERTHukUFnfXDHFTzEQ+QsuXUglne5Rw9UmNcLAPi1jSkzDh+6IrCDyVMcknt6FVBa7ked0JAhUjjKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429948; c=relaxed/simple;
	bh=OuUBQFj5W/CwdGn4MGWFc5bUyYIqLUwL8ShcbD9R874=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNKU+XF1cjBZ284Rpt61EXUSXr1qnAz7O/ksfqp0tI5rMPUZb0TNo2CN5t9NqPmNT5HrYAyMbrEKUp6ORimaPqygSzhGFakp0asCURo0/xesR+46u1PtHejCBID7UiMAOSafLrnANdvS4iF1AYnLw7Klpm77x4K3REZfAihuvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBs4mNRs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBs4mNRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783429946; x=1814965946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OuUBQFj5W/CwdGn4MGWFc5bUyYIqLUwL8ShcbD9R874=;
  b=eBs4mNRsEVhieAOsTUR9yrB4uIZCBhxfJ27FwfS3hf6tOEu7Ip1Fz53i
   dwXg5kGoNQLCdTyIr5PlbHkTcwHKgObsOy286+huRYix0nn6ht/nNvoxm
   kv1u/O8l9I1ldMMu7csSW6CobjhhwehJUknb++DDUCM9LdvOWSeVp5YIW
   qSj4b1Q6LxtuCjGMwyelKz+A2dTsaGk7FwWgfK8OekL19l53eEn1S8LPG
   jrmmiujSDqIgpyVIrLWTj2O6u1BTSd5vEBsLJBs/RKxIzB+iSa9rJ03yM
   13D+8Rs0PiSApSusFSoEQk++u1n1uy24CG0aRViJUZwf0bOZGPyj1yHy/
   w==;
X-CSE-ConnectionGUID: xW8Vqm5lTSO3QSoZcFBJFQ==
X-CSE-MsgGUID: Y2IHxaHWTWS5UM/w4ReQCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83052208"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83052208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:12:26 -0700
X-CSE-ConnectionGUID: hzSn5+SZS+aW9I4MvvcDkQ==
X-CSE-MsgGUID: gROGZj+SSx+EC35+Sk9egg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251323810"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:12:22 -0700
Date: Tue, 7 Jul 2026 16:12:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <akz7NLTDuvQevMvv@ashevche-desk.local>
References: <20260707104234.1957104-1-shofiqtest@gmail.com>
 <akz6i9yq8ENt-0FP@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akz6i9yq8ENt-0FP@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 04:10:26PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 07, 2026 at 01:42:32PM +0300, Md Shofiqul Islam wrote:
> > Changes in v8:
> > - Fold MAINTAINERS entry into the driver patch; no separate patch
> 
> All three emails were sent as standalone and not in a properly chained series.

Besides that, where are the links to the previous versions (to lore.kernel.org
archive)?

-- 
With Best Regards,
Andy Shevchenko


