Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116613;
	b=enxksDrTlBdrOLS2jGP0UYGX82CWM2QV2V4SM3qyPOvBZ/KN5OnTgglZyyQLIVgZ9vsY
	 D6dLrOMaoZqTa0+IP5YZxVQJEWtx6fm+NHoiNcK8XScpSbNihN2FXxeuxS2TT1H4i+yPg
	 tm4k9ycIkQVjR8zpbaKocJpAaXJPtd6JeufFmPst7bH60g/a9YX5Gtn6UXA/MUuGZdVi1
	 cHDbard3vQrfVg401wGcAxZE+Jr6nkOHs7Ne/2EtGX2j+fikIbr8Fk8QRIH/+2XfRP0SX
	 ziPq6+6XE5wlsue/LbX2T0x0+ayEu+3FXWNwa+IbasAaOEs7iHY0xFFg4ADhW5WXgsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116613;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/CdPFDOoxpgoh2yXSNqWXWRmNvIL8+vC07dIdltlu8k=;
	b=KWo+LA2iWJgB8j7XLyE4RV8utjltofe/u48/u6iI2Fy3WonFuSuXXD0HLyAF8PkpYlX9
	 KR7gOI+I3BnFLiBQNBLNnIF5b6eN1GTuJTZlACF/gFCLj2Bhul9cf8Rk5V2j3B9wKhPkZ
	 ioNd/H4jWsiz1ThGMHIh49DCTi4uUmTZRYV2ZtNHhhDJ0OF60MdleIF5FP29ud8yvRRU/
	 lGj6QZxD/iUs0VXKtkef7jgoPA5qk+cC09Cxts5vVywGGwwlg02+uFVvglpbEvQtKeUaW
	 33BLXiXa+lDa6Hgzw2ILLeMT7IOtdRyejXQM60AJrZEXJUXIy6lEiJExFpFIEOsWLgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WmAXM45m;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38274606A31B;
	Tue, 27 Oct 2026 15:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38274606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WmAXM45m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793116611; x=1824652611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SkBs68L4h4eRhe+r9S7dFAfJLJyj5ClSDPWOzR+e3Kk=;
  b=WmAXM45mxeRCXvKmguoSh7o+MeV0Bj3h3sJzLmDhbqqSXWgDaHNaUtqC
   04+2kQbc0kGEkp9kGSufIxDisA9IX/28/E0ak96K7OC9lzFwEnoGk7sJe
   ndj7snELUgPVvd8lxzcxj2XwgP2z/lF53EfAe0Z1hqtW/XzTFt1bo6Tkt
   HIOFp/Z1OO2gZh/k7wXyz5OUbXIFEUQMgt0EJNxzE/R6xWn+OcxHAPcLy
   /SxZJqvwlKXkQ5Dzt7yqixvZjpbmr+KbQJTRBepBQu50EziItsd7D0SGH
   dsVpcqFYpj+Voni1l6jrEdgUDfzTHtOkVMu01ggUMxBeXkxc0DC+YrIMS
   A==;
X-CSE-ConnectionGUID: 4N0lUIChTWipP+VPGH/YtQ==
X-CSE-MsgGUID: qQVXpKHsThe5/heoMOiIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1844674"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1844674"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:56:49 -0700
X-CSE-ConnectionGUID: CGSCTBepT+23PrMwzs56OQ==
X-CSE-MsgGUID: yGG9dL5gSK6Y0aqQEaodAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4650687"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:56:46 -0700
Date: Tue, 27 Oct 2026 17:56:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: add LTC2387 and ADAQ2387x support
Message-ID: <auDJu8u85flQ9bjo@ashevche-desk.local>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 03:44:07PM +0200, Nicolae-Daniel Deaconescu wrote:
> This series adds a driver for the LTC2387-16/18, 15 Msps SAR ADCs with
> an LVDS data interface, and for the ADAQ23875, ADAQ23876 and ADAQ23878
> uModule ADCs, which pair an LTC2387 die with a fully differential
> amplifier front end.

Why have you written a brand new driver?

> Conversion start (CNV) and the gated LVDS data clock are generated by
> two channels of an AXI PWM generator. Sample data is captured by the
> AXI ADC IP core and reached through the IIO backend framework. The
> front-end gain of the ADAQ parts is described with adi,gain-milli
> (fixed at 2 on the ADAQ23875, pin-strapped on the ADAQ23876/78) and
> applied to in_voltage_scale.
> 
> Tested on an EV-ADAQ23875FMCZ on a ZedBoard running the adaq2387x HDL
> project in two-lane, 16-bit mode: probe, in_voltage_scale,
> sampling_frequency (writes, rounding and range checks), buffered
> capture up to 1M samples, and unbind/rebind. The bare LTC2387
> variants, one-lane mode and the -x4 variants were not tested on
> hardware.

-- 
With Best Regards,
Andy Shevchenko


