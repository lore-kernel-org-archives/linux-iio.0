Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801562;
	b=pk57GCkcHUAqxB8UrhJfL4aNLusJzV0IO+8i4n9StGenLEZHrjIM3Y5lYykl/adVz9rj
	 Qne294DQzCjNRvsNJWEpEzaXJGlhYUz+Na9qgu3SMTy7vrx8YGou/heQCx2x+HjV3c7vB
	 YiBi2ULzdHewX2KFmM289TRPVUlCpw5NN/JWHb3V+Vjne/CfaFzF7m/EVtSuuKjILV3bz
	 UfIiltHRb3pwm3iebUAppmNqxg+T8FKn5S87q1GY81e/ezFRamXo4B9vV/ZXGp7BRRiCk
	 GYIKPnm57owkwEee9GO4w2qVZXCSS1HghTEU/nYsEkS0LOyU3cpbZKC1CpBl+W7sRRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801562;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=d/GgeOdCbcrNVlzorAk5pxyI7Ij7/TVcaBTiw8cnyKM=;
	b=OVGBH8Mt8z46cmvLpZ4s/wJWAPlht7q5KFpCRD5Trs3g4P/1CkNJ7VG6PLdOIjzw/oqi
	 nJk6E8lCVbYi0bjTQoCnqvL86+V4VY3KeQdm0fMGxjli1d2M2JIGbyu4edHvy69g3eQEy
	 zqXO9y8rn7M8pOQtgGFgRhjsZWyQhJMKwBZMulxDxmf900xcVQdtvSzAB6rRI+/x0+Szb
	 3I1BP3XilSnlkVhGa8NHVuopwwm/QbKJeEWgioNKws/2CSp62ycITerV3lZ5v9QfTAKW9
	 rvThPZXYL4yBo1jOZUE3pjVxgWGZsJp3xqnjDpu7qNcNvjTb6pbElTBweF1ynHV9iMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mGvT1tj/";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5745606A31C;
	Fri, 27 Nov 2026 17:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5745606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mGvT1tj/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795801562; x=1827337562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUEhHrxBMdLiKaJMKA34DLvan8tVLz2P6jEs36FCaFQ=;
  b=mGvT1tj/Mb3s5WQxtYw6lRPc08irK1tFiwojCWDwZApN/VkhSdmqjTGm
   eaBiusCBlYkHEgwvp6t7YYkfr0kohxIgjv6SMVWk921k+kM6SSOUJgg5M
   VPXuutBr1J75fC59pZRnwspJ0KvZc66sJbpCA9EAxRqTvzqqbrCbZqMPK
   wmX0JzKNTakCl2npJNJX3zUpu3o4/IZuqU2g1ovtdNLPb0vkfyD4QMAg+
   vsc+JnG0HqTxiYDJunuQLZVR4WV1y5kG0Cd2ZE+Sle2eKaJKuL7mCn7Th
   WPJjjvuYDtAxnhQ16CYX0IgBiEK8Pcq7+8kVbQxN9jkrvj1tlIRsNWw/h
   Q==;
X-CSE-ConnectionGUID: cty7vD93Tv2VMtu+wE8FNw==
X-CSE-MsgGUID: vNsyj7c7ToyAWn+d+0brOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4683241"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4683241"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 09:46:01 -0800
X-CSE-ConnectionGUID: d7PIIf74SC6nfbHXoWmgcA==
X-CSE-MsgGUID: TQShYT8qQEaUewshswitkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12354314"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 09:45:58 -0800
Date: Fri, 27 Nov 2026 19:45:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: robertijtsma@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient
 light sensor driver
