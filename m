Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3031E845;
	Thu, 11 Jun 2026 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161608; cv=none; b=NM81zl9CU3DD1T/zk/gtDzd7UMijQroa2D1vLrHjxCL+V2x/VR4ZfXPoJ1Fbv3HtWr8/K14i084ZD2ce41dd7zSgHjX5RoMG1L+u5vIpUOSfu1DaUGLHPhuiW/vEHbqPBOzokS7luysGRRPm32LIfSvRUmQfum13W1RcgnO59sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161608; c=relaxed/simple;
	bh=ru/kVZRQaWRE1Tkf6v52oGYzkCYkHCBsea1js4X2Uqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooRRapfsmZDuBR0gIX5AMMY4q7G1TrLVDPC9T77T/DMHqGzSZK775KrCiQiCl7I2u6FnqT/Et5QMLQzlqAz8XviSpdhuJAsg147qQlEDfw8fk3P8jtAlu/6XitfHdFvnpP84mRdbe8JEwUGNcyTrLr0sEVrPG+X//MTPWaxbmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpC5QYz7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpC5QYz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781161607; x=1812697607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ru/kVZRQaWRE1Tkf6v52oGYzkCYkHCBsea1js4X2Uqs=;
  b=lpC5QYz7HQZWU9QY+7en12oC+/rZ4NH5ZDduoSupFyhwXRP/JJJ+EMh+
   puGh9PMRCslyFfcoNMakMleMyUP+fR3ry0+s3mSz5sVH8DRp5I7DYb23s
   XI6kDbtvhmUdxvPImRqYpX9txuLSp1cD7bamvqf0B2NY8OvBr588mnx+C
   SqCG7MJiO7EC9XFBJ9IBJ/lUZ5Ui269CRZ2I8FxEV7XOWcooTYsvBfxDW
   Cz6WfTb3PaYxNrtManjKWyRBdpZeLrma6Zzu4+NSvnBHBlKqs3fsy/ttO
   EjHqZs5HgKU6QRGfGCaysyWIIg0k4Z5PAEsGx1AC6JJPaNBHt/hmQYzvn
   Q==;
X-CSE-ConnectionGUID: dnxhBkc8SyuU4zMqABwy1w==
X-CSE-MsgGUID: oAS8qg0cQ8qaG5PSJK2s+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82162450"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="82162450"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:06:47 -0700
X-CSE-ConnectionGUID: rbCQ643GSkmpi5JBui/Gjg==
X-CSE-MsgGUID: VsaHUltRSLyPAveelKcKIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243453555"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:06:44 -0700
Date: Thu, 11 Jun 2026 10:06:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nguyen Minh Tien <zizuzacker@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: Add Texas Instruments ADS1220 ADC
Message-ID: <aipegeFkRY7sZasE@ashevche-desk.local>
References: <20260610151342.44274-1-zizuzacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610151342.44274-1-zizuzacker@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 10:13:40PM +0700, Nguyen Minh Tien wrote:
> This series adds support for the Texas Instruments ADS1220, a 24-bit,
> 2-kSPS, 4-channel delta-sigma ADC with an SPI (mode 1) interface, a
> programmable gain amplifier (1 to 128), an internal 2.048V reference and
> a dedicated DRDY data-ready output.
> 
> The driver supports:
>  - single-ended and differential voltage channels described as
>    device-tree child nodes;
>  - per-channel programmable gain (via _scale) and data rate (via
>    _sampling_frequency), with the matching *_available attributes;
>  - the internal 2.048V reference, an external reference on REFP0/REFN0
>    via a regulator, or the analog supply (AVDD) as a ratiometric
>    reference for single-supply measurements;
>  - single-shot conversions gated on the DRDY interrupt, or on a
>    data-rate-derived delay when no interrupt is wired;
>  - a DRDY-interrupt-driven triggered buffer for streaming;
>  - runtime PM (power-down between conversions).
> 
> I tested this on a Lichee Pi Nano (Allwinner F1C100s) running Linux 7.0:
> with a potentiometer on AIN0 (single-ended against AVSS, AVDD as the
> reference), in_voltage0_raw tracks the wiper linearly across the full
> 0..3.3V range (0 to 0x7fffff). Nothing in the driver is board-specific -
> it only uses the SPI and IIO frameworks - so it should work on any SPI
> host.
> 
> This is my first kernel contribution. I modelled the driver on the
> existing TI ADS-family IIO drivers - ti-ads1119 for the structure and
> ti-ads124s08 for the SPI side - so I'd welcome any feedback on things
> I've missed.

When adding a brand new driver, answer to the following questions:
- Why a new driver? Can any existed one cover these chips with some refactoring?
- Where to find a datasheet (URL, other means)?

-- 
With Best Regards,
Andy Shevchenko


