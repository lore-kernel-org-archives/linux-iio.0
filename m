Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45526F2B0;
	Tue, 30 Jun 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821891; cv=none; b=o0LC2TxPR1A4yTB6E6nHvIPlb5xFvpHcEa0+Bw3/jXx0ZrwC6AMWxKNp4/HOB9qWhJBVRlHXzdS+hOwTDOVBFPCJhDYOPq/pX9LcwNuHh8UvTR5wR/k0bh8B7Tslak6nrWLby/KuMA+xde+WE9av3nlsTu472SNFzkD52nZQgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821891; c=relaxed/simple;
	bh=L6xp0DTy9IxxrWFDObsUK7MAMrgrWXdOPmbbvUmwO7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMX9FzmXDrqf3Mpi/IJsXHLT2+ojaJTCU6qP0kysugc7ASUJw5Cjudp+muOpaYEl/eWE8GW8/FfZOBrsugOqZi6/NjHlUgCzpsjLSu2xRWLNuI3we7AmSg/PwbOSC/c8vg9H1kfnlzqCqpf0g3ujXUT8BnKlxN6bjTkZyb1ZYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDpfygE/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDpfygE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782821890; x=1814357890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L6xp0DTy9IxxrWFDObsUK7MAMrgrWXdOPmbbvUmwO7U=;
  b=EDpfygE/O4OTau6UPILamTlY126TvQxPYcOlNnSVqutvLv78JdZ8Ejp4
   qjVAvyYk6kKaJ91+qTjdRC4XHqbLjWzDfGBDs/M9UuavzulpfDROTQva9
   GkvcOhA7nblq7w3LtC5Af3ZukDQDr8Rk8vadJd3koszCKlH2YpHiPVud8
   94cgSEkUIURCen06rGlVoJ+iO/a0esbARi6cEYLvy0WXMqDT9YLS8chjn
   +ExYvaRFd7B6zwPFt+8C6MVkKYiLZEXCLSJioDf1cQGcK0QgQYy2wD1DI
   97afpFGPrbACObgo8PA+VaPO41j8ch7JXKU/v8orss/YvR2LpTiTiOSgb
   Q==;
X-CSE-ConnectionGUID: giQa+t2jTWmoPmJRZxlNww==
X-CSE-MsgGUID: IZlnac6sRe6E0CroEHzcKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="106325472"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="106325472"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:18:09 -0700
X-CSE-ConnectionGUID: W0felgykRje2Q5K6ZMNsyA==
X-CSE-MsgGUID: XVi5LnrERTuYihhS0ukT+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="282312161"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:18:04 -0700
Date: Tue, 30 Jun 2026 15:18:01 +0300
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
Subject: Re: [PATCH v3 04/13] iio: adc: at91-sama5d2_adc: adapt the driver
 for sama7d65
Message-ID: <akOz-Q7Hvxbyzbl7@ashevche-desk.local>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-5-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630093603.38663-5-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 03:05:54PM +0530, Varshini Rajendran wrote:
> Add support for sama7d65 ADC. The differences are highlighted with the
> compatible. The calibration data layout is the main difference.
> 
> Update Kconfig help text to mention SAMA7 SoC family support.

...

> +static const struct at91_adc_platform sama7d65_platform = {
> +	.layout = &sama7g5_layout,
> +	.adc_channels = &at91_sama7g5_adc_channels,
> +	.nr_channels = AT91_SAMA7G5_SINGLE_CHAN_CNT +
> +		       AT91_SAMA7G5_DIFF_CHAN_CNT +
> +		       AT91_SAMA7G5_TEMP_CHAN_CNT,
> +	.max_channels = ARRAY_SIZE(at91_sama7g5_adc_channels),
> +	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
> +	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
> +	.osr_mask = GENMASK(18, 16),
> +	.oversampling_avail = { 1, 4, 16, 64, 256, },

In this case the inner trailing comma is not needed (because everything is on
the same line).

> +	.oversampling_avail_no = 5,
> +	.chan_realbits = 16,
> +	.temp_sensor = true,
> +	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
> +	.temp_calib_layout = &sama7d65_temp_calib,
> +};

-- 
With Best Regards,
Andy Shevchenko


