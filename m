Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53315346798;
	Thu, 26 Mar 2026 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520083; cv=none; b=ksIZBeV/GT7iqEYia8UzzY1yfbn6uvwV7s7WccMkW9gZJR+2QWLIBJ+H3Q9eB3Q6PwKPDWiHGz6PUZPxjEVmHfMEs1N+pOznDQpRdBoXVsQsYtOk9uXM5d3ljCOFZtRPpinjEdLoN4X2bMmuh+iYzDCoZwY/SgbM3uc8EKXmPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520083; c=relaxed/simple;
	bh=tEqDeTVXr0t4WjZN8SD7HbZac5wqIjVvgH5+wD1SEuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un08URufZwrRtrr293Cvdm7JoGP/gavPd6iGAm9E5l+rVupKz587inefNNNSRQKhElwpTG6/j5i7/rTzgNYtipV/MK4aekg/GHCvl5XmjfvOT8weGb5rnKCz2Vp2/4ViuiOFi5QgW6rSkWbMemuyNujue0ZhDb5mZck8cb7Uko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lxzickrg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lxzickrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520083; x=1806056083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEqDeTVXr0t4WjZN8SD7HbZac5wqIjVvgH5+wD1SEuQ=;
  b=LxzickrgVksfjbMuIzM1nHcivGwL5Er383XnrDlZMeFwiRdqqxyldEif
   dpFtho8xQwWDJpyBALh3ZsHEWvyMwH5kSskBuQ1dJ5qBG25ajtZrtyVmS
   zFP/2PE3Wbt5JmLaNFtb/P6lIoauWr2D77oc9GeRp+q+qaMp0Ur2Y1Vv3
   r+QVdP9USoI+XBxkHknJTSX6oVLfpZ65UNNz5NgXy1CzNnTSxHld+yukU
   c6DvEGnUf5TWJkjU9RmtajpkIKPs4MLvM7zCl5ljZugDie1DLVbHiscM1
   i9/SzljidY1O+bGJamEW+5VX4IRIMBIgAm2RKynV6pa6wehsjU/GV3RK6
   Q==;
X-CSE-ConnectionGUID: cht9MVNaR9mpm2E3OslHPg==
X-CSE-MsgGUID: +ufNfkSZQZm0tl/Ug2XXIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75457360"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75457360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:14:42 -0700
X-CSE-ConnectionGUID: r1k0VsIAQl2ijKlxEhMsRA==
X-CSE-MsgGUID: gN2J6wfJR1amMdBGewaRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224148200"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:14:39 -0700
Date: Thu, 26 Mar 2026 12:14:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <acUHDGUqg4RdI7fW@ashevche-desk.local>
References: <20260325202005.29822-1-email@sirat.me>
 <20260325202005.29822-3-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325202005.29822-3-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 02:19:42AM +0600, Siratul Islam wrote:
> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.

Some ideas for small followup amendments.

...

> +#define VL53L1X_REG_SOFT_RESET						0x0000
> +#define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
> +#define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
> +#define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
> +#define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
> +#define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
> +#define VL53L1X_REG_PHASECAL_CONFIG__TIMEOUT_MACROP			0x004B
> +#define VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_A			0x005E
> +#define VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_A			0x0060
> +#define VL53L1X_REG_RANGE_CONFIG__TIMEOUT_MACROP_B			0x0061
> +#define VL53L1X_REG_RANGE_CONFIG__VCSEL_PERIOD_B			0x0063
> +#define VL53L1X_REG_RANGE_CONFIG__VALID_PHASE_HIGH			0x0069
> +#define VL53L1X_REG_SYSTEM__INTERMEASUREMENT_PERIOD			0x006C
> +#define VL53L1X_REG_SD_CONFIG__WOI_SD0					0x0078
> +#define VL53L1X_REG_SD_CONFIG__WOI_SD1					0x0079
> +#define VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD0			0x007A
> +#define VL53L1X_REG_SD_CONFIG__INITIAL_PHASE_SD1			0x007B
> +#define VL53L1X_REG_SYSTEM__INTERRUPT_CLEAR				0x0086
> +#define VL53L1X_REG_SYSTEM__MODE_START					0x0087
> +#define VL53L1X_REG_RESULT__RANGE_STATUS				0x0089
> +#define VL53L1X_REG_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0	0x0096
> +#define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
> +#define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
> +#define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
> +#define VL53L1X_REG_DEFAULT_CONFIG					0x002D

