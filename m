Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C47246781;
	Mon, 10 Aug 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375978; cv=none; b=WKR3T/YsxnnKlGG57R6yarnTs6HJJd+VYXlNVP09jpIM2m0AQZpJoiafLix5h6ZoXnSoiza6fijlWbi2tICjfk/kFA4Bwn/qJ9hlWF8Mb13mDyXdp3RqIMaYy6qyEaqiu+F1CDo4ESmdhQfpSLV2STyrkPKYvslpdcXi36Cj+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375978; c=relaxed/simple;
	bh=aaKOebfmXERWZlaDsbQsPJVY9s0zqI6/KIPC1laKuDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkMoVic9lWr6Nmyf1Z4GYwXKatW8cvaRCzDeBFWBBPcbJ/Ap7WvDSHUCXKEbJtZzU0VhFp1HpYA2g+Qj//4DJlHnNtliSvweoLRUakJ4YdnKDFivbCodVJUALp/TNzRifnzDQ1leb6lUTR5M3dGNH9hDXFmboPA3HttyLFa8uDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XD8l0AE2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XD8l0AE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786375977; x=1817911977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aaKOebfmXERWZlaDsbQsPJVY9s0zqI6/KIPC1laKuDA=;
  b=XD8l0AE2xyqcoC4gWBf8GAp8FoKC0znomzzTYak4hT81D7vmMhjgzq88
   kXLlUeum3WIpH/Rr+dzOWwDgVPqKTqfw/BZkpeqDoMg7cVeoi0nwoxtCf
   CXD482AGaHDaEjgZ8FsDlGR5qAzuc3pQG90pkydzK+qxm8FYGff9njW72
   iQY7A5ywhqV0Hv3rqZ9b4sdUSULEbImXt3hILSQdv8IM+0VGCJ00DYDIe
   Pxa8PW9FyJNinHq4VVk+1SFqwUKBEbjmatSjWOIfv+KUmA9vqoMs3e17p
   ei5ViutWX1lIgTREEuvftSb7ZvWFkfpHF018AX2VGudHT2os0DnXG9quv
   g==;
X-CSE-ConnectionGUID: LpVmovUKQhaaMwYhbDBIqw==
X-CSE-MsgGUID: 6sL4d+tTSXqYYH/wM0FX+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86652234"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86652234"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:32:57 -0700
X-CSE-ConnectionGUID: vmqD0HW2To+PGpMWNaJ5jQ==
X-CSE-MsgGUID: jE0DVeErQ/qWXNH2C7DOGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="268223932"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:32:53 -0700
Date: Mon, 10 Aug 2026 18:32:49 +0300
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
Subject: Re: [PATCH v5 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <annvIc7WLeWEDCAC@ashevche-desk.local>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-4-e60876fb3640@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807-veml6031x00-v5-4-e60876fb3640@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 03:51:55PM +0200, Javier Carrasco wrote:
> The device provides a shared interrupt line for to notify events and
> data ready, which can be used as a trigger. The interrupt line is not a
> requirement for the device to work. Implement variants for the cases
> whether the interrupt line is provided or not.

...

> +#define VEML6031X00_INT_MASK        (VEML6031X00_INT_TH_L | \
> +				     VEML6031X00_INT_TH_H | \
> +				     VEML6031X00_INT_DRDY)

Make it better style with

#define VEML6031X00_INT_MASK						     \
	(VEML6031X00_INT_TH_L | VEML6031X00_INT_TH_H | VEML6031X00_INT_DRDY)


(looking further in the code I kinda have a déjà vu that I said that already in
 the past).

...

> +	/*
> +	 * Serialize access to irq enable/disable by events and trigger
> +	 * (shared line)

Missing period.

> +	 */

...

> +static int veml6031x00_read_period(struct iio_dev *iio, int *val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, regval;

Why is regval signed?

> +	ret = regmap_field_read(data->rf.pers, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*val = 1 << regval;

BIT() ?

> +	return IIO_VAL_INT;
> +}

...

> +static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2, int dir)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	__le16 regval = cpu_to_le16(val);

There is no technical need to assign it here, especially if the below
validation won't pass, but it doesn't have any side effects, so I guess
it's fine.

> +	int ret;
> +
> +	if (val < 0 || val > U16_MAX || val2)
> +		return -EINVAL;
> +
> +	if (dir == IIO_EV_DIR_RISING) {
> +		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
> +					&regval, sizeof(regval));
> +		if (ret)
> +			dev_dbg(regmap_get_device(data->regmap),
> +				"Failed to set high threshold %d\n", ret);
> +	} else {
> +		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
> +					&regval, sizeof(regval));
> +		if (ret)
> +			dev_dbg(regmap_get_device(data->regmap),
> +				"Failed to set low threshold %d\n", ret);
> +	}
> +
> +	return ret;
> +}

...

> +static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
> +	__must_hold(&data->irq_lock)

The sparse annotations is fine, but lockdep one is even better.

> +{
> +	int ret;
> +
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

> +static irqreturn_t veml6031x00_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *iio = private;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	s64 timestamp;
> +	int regval, ret;

Why is regval signed?

> +	bool trigger_poll;
> +
> +	scoped_guard(mutex, &data->irq_lock) {
> +		ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &regval);
> +		if (ret) {
> +			dev_dbg(regmap_get_device(data->regmap),
> +				"Failed to read interrupt register %d\n", ret);
> +			return IRQ_NONE;
> +		}
> +
> +		if (!(regval & VEML6031X00_INT_MASK))
> +			return IRQ_NONE;
> +
> +		if ((regval & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) &&
> +		    data->ev_en) {
> +			timestamp = iio_get_time_ns(iio);
> +
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
> +	}
> +
> +	/*
> +	 * iio_trigger_poll_nested() must be called with irq_lock released:
> +	 * iio_trigger_poll_nested() runs trig_handler() synchronously in this
> +	 * thread, which calls reenable() on completion, and that callback also
> +	 * takes irq_lock.
> +	 */
> +	if (trigger_poll)
> +		iio_trigger_poll_nested(data->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(regmap_get_device(data->regmap),
> +					    "%s-drdy%d", iio->name, iio_device_id(iio));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &veml6031x00_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, iio);
> +
> +	ret = devm_iio_trigger_register(regmap_get_device(data->regmap), data->trig);
> +	if (ret)
> +		return ret;
> +
> +	iio->trig = iio_trigger_get(data->trig);
> +	ret = devm_request_threaded_irq(regmap_get_device(data->regmap),
> +					i2c->irq, NULL,
> +					veml6031x00_interrupt,
> +					IRQF_ONESHOT,
> +					iio->name, iio);
> +	if (ret)

> +		return dev_err_probe(regmap_get_device(data->regmap), ret,
> +				     "Failed to request irq %d\n",
> +				     i2c->irq);

This is a dup message. Remove it.

> +
>  	return 0;

	return devm_request_threaded_irq(...);

>  }

-- 
With Best Regards,
Andy Shevchenko


