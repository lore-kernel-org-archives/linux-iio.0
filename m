Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7333B42D7;
	Mon, 17 Aug 2026 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950740; cv=none; b=NM0WMtmldXVH+2mP+9lkxOsOfM6oVjC6PdmzRd+9eCoP0iGqy3HoLbGQFYVnlejuaVDYLLL424joJDtf0WYDhLbJjDvwEDUdaCWAhgJk58aYEc21U3tNB6cEUku8ctPfR2e0xP5KzlrgQWgC96a/pMqKzCNp6+prNF3XnJb+CLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950740; c=relaxed/simple;
	bh=aBZ1EFUyFJ6GTj4WNko3xlWYc+8GP2Kd+tMsF69ipKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckrbgC+inzbMe8Os2ImusG8Xe4y5qKBbeqyW3dj26Aci1FyUBwb3NTT9pSmgaFISxvpgECTnQaQvUZfYpJRmfHNUmTfYMu7WaITdC6MUzIfRUrpvHjG3Xn1FgUNtegJ9MRVu3PsWPa6G+dJhUQvlEoYLC0RCQsdTtNc/iebrpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixUV/d2x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixUV/d2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786950738; x=1818486738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aBZ1EFUyFJ6GTj4WNko3xlWYc+8GP2Kd+tMsF69ipKA=;
  b=ixUV/d2xgnfD/7ageDo8P/8aUUVLUHWfD5fEnQ7LCn0qPunf8XpzyXk4
   V1BlzWs0c+PrdUG7rtBPCmOL8eW7rU+HHpR0HcbJczZN96UM8Eyfd9wIb
   OY09Rsm/rjgFZQsJ0lwFGBQrv0i/F9rG4N32hKHeS3FVd1Y6ThfvUSl5G
   DPdcZL8QpchFKvmruSI/Ct5bS3fqqYIyZ1TqNgSPVtIwant1p/chS2lFz
   3oUuGzfZ9MEYKNOu9jA7E9lN+/lueYdX0Q+Xy8ubKIIhbQDoOUhNLSPtL
   wIv14ePdJaCbHQWKqLYypAS+OwcgMCO0PqZ0v1jwB0z3uU23BVaHRePFC
   A==;
X-CSE-ConnectionGUID: R+HlkNg/QCqYeMxYLwfsrw==
X-CSE-MsgGUID: f35SOh17Q1aLnLbX3z/99g==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91234126"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91234126"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:12:17 -0700
X-CSE-ConnectionGUID: 9EyRyIBdQNiyuCo+CL3vBg==
X-CSE-MsgGUID: eYxy3WEGRLKpHa/dML7pgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="294754512"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:12:15 -0700
Date: Mon, 17 Aug 2026 10:12:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <aoK0TKBFZOM6A-c9@ashevche-desk.local>
References: <20260813-ti-ads112c04-driver-v5-0-79dff9e249cd@gmail.com>
 <20260813-ti-ads112c04-driver-v5-2-79dff9e249cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ti-ads112c04-driver-v5-2-79dff9e249cd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 11:06:03AM +0800, Kyle Hsieh wrote:
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

...

> +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> +{
> +	int ret, err;
> +	u8 val;
> +
> +	if (st->client->irq > 0) {
> +		/* Timeout is 100ms (slowest data rate is 20 SPS) */
> +		if (!wait_for_completion_timeout(&st->completion, msecs_to_jiffies(100)))
> +			return -ETIMEDOUT;
> +
> +		return 0;
> +	}
> +
> +	ret = read_poll_timeout(ads112c04_read_reg, err,
> +				(err < 0 || (val & ADS112C04_CONF2_DRDY)),

Better to split logically, also the outer parentheses are redundant.

	ret = read_poll_timeout(ads112c04_read_reg,
				err, err < 0 || (val & ADS112C04_CONF2_DRDY),

> +				1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC, false,
> +				st->client, ADS112C04_REG_CONFIG2, &val);
> +	if (err < 0)
> +		return err;
> +
> +	return ret;
> +}

...

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (st->vref_source[idx]) {
> +		case ADS112C04_VREF_SOURCE_EXTERNAL:
> +			*val = st->ext_ref_mV;
> +			break;
> +		case ADS112C04_VREF_SOURCE_AVDD:
> +			*val = st->avdd_mV;
> +			break;
> +		default:
> +			*val = ADS112C04_INT_REF_mV;
> +			break;
> +		}
> +		*val2 = 15;

Seems like this being used in one of the above functions already. Perhaps you
want a defined constant? (I haven't checked if that 15 and this one are
semantically related, though.)

> +		return IIO_VAL_FRACTIONAL_LOG2;

...

With

	const char *sp = "single-channel", *dp = "diff-channels";

The below...

> +		if (fwnode_property_present(child, "single-channel")) {
> +			ret = fwnode_property_read_u32(child, "single-channel", &channel);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read single-channel property\n");
> +
> +			if (channel > 3)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "single-channel must be 0-3\n");
> +
> +			spec->channel = channel;
> +			spec->address = ADS112C04_CONF0_MUX_AIN_SINGLE_BASE + channel;
> +		} else if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child, "diff-channels",
> +							     pair, ARRAY_SIZE(pair));

+ array_size.h

> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read diff-channels property\n");
> +
> +			if (pair[0] > 3 || pair[1] > 3)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "diff-channels must be 0-3\n");
> +
> +			spec->channel = pair[0];
> +			spec->channel2 = pair[1];
> +			spec->differential = 1;
> +
> +			if (ads112c04_diff_mux[pair[0]][pair[1]] < 0)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid diff-channels combination\n");
> +
> +			spec->address = ads112c04_diff_mux[pair[0]][pair[1]];
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel node must have single-channel or diff-channels\n");
> +		}

...can be written as

		if (fwnode_property_present(child, sp)) {
			ret = fwnode_property_read_u32(child, sp, &channel);
			if (ret)
				return dev_err_probe(dev, ret, "failed to read %s property\n", sp);

			if (channel > 3)
				return dev_err_probe(dev, -EINVAL, "%s must be 0-3\n", sp);

			spec->channel = channel;
			spec->address = ADS112C04_CONF0_MUX_AIN_SINGLE_BASE + channel;
		} else if (fwnode_property_present(child, dp)) {
			ret = fwnode_property_read_u32_array(child, dp, pair, ARRAY_SIZE(pair));
			if (ret)
				return dev_err_probe(dev, ret, "failed to read %s property\n", dp);

			if (pair[0] > 3 || pair[1] > 3)
				return dev_err_probe(dev, -EINVAL, "%s must be 0-3\n", dp);

			spec->channel = pair[0];
			spec->channel2 = pair[1];
			spec->differential = 1;

			if (ads112c04_diff_mux[pair[0]][pair[1]] < 0)
				return dev_err_probe(dev, -EINVAL, "invalid %s combination\n", dp);

			spec->address = ads112c04_diff_mux[pair[0]][pair[1]];
		} else {
			return dev_err_probe(dev, -EINVAL,
					     "channel node must have %s or %s\n", sp, dp);
		}

(but it also makes sense to check with bloat-o-meter to see how much code is
 added and how much data space is saved).

...

> +	/* Datasheet: POR releases ~500us after supplies are stable */
> +	fsleep(500);
> +
> +	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset), "failed to get reset\n");
> +
> +	if (reset) {
> +		ret = reset_control_reset(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to reset device\n");
> +	} else {
> +		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> +		if (ret < 0)
> +			return ret;
> +	}

Also a comment here?

> +	fsleep(1 * USEC_PER_MSEC);

-- 
With Best Regards,
Andy Shevchenko


