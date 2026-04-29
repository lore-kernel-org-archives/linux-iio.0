Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF78390C9A;
	Wed, 29 Apr 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471637; cv=none; b=ju5ofkZUocV8FQZTLRYwHa77Ak2YRRugQeRyP9EqK60tiiGF4OKBriuFqjRafbzFa9Wxi8gp7VuCm3NPDB1W72smG3t/vb0bxhHrf/F0OwcYf3UncduhZ/7FzFdmHbjAc3sbTIJ8dz+9q73KtPipkCCcsz1Xdroid56OaYNlMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471637; c=relaxed/simple;
	bh=2d5473Lt15QQD0Vc+rH6l0ta2hhbH/2ZdIq+Y8Dz3JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPf9tMTk2dvOrGMpUGKExfPt3t0kUzRiH3zbLh0nYUbbpbnHwsdq2wh05fExdh4QfCP2bvv2WvSXyrtWY7U8XSwaWXUl2sqvHSYIAJPthfzYYL9iHfrZVMXXiW8qOeGlNXNzbE2b/yjhEIM7CKT+DNC9PyJ6lq+gQLQ4PVra+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XALWFLDA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XALWFLDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777471637; x=1809007637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2d5473Lt15QQD0Vc+rH6l0ta2hhbH/2ZdIq+Y8Dz3JQ=;
  b=XALWFLDAe5AUQ+AOuHH34nHae83ccHmRMWX1jVagN5mjq0WKwE7x3prA
   pwItRFlf129f2dR3bmHqlKkagL8C2pOgTILloz7FVBGWvNP+ypkyrDSDr
   nA4DYQehcmdhIMgAiEOkfaTXfRN+RhjhLIaJW8wn9wM1KVE0gsPVSNMck
   qobV7R24KwMyonGpOXlObq+HDL3QZB8BhrY5ukgwCJgVicONFVaD2na5D
   U5Q6d8uv8hat7d9+7HobJPdPJ9OFzK8vFzoVpMZ6b0EFsAyB456EFgiVm
   L5mu2lm0uXXl0FfZMV904Y1mzFajOG7PfvX7p5KTjcVZvPxu23gtofKEk
   g==;
X-CSE-ConnectionGUID: i3IwC6S3RpqS+yLz9jkGww==
X-CSE-MsgGUID: iftJu0RtQSiPrp868yKddA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101062493"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101062493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:07:16 -0700
X-CSE-ConnectionGUID: M7YBnsaCQTCLOmkEW2+eSw==
X-CSE-MsgGUID: Wfk7zgfOSBS0JUDqrc2u5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233422262"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:07:11 -0700
Date: Wed, 29 Apr 2026 17:07:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rodrigo Alencar <rdealencar@gmail.com>
Subject: Re: [PATCH v4 05/13] iio: dac: ad5686: fix overlapping DMA buffers
 in I2C read
Message-ID: <afIQjU2TGrZ6P-3w@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:07:35PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> The TX and RX buffers in ad5686_i2c_read() both reference data[0], causing
> byte d8[1] to be shared between the TX buffer and the RX buffer. I2C
> controller drivers that map all message buffers for DMA before initiating
> the hardware transaction will map overlapping memory ranges with
> conflicting DMA directions (DMA_TO_DEVICE and DMA_FROM_DEVICE). This issue
> was reported by sashiko.

Not sure how this patch helps with that. The minimum granularity for DMA is
a cache line size. Do we have data[0] and data[1] be cache line separated?

It might be I miss something obvious, but this topic is always confusing
to me (DMA alignment).

-- 
With Best Regards,
Andy Shevchenko


