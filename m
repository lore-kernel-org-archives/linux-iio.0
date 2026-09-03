Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D53E5A36;
	Thu,  3 Sep 2026 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417671; cv=none; b=izFMvw7ipSpMSvAsZS9CG12T2aG2y/iGQSBe/V3INzccD3yqhQWve7czfrMzOcHijtnC7ToAb/merHrZVjcfcWejucbBkrftDoeXN3HFPIPcvWCaUN9nFHw03l9+LmFmNvR/XnsvuQK2rmRyqPSNkyUuoXr53cxuBVOkicwXZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417671; c=relaxed/simple;
	bh=Wo15GcwJ1Qgli6mrGtIRqSHX+bpjKGDrMUlX59EIAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEPQ9u8mI1eEByDzCrF13Ns/djSh/KtnRE0nI7R2ijYCrHYRkswHJOvUWRqrPVeNMC2Bki90sevHbf5K/JnBsaxHZvM2njQJVeI/mx0otigXQVdduORZ18KXLRuTX5MN60PKiFJQF9d8gmOWA8/rnJ0XLb+rrC9R1pr89dhzzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wv+0j0Pm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wv+0j0Pm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417668; x=1819953668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wo15GcwJ1Qgli6mrGtIRqSHX+bpjKGDrMUlX59EIAqA=;
  b=Wv+0j0PmyHWxoNNsV9Qk0ncN/zZckPy8p+igy8wmLR0+XEFz0/wmMloP
   ypIHmsiTo2uBiJwC06qG7ED0jtTgSQiW/hxC1bZzCFdcu9Kf/UkEBfFCf
   mCh305Ane5rSPuuoxpow6wUavVITC711mNMTICM6whZ/6Jw7SueJrHyMx
   UGqqh2YF/6CsMsoaDFfmeLAvhMh4ynURsQfVVUxzd+MxHUCzYAfOwgd4i
   3YB6ai5ujLgfSWP3sxC9yo+lAd+c/myFUXIsLBc4qU3E25IQe241sk78n
   ITlJanMiv99BsjH76QnMT1YYYtMjAI+gVlE1Ixoh1IssmcTQVrhEY3P/P
   A==;
X-CSE-ConnectionGUID: rCLdSLINS7a6bCKNLbmdpw==
X-CSE-MsgGUID: clBXKqcmTXm7XWh/wmGYVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="76443787"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="76443787"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:39:54 -0700
X-CSE-ConnectionGUID: D3OeNzWoSB28Ajijcl0lcg==
X-CSE-MsgGUID: p2Pm2R1iQpWsVwAYMG7rtA==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:39:50 -0700
Date: Thu, 3 Sep 2026 09:39:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 09/13] iio: adc: ad4134: Support SPI 4-wire mode
Message-ID: <apkWNHHKyf9e9_Q7@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <b7639db1c5f9b13f74d0c4f04edc8d9c11ac4727.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7639db1c5f9b13f74d0c4f04edc8d9c11ac4727.1788368334.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 02:24:25PM -0300, Marcelo Schmitt wrote:
> AD4134 devices can be wired in a few different ways. So far, only minimum
> I/O mode was supported. While minimum I/O mode allows interfacing with
> AD4134 with a reduced number of wires, that wiring configuration is not
> optimal for high-throughput data acquisition.
> 
> Extend AD4134 support to enable interfacing in SPI 4-wire configuration.

...

> struct ad4134_state {

I hope on each stage you run `pahole` to confirm that this is the optimal
layout.

>  	struct gpio_desc *odr_gpio;
>  	int refin_mv;
>  	bool crc_en;
> +	enum ad4134_spi_mode spi_mode;
> +	struct mux_state *mux_st[2];
>  	/*
>  	 * Synchronize access to members the of driver state, and ensure
>  	 * atomicity of consecutive register access operations.
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Ensure atomicity of access mode switch operations.
> +	 */
> +	struct mutex access_mode_lock;

>  };

...

> +static int ad4134_set_register_access(struct ad4134_state *st)
> +{
> +	int ret;
> +
> +	guard(mutex)(&st->access_mode_lock);

+ blank line.

> +	st->spi->mode = SPI_MODE_0;
> +	ret = spi_setup(st->spi);
> +	if (ret)
> +		return ret;
> +
> +	ret = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
> +	if (ret)
> +		dev_err(&st->spi->dev, "error on DOUT0 deselect: %d\n", ret);

> +	ret = mux_state_try_select(st->mux_st[AD4134_SDO_INPUT]);
> +	if (ret && ret != -EBUSY)
> +		return ret;

Reading this without a comment about EBUSY is difficult. Interpreting BUSY as
occupied mux channel, why do we return success?

> +	return 0;
> +}

...

> +static int ad4134_set_sample_access(struct ad4134_state *st)
> +{

	struct device *dev = &st->spi->dev;

> +	int ret, ret2;

I would go with

	int mux_state_ret;
	int ret;

> +	guard(mutex)(&st->access_mode_lock);
> +	ret = mux_state_deselect(st->mux_st[AD4134_SDO_INPUT]);
> +	if (ret)
> +		dev_err(&st->spi->dev, "error on SDO deselect: %d\n", ret);
> +
> +	ret = mux_state_try_select(st->mux_st[AD4134_DOUT0_INPUT]);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "error on DOUT0 select: %d\n", ret);
> +		return mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
> +	}
> +
> +	/*
> +	 * Data output on the DOUT lines is sampled on the falling edge
> +	 * (SPI mode 1).
> +	 */
> +	st->spi->mode = SPI_MODE_1;
> +	ret = spi_setup(st->spi);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "failed to setup SPI mode 1: %d\n", ret);
> +		ret2 = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
> +		if (ret2)
> +			dev_err(&st->spi->dev, "error on DOUT0 deselect: %d\n", ret2);
> +
> +		ret2 = mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
> +		if (ret2)
> +			dev_err(&st->spi->dev, "error on SDO select: %d\n", ret2);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}

...

>  static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct ad4134_state *st = context;
> +	int ret, ret2;
>  
> -	if (reg >= AD4134_CH_VREG(0))
> -		return ad4134_data_read(st, reg, val);
> +	if (reg >= AD4134_CH_VREG(0)) {
> +		if (st->spi_mode == AD4134_SPI_MODE_4_WIRE) {
> +			ret = ad4134_set_sample_access(st);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = ad4134_data_read(st, reg, val);
> +
> +		if (st->spi_mode == AD4134_SPI_MODE_4_WIRE) {
> +			ret2 = ad4134_set_register_access(st);
> +			if (ret2)
> +				dev_err(&st->spi->dev, "access mode error: %d\n", ret2);
> +		}

I would go with duplication of _data_read() call but better flow

		if (...) {
			_set_sample_()
			ret = _data_read();
			_set_register_()
		} else {
			ret = _data_read();
		}

> +		return ret;
> +	}

...

> +	ret = device_property_match_property_string(dev, "adi,spi-mode",
> +						    ad4134_spi_modes,
> +						    ARRAY_SIZE(ad4134_spi_modes));
> +	/* Default to "no-cs" mode if adi,spi-mode is not specified */
> +	if (ret == -EINVAL)

No, use device_property_present() instead.

> +		st->spi_mode = AD4134_SPI_MODE_NO_CS;
> +	else if (ret < 0)
>  		return dev_err_probe(dev, ret,
> -				     "failed to setup minimum I/O mode\n");
> +				     "getting adi,spi-mode property failed\n");
> +	else
> +		st->spi_mode = ret;

-- 
With Best Regards,
Andy Shevchenko


