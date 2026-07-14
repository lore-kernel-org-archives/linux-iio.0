Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148339CCF4;
	Tue, 14 Jul 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048658; cv=none; b=I6DmfcAk+69EWqsKsIkTcnKX+SNWi+nM+wXO0fI2QyFouiXGfNsvQhYW7MbYl78fW+UkLYHMCKR3TCFBr9wL6k0rysVLbuDQu4TlV/7Np13xjo264Y5mjnWmG1DItC9yQT7g2xOtu/Rct7DWwOq3azIdocDiVsAiM2nV/3Sh7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048658; c=relaxed/simple;
	bh=sKR9I/L3AuyHpaNYMNzxh2mk1+uFX8P/r90cJEtFs0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c57kc1gpalZunsfGZ/39F7EQcpy5FmiSX6R/y1GZ/0H3Ut1Ipf6cdZha0SsgfXEmb6NKtv53J2YBbmdId0ToC/ZEOLosKFqmvtBZ1rPAWg6XHRdKN2N1W2OW4Upbe9ZeGeNU2TQb6/PxLEHb5fBpdR22jafk+VoRKevE6beCMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHC6KHeP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHC6KHeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784048656; x=1815584656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKR9I/L3AuyHpaNYMNzxh2mk1+uFX8P/r90cJEtFs0w=;
  b=SHC6KHePe6/05CqHzscMZoH9TPUllyETxqpIDcCsVwQxdKlfIQkR//8X
   vhIcOoYPdcKMBwtlUQk7maK3m1C95GPJdA0l6StGriVbl/AQ0aOtzEauu
   kmQF5k9HYgnjnrwBlM+EqwBdp319p7CQ/RrIkJfrOMp+b4UCD3voFzB1I
   ZjYCMFUbPwQ/7ObPYMgu+X9o6uPliW+mXyuT5msik2/EXXEVZPn2yRTGl
   ZSNkucOntD0YBQd9ksX4EKCDQpJbsp7jH++dn3/P2n+7nXGYcFYU1jXeX
   vurPtFpcOzGRfL356/QcpSqyfrZM8k43y4r7I8mPZSNVzePBdmlmT/Yuy
   A==;
X-CSE-ConnectionGUID: 4ReXG3UZST6UTEbMc/nKWg==
X-CSE-MsgGUID: FruoY8jWTjiir+MjKH7b8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95823892"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95823892"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:04:15 -0700
X-CSE-ConnectionGUID: rMWrAxuZTg+5ooVu182LEQ==
X-CSE-MsgGUID: ykmxnJXMQgefm6qpnQm5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279200535"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:04:13 -0700
Date: Tue, 14 Jul 2026 20:04:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <alZsCghbqDBF6X0d@ashevche-desk.local>
References: <20260714-opt3001-unwind-cleanup-v4-1-7ebea805bfac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-opt3001-unwind-cleanup-v4-1-7ebea805bfac@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 05:36:48PM +0200, Joshua Crofts wrote:
> Split the logic inside the opt3001_get_processed() function, as the
> current flow is hard to read, mixing IRQ and non-IRQ code blocks.
> 
> Separate the IRQ code path into its own function, same for the
> non-IRQ path.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
> -	if (ret < 0) {
> +	if (ret < 0)

At some point consider dropping ' < 0' pieces for the i2c_smbus_write_*() cases.
Read cases are different, of course.

>  		dev_err(dev, "failed to write register %02x\n",
>  			OPT3001_CONFIGURATION);
> +
> +	return ret;

-- 
With Best Regards,
Andy Shevchenko


