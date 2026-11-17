Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908597;
	b=3DkSOI3bj8tJMfOlQx/L3IJzdAvX8XklepdZC9B6DEksAGV28TELYTafeMB24O31WCui
	 FTBsHzHu9K0WGqeaFnCQpoyGkvqJ80TQUyLTbqrLfHYzWrpIW8f/cfJb1yo1Yre4F+p+X
	 sjSLn16O1nylaLVtXG55Jth4Rr7rUYxksSWfBQikifAoNofPbCMtBuJT9ApA1mvsW5eEz
	 BcJ1hBbG36drxUibuZP9Nbs/y6vb1fKq1WCud8S8g1U1q5pk3SFZdbmVYYRP+iz0WHhZA
	 7RZp8FZYCt4atEECYhqrtAWECfFLAz63B7iiWJm9C0IIi8wQyyz0IbofULMV6Xhj/wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908597;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1JFZCHrxuZbSUWndPTw9K3y86Gq6Tb/RKCBBhoAAS0M=;
	b=b055v1DoXR1ToFZ/XIcmWHREVAZXw5OXZdMtbR8hYBkcHDUG1TnNZvMQ9RbScjQ0XQ97
	 RAaV4Lsa3d1+LHqxVXb1z76OEgWs5n5Uh15vbJrR1R+GYA5gZ7AQfSr76NgKWRxJGMjLU
	 QSfOky53qa3vg9blocgivO6cc6BYLy3eK0P93LrgIu6he4waF8ZRbAYllFo/UG6vKs6LG
	 tsHzbecG3EKrrvqt25WUjxF+e8pZdTFVRaeJnPOrfe1NIyGEvjpzdwro87W4Hn9aAJvGd
	 3vYaZY1lX4nK/U2Plo5K/a5rSFfjaZB/sGoRzwhjfd7eb2MfOG2YL4+a9tJAW+ehAWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PUg8uSDm;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09991606A31C;
	Tue, 17 Nov 2026 09:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09991606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PUg8uSDm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794908598; x=1826444598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GI53b4sXCSiU9qDVUDU1ic+ORGhD0l/yLB4uV7dWQk=;
  b=PUg8uSDmb4ajJ6QsnmmnkrbAJsv5FfSFxkHDpfwhAO+pm2XkgFA6hBrN
   e037FAI/ETNLZ73TpnuX708UuzEb25KhRM3Sfh1LyZ3/dpuUL2Y24RTTW
   9uwLkD/zXGWoNKG2qcXy4dynKytIrjkMebupz3IV6/689RoL5GZZzo4sl
   tn9nP0f/5grugP1vAIw/02f6ywEAmBAW+/S69IqY4YjbhCTx2wtdZl2iZ
   PMO0wOp0ynD3g4oF1BIxMeMwpO6eAS5nO0kKx7hkXBL4gS9/3YZM0x5gb
   FIxTmekX75wjHWZQ8Fvi5Tp+Hgsf4nMtnK3WWMlbAF6UtC+eCYgl9Cnyh
   w==;
X-CSE-ConnectionGUID: c9kawMAzTeOXsvQh1yvEyg==
X-CSE-MsgGUID: Stg4fDpWSBmYPQrxSrIMeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3709672"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3709672"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:43:17 -0800
X-CSE-ConnectionGUID: YkQDCuzQSRy3DqkoiJVpUA==
X-CSE-MsgGUID: +4chQQiAQuG/Z452xZTgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10013561"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:43:13 -0800
Date: Tue, 17 Nov 2026 11:43:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, chernyakin.victor.j@outlook.com,
	cwweng@nuvoton.com
Subject: Re: [PATCH v5 3/3] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <avwhriewntd6_F8u@ashevche-desk.local>
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
 <20261117082832.1551574-4-cwweng.linux@gmail.com>
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
In-Reply-To: <20261117082832.1551574-4-cwweng.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:28:32PM +0800, Chi-Wen Weng wrote:
> 
> Add an IIO driver for the Enhanced Analog-to-Digital Converter found on
> Nuvoton MA35D1 SoCs.
> 
> Support single-ended and fixed differential inputs, direct conversion,
> and triggered buffered capture. This initial implementation uses sample
> module 0 and therefore supports one active voltage channel per buffered
> scan.

...

