Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81D3515CD;
	Mon, 24 Aug 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565263; cv=none; b=Rbfh9a578cmu4KpEMfCdHDgLAeLqSajGwECA2zt4dvgph47wKjW+XREQMrGSvW9zV8ocUfmdZ/E8Xn2Cso1VLTi+Uyd1MyChSbIANrxY77y5bSljmc6k8eonvHw9OSfdbueHe6tqkRAm2fnS1mVwdLn/TJvRBAW4uu7WmcYTlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565263; c=relaxed/simple;
	bh=mbMbRMfNqvAsWAoKe2zPVrwdkGENE8wTO9cLvQmmDlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZQuOQ6zPlbzvzP7UNOvqntG/ZPMVkFmToGzwcVPU/OPGOTj+cs/BJI4pVmZP8val8vZSNfj40q/O5zKulzt4ymAlHC30PigKX6LBzRv33MgMtjrmJ7Gkjg/c8mg1AAGsyxsCu8ksqTL5LcfXZwFe4XfsKDxa3z+9POWouXj5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyFOX8mj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyFOX8mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787565261; x=1819101261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mbMbRMfNqvAsWAoKe2zPVrwdkGENE8wTO9cLvQmmDlg=;
  b=LyFOX8mj3wev8DL99RIUvAL4goQpQ1hMQmCpCfOo9BEZqNbV8Mq0O08D
   VVo0dU+JKyGli+ukzPlAqfZYI/wkhbsHagO5HvQW7D2FRVhKQ0lCp/wrB
   sEK6Yh45ac7VjjUr/KWl8eXuABSeu6ziL7khd9cdTMv/2Oq8nZ5NYp1NA
   aZBeaieWDv2PaoZITcd8BrpBrhkmQVJYHHdNPuz9WE89RhLZbMtgl7VIX
   oaB14VifbYGZSJVi10XtVKzK5wImM8GfO3n5qa72+6DG17Z1zJpjr6YNP
   j9N0fmrSGEz8VYSPvkf5yg/gEjziEEc+6cuU2fAAioOo9+kUakX6V2xKp
   Q==;
X-CSE-ConnectionGUID: uq718OfITkKc8SZxu5sKYQ==
X-CSE-MsgGUID: qcRXpTPCRvis+3QnGyzI5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87882432"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87882432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:54:13 -0700
X-CSE-ConnectionGUID: rHae4vIMTN6ygNFScXxgig==
X-CSE-MsgGUID: AeMSxCbyT669lP+dt5gkIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265185476"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:54:10 -0700
Date: Mon, 24 Aug 2026 12:54:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <aowUv2J5jFM7UEDb@ashevche-desk.local>
References: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
 <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 04:49:39PM +0800, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Per-channel reference source selection (internal 2.048V, external
>   REFP/REFN, or AVDD) via the reference-sources device tree property.
>   refn-supply is not yet supported.
> - Hardware reset via the reset controller framework, falling back to
>   the RESET command when no reset controller is present.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int ads112c04_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads112c04_state *st;
> +	struct reset_control *reset;
> +	bool need_avdd_ref = false, need_ext_ref = false;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	init_completion(&st->completion);
> +
> +	indio_dev->name = "ads112c04";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads112c04_info;
> +
> +	/* Forward compatibility checks for unimplemented DT properties */
> +	if (device_property_present(dev, "refn-supply") ||
> +	    device_property_present(dev, "ti,refp-refn-resistor-ohms"))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "refn-supply and external resistors are not supported yet\n");
> +
> +	ret = ads112c04_parse_channels(indio_dev, &need_avdd_ref, &need_ext_ref);
> +	if (ret)
> +		return ret;
> +
> +	if (need_avdd_ref) {
> +		ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "failed to get avdd voltage\n");
> +
> +		st->avdd_mV = ret / (MICRO / MILLI);
> +	} else {
> +		ret = devm_regulator_get_enable(dev, "avdd");
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
> +	}
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
> +
> +	if (device_property_present(dev, "refp-supply")) {
> +		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "failed to get refp voltage\n");
> +
> +		st->ext_ref_mV = ret / (MICRO / MILLI);
> +	}
> +
> +	if (need_ext_ref && !st->ext_ref_mV)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "external reference measurements require refp-supply\n");
> +
> +	/* Datasheet: POR releases ~500us after supplies are stable */
> +	fsleep(500);
> +
> +	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset), "failed to get reset\n");
> +
> +	if (reset) {
> +		/* Datasheet: tw(RSL), the RESET low pulse, is 250ns minimum */
> +		fsleep(1);
> +
> +		ret = reset_control_deassert(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to deassert reset\n");
> +	} else {
> +		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Datasheet: td(RSSTA) is 100ns minimum after the RESET rising edge */
> +	fsleep(1);

Perhaps simply ndelay(100) ?

> +	/*
> +	 * Initialize CONFIG0 with all fields explicit: gain of 1 with the PGA
> +	 * bypassed, which allows full-scale single-ended measurements. The MUX
> +	 * field is updated per channel before each conversion.
> +	 */
> +	st->config0 = FIELD_PREP(ADS112C04_CONF0_MUX,
> +				 ADS112C04_CONF0_MUX_AIN0_AIN1) |
> +		      FIELD_PREP(ADS112C04_CONF0_GAIN,
> +				 ADS112C04_CONF0_GAIN_X1) |
> +		      ADS112C04_CONF0_PGA_BYPASS;
> +
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
> +	if (ret)
> +		return ret;
> +
> +	st->config1 = FIELD_PREP(ADS112C04_CONF1_DR,
> +				 ADS112C04_CONF1_DR_20SPS) |
> +		      FIELD_PREP(ADS112C04_CONF1_MODE,
> +				 ADS112C04_CONF1_MODE_NORMAL) |
> +		      FIELD_PREP(ADS112C04_CONF1_CM,
> +				 ADS112C04_CONF1_CM_SINGLE_SHOT) |
> +		      FIELD_PREP(ADS112C04_CONF1_VREF,
> +				 ADS112C04_CONF1_VREF_INTERNAL) |
> +		      FIELD_PREP(ADS112C04_CONF1_TS,
> +				 ADS112C04_CONF1_TS_DISABLED);
> +
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_irq(dev, client->irq, ads112c04_irq_handler, 0,
> +				       indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


