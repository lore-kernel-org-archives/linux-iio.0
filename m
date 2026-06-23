Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119235AC00;
	Tue, 23 Jun 2026 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238520; cv=none; b=dEvUmDV1pFtrKmHW7QIyMmegOrtHC/xAxz1Zg5VA/awQJCg13VJQJRge85gXU1chV7b6JIYL5FCvMWV9dvGrUzq3xYesWBVqlWmSu74ipH5daGiaq3meik1ZYDzzD3tbPSCaQe4naUshgQWTLlOQGJ1W8lxVLcp7XT+8ieccGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238520; c=relaxed/simple;
	bh=xcbEsbtbk3fPpranQsUZotb8RvoHkOQhoDEUoBvvYgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUbL17Ys3JxlIQaziKs42zObLao01XHm9+sjTwpZKkinBZIo2aYSaaU4SIjf54t9U099cuCCWeB28+58xW0XKludkAYcJVP4vQOOyXyw4wQtMVz1i8T2+IYZlGiRSUR/cW/Em+baiWyEliu/JTcKahFyD/PiADGgLBGbdQCLU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMTSiFAZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMTSiFAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782238519; x=1813774519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcbEsbtbk3fPpranQsUZotb8RvoHkOQhoDEUoBvvYgE=;
  b=YMTSiFAZbPZiwdr2ug59iDfv3I4FuUqfVFzceUokCLjijg/vytXh8rHl
   rLWa5axSrl1L0IqhxnY0DWUQSI8M58ECOx5K5EquZBzLTMcKosn250Y6U
   U+6+axpa6UhbwOuuPdQV53St1s0kNaMjUTw0DcqiEAr+Az8P2Bnt3Ksqq
   HxPACukXNiC6iysw735FBH7YhJOzWi7QcIVSr5Oz3IYSM+8zWsmDQFI+O
   Kdc1+jSvMpbh8RhYb2CgjHucZXuur0FesmiHCIEn19p+maQDLzq/PqIEt
   NbOMm2nr4uSXAlv7OUBTn+QahDuglLutG4s7g8n05q20xfDTeorkgQmvw
   Q==;
X-CSE-ConnectionGUID: JAmZpQEcRO6TkqG0pz4vtg==
X-CSE-MsgGUID: y2R+7qd7RJemSLfX+xuF8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="85547060"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="85547060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 11:15:18 -0700
X-CSE-ConnectionGUID: r0kpRXVzSiiF80Ar8mHq4w==
X-CSE-MsgGUID: d0ukBF0MT8aIr32sW04SQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="287715607"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 11:15:14 -0700
Date: Tue, 23 Jun 2026 21:15:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] iio: adc: at91-sama5d2_adc: rework temp
 calibration layout handling
Message-ID: <ajrNL2RcvpNMjjMj@ashevche-desk.local>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
 <20260623105944.128840-3-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623105944.128840-3-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 04:29:34PM +0530, Varshini Rajendran wrote:
> Extend support to handle different temperature calibration layouts.
> 
> Add a temperature calibration data layout structure to describe indexes
> of the factors P1, P4, P6, tag, minimum length of the packet and the
> scaling factors for P1 (mul, div) which are SoC-specific instead of the
> older non scalable id structure. This helps handle the differences in the
> same function flow and prepare the calibration data to be applied. Add
> additional condition to validate the calibration data read from the
> NVMEM cell using the TAG of the packet.
> 
> Use cleanup helpers for NVMEM data buffer wherever applicable.

> +#define AT91_TEMP_CALIB_TAG_ACST	0x41435354

This seems like FourCC that can be represented in ASCII (I suppose "ACST").
Can you add a short comment on top to decode that?
/* ...blablabla... in ASCII "ACST" */

...

>  struct at91_adc_platform {
>  	const struct at91_adc_reg_layout	*layout;
> @@ -481,6 +504,7 @@ struct at91_adc_platform {
>  	unsigned int				chan_realbits;
>  	unsigned int				temp_chan;
>  	bool					temp_sensor;
> +	const struct at91_adc_temp_calib_layout	*temp_calib_layout;
>  };

Is this the best placement in accordance with `pahole` tool?

...

> -	u32 *buf;
> +	u32 *buf __free(kfree) = NULL;

This looks like a separate change. Why is it in this patch?

-- 
With Best Regards,
Andy Shevchenko


