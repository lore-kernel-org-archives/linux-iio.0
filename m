Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDC222582;
	Wed, 10 Jun 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116687; cv=none; b=p7wVnXB8wqM7vz5EgXnwX7kmyqX0i93vp92EVZz5EbsX0yo1hkvT7AhYa25Hd5rNGE4xbowQC58fJMwdie90okodMPpmTCGvxdPRH9Pho/6Vw2XmKWeDRE7NyAT07C7DWNY8XoKDwzZ8ExR5BOrV5USD7JkoFPVECQE2CkKaFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116687; c=relaxed/simple;
	bh=7NxpVDL3U9isnRJLHACxXEAsc4azboP8sWPfRYo80Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTH2G+eOz8EcnM0VmCkBXeGVZJKaamv5wCti1/kjfPYZ0jsMhoQA0N5AiyjnSao7OVWN+goA1YdebF/PHn6FZfxxd03Yvn+nSxX5SHYACVd9OL49hKoJbJhuRElDtWGdwtbNBu0E1qUrefqZ69EDjYzCX8uA4pZKsRz5HwP3sx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J289lOQh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J289lOQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781116684; x=1812652684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NxpVDL3U9isnRJLHACxXEAsc4azboP8sWPfRYo80Ds=;
  b=J289lOQhzVhWJEV+KLeamRZJqxa6e1vBtxfpdhmSRjQf4JkQqPSDFQgR
   fznddfv7LrvYf5a+bUtfujfSH50riO2oa+XwfblK6yIbZPAc7H8NzHMjm
   v/LLRp1q2cFJeiZ96AJnGWzAwwZIhgFr3kQmVeKUCvC5Mjjefinp/SgH9
   fNK9oqhpFn8aGs+xT9RKYq0f5uhCouC6k/1LnWSCIJZZF6H+JVOJgxbzm
   IjPacT5DxlfIxxcRvE812BVG4PYwuqZFr8fXk+ew7+vyuk4uefatT70bo
   2v0GNf43TpSH0VQvy0MZtLlADC/S4yelayqix8LnDf5gE9zJaIrw0caLM
   A==;
X-CSE-ConnectionGUID: UOnsywIkR9qtIM/d1QLu9g==
X-CSE-MsgGUID: IsvhnkQXSmabfLxcIoM8ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81983191"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81983191"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:38:04 -0700
X-CSE-ConnectionGUID: At8iO3BCQcekizLr5CqvQw==
X-CSE-MsgGUID: y8KMfhWISiKYJbKXdkM3nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="248120180"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:38:01 -0700
Date: Wed, 10 Jun 2026 21:37:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <aimvBvJp8CsNKlPU@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
 <20260610020458.104818-3-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610020458.104818-3-adamianlouis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian wrote:
> Add correct temperature compensation for ms5637-30BA, MS5803-01BA,02BA,
> 05BA, 14BA, 30BA, MS5837-30BA. The temperature compensation formula is
> shared across these sensors but with different constants. Add
> ms_tp_comp_consts to capture these per-device differences. Add pressure
> variant specific pressure scale variable.

Is there SPI driver? If so, why only i2c is affected?

...

> +/* apply second order temperature compensation */
> +static void ms_tp_compensate(const struct ms_tp_comp_consts *c,
> +			     s32 temp, s32 dt, s64 *t2, s64 *off2, s64 *sens2)
> +{
> +	if (temp < 2000) {
> +		s64 tmp = (s64)temp - 2000;

Why casting?

> +
> +		*t2 = (c->low_t2_multiplier * ((s64)dt * (s64)dt)) >>
> +		      c->low_t2_shift;
> +		*off2 = (c->low_off2_multiplier * tmp * tmp) >>
> +			c->low_off2_shift;
> +		*sens2 = (c->low_sens2_multiplier * tmp * tmp) >>
> +			 c->low_sens2_shift;


> +		if (temp < -1500) {
> +			s64 tmp_vlow = (s64)temp + 1500;

Missing blank line. But Q here is why tmp can't be used here?

> +			*off2 += c->vlow_off2_multiplier * tmp_vlow * tmp_vlow;
> +			*sens2 +=
> +				c->vlow_sens2_multiplier * tmp_vlow * tmp_vlow;

Make it one line.

> +		}
> +	} else {
> +		*sens2 = 0;
> +		if (c->has_vhigh_temp && temp > 4500)
> +			*sens2 -= (((s64)temp - 4500) * ((s64)temp - 4500)) >> 3;

Here...

> +		*t2 = (c->high_t2_multiplier * ((s64)dt * (s64)dt)) >>
> +		      c->high_t2_shift;
> +		*off2 = (c->high_off2_multiplier *
> +			 ((s64)temp - 2000) * ((s64)temp - 2000)) >>

...and here you may also use tmp, just make it global to the function.

> +			c->high_off2_shift;
> +	}
> +}

Overall this all needs a good comment or even comments to explain all
calculations with the references to the respective sections / tables / pages
in the datasheet.

...

> int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,

>  	s32 dt, temp;
>  	s64 off, sens, t2, off2, sens2;
>  	u16 *prom = dev_data->prom, delay;
> +	const struct ms_tp_comp_consts *c = dev_data->comp_consts;

Try to keep more or less reversed xmas tree order.

...

>   * struct ms_tp_dev - Temperature/Pressure sensor device structure
>   * @client:	i2c client

>   * @prom:	array of PROM coefficients used for conversion. Added element
>   *              for CRC computation
>   * @res_index:	index to selected sensor resolution
> + * @comp_consts: temperature compensation constants
>   */
>  struct ms_tp_dev {
>  	struct i2c_client *client;

>  	const struct ms_tp_hw_data *hw;
>  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
>  	u8 res_index;
> +	const struct ms_tp_comp_consts *comp_consts;

Please, check with `pahole` if this is the best layout.

>  };

>  struct ms_tp_data {
>  	const char *name;
>  	const struct ms_tp_hw_data *hw;
> +	const struct ms_tp_comp_consts *comp_consts;
>  };

Can this be simply embedded into ms_tp_dev (and copied there if required)?

...

>  		case IIO_PRESSURE:	/* in kPa */
> -			*val = pressure / 1000;
> -			*val2 = (pressure % 1000) * 1000;
> +			*val = pressure / dev_data->comp_consts->press_scale;
> +			*val2 = (pressure %
> +				 (s64)dev_data->comp_consts->press_scale) *
> +				(1000000 / dev_data->comp_consts->press_scale);

MICRO (might need units.h)?

>  			return IIO_VAL_INT_PLUS_MICRO;

...

Have you considered to prepare the infrastructure in one patch and add
the actual compensation data tables in another?

-- 
With Best Regards,
Andy Shevchenko


