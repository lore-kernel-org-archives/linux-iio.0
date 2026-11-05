Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899953;
	b=UobB1TPcgsw61awndPQt+Gym2mSlrQhZftNKSiLyJXqHle360o5VW/pd1sV44jH7VBki
	 i0/ISvdocJx92lLusBUQ8CQnLT6DW432L4n/Pc8kx9Q8Akt5+L2JgN+Yr80f6vuWC8H+G
	 cLdIYEQ/AtRDQ8HVpiH4ebwd3R+C12yv9iX5KRhMl8jU8wDQOsNdkcOdun2XGZC34F9WW
	 jE31IwsViJJTUlckFFOlra366npb67Mivz7WBk3lVkaaz542ekvb9Pmm8jiLiCDmdlNFQ
	 2mf2TE2RQiXgvOqi577gCo7j3B4YQEcydWmgcjsnl7kcP49Q0gjIDDPtd5xCtwI7CAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899953;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=Fw/TE8Xsp2zBtCiKWBPoOkAIZEd639KSPQ+dZpJxChE=;
	b=02t58A/8hdy439ml6Gm+yfZkDCtA43Rw2b4DcFkWSiFyjwyoB+XZ1TCHObLjtTReg1OA
	 4RGbonvKb5QhTP+2zErKgrxbAxEID+scwlhN93a8CMl84Iulmctama9kCR7hstbiXDJ4p
	 2aq7Y/eSqbSfGMbZZ8S6EYbxBdnP0maCNw3takqTdZ/39Sn5eve3nkIDdJCdtUMC/hISY
	 ubeAlXuTW/OfjOUIu4vyvkNCjfTspcMYs4pyQ52vaESmiSvaGExOgh1INEC6JqRw8OZMn
	 Qi65Wz0NKYBlCNEtFK5AmLtYoSvcyLwaJa9jylSOVu49jKZVe1RGiTodqt88p30WiJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1uXJ197;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00384606A32D;
	Thu,  5 Nov 2026 17:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00384606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1uXJ197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793899952; x=1825435952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kzqQSRJBlTTXdErRT8YlRUVaPuC8/FkNEumQJo077ZM=;
  b=K1uXJ1978rJO86GwWSPOh7CZBE8v6NanTcliBVHz7C/RWFyWEr4NYhZJ
   ynAYozhmoqH1woZlSA4UdbhlAwX92IJpgE7W+s98lNMd39WjeexQw3Wlm
   P2E+WcE9ehzxsviWLZViJIYj9LVK/GhBgxjpbiTqdCcC53bMNvMRFyesg
   wzoF/wsPr4Dp6bGC2SWprbkjX6gNkFLU1JhLgsxuOIvzZkBm2exmLYi7D
   +/PCYSgGx93vFOHlWbCmsqC0QVryr/E05Ax+MvJ3kt4xJaINRyhrMp/uo
   AcnvaGk51Htug/mnOMEKtXefzORsq5iXlZsyXyGMKpUIsovflkgLAT08b
   w==;
X-CSE-ConnectionGUID: DV/pPnqdTFqyWduYyWB/qQ==
X-CSE-MsgGUID: MvbztwtsSsitIKYEb+3fQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2736875"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2736875"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:32:31 -0800
X-CSE-ConnectionGUID: fCjY+B8bQ82fED1PGAqWSQ==
X-CSE-MsgGUID: rcQgfxUdRoOtTtEqb3gguQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6969100"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:32:27 -0800
Date: Thu, 5 Nov 2026 19:32:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v6 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <auy9qPZopjJjZ3ZB@ashevche-desk.local>
References: <20261105-topic-sm8x50-iio-max34417-adc-v6-0-63b4e8279633@linaro.org>
 <20261105-topic-sm8x50-iio-max34417-adc-v6-3-63b4e8279633@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105-topic-sm8x50-iio-max34417-adc-v6-3-63b4e8279633@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 01:42:48PM +0100, Neil Armstrong wrote:
> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power, accumulated average
> power and energy over an I2C/SMBUS serial interface.
> 
> The MAX34417 datasheet only specified on how to calculate the
> accumulated average power, but with the Sample Per Second rate
> we can easily get accumulated Energy in Joules.
> 
> By default the IIO driver only supports single-shot Voltage
> and Power sensing, but the accumulation can be enabled by
> enabling the Energy IIO channel which then enables the
> Continuous Accumulation Mode.
> 
> The counter is common to all channels, so when reading a single
> channel we will copy all accumulators to registers, so in order
> to permit reading individual channels we must accumulate the
> other channels in the driver when Continuous Accumulation Mode
> is enabled.

I have a few nit-picks, mostly about the style. The only two seems more
important, actually the very first two (_uOhm suffix and use of a bitmap).

...

> +#define MAX34417_MIN_RSENSE		(1 * MILLI) /* 1000 microOhm */
> +#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100000 microOhm */
> +#define MAX34417_DEFAULT_RSENSE		(1 * MILLI) /* 1000 microOhm */

Why not adding a unit suffix _uOhm and drop the comments?

Moreover the burden of a typo is now in the comments and in such a case may
confuse the reader.

...

> +struct max34417_data {
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
> +	const char *input_label[MAX34417_CHANNEL_COUNT];
> +	s64 acc_power[MAX34417_CHANNEL_COUNT];
> +	s64 acc_count[MAX34417_CHANNEL_COUNT];

> +	bool overflow[MAX34417_CHANNEL_COUNT];

Why not a bitmap?

	DECLARE_BITMAP(overflow, MAX34417_CHANNEL_COUNT);

> +	ktime_t last_update;
> +	bool cam_mode;
> +};

...

> +static int max34417_check_ovf(struct max34417_data *max34417)
> +{
> +	struct regmap *map = max34417->regmap;
> +	u32 control;
> +	int rc;
> +
> +	rc = regmap_read(map, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	if (!(control & MAX34417_CONTROL_OVF))
> +		return 0;

> +	rc = regmap_clear_bits(map, MAX34417_CONTROL_REG,
> +			       MAX34417_CONTROL_OVF);

It's precisely a single line

> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	/* Save the timestamp for the next read */
> +	max34417->last_update = ktime_get();
> +
> +	return 0;
> +}

...

> +{
> +	s64 delta_us = ktime_us_delta(ktime_get(), max34417->last_update);

It's better to split the assignment of the variable (that's going to be
validated) from maintenance p.o.v.

> +	struct regmap *map = max34417->regmap;
> +	u8 buf[MAX34417_VOLTAGE_READ_LENGTH];
> +	int rc;
> +
> +	/* Sleep up to 1msec to make sure we have a measurement cycle done */
> +	if (delta_us >= 0 && delta_us < (1 * USEC_PER_MSEC))
> +		fsleep((1 * USEC_PER_MSEC) - delta_us);

	struct regmap *map = max34417->regmap;
	u8 buf[MAX34417_VOLTAGE_READ_LENGTH];
	s64 delta_us;
	int rc;

	/* Sleep up to 1msec to make sure we have a measurement cycle done */
	delta_us = ktime_us_delta(ktime_get(), max34417->last_update);
	if (delta_us >= 0 && delta_us < (1 * USEC_PER_MSEC))
		fsleep((1 * USEC_PER_MSEC) - delta_us);

> +	/*
> +	 * When not in CAM mode, we use the default mode where each
> +	 * UPDATE command will move the current accumulated data to the
> +	 * SMbus registers, reset those accumulators and run a new
> +	 * measurement cycle.
> +	 */
> +	if (!max34417->cam_mode) {
> +		/* Reset the accumulators and perform a measurement cycle */
> +		rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +		/*
> +		 * UPDATE commands should be no less than 1msec apart for reliable
> +		 * measurements, since in Manual mode the SPS is 1kHz, we need wait
> +		 * for the measurement to finish before moving the data in the SMbus
> +		 * registers.
> +		 */

This comment goes up to 85 characters...

> +		fsleep(1 * USEC_PER_MSEC);
> +	}
> +
> +	/*
> +	 * Move the new UPDATE data into the SMBus read registers.
> +	 * This will also reset the accumulators, returning the
> +	 * power accumulated since the last UPDATE.
> +	 */

...and this one only up to 67. Can you bring some consistency to that?
Same comment to other similar cases all over the code.

> +	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	/* Save the timestamp for the next read */
> +	max34417->last_update = ktime_get();
> +
> +	if (max34417->cam_mode) {

> +

Redundant blank line.

> +		/* Retrieve all channels to avoid missing data for other channels */
> +		rc = max34417_save_accumulators(max34417);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = regmap_noinc_read(map, chan->address, &buf, sizeof(buf));
> +	if (rc)
> +		return rc;
> +
> +	/* Ignore first byte which contains the Byte Count & data starts at Bit 2 */
> +	*val = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]) >> 2;
> +
> +	return IIO_VAL_INT;
> +}

