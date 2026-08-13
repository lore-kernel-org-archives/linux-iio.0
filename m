Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95937881E;
	Thu, 13 Aug 2026 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610527; cv=none; b=CvJq3YNE6sXCoQh3f79VM1KtCaO3OWAOUz/Ay6nkH++wCDpD0g7DAhmSO5qy+ZScQCF5Gw0Su6NgSfk3nSVkL/fk7R+hJmcKT9zIcJeS7XFdF/Ky2Ew/K2GGrazWgV/FJumOaBII4p5JauG44G0CdqraSQ/7eUp6+SFI9eEG9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610527; c=relaxed/simple;
	bh=5eHWkgvFTQP3h/iG1G2Gr1f0+Z7Iz79Og77G/bMVUpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnwpCJ4cg0Y3vwIcCdIxYRDKwVz2hOmJtrqZ1TISmLe7X3LrXdM9mpPadDJUQ+kz91rID6SRRMOoKMyhsDiOK14PFYbJjMXCNU6X7VmfWU5lFGZ/1VYT30WksAzrG0tha5JLcyFz2zoPfGTs8CLdbYhvsR5cHb45EKbMelAqoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+ksmDCg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+ksmDCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786610525; x=1818146525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5eHWkgvFTQP3h/iG1G2Gr1f0+Z7Iz79Og77G/bMVUpw=;
  b=R+ksmDCgyV4RfAJV+PZQhsonXs75Zi4klgOjdCtKZeeTvdX7F/ezOIJD
   ymAXr0Fn99U5lyvxeUT3MvnXkSZToabsnsTbV+H52MBTg1ebUDTSd6hQI
   XFqWozivv2w3319GVqm3DCVosEcQwwpoEYjp39zLWblVc2xdTmePz5YS1
   b7Mgc+BF+RKFCi/cCydyAdfdStl6AEHXF+7MVDqVaudSnnLRsdV3konhS
   idtMYXvvcSF3KOPvwUy2AWunSpueU4QYLxsbPHkX8pPTZGjsGp38wNlI9
   cIxGCSOCtmtflXIKYLDzBvEuQMAsUlWZb+VCU7NffQWfzErEjcWqyOuBe
   A==;
X-CSE-ConnectionGUID: X1YL9mZPTmOHAISLomt30w==
X-CSE-MsgGUID: udHkoB3fSoKgBxPZwLv4cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="74717264"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="74717264"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:42:04 -0700
X-CSE-ConnectionGUID: g8Kc792+SjCNle1h7GXnAw==
X-CSE-MsgGUID: BKCByXKzTZCpftkO716cxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="302142182"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:42:01 -0700
Date: Thu, 13 Aug 2026 11:41:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <an2DVvX8mBFBhHn-@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:27:43PM +0200, Javier Carrasco wrote:
> The device provides a shared interrupt line for to notify events and
> data ready, which can be used as a trigger. The interrupt line is not a
> requirement for the device to work. Implement variants for the cases
> whether the interrupt line is provided or not.

...

> +static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
> +	__must_hold(&data->irq_lock)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&data->irq_lock);

This needs another include.

> +	if (state) {
> +		data->int_users++;
> +		if (data->int_users > 1)
> +			return 0;
> +	} else {
> +		data->int_users--;
> +		if (data->int_users > 0)
> +			return 0;
> +	}
> +
> +	ret = regmap_field_write(data->rf.int_en, state);
> +	if (ret) {
> +		if (state)
> +			data->int_users--;
> +		else
> +			data->int_users++;
> +	}
> +
> +	return ret;
> +}

...

> +	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &regval,
> +				sizeof(regval));

I always suggest to go with logical split.

	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
				&regval, sizeof(regval));

With shortened name and

	struct regmap *map = data->regmap;

this can be reduced to

	ret = regmap_bulk_write(map, VEML6031X00_REG_WL_L, &val, sizeof(val));

which is perfectly under 80 limit.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	regval = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &regval,
> +				sizeof(regval));

Ditto and so on...

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");

...

> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
> +					    iio->name, iio_device_id(iio));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &veml6031x00_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, iio);
> +
> +	ret = devm_iio_trigger_register(dev, data->trig);
> +	if (ret)
> +		return ret;
> +
> +	iio->trig = iio_trigger_get(data->trig);
> +
> +	return devm_request_threaded_irq(dev, i2c->irq,
> +					NULL, veml6031x00_irq,

	return devm_request_threaded_irq(dev, i2c->irq, NULL, veml6031x00_irq,

...is perfectly one line and keeps be split logically.

> +					IRQF_ONESHOT, iio->name, iio);
> +}

...

>  	pm_runtime_get_noresume(dev);
>  
> +	ret = devm_add_action_or_reset(dev, veml6031x00_disable_event_action, data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to add event cleanup action\n");
> +		goto err_pm_put;

No, this is (I am pretty sure) wrong. It's a red flag if one sees a goto after devm.

> +	}

-- 
With Best Regards,
Andy Shevchenko