Message-ID: <awnB1KT-oJQoPjOM@ashevche-desk.local>
References: <20261127-iio-tcs3430-v3-0-e191a40a4ae9@gmail.com>
 <20261127-iio-tcs3430-v3-2-e191a40a4ae9@gmail.com>
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
In-Reply-To: <20261127-iio-tcs3430-v3-2-e191a40a4ae9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 09:12:50AM +0100, Robert Ijtsma via B4 Relay wrote:
> 
> Add an IIO driver for the ams OSRAM TCS3430 ambient light and CIE 1931
> XYZ tristimulus color sensor (found at I2C address 0x39 on devices such
> as the Microsoft Surface Pro X).
> 
> Unlike the older TAOS RGBC drivers (tcs3414, tcs3472) that use the 0x80
> COMMAND-bit SMBus protocol and RGBC channels, and unlike the banked
> MAZeT/JENCOLOR as73211 driver, the TCS3430 uses ams's direct-addressed
> 0x80..0xdd register map and exposes Z, Y, IR1, and X tristimulus channels.
> 
> The driver exposes:
> - Illuminance (photopic Y channel) with raw counts and lux scale
> - Modified intensity channels for X, Y, Z, and IR1
> - Selectable scale and integration time via the IIO GTS helper across
>   1x/4x/16x/64x/128x gain and 50.04/100.08/200.16/400.32 ms integration
>   time settings
> - Regulator management and system sleep suspend/resume support
> 
> Tested on Microsoft Surface Pro X SQ2 (SC8180X).


There are a couple of nit-picks below, but overall LGTM, after addressing them
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +config TCS3430
> +	tristate "ams OSRAM TCS3430 ambient light and CIE 1931 XYZ sensor"

This doesn't scale, but okay, I don't expect this kind of compatible devices
appear in a volume, we may rephrase this later on.

> +	depends on I2C
> +	select IIO_GTS_HELPER
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the ams OSRAM TCS3430
> +	  ambient light and CIE 1931 XYZ tristimulus color sensor.

Usually when it starts with more that a single vendor line of the devices
the list of them is better as it's easier to tweak later on:

	  If you say yes here you get support for the following sensors:
	  - ams OSRAM TCS3430 ambient light
	  - CIE 1931 XYZ tristimulus color

(feel free to amend this example). But if you go to do that, change the
above text to something like

	tristate "ams OSRAM TCS3430 ambient light and compatible sensors"

(and sync with other places),

TL;DR: Change if you wish, but I'm okay with the proposed texts for now.

> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tcs3430.

...

> +static int tcs3430_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tcs3430_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int dev_id;
> +	int ret;

> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");

Why so early? It's better to avoid touching HW as long as we can, then all
other possible errors will not provoke any glitches and unneeded power
consumption and delays.

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;

So, somewhere here (to be robust against the cases when regmap wants to fill
the cache from HW or somebody reads debugfs at the time of initialisation.

> +	data = iio_priv(indio_dev);
> +	data->regmap = devm_regmap_init_i2c(client, &tcs3430_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	ret = devm_iio_init_iio_gts(dev, TCS3430_MAX_SCALE_INT,
> +				    TCS3430_MAX_SCALE_NANO,
> +				    tcs3430_gain_sel,
> +				    ARRAY_SIZE(tcs3430_gain_sel),
> +				    tcs3430_itime_sel,
> +				    ARRAY_SIZE(tcs3430_itime_sel),
> +				    &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel = TCS3430_DEFAULT_GAIN_SEL;
> +	data->atime = TCS3430_DEFAULT_ATIME_SEL;
> +	dev_set_drvdata(dev, data);

> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;

> +	ret = regmap_read(data->regmap, TCS3430_REG_ID, &dev_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read device ID\n");
> +	if ((dev_id & TCS3430_ID_MASK) != TCS3430_ID_VAL)
> +		dev_info(dev, "unexpected part ID 0x%02x\n", dev_id);
> +
> +	ret = tcs3430_init_hw(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize device\n");
> +
> +	ret = devm_add_action_or_reset(dev, tcs3430_power_off, data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "tcs3430";
> +	indio_dev->info = &tcs3430_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = tcs3430_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tcs3430_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


