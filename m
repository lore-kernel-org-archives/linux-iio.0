Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225718A92F;
	Tue, 30 Jun 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821800; cv=none; b=mCV5ev/RwNRGpWYppJO8U7FdaMoJrWj3DEN1ODkPFJBm+fnB00iuVGErnRHHC5fy8L4sNaVLAjl2/bNFSvHu2ui06GxHmFpCvFEPYFcMNcHjRIk+jRkC2SiC8wI97MJazpfOgIGyjDbJDGVovrJda7S/a1uvMc60Be7ro7TD/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821800; c=relaxed/simple;
	bh=VmtYJeyjTF+nW+MqqASSDf26xTqsmBZJhwKzsP7qfPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/BO7FZYVbWYNZ/2FWOmBfR7DiIUcqSQfC+yzoabgFanig6Hk/cW+kqffR4jE1bOtn51fkg/C0LRwR4En9weCaj4oexImRx8KZ8vLWAW61TMmlCjxY14Dxbso3Vy67MAj4zFpnEUvR3TlNLWJSFbWpBbOuOJvxk3iBEWjQwy/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2G+QQek; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2G+QQek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782821800; x=1814357800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VmtYJeyjTF+nW+MqqASSDf26xTqsmBZJhwKzsP7qfPA=;
  b=E2G+QQekF3eZrYeNT0NWcyKOZ5CzkpiprbLu1INWHv5IZWdS3p8ecGAD
   anbHuxjBwR7wbq9JJBvkuyPjF7KjRGOWJm7tZRqZPdnlJbgkcu9hZDfyr
   cUK9+sZQtaezP3AWU7MeDMUYgJPhlry42pvM2gw1tvG4QgEr6BUVDynNu
   ooKMZK2yfMswokXgZwk/PpiEVXxF6xvSSo/5Cki00iwJnGpCHEAMDdhBk
   Cx+b2EzS96MZ/Q6COwvgQf02YOG7JDw5clmYqsR6VuNNcVv4c8wpFeZPF
   gWO3tueqM38lQpOCwqSC/J1blMN8bRLzt7TMLNv6m+BKnqqkgytkieXb/
   g==;
X-CSE-ConnectionGUID: r7WiXqydQACfnE38zVVpyg==
X-CSE-MsgGUID: tvQMGbGmSheTrNImSqhyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82521273"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82521273"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:16:39 -0700
X-CSE-ConnectionGUID: dJEhJRdtTxqOgFFYZ+iaZg==
X-CSE-MsgGUID: yA1VguZ+QZukmHFHt/ditg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="276531891"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:16:33 -0700
Date: Tue, 30 Jun 2026 15:16:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	marcelo.schmitt@analog.com, jorge.marques@analog.com,
	mazziesaccount@gmail.com, Jonathan.Santos@analog.com,
	jishnu.prakash@oss.qualcomm.com, antoniu.miclaus@analog.com,
	duje@dujemihanovic.xyz, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/13] iio: adc: at91-sama5d2_adc: rework temp
 calibration layout handling
Message-ID: <akOzn9ci3FPCtqqo@ashevche-desk.local>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-4-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630093603.38663-4-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 03:05:53PM +0530, Varshini Rajendran wrote:
> Extend support to handle different temperature calibration layouts.
> 
> Add a temperature calibration data layout structure to describe indexes
> of the factors P1, P4, P6, tag, minimum length of the packet and the
> scaling factors for P1 (mul, div) which are SoC-specific instead of the
> older non scalable id structure. This helps handle the differences in the
> same function flow and prepare the calibration data to be applied. Add
> additional condition to validate the calibration data read from the
> NVMEM cell using the TAG of the packet.

...

>  /**
>   * struct at91_adc_platform - at91-sama5d2 platform information struct
>   * @layout:		pointer to the reg layout struct

>   * @oversampling_avail_no: number of available oversampling values
>   * @chan_realbits:	realbits for registered channels
>   * @temp_chan:		temperature channel index
> + * @temp_calib_layout:  temperature calibration packet layout

This uses spaces instead of tab(s).

>   * @temp_sensor:	temperature sensor supported
>   */

...

> +	layout = st->soc_info.platform->temp_calib_layout;
> +	if (!layout || !layout->p1_div)

Technically speaking the !layout condition rather means -ENODEV.

> +		return -EINVAL;

...

> +	clb->p1 *= layout->p1_mul;
> +	clb->p1 /= layout->p1_div;

So, p1 can be defined in layout as struct u32_fract.

-- 
With Best Regards,
Andy Shevchenko