...

> +static int max34417_read_energy(struct max34417_data *max34417,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2)
> +{
> +	struct regmap *map = max34417->regmap;
> +	s64 delta_us = ktime_us_delta(ktime_get(), max34417->last_update);

Split the assignment.

> +	s64 acc_power;
> +	int rc;
> +
> +	/* Sleep up to 1msec to make sure we have a measurement cycle done */
> +	if (delta_us >= 0 && delta_us < (1 * USEC_PER_MSEC))
> +		fsleep((1 * USEC_PER_MSEC) - delta_us);
> +
> +	/* Move the data to the SMBus registers */
> +	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	/* Save the timestamp for the next read */
> +	max34417->last_update = ktime_get();
> +
> +	/* Retrieve all channels to avoid missing data for other channels */
> +	rc = max34417_save_accumulators(max34417);
> +	if (rc)
> +		return rc;
> +
> +	if (max34417->overflow[chan->channel]) {
> +		max34417->overflow[chan->channel] = false;
> +		max34417->acc_power[chan->channel] = 0;
> +		max34417->acc_count[chan->channel] = 0;
> +		return -EOVERFLOW;
> +	}
> +
> +	/* Get current channel power and reset them */
> +	acc_power = max34417->acc_power[chan->channel];
> +	max34417->acc_power[chan->channel] = 0;
> +	max34417->acc_count[chan->channel] = 0;
> +
> +	iio_val_s64_decompose(acc_power, val, val2);
> +
> +	return IIO_VAL_INT_64;
> +}

...

> +static int max34417_probe_channel_node(struct device *dev,
> +				       struct max34417_data *max34417,
> +				       struct fwnode_handle *node)
> +{
> +	u32 rsense_uOhm, index;
> +	int rc;
> +
> +	rc = fwnode_property_read_u32(node, "reg", &index);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
> +				     node);
> +
> +	if (index >= MAX34417_CHANNEL_COUNT)
> +		return dev_err_probe(dev, -ECHRNG, "invalid reg %d of %pfwP\n",
> +				     index, node);

> +	if (fwnode_property_present(node, "label")) {
> +		rc = fwnode_property_read_string(node, "label",
> +						 &max34417->input_label[index]);
> +		if (rc)
> +			return dev_err_probe(dev, rc,
> +					     "failure reading label property of %pfwP\n",
> +					     node);
> +	}

Can be

	const char *propname;
	...
	propname = "label";
	...
	propname = "shunt-resistor-micro-ohms";

> +	if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
> +		rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +					      &rsense_uOhm);
> +		if (rc)
> +			return dev_err_probe(dev, rc,
> +					     "failure reading shunt property of %pfwP\n",

...and here you can refer to it in full using %s.

> +					     node);
> +
> +		if (rsense_uOhm < MAX34417_MIN_RSENSE ||
> +		    rsense_uOhm > MAX34417_MAX_RSENSE)
> +			return dev_err_probe(dev, -EINVAL,

-ERANGE?

> +					     "invalid shunt value %d of %pfwP\n",

Same here — use %s and propname.

> +					     rsense_uOhm, node);
> +
> +		max34417->input_correction[index] =
> +			max34417_calc_input_correction(rsense_uOhm);
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


