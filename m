Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A57376BFD;
	Mon,  2 Mar 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438969; cv=none; b=duU/NTgp8rfEE1hUGS4saX1sckqb4CzHWEgSSLijOkKjwbXZ/ZPDDLe9WynuPwm0y/9WYAg4Og4bLDylKhBnng+XtVKudL69SR7vmkihzliKj6yJKnIxd4bY3k8+dbRf8IPwMUuUV/OvjCvvPcHF2yQFgGpT1Z/2cp2dV0pJQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438969; c=relaxed/simple;
	bh=12lgcgFyIeyWQxBmruCI4XfeSnr0ZEDdbch7oKnWwXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1qd8PgpTyvYTsUQ1ZQ2uMR/jk9y/UnS3/G75//nEE2mVje8u4SOz5mBk0iU/izJKu4f4P07rMNeGdC1Bz8Y6ujlK4A+smiX1odCI2aL3T3CqZ1knTMlOebxKyiiR0i8I8IYvI/tANN76sfrNtD1XB5+971Sq9j99Usj994rxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZ7GJR4z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZ7GJR4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772438967; x=1803974967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12lgcgFyIeyWQxBmruCI4XfeSnr0ZEDdbch7oKnWwXE=;
  b=WZ7GJR4zlNOkXr+VUeHE95KvukuWBvuLNX72mdGWa69x+ngCtQ+UrviB
   x1PVaz0w149Qv7Y2cNyDBr7o7OxC50Py4wDX3pSY+y2IbaAQwznqsF3IO
   MMiguFXdLHRTl/Zn3Miui3eqG8VFUpnNuy6Aa8aTM9hnuHDoCw1RHjcvU
   yzJGNZBXV5+e8ivxJordLdTc+4ughze8YasVe9lm+CV3uZYcHIxSAgOma
   BlGWoo7xaxvWmkplPLjFvGBrxbFdN/QGzPAsJOFF4M9EI1Q9SeiXqDMIW
   9pxozkHd9t4740lNOf/Obf+cTB0iRU0tcFqBY2CIWd5X0rtwrHYYqdmL+
   g==;
X-CSE-ConnectionGUID: cG60hL+ATg2Xas+QXhfOyw==
X-CSE-MsgGUID: w43h0vitSPm24Hgu5yYDnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73505383"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73505383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:09:21 -0800
X-CSE-ConnectionGUID: MUPOAwiITLa9OJBNGSX4fg==
X-CSE-MsgGUID: fJcI92HQT/uk2VzbG2eRdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="221727576"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:09:19 -0800
Date: Mon, 2 Mar 2026 10:09:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad799x: convert to fully managed resources
Message-ID: <aaVFrLVNNmbFSXBH@ashevche-desk.local>
References: <20260302052559.19494-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302052559.19494-1-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 10:55:59AM +0530, Archit Anant wrote:
> Refactor the driver to use device-managed allocations and actions,
> allowing for the complete removal of the ad799x_remove() function
> and simplifying the error paths in probe().
> 
> Key changes:
> - Replace the dynamic rx_buf allocation with a fixed-size, DMA-safe
>   buffer using IIO_DECLARE_DMA_BUFFER_WITH_TS() in the state struct.
>   This avoids memory leaks during scan mode updates and removes the
>   need for manual kfree().
> - Cache the VCC and VREF voltages in the state structure during probe()
>   to avoid querying the regulator API during fast-path read_raw() calls.
> - Use devm_add_action_or_reset() to register regulator_disable()
>   callbacks for both VCC and VREF regulators.
> - Convert iio_triggered_buffer_setup() and iio_device_register() to
>   their devm_ variants, ensuring safe, reverse-order unwinding.

Seems like a series squashed into a single patch, please resplit.

-- 
With Best Regards,
Andy Shevchenko


