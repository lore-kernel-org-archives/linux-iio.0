Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329304;
	b=srvyF96+JGvwyZ1Jv7/WUTQMREgGgx2hePFs+QI6CwpZDhB59nGK0V/UfjMp4sWew+7c
	 UN0vf9s6tGpKLN+Pyle1PPprmDEggAeFTgTKFikDOvJfa+6QkgyShz+9+00d0hEiwSifz
	 HY+e1PCLj+PfIo1smZT/CL4zEj/DK3+ZaW4mWaS+43UiaigCG6d4e/8Jli+2Ang88PVgJ
	 3oTHQH66TVB3mK/ij7fXATyvgtlYN+LY1GvfN71yIO33P4AWXuzNyJy7w48O2qcdjiBcm
	 91EZlj9ZjZvep0UeokFnrSOoXdP1EZTY5VMXWVB7dpVlrrfiAbmC189f1/vhdkB3Psw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329304;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2iT2z9deD3v2LTiCM0NOycxK+0oeR8FJkn/kz5VClR8=;
	b=sEpddUezBuhqA18TN1NKyyzaO4j2f9rbRaY0D5pOqwpmWh1e9X4LdKtjPae1KBMsKX/y
	 FxTH/0Z1xPJFtUIjNhbULs/ClG/g5XWkY/6wV3pZicQC16hu1dPa31djRr2zBeeL16jeI
	 M6wTDrm0W893SgbrlwEXeyBpogQJ9chrJhxRhUrFDtIX119Re2Xxcz1iacdl0iqs08QaY
	 ikVGZvOlXvRlmx2q4uvDCOh/x8cs84UG/caUZTLSgoiDitJXO+Xz4QV4dqlqKdbQeFb/I
	 Fzqf8d+PQtJoQHu74DDuLCZvMH3ZHI4XK0U/Uvw5Hh3WdM7Of++ZTgcktQ9u1lBayRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aH9t1QJu;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD7606A330;
	Tue, 10 Nov 2026 16:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFD7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aH9t1QJu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794329302; x=1825865302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4UdVx86IM4K7U+2Y3fruIEQKmiuo2wLg8MXLMOMdCQ=;
  b=aH9t1QJu53zPlhACTqQU1X/omwi6eSehZf1qlxxE0GTZKWeKOF6JSUa8
   2EkE9HLfDV2iGiHGKpGQsRKh4fJL4rHz6GzbWdwi2ShuYKMJgsVilmKET
   BHOIYUofAb3gMSig3P2sTAHznB+PVY9Rg1vUHUIAPjhIh21813cWaDkdB
   Xz+eGodtO0Pw4IzlXI0D1MXLe30xk6zf9JD6dJ9apqCLAZKduJROVUAYl
   27tN7Kdo0euy+JiW/DfDFMRQZo6MpI+FfBVoeY43VNs2egBkHzkG/+qd6
   cB7eShQskUN+wUpQZTXbteMLc6LNo7E6T/nBZyHXiQl+kDcWoOaqmKxfw
   g==;
X-CSE-ConnectionGUID: wRDzD+m9T92TpxZuHaXKTQ==
X-CSE-MsgGUID: v2BlIVsCQpGcrJOuYEjTBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3083388"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3083388"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:48:22 -0800
X-CSE-ConnectionGUID: KjvyDt4+TQOaqKPGq7kkmg==
X-CSE-MsgGUID: kfbUK6o9TzGt6oYNNEFwlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8298130"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:48:19 -0800
Date: Tue, 10 Nov 2026 18:48:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/2] iio: pressure: dps310: add a data-ready trigger
Message-ID: <avNK0EldiZVxrhE8@ashevche-desk.local>
References: <20261110154254.39092-1-zoone.rupert@gmail.com>
 <20261110154254.39092-3-zoone.rupert@gmail.com>
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
In-Reply-To: <20261110154254.39092-3-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 05:42:54PM +0200, Rupesh Majhi wrote:
> With an interrupt wired to SDO, the chip can signal each new pressure
> result. Expose it as a trigger, so captures follow the measurements and
> scans carry the time the result was ready, not when the handler ran.
> 
> Polarity follows the interrupt type. Status latches while the interrupt
> is disabled, so it is cleared before enabling. The trigger is not the
> default, so FIFO mode without a trigger is unchanged.

...

> +static int dps310_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct dps310_data *data = iio_trigger_get_drvdata(trig);

	struct regmap *map = data->regmap;

> +	unsigned int status;
> +	int rc;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/* Status latched while disabled would fire a stale interrupt */
> +	if (state) {
> +		rc = regmap_read(data->regmap, DPS310_INT_STS, &status);

(as per below)

> +		if (rc)
> +			return rc;
> +	}
> +
> +	return regmap_assign_bits(data->regmap, DPS310_CFG_REG, DPS310_INT_PRS,
> +				  state);

	return regmap_assign_bits(map, DPS310_CFG_REG, DPS310_INT_PRS, state);

> +}

...

> +static int dps310_trigger_probe(struct dps310_data *data)
> +{
> +	struct device *dev = &data->client->dev;

	struct regmap *map = data->regmap;

> +	struct iio_dev *iio = data->iio;
> +	int irq = data->client->irq;
> +	bool active_high;
> +	int rc;
> +
> +	switch (irq_get_trigger_type(irq)) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +	case IRQ_TYPE_EDGE_RISING:
> +		active_high = true;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +	case IRQ_TYPE_EDGE_FALLING:
> +		active_high = false;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Unsupported interrupt type\n");
> +	}

> +	rc = regmap_assign_bits(data->regmap, DPS310_CFG_REG, DPS310_INT_HL,
> +				active_high);

	rc = regmap_assign_bits(map, DPS310_CFG_REG, DPS310_INT_HL, active_high);

> +	if (rc)
> +		return rc;
> +
> +	data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", iio->name,
> +					    iio_device_id(iio));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &dps310_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, data);
> +
> +	rc = devm_request_threaded_irq(dev, irq, dps310_irq_handler,
> +				       dps310_irq_thread, IRQF_ONESHOT,
> +				       iio->name, data);
> +	if (rc)
> +		return rc;
> +
> +	return devm_iio_trigger_register(dev, data->trig);
> +}

-- 
With Best Regards,
Andy Shevchenko


