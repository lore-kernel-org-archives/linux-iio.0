Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7E32860F;
	Wed, 22 Apr 2026 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889014; cv=none; b=Sa9cCezyd4fD2Ci4BQsuqyldtQZSNy2u4O3vssuruYT3kLlo3Wy3Pea+jKfX0zlkqqz0x8Y21fdDLJ5Sn2TCKpbNhN5vSzuEmAdHJt2ylVs1deKDC+ikHJs0iV1MZMb4Uo9Zle1KKxId0Du1HrXupTxO81iC4bQB6y/Yg3l+ZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889014; c=relaxed/simple;
	bh=XxzWMiQc10zG3tMyK37kwgGSuM0sEg9L/1nezQQ2Isk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+W//mesP9yAlyYaMCYR4JdJjbNtT7O8dEPez9xjd9YolPIU4/i+k/LCQTjQtQoiCOXnBomAUnRulSxlnYXB4GRR72M+AsBR/M4ImhCA4DhCcDExTHQj4qyIV4qe6mYTJ6osVHNG7FFPYdi5M+JxUiDcJrj+9EduMy06SpuM1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDxH7VJa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDxH7VJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776889013; x=1808425013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxzWMiQc10zG3tMyK37kwgGSuM0sEg9L/1nezQQ2Isk=;
  b=cDxH7VJaORkYSOTszKG6+nK2bnGLiPmxITe26R219cNJEkRozmtiIo+J
   g2czvvdzVW5rebs+zf2XgC0YvjV4rMkwkeCryNNJKYoRXbCCmoHZnLZ3g
   50mFop9zWqB6xZX4W102S2ShPHAQp6O1+6c9+zWBODo4Oi27RvTY6bH8r
   tnjhTvHQj7NLCgNa2jSGq77ryamj9bEbAI62wU6xTR6EkusM105xrYVRf
   h7TOQh+2hLkdw0rawaSpwiyxWp4vOL+qYGoq26fc2haGxGXSiAJgYwjen
   whjAu/vWFynsCkqgC5LCFkOuI2JhEgyr5rS8SkCUwhKFVSBvSoQ8xhhW8
   w==;
X-CSE-ConnectionGUID: KHGELFnIRS6olBghYVpo9A==
X-CSE-MsgGUID: 9nmgdbJsTTmSzMZnHTS4bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77868155"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77868155"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:16:52 -0700
X-CSE-ConnectionGUID: p3r6NocQS6+IMJHAsltZZQ==
X-CSE-MsgGUID: MW9v2S8hQuyEEjmjr93csA==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:16:49 -0700
Date: Wed, 22 Apr 2026 23:16:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: hx711: refactor to per-chip
 hx711_chip_info structure
Message-ID: <aeksrz1Q0n5NMFUu@ashevche-desk.local>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
 <20260422175910.1258579-3-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422175910.1258579-3-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:29:09PM +0530, Piyush Patle wrote:

...

>  config HX711
> -	tristate "AVIA HX711 ADC for weight cells"
> +	tristate "AVIA HX711 and compatible ADCs"
>  	depends on GPIOLIB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  If you say yes here you get support for AVIA HX711 ADC which is used
> -	  for weigh cells
> +	  If you say Y here you get support for the following AVIA ADCs:
> +	    - HX711
> +	  which are used for bridge sensors such as weigh cells.
>  
>  	  This driver uses two GPIOs, one acts as the clock and controls the
>  	  channel selection and gain, the other one is used for the measurement

This along with top comment and other text doesn't belong to the change, please
split into separate patch.

> +/**
> + * struct hx711_chip_info - per-variant static configuration
> + * @name: IIO device name
> + * @channels: channel specification
> + * @num_channels: number of channels
> + * @iio_info: IIO info ops for this variant
> + */
> +struct hx711_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
> +	const struct iio_info		*iio_info;
> +};


...

>  	/*
> -	 * delay after a rising edge on SCK until the data is ready DOUT
> -	 * this is dependent on the hx711 where the datasheet tells a
> -	 * maximum value of 100 ns
> -	 * but also on potential parasitic capacities on the wiring
> +	 * Delay after SCK rising edge before sampling DOUT.
>  	 */

Doesn't seem like a part of this change.

...

> -	for (i = 0; i < 24; i++) {
> +	for (int i = 0; i < 24; i++) {

Be consistent. Why here is 'i' signed?

In any case doesn't belong to this change.

...

> -			ret = hx711_read(hx711_data);
> +			ret = hx711_read(hx711_data,
> +					 hx711_get_gain_to_pulse(hx711_data->gain_set));

This sounds like a separate change to me.

...

> -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> +MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");

Doesn't belong to this change.

...

This needs to be split to 3 or even more patches!
- text in the MODULE_*(), top comments, and Kconfig
- chip_info initial change

- modifying  the existing code to prepare for new HW support
(the above  ^^^ might be done in a couple of patches)

-- 
With Best Regards,
Andy Shevchenko


