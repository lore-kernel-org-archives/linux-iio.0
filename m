Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515873A426D;
	Wed, 13 May 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702297; cv=none; b=bR3EV8qevTM9jPUtKfobkSAPhL2s1CwJKIMGuRijsazW/VCMKsizDDaJ8FVvL9W5bl4q0BXGkh/XCF2b3iTfwlTEIdORyVytIyypQ/o+cdiXZyKMTs+riI8EHa0DFcGtllA0IlXS+NIaLhJr/P4hYXL0uIVAGMrzaPXWSQYurx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702297; c=relaxed/simple;
	bh=qmcCLxzDWCNGCFREjDdO/t9+j3qwYypQF9grM1WaKzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzHiyUOpcR+ON+iU5sHdZiP93wU2/iMpfqn/WJ2KdcHrKwtu0h9ZE/uUOzSc3dfs26ceG0jX5M89ewjI5dRMOsLTaItGfn+6kAd+mxC3VnQa05UJRYdB3dRj9wUqWWAYpvkmpH6L92uOZvEwc0RSci1o4ZEGm4wJTVUdFiIwRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRSHavaG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRSHavaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778702297; x=1810238297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qmcCLxzDWCNGCFREjDdO/t9+j3qwYypQF9grM1WaKzs=;
  b=gRSHavaGlX01XaSnRhHgdQAyJ815M2tPyJFs1cBQbRY5GHGuewQFtCHD
   RIwt1FYeuJYU0C3bVItb8Mb1EAmmmlpj1mUAcFYfLUbsCFCyzCfWU4zyb
   D/UDt0ayh1StSXqIdpdgJy4KnMVWrc5krpzw0QSOA8oLRGWKFVw4M19IF
   Q5nBIddabrbaW9uFM+vT8icOyKgGMsfkZgfYtZiKq/h+kR6LFipN4g2uX
   L2qA4oREOvFYAU2EvOHGC150eSEuuZ34v6IxE3M98r1V88eGDcuSoSfBf
   hPYG6lFE2TZ2xpHQ6L3QBzWhZ6Vdt9lpG0i0gJ4NVigb9NAqxH1A89TdE
   g==;
X-CSE-ConnectionGUID: 6pc8onk2Tba+GYyxhhb00w==
X-CSE-MsgGUID: hzWnXyuRTCa4aqjPLxXIZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102307320"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="102307320"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 12:58:16 -0700
X-CSE-ConnectionGUID: Ay9VBkBhT0CqECmPbuw2YQ==
X-CSE-MsgGUID: wS4ruFstS1+mKtohxw8T3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="233724693"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 12:58:12 -0700
Date: Wed, 13 May 2026 22:58:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: veml6030: remove unnecessary read of
 IT index
Message-ID: <agTX0jFuTueBU8EZ@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-1-4703ca661a1d@gmail.com>
 <agSt_TGpyujxqrZc@ashevche-desk.local>
 <DIHR7242IVEQ.HZ3NLNX0G9E1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIHR7242IVEQ.HZ3NLNX0G9E1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 07:17:24AM +1300, Javier Carrasco wrote:
> On Thu May 14, 2026 at 5:59 AM +13, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 05:49:41PM +1300, Javier Carrasco wrote:
> >> This is dead code as the IT index is not used by gts to set the new scale.
> >> In its current form, the value is read but not used afterward. Remove
> >> the dead code.
> >
> > Does it have any side-effects on the HW side? Exempli gratia, flushing FIFO,
> > R1C (read to clear 1) bits?
> >
> >> Fixes: 22eaca4283b2 ("iio: light: veml6030: fix scale to conform to ABI")
> >
> > Not sure it fixes anything. But it might regress, see above why.
> >
> > ...
> >
> > If no side-effects, the code wise looks good.

> This patch does not have side effects on the HW side. Apart from having
> it tested with real HW, the operation being handled here is setting a
> new scale, which is stored in a persistent register.

It's not only about volatile bits, but good that you able to test on real HW,
this is much better than just theoretical clean up, thanks for confirming it
works as expected.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