> +static int ma35d1_adc_read_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	u16 raw;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		guard(mutex)(&adc->lock);
> +
> +		if (adc->suspended)
> +			return -EBUSY;
> +
> +		ret = ma35d1_adc_read_conversion(adc, chan, &raw);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->differential)
> +			*val = sign_extend32(raw, MA35D1_EADC_RESOLUTION - 1);
> +		else
> +			*val = raw;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = adc->vref_mV;
> +		/* Differential mode has a VREF / 2048 LSB; single-ended uses /4096. */
> +		*val2 = chan->differential ? MA35D1_EADC_DIFF_SCALE_BITS : MA35D1_EADC_RESOLUTION;

+ blank line as it's done elsewhere.

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ma35d1_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				       const unsigned long *scan_mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	const struct iio_chan_spec *scan_chan = NULL;
> +	int bit;
> +
> +	if (!iio_validate_scan_mask_onehot(indio_dev, scan_mask))
> +		return -EINVAL;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		const struct iio_chan_spec *chan = &indio_dev->channels[bit];
> +
> +		if (chan->type != IIO_VOLTAGE)
> +			return -EINVAL;
> +
> +		scan_chan = chan;
> +		break;
> +	}
> +
> +	if (!scan_chan)
> +		return -EINVAL;

> +	adc->scan_chan = scan_chan;

So, this is only valid when scan_chan is not NULL, and this is the only case
inside the loop, hence temporary 'scan_chan' variable is not required at all.

	iio_for_each_active_channel(indio_dev, bit) {
		const struct iio_chan_spec *chan = &indio_dev->channels[bit];

		if (chan->type != IIO_VOLTAGE)
			return -EINVAL;

		adc->scan_chan = chan;

		return 0;
	}

	return -EINVAL;

> +	return 0;
> +}

...

> +static void ma35d1_adc_trigger_capture(struct iio_poll_func *pf)
> +{
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	struct {
> +		u16 channel;
> +		aligned_s64 timestamp;
> +	} scan = { };
> +	int ret;
> +
> +	guard(mutex)(&adc->lock);
> +
> +	if (adc->suspended || !adc->scan_chan)
> +		return;
> +
> +	ret = ma35d1_adc_read_conversion(adc, adc->scan_chan,
> +					 &scan.channel);

This fits a single line.

> +	if (ret)
> +		return;
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> +}

...

> +static int ma35d1_adc_parse_single_channel(struct device *dev,
> +					   struct fwnode_handle *child,
> +					   struct iio_chan_spec *chan,
> +					   unsigned long *used_single_inputs,
> +					   bool has_single, u32 reg,
> +					   unsigned int scan_index)
> +{

	const char *propname = "single-channel";

> +	u32 input = reg;
> +	int ret;
> +
> +	if (has_single) {
> +		ret = fwnode_property_read_u32(child, "single-channel", &input);

		ret = fwnode_property_read_u32(child, propname, &input);

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "invalid single-channel for index %u\n",
> +					     reg);

			return dev_err_probe(dev, ret, "invalid %s for index %u\n",
					     propname, reg);

Similar approach can be used for differential channel parser.

Or even supply that as a parameter, so you will have defined that only once
in _parse_channels().

> +	}
> +
> +	if (input >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +		return dev_err_probe(dev, -ECHRNG, "invalid ADC input %u\n", input);
> +
> +	if (test_and_set_bit(input, used_single_inputs))
> +		return dev_err_probe(dev, -EEXIST, "duplicate ADC input %u\n", input);
> +
> +	*chan = (struct iio_chan_spec) {
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = input,
> +		.address = reg,
> +		.scan_index = scan_index,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_type = {
> +			.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
> +			.realbits = MA35D1_EADC_RESOLUTION,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	};
> +
> +	return 0;
> +}

...

> +static int ma35d1_adc_init_vref(struct ma35d1_adc *adc, struct device *dev)
> +{
> +	int ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret == -ENODEV) {
> +		adc->vref_mV = MA35D1_EADC_INTERNAL_VREF_mV;
> +	} else if (ret < 0) {
> +		return dev_err_probe(dev, ret, "failed to get VREF supply\n");
> +	} else if (ret > 0) {
> +		adc->external_vref = true;
> +		adc->vref_mV = ret / (MICRO / MILLI);
> +	} else {
> +		return dev_err_probe(dev, -EINVAL, "invalid VREF voltage\n");

What to do, if ret is < 1000 and > 0 and the above will simply make vref_mV == 0?
Wouldn't the same constraint be applied and respective error message issued?

> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


