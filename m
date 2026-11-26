Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701858;
	b=5CPZjvun0blxH+jL9IO7eTqLsHBF4HuuqJIOWRHaFEp7Syqr/SgDZe5LZKOqIrP3jJ5h
	 zCBQSeuHnYXyaE+8ihlkXq33h/6Quh0mn7ljR7T/h5t16pfqX2kMfuILUVifMjeBPVf5d
	 ep6TazwZVM2UaDS9ZDBaN6EuH31RpgdNymQvZf1M48bJsfjhDK92rPuUKdI2Y+kpt8NNk
	 KgdMj5uJ6xIkDW7fTtb+LHGmk2LcFVSHyYnw33xVvCaAUDEzVo2gu/T8lI+HiFLwAUDU4
	 LQ40PdyDGaHt9SsiMq7T6UFmue3sWtdODfTaxWxu1EJmx5nhR+S0SlKUIelx4VZVPKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701858;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kVnDN2YB/Rq2MZvuzYs7u9jJ/Ii0K42RtQhfqcB/k+k=;
	b=EqZkW8uYHwvxucpywXaH+q3YPRJ/YjCCXmqczTdzMByMPtiK0JLffECGKbIMizJmbVzz
	 H6JRQHT7WJO1F0IVdVn7+PN/eiSAz90lNF6pGAxgpUAIKolq02cDZZAhZpGVe/kjrwVI7
	 yKX6vQ3k3521VygQOxk+269r6qXzV/9gQaBxlryiUGqYOdxQamdVEDK2AEjZ2vFO4wynG
	 ESDPH/Cz+l7bGbDATgFWgLIkcGdeD7cIMGmcDTKkERuJSgOkmM1+82qWDJGVBx1UVP3YV
	 JdH5ICYTLp9Um3wFrIG5X6oUwKVKoI9vUi5PbYyt8SLWakD9ADESiw0OYK9qVRwgQug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XZXgpzKi;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED86606A31C;
	Thu, 26 Nov 2026 14:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XZXgpzKi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795701857; x=1827237857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jShNgctqUDhIWWUL9t1y3IvHLsqM3SccaTZXZU0e1EY=;
  b=XZXgpzKiLsZdQ0jQfELROyttVM2hpJcS3u09B/win6OPMgkHHdBFS4UM
   AD+sLakWce6tG6/CupM7Ug+dMvARcw/4086riYz/Ln0q+c8AfYyFfyf+3
   HcGSWqkylrM33Nlg3/zpEy6IrUrBbK0gUqozhhi0fD061sjh2rxzsLtTf
   j6dVdU9XdPhjzDdj8r7XcQOzSa3kwIE+Q/q0ASPldkaP50BoESjk4cw53
   oJbhTCmDW3H4OShgBNyyhXhJqgIAhoqjuVX5qYX6Lm1tvurY4qTGL2RkO
   58W/H37Auiceq0irHnl/pAhmM93io2pnLFDsRgUGdlMwoL7HmpMlFun9E
   g==;
X-CSE-ConnectionGUID: UmRr5k8fQUqpftHL+VTU1Q==
X-CSE-MsgGUID: iNhjB46oRBqwA2qMLiaQtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4569165"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4569165"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:03:58 -0800
X-CSE-ConnectionGUID: HGnPPOSxRnusO++2XnpBxQ==
X-CSE-MsgGUID: dirvXu3SRB+32S9QfcV4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12337320"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:03:55 -0800
Date: Thu, 26 Nov 2026 16:03:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: iasnezhkov@gmail.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: mt6359: divide scale by ADC resolution
Message-ID: <awg8SQRRCia77Guc@ashevche-desk.local>
References: <20261126005326.71926-1-iasnezhkov@gmail.com>
 <20261126005326.71926-2-iasnezhkov@gmail.com>
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
In-Reply-To: <20261126005326.71926-2-iasnezhkov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 12:53:27AM +0000, Ilia Snezhkov via B4 Relay wrote:
> 
> mt6359_auxadc_read_raw() returns raw ADC counts for IIO_CHAN_INFO_RAW
> (12-bit or 15-bit depending on the channel), and returns only
> (r_ratio.numerator * vref_mV) / r_ratio.denominator for
> IIO_CHAN_INFO_SCALE without dividing by the ADC full-scale range
> (1 << chan->scan_type.realbits).
> 
> As a result, iio_read_channel_processed() and userspace consumers
> multiplying raw * scale obtain millivolt values that are 4096x (12-bit)
> or 32768x (15-bit) too large.
> 
> Include the 1 << chan->scan_type.realbits divisor in
> IIO_CHAN_INFO_SCALE: shift r_ratio.denominator left by realbits for
> IIO_VAL_FRACTIONAL when denominator > 1 (r_ratio.denominator is u8 and
> realbits is at most 15, so the result fits comfortably in int), and
> return IIO_VAL_FRACTIONAL_LOG2 with realbits otherwise so channels with
> denominator == 1 use an exact shift and unpopulated descriptors (such
> as MT6357 VDCXO where denominator == 0) cannot trigger division by zero.

> Found and drafted with an AI coding assistant.

Move this to be below the '---' line.

> Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
> ---

...

> +			*val2 = (int)desc->r_ratio.denominator << chan->scan_type.realbits;

Make the struct to be s8_fract instead?

-- 
With Best Regards,
Andy Shevchenko


