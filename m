Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F36224B13;
	Tue, 18 Aug 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061703; cv=none; b=FgypbeIT7HrCySM9WNQ8OsTjNvEfxdPx16nqKIsI4oDf+s0c6ELfGeBquZjxWtP979ode0SXHMfOOP101thNneOqmhBOJTPWKkO8UtguzMuGDvAHJ7x5aoJ3dKyVrwHi1S/wDI+4cEFYuuX0GSiqUQO+eIJUY7GArCfYGseMieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061703; c=relaxed/simple;
	bh=//PmUf126ej0sjGBWB4w/eOZ2JO+QkS7LpA95oIVS5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KubyArLfx5j5MsKV8HpqV4lVqTKqLu8fp2jUMH1pGPnobzFyea8GmKPySEwugV0zrra95jRcFX7UoBE3g1P9MOM08GmqDkkNBQJiqsFlZrGHdZV0dtsKKfj6TLE3bTLdw+vGHk+k6ywX8Yo8Cuv3fHVfZ/bJBTr/nH6Nf993BFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mht+iUPf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mht+iUPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787061701; x=1818597701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//PmUf126ej0sjGBWB4w/eOZ2JO+QkS7LpA95oIVS5w=;
  b=mht+iUPfsHT04oG0OFohMorP498MGLVTcN46meQVDXzBnW4d4PmZ1Y//
   ZrInKwp3zEaTUcc86a6oD/lAWJXpC5Y+SgSEBchWvtzHMO4NnB2o+HNf4
   iv7SK/DcxdOqkBOpj7K6Rs6im/YP9d3Z29QWUi0J5Vf26EaDj0YPUSD/I
   9bHludwRdtJUOcNdF6s/UG/IqX3JavFu8iFmxYcer14DioOAqvyTF9Loc
   B8h2oCN0D8qVuSF9eiXn7ifqsTF1DPtp7oFHsAHAFK+lrIh4IjtTvLRjw
   DxejsLd8H7fhAPB0Km6Jm8CyyMYf7eTdTqKBUhWmjikzOcYU5pXnd4YcN
   A==;
X-CSE-ConnectionGUID: MRNbow4eRay/cRYGvtGbcw==
X-CSE-MsgGUID: pLXRNYjGT2OYRqVOSADrUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113096077"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="113096077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:01:35 -0700
X-CSE-ConnectionGUID: uast6XaVRDaYCv122mCl1Q==
X-CSE-MsgGUID: gXHY9txrT0CyCKWXLM7GiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="259040484"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:01:28 -0700
Date: Tue, 18 Aug 2026 17:01:26 +0300
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
Subject: Re: [PATCH v7 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <aoRltgy0AYZ_Vcum@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-4-2b0de0f20edf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-veml6031x00-v7-4-2b0de0f20edf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 01:34:29PM +0200, Javier Carrasco wrote:
> The device provides a shared interrupt line to notify events and
> data ready.
> 
> Add support for configurations with and without an interrupt line,
> providing events and trigger support when an interrupt line is available.

...

> +static int veml6031x00_write_period(struct iio_dev *iio, int val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	if (val < 0 || val > 8 || hweight8(val) != 1)
> +		return -EINVAL;
> +
> +	return regmap_field_write(data->rf.pers, ffs(val) - 1);

That ffs() was bothering me all these review rounds. Now I got the idea how to
improve

	if (val < 0 || val > 8 || !is_power_of_2(val))
		return -EINVAL;

	return regmap_field_write(data->rf.pers, ilog2(val));

> +}

...

> +static irqreturn_t veml6031x00_irq(int irq, void *private)
> +{
> +	struct iio_dev *iio = private;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	s64 timestamp;
> +	unsigned int regval;
> +	int ret;
> +	bool trigger_poll;
> +
> +	ret = pm_runtime_get_if_active(dev);
> +	if (ret <= 0)

< 0 seems too much to me. If there is disabled runtime PM (and supposedly
device is always on) this prevents from getting events.

> +		return IRQ_NONE;
> +
> +	scoped_guard(mutex, &data->irq_lock) {
> +		ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &regval);
> +		if (ret) {
> +			dev_dbg(dev, "Failed to read interrupt register %d\n", ret);
> +			pm_runtime_put(dev);
> +			return IRQ_NONE;
> +		}
> +
> +		if (!(regval & VEML6031X00_INT_MASK)) {
> +			pm_runtime_put(dev);
> +			return IRQ_NONE;
> +		}
> +
> +		timestamp = iio_get_time_ns(iio);

> +		if ((regval & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) &&
> +		    data->ev_en) {

With swapped operands it might be easier to follow.

		if (data->ev_en &&
		    (regval & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L))) {

> +			if (regval & VEML6031X00_INT_TH_H)
> +				iio_push_event(iio,
> +					       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +								    IIO_EV_TYPE_THRESH,
> +								    IIO_EV_DIR_RISING),
> +					       timestamp);
> +			if (regval & VEML6031X00_INT_TH_L)
> +				iio_push_event(iio,
> +					       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +								    IIO_EV_TYPE_THRESH,
> +								    IIO_EV_DIR_FALLING),
> +					       timestamp);
> +		}
> +
> +		trigger_poll = (regval & VEML6031X00_INT_DRDY) && data->trig_en;

Ditto.

> +	}
> +
> +	/*
> +	 * iio_trigger_poll_nested() must be called with irq_lock released:
> +	 * it runs trig_handler() synchronously in this thread, which calls
> +	 * reenable() on completion, and that callback also takes irq_lock.
> +	 * iio_pollfunc_store_time() is not called for our own trigger, so the
> +	 * timestamp is stored here.
> +	 */
> +	if (trigger_poll) {
> +		iio->pollfunc->timestamp = timestamp;
> +		iio_trigger_poll_nested(data->trig);
> +	}

> +	pm_runtime_put(dev);

With the above this needs to be conditional like

	if (pm_status > 0)
		pm_runtime_put(dev);

> +	return IRQ_HANDLED;
> +}

...

> +static int veml6031x00_hw_init(struct veml6031x00_data *data)
> +{
> +	struct regmap *map = data->regmap;
> +	struct device *dev = regmap_get_device(map);

> +	__le16 regval = 0;

Redundant assignment.

> +	int ret, val;

Why is 'val' signed?

> +	ret = regmap_bulk_write(map, VEML6031X00_REG_WL_L, &regval, sizeof(regval));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	regval = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(map, VEML6031X00_REG_WH_L, &regval, sizeof(regval));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> +
> +	ret = regmap_field_write(data->rf.int_en, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, VEML6031X00_REG_INT, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> +
> +	return 0;
> +}

...

> +static int veml6031x00_init_iiodev(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	iio->name = data->chip->name;
> +	iio->modes = INDIO_DIRECT_MODE;
> +
> +	if (!i2c->irq) {
> +		iio->channels = veml6031x00_channels;
> +		iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +		iio->info = &veml6031x00_info_no_irq;
> +
> +		return 0;
> +	}
> +
> +	iio->channels = veml6031x00_channels_irq;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels_irq);
> +	iio->info = &veml6031x00_info;
> +
> +	ret = veml6031x00_setup_irq(i2c, iio);
> +	if (ret)
> +		return ret;

> +	ret = devm_add_action_or_reset(dev, veml6031x00_disable_event_action, data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return devm_add_action_or_reset(...);

> +}

-- 
With Best Regards,
Andy Shevchenko


