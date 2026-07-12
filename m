Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C3194A6C;
	Sun, 12 Jul 2026 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783849386; cv=none; b=oON+qiygkHx1pw6UlNpXhMH2kDxqRV0F0C8vT/Wy9sIptXKcf1MekYhVzbuHFKLL6eh1zGMOIX7Hd4dMgMBImSjBLy46RAxL1PL/ZERhmleNZDdMQO+v8qBQMDSqKi+5JhVXmRJKzJrF1VVk2PX8DQRljIM3gKE4YfSPWde3c0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783849386; c=relaxed/simple;
	bh=TKxKr0MygzhI1nHZzXrAwCedHsz3xYd9YHH+NSnVEGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO2TGQeT9c2RCsDUQPlH6wlrzSEjhdLmBsMOpuIViLpTDSahw97+HRJoq0i/63WbxsTM1WA1dK8IwVk2ARBiuLhYbJNpvnY3Bv12vmwcoaG4CK+bmVmLtG54WK3HWJfuLDJzpEGK4PR7KvIDQ9iONEXL8IHztH53Yiwv+EYyfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCGEw4sy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCGEw4sy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783849385; x=1815385385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TKxKr0MygzhI1nHZzXrAwCedHsz3xYd9YHH+NSnVEGo=;
  b=LCGEw4sy8D5uQvQ8+Q12SPYe3CEkNMRtkIh9Be03fm+MJIIIEdFstOCO
   rjdOqFKHzBoFC1PYiAnHcKC+LorialKQHr002GfCwbd8mePwPe8LuFeim
   +QExcfqSr5xID2pLpJ0Y27WUyFLlBI1OL6MCSkQW2Pu0YTk0KItUGAHUk
   xafaF1pDaApE6YK2XMZyBV4j03AdNfmhiYuujnW9M/jTBqPjviF222ly1
   am/abz1YrJGSNoiQr/cgILcUaXQKbJLkBH3ub4oB/asAo7kRtyHMfBDWH
   55cQWPK9ILX8UAX4QBebStdbLjZoSPmTrZIL8MMaTXj+UwnwSdfxaU4zI
   w==;
X-CSE-ConnectionGUID: 8Q32t2KZRP2ljZdIoF2OEg==
X-CSE-MsgGUID: nQx/eGAvS/OxwDPW3AHyng==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87030408"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87030408"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:43:04 -0700
X-CSE-ConnectionGUID: 4U2/jy8DRd+OGl2bNCvJ0w==
X-CSE-MsgGUID: ZEbinDOlRRuvvHxCv45JGQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:43:01 -0700
Date: Sun, 12 Jul 2026 12:42:58 +0300
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
Subject: Re: [PATCH v3 6/8] iio: adc: add ti-ads112c14 driver
Message-ID: <alNhom1_o1hZgEnz@ashevche-desk.local>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 05:50:39PM -0500, David Lechner (TI) wrote:
> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
> 
> This first step is adding a very basic driver that only supports power
> on/reset and reading the system monitor channels.
> 
> ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
> logical order by address to keep the voltage channels together and in
> case we find we need to add variants of this channel with different
> voltage reference later.

...

> +static int ads112c14_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	const struct ads112c14_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	struct ads112c14_data *data;
> +	u32 reg_val;
> +	int ret;
> +
> +	info = i2c_get_match_data(client);
> +	if (!info)
> +		return dev_err_probe(dev, -EINVAL, "missing match data\n");

I think -ENODEV suits better here.

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->chip_info = info;
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
> +
> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to init regmap\n");

Do we have a guarantee that device is powered on here?

> +	/* Write magic reset value (0x16) to ensure known state. */
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   FIELD_PREP(ADS112C14_CONVERSION_CTRL_RESET, 0x16));
> +	/*
> +	 * The reset may cause an -EREMOTEIO error because of failing to get the
> +	 * I2C ACK at the end of the message. The device still gets reset so it
> +	 * is safe to ignore this error.
> +	 */
> +	if (ret == -EREMOTEIO)
> +		ret = 0;
> +	if (ret)
> +		return ret;
> +
> +	fsleep(ADS112C14_DELAY_RESET_US);
> +
> +	ret = regmap_read(data->regmap, ADS112C14_REG_STATUS_MSB, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
> +		return dev_err_probe(dev, -EIO, "reset failed\n");
> +
> +	/*
> +	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
> +	 * that happens on every reset.
> +	 */
> +	ret = regmap_write(data->regmap, ADS112C14_REG_STATUS_MSB,
> +			   ADS112C14_STATUS_MSB_RESETN |
> +			   ADS112C14_STATUS_MSB_AVDD_UVN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, ADS112C14_REG_DEVICE_ID, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val) != info->device_id)
> +		dev_info(dev, "device ID mismatch, expected 0xX%X, got 0x%lX\n",
> +			 info->device_id,
> +			 FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val));
> +
> +	/* Place in single-shot conversion mode to make ready for raw read. */
> +	ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +			      ADS112C14_DEVICE_CFG_CONV_MODE);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads112c14_sys_mon_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads112c14_sys_mon_channels);
> +	indio_dev->info = &ads112c14_info;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


