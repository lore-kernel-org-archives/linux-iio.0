Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF645BE3;
	Tue, 18 Aug 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033544; cv=none; b=kzTI8CYrKDCzvqVOmX+iZHXPcixAaC9amiXEda7t1ePjEHsClEjz5M2fkxgL1YouowYSE7GVvWPLgVbuS/XBS5sz/jP7kuP/6Ei3BDfXG5EzMGrqDAidtX3XUIViV5N9Qww+4haTJ+606VbrvmPZi/TqNk0Bqj5OUuIkF/qcwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033544; c=relaxed/simple;
	bh=hk9j3NYk7hubwkCAAu/IxccCrHb+wSrObT2+aLKiprY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgvgd1kxGZbPmGJKAVCD877Uhm1HhSLkXCp/VgepCvGeTPI/8Wek17BjjjbIMtDvVKRmlOFWUSl0fL2hmFW3Zy1lbL699B8DCWu9Q3/IvQxXRl6wVjN8xwiQ9sDTVaqA5UjKo2wZdJbd5zhszeiv4+TJImmBNiuwLQTJh86xiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh4i4IVS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh4i4IVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033543; x=1818569543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hk9j3NYk7hubwkCAAu/IxccCrHb+wSrObT2+aLKiprY=;
  b=lh4i4IVSni0deuDSGviLIVrsGuHVLvLKQnEsDnTmGZjCFM+2QyDMSDGZ
   HujED35MmG98wlIU2mjIvgSoMTKf6so1AY/LbzexdfsFg/86Idi5uMYag
   p6nXKJpcTa/YK2IsfY0o0h1xUJAICA98SOqVC02ALLKL1FxaqUs68KGFB
   bE3coh2ktzh6r9ivx0FwdaoxNa4eG/tOAzhxx2yMmJE28FKDFupoqlaw4
   N0ix+Ydda8jVO9FI3EFxSpKZaRH/cfYECVJVIKqp9l+UJJEGTGjficpx7
   zhqvJBn586xdcfQEIMzMOH5TNMsmwNJ4K5dJDruM5y5SCkBAAal44fKsH
   w==;
X-CSE-ConnectionGUID: hRTW+JWQT26I87Fee3CRag==
X-CSE-MsgGUID: Qau3wlonQq630N198MJMew==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="105050624"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="105050624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:12:22 -0700
X-CSE-ConnectionGUID: gcCnpN0wQ/ylJGGuzod2Vg==
X-CSE-MsgGUID: pTEZsEyOTG2XjMxWoNQ/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="295053626"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:12:19 -0700
Date: Tue, 18 Aug 2026 09:12:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: dac: ad5504: introduce local lock to protect
 state and spi transfers
Message-ID: <aoP3wFuQBYJfEo8D@ashevche-desk.local>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
 <20260817211118.21833-5-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817211118.21833-5-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 05:11:13PM -0400, Taha Ed-Dafili wrote:
> The AD5504 driver currently lacks locking, exposing it to several
> multi-threading race conditions:
> 1. The shared DMA-safe SPI transfer buffers (st->data) can be
>    corrupted if multiple threads trigger read_raw or write_raw
>    simultaneously.
> 2. The ad5504_write_dac_powerdown() routine executes a sequence of
>    back-to-back SPI writes (a CTRL register update followed by a
>    mandatory NOOP). This entire sequence must be atomic.
> 3. Internal state variables like pwr_down_mask and pwr_down_mode
>    can be read and modified concurrently.
> 
> Introduce a mutex in the ad5504_state structure and initialize it via
> devm_mutex_init() in probe. Use the modern scoped guard(mutex) macro
> at the top-level public IIO callbacks (read_raw, write_raw, and the
> powerdown attributes) to safely serialize access to the device state
> and the SPI bus.
> 
> In ad5504_read_raw() and ad5504_write_raw(), guard(mutex) is scoped to
> the IIO_CHAN_INFO_RAW case only, since IIO_CHAN_INFO_SCALE merely reads
> vref_mv, which is fixed at probe time and never modified afterward and
> therefore needs no serialization. Because guard(mutex) declares a
> cleanup-scoped variable, it cannot appear directly after a case label;
> wrap the case body in a compound statement (case IIO_CHAN_INFO_RAW: {
> ... }) to give it the block scope it requires.

Was this message written with a help with AI?

...

> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->lock);

Always use blank line(s) to separate the guard()() from the rest of the code.

>  		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;

...

>  	struct ad5504_state *st = iio_priv(indio_dev);
>  
> +	guard(mutex)(&st->lock);

This is even stronger as we also require the blank line before return.

>  	return st->pwr_down_mode;

...

And so on...

-- 
With Best Regards,
Andy Shevchenko


