Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F12D8376;
	Sat, 11 Jul 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774836; cv=none; b=HNi8Z9z9a5e6GFmFW4JAX30Cth2owJ1+9JMlwVHczCEUKHCXOSNTxHNfMPwBDqI/IuaQrL2zoaHr5BTNsKRsbko9+P5iicYlyZpVgpY+OwQPpuzR1IoqCO2DpvrxguLzX1IFuEkYbWUM15GBWPdp2baZQYSDZ1Tq3P8kShDLWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774836; c=relaxed/simple;
	bh=oqWg7UABC2GpV74e/SzQ4pYEpntQ+E/jiLoCkyEhzas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+m5t5y/D+eTNt/MNlhiM8hKhmcL1eGOAzQFEA+3iS3+nPYOafC4UAeVt60fwrKygO+lxr/pv2MU3jUpgzQ7Bq7VN0kjn/z2qYV+hgmffp6+dfwHkn5f7N2cyQl6CNmlPr035yZAnndofrkLkCW/AC1uorBe8BnoTCC0r+Qmln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4gsKIJn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4gsKIJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783774834; x=1815310834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqWg7UABC2GpV74e/SzQ4pYEpntQ+E/jiLoCkyEhzas=;
  b=b4gsKIJnfCX8myoar/w/Md+rkqsdGYRo4vXMPffXgEm394fVpOH5ylzT
   p2DzqUNx+YxSEWD6oHoLfth3XK5lBKqUNzlB6Jnp1IJG1SFbtgdg+bD0D
   wj9bnj84lKUIh6raCtGmjR/EHZGNsQlFzQZDKb1sNlHfwYSM/p8MMBNpY
   s2ShxITtIL//6nbwszZgul2W68s7LVuzgedkziQ/yaqSEL/tlrP+qv1xy
   EFizUOkhfsWtP/Y9MvDe0Cc7HfJ9rpzza/Z+398CbO/QJbKyvj9CSZ5Kk
   Ojyzw8/BEBcjT0a0LeJ/I2mlQLt7V7h42pfGw8htUWcs2MI2h8eQvcyb8
   g==;
X-CSE-ConnectionGUID: 3BfO6jyKQaurNKecnJjFWg==
X-CSE-MsgGUID: WzVaG2SSQ6i+dXdkWgHUXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101879009"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101879009"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 06:00:33 -0700
X-CSE-ConnectionGUID: W6vyTWFpTCyUzW3UkR0L9A==
X-CSE-MsgGUID: EyDTz2rPSfuZD2o/DuC8AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="257067270"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 06:00:29 -0700
Date: Sat, 11 Jul 2026 16:00:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <alI-a6nkGvXp6sDo@ashevche-desk.local>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-8-746d52cbf1d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-8-746d52cbf1d0@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 05:50:41PM -0500, David Lechner (TI) wrote:
> Add support for parsing devicetree properties for measurement channels
> and doing direct reads on these.
> 
> There are quite a lot of conditions that have to be met for each
> measurement to be made, so quite a bit of state and algorithms are
> required to handle it.
> 
> Channels are created dynamically since the number of possibilities is
> unreasonably large.

...

> +struct ads112c14_measurement {
> +	const char *label;
> +	u32 vref_source;
> +	u8 iunit;
> +	u8 idac1_mag;
> +	u8 idac2_mag;
> +	u8 idac1_mux;
> +	u8 idac2_mux;

I would group this slightly differently:

	u8 idac1_mag;
	u8 idac2_mag;
	u8 idac1_mux;
	u8 idac2_mux;
	u8 iunit;

I haven't seen the code, but names suggest that most likely one would read
*[12] together or close enough, and less probably mixed with 'iunit' reads.
Current layout might lead to interesting code generation complications on
the unaligned-intolerable architectures.

> +	u8 iadc_count;
> +	u8 gain_val;
> +	u8 burnout;
> +	bool global_chop;
> +	bool bipolar;

> +	s64 scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];

Also this can be moved upper, but I think it won't save any bytes in this
layout.

> +};

...

>  struct ads112c14_data {
>  	const struct ads112c14_chip_info *chip_info;
>  	struct regmap *regmap;
> +	u32 avdd_uV;
> +	u32 ext_ref_uV;

> +	bool refp_is_avdd;
> +	bool refn_is_gnd;

Here is a definite gain in memory if booleans combined with u8 below

> +	u32 ext_ref_ohms;
> +	struct ads112c14_measurement *measurements;
> +	u32 num_measurements;

Something like

	struct ads112c14_measurement *measurements;
	u32 num_measurements;
	u32 avdd_uV;
	u32 ext_ref_uV;
	u32 ext_ref_ohms;
	bool refp_is_avdd;
	bool refn_is_gnd;

? (Don't forget to run `pahole`.)

>  	u8 sys_mon_chan_short_gain_val;
>  	s64 sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
>  };

...

> +	return regmap_update_bits(data->regmap, ADS112C14_REG_REFERENCE_CFG,
> +				  ADS112C14_REFERENCE_CFG_REFP_BUF_EN |
> +				  ADS112C14_REFERENCE_CFG_REFN_BUF_EN |
> +				  ADS112C14_REFERENCE_CFG_REF_VAL |
> +				  ADS112C14_REFERENCE_CFG_REF_SEL,
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFP_BUF_EN,
> +					     refp_buf_en) |
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFN_BUF_EN,
> +					     refn_buf_en) |
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_VAL,
> +					     ref_val) |
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_SEL,
> +					     ref_sel));

Personally I would go over 80 here.

				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFP_BUF_EN, refp_buf_en) |
				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFN_BUF_EN, refn_buf_en) |
				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_VAL, ref_val) |
				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_SEL, ref_sel));

All are less than 100.

> +}

...

> +	/* measurement channels */
> +	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
> +		struct ads112c14_measurement *measurement;
> +
> +		measurement = &data->measurements[chan->scan_index];

> +

I would drop this blank line. It's naturally looking to have them coupled.

> +		if (!measurement->label)
> +			return -EINVAL;
> +
> +		return sysfs_emit(label, "%s\n", measurement->label);
> +	}

...

> +			if (pair[0] <= 100000 && (measurement->iadc_count == 1 || pair[1] <= 100000)) {

100 * (NANO / MICRO)

in the similar way how you done elsewhere in the code.

> +				/*
> +				 * If both values are 100uA or less, then we can
> +				 * use IUNIT = 1uA for better precision.
> +				 */
> +				ret = ads112c14_populate_idac_mag(pair[0],
> +								  &measurement->idac1_mag);
> +				if (ret)
> +					return ret;
> +
> +				if (measurement->iadc_count > 1) {
> +					ret = ads112c14_populate_idac_mag(pair[1],
> +									  &measurement->idac2_mag);
> +					if (ret)
> +						return ret;
> +				}
> +			} else {
> +				/*
> +				 * Otherwise, IUINT is 10uA (flag set) and so
> +				 * IxMAG is 1/10 of the actual current.
> +				 */
> +				measurement->iunit = 1;
> +
> +				ret = ads112c14_populate_idac_mag(pair[0] / 10,
> +								  &measurement->idac1_mag);
> +				if (ret)
> +					return ret;
> +
> +				if (measurement->iadc_count > 1) {
> +					ret = ads112c14_populate_idac_mag(pair[1] / 10,
> +									  &measurement->idac2_mag);
> +					if (ret)
> +						return ret;
> +				}
> +			}
> +		}

-- 
With Best Regards,
Andy Shevchenko