Keep the list ordered by the value?

...

> +static int vl53l1x_chip_init(struct vl53l1x_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val;
> +	u16 model_id;
> +	int ret;
> +
> +	if (!data->xshut_reset) {
> +		ret = regmap_write(data->regmap, VL53L1X_REG_SOFT_RESET, 0x00);
> +		if (ret)
> +			return ret;
> +		fsleep(100); /* conservative reset pulse, no spec */
> +
> +		ret = regmap_write(data->regmap, VL53L1X_REG_SOFT_RESET, 0x01);
> +		if (ret)
> +			return ret;
> +		fsleep(1000); /* conservative boot wait, no spec */
> +	}
> +
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS, val,
> +				       val & BIT(0),
> +				       1 * USEC_PER_MSEC,
> +				       100 * USEC_PER_MSEC);

Use logical split

	ret = regmap_read_poll_timeout(data->regmap,
				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS,
				       val, val & BIT(0),
				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);

> +	if (ret)
> +		return dev_err_probe(dev, ret, "firmware boot timeout\n");
> +
> +	ret = vl53l1x_read_u16(data, VL53L1X_REG_IDENTIFICATION__MODEL_ID,
> +			       &model_id);
> +	if (ret)
> +		return ret;
> +
> +	if (model_id != VL53L1X_MODEL_ID_VAL)
> +		dev_info(dev, "unknown model id: 0x%04x, continuing\n", model_id);
> +
> +	ret = regmap_bulk_write(data->regmap, VL53L1X_REG_DEFAULT_CONFIG,
> +				vl53l1x_default_config,
> +				sizeof(vl53l1x_default_config));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, VL53L1X_REG_GPIO_HV_MUX__CTRL, &val);
> +	if (ret)
> +		return ret;
> +	data->gpio_polarity = !!(val & VL53L1X_GPIO_HV_MUX_POLARITY);
> +
> +	/* Initial ranging cycle for VHV calibration */
> +	ret = vl53l1x_start_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       VL53L1X_REG_GPIO__TIO_HV_STATUS, val,
> +				       (val & 1) != data->gpio_polarity,
> +				       1 * USEC_PER_MSEC,
> +				       1000 * USEC_PER_MSEC);

Ditto.

	ret = regmap_read_poll_timeout(data->regmap,
				       VL53L1X_REG_GPIO__TIO_HV_STATUS,
				       val, (val & 1) != data->gpio_polarity,
				       1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);

> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_clear_irq(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_stop_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap,
> +			   VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND,
> +			   VL53L1X_VHV_LOOP_BOUND_TWO);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->regmap, VL53L1X_REG_VHV_CONFIG__INIT, 0x00);
> +}

...

> +	if (data->irq) {
> +		reinit_completion(&data->completion);
> +
> +		ret = vl53l1x_clear_irq(data);
> +		if (ret)
> +			return ret;
> +
> +		if (!wait_for_completion_timeout(&data->completion, HZ))
> +			return -ETIMEDOUT;
> +	} else {
> +		unsigned int rdy;
> +
> +		/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
> +		ret = regmap_read_poll_timeout(data->regmap,
> +					       VL53L1X_REG_GPIO__TIO_HV_STATUS, rdy,
> +					       (rdy & 1) != data->gpio_polarity,
> +					       1 * USEC_PER_MSEC,
> +					       1000 * USEC_PER_MSEC);

Ditto.

		ret = regmap_read_poll_timeout(data->regmap,
					       VL53L1X_REG_GPIO__TIO_HV_STATUS,
					       rdy, (rdy & 1) != data->gpio_polarity,
					       1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);

Yes, in this case they are slightly longer than 80 characters. But
looking at the above this entire call should be a helper, so you can
reuse it here and above.

> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


