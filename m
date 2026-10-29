Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279065;
	b=e8V8tIMgKcHuaNzi1ocKTgU35bxYt4WKQ88Ncav7MKGfsByn0FZ9zh7ETxkItT2cTv7G
	 u8xNSDGlGdeMRH3CP6gL8yOH2nRXSIXEtLeO0jwWAg6n25P4bNsqpmoKP9SCIGGhlYd9w
	 1ngbUz4c+rhiLGiaj62nvEc8pxobIkmgMe8qnKkFnTyXPBUagRunAIBMrdvPkpQzR53qY
	 KSTaF0IcZBsyge+C+/q1CSoSSP1puFg9PDD8RTbn9nBzW2O+GwLuudLR01R68BYG7M85W
	 2gMkk7jC5DGRvXnl4qWSokHMWGAeNyWhJQN0/3OzNXmQtTjb9c4paRbxuEUIwwGwH2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279065;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=E2rrldLe2TfvY3mZkpeBUbdafNpEiTljG0GeMKLp0yk=;
	b=W3cb2CDV1Fmnn3IpPI63+o8EquFW0rHgK6N7gQP/JsJuf+6TGGgLpI5lm2+ksG88cRvW
	 1jXKAqNIEwtQRDUeffYnO+agnrftAif+AHkY4SOYyCQ/J1D7Ox+UhCyBxPxNxbUvrWwDL
	 EW0osN3AWj8Rj1+PxUOzO6MObj+ARUw/4WD93DCXOl+UyH7QcFIevSBstKvEGDEo6ExZy
	 R8CpofB1eCWyXHYH0sIa7avoxCfQyUPuS80w/qO46dQkpioCPPmF8rYS8680cI2/Gk1tZ
	 kfYSQP9Gq0OWIZHs+drpVCiFOTCKxH5uEGyhcqmRsbZF0VW1XjScNoWTnSdx7OeY8pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e1YkCQaD;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F584606A31A;
	Thu, 29 Oct 2026 13:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F584606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e1YkCQaD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793279065; x=1824815065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7j/9ifMemQ9Lboj1kWeh8DMVCXOP/dza77a5m0PuCuI=;
  b=e1YkCQaDiyDk2r2lJ94yJeiKIh+ZulU7JxZ5Jo5694Qmq4vh/gkq3hAK
   FpJlmlRo2Z+PebBkhZ1PAuqUEqSe91EI2nPzpIaGWnOoK/uUHAWMoPRaC
   NAxVyntRGmfCxeNRA2ZIgr06DQzKoFwa7lV5owmF2Za869ga5UsTInp9W
   mvfMpHv+db6bTApm2nobaqyxYgqaAP81+fsoSl0A3vVCIcp9aI1Uv4pZh
   xVd+TauqX47kEWPwV7yhqm0Sk8lA7E01qcD1dOQVcSssudvtUSN+qX9vE
   UMZQbXxB38ndkEQUpPZ5EjYtCOnrD/N511jaKpavZCB05Y7oETEUEH8QA
   A==;
X-CSE-ConnectionGUID: O/AklY9vSlq4/8ZlCY32wg==
X-CSE-MsgGUID: mAcq9hWNTaGgTxcV3wOFQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1902378"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1902378"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:04:25 -0700
X-CSE-ConnectionGUID: 9yFsFRLlR/6P6dKJVhQ/iw==
X-CSE-MsgGUID: 5PsaF7zjS5iKwRlik8zs9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5234308"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:04:21 -0700
Date: Thu, 29 Oct 2026 15:04:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: neil.armstrong@linaro.org, Michael.Hennerich@analog.com,
	andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
	robh@kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <auNEU_eozTEhRwGN@ashevche-desk.local>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
 <SN1PR12MB25286BDD49B0947AC40257D1A56F2@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25286BDD49B0947AC40257D1A56F2@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 01:12:40PM -0500, Victor Chernyakin wrote:

...

> > +/**
> > + * struct max34417_data - MAX34417 specific data.
> > + * @indio_dev:  IIO Device.
> > + * @regmap:	Device register map.
> > + * @lock:	Lock for protecting access to device hardware registers, mostly
> > + *		for reading common accumulator count and control register.
> > + * @input_correction:	Correction based on the Rsense value from channel nodes.
> > + * @input_label:	Channel label from channel nodes.
> > + * @cam_mode:		State of the Continuous Accumulate Mode feature
> > + * @acc_power:		Saved power accumulator for each channel when in CAM mode
> > + * @acc_count:		Saved counter for each channel when in CAM mode
> > + */
> 
> All the sentences should have periods at the end

Not really. The only requirement is to keep a consistent style (either all with
periods as you pointed out, or all without).

...

> > +static int max34417_check_ovf(struct max34417_data *max34417)
> > +{
> > +	u32 control;
> > +	int rc;
> > +
> > +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (control & MAX34417_CONTROL_OVF) {
> > +		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
> > +				       MAX34417_CONTROL_OVF);
> > +		if (rc)
> > +			return rc;
> > +
> > +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Up to you, but could reduce indentation here:

This makes sense as the function is dedicated for overflow check.

> 	if (!(control & MAX34417_CONTROL_OVF))
> 		return 0;
> 
> 	rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
> 			       MAX34417_CONTROL_OVF);
> 	if (rc)
> 		return rc;
> 
> 	return regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);

...

> > +	*val = lower_32_bits(power);
> > +	*val2 = upper_32_bits(power);
> 
> iio_val_s64_decompose(power, val, val2)?

Good catch!

...

> > +		rc = regmap_set_bits(max34417->regmap, MAX34417_CONTROL_REG,
> > +				     MAX34417_CONTROL_CAM);
> > +		if (rc)
> > +			return rc;
> > +
> 
> Can the regmap_clear_bits() and regmap_set_bits() calls be
> merged into one regmap_update_bits()?

If they are separated, it should be carefully checked with datasheet.

...

> > +static unsigned int max34417_calc_input_correction(u32 rsense_microOhm)
> 
> Spell the return type as u32, to match the parameter

If it's going to be used as an input for regmap APIs unsigned it makes perfect
sense.

-- 
With Best Regards,
Andy Shevchenko


