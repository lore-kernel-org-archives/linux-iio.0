Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483839;
	b=cvhFFKVEXQ/gaIHZBdOnmVOLiAgfFRxvrXENPRuX5ZBcjnBE3Q+HnzAAyNyypiUmmItw
	 fyUGU00kZ8rw2KRxygOqwZ9isylFE4rUKXRhGB9YO0Mh8EN4zHiQtcqPEr2uFJCgaXzKZ
	 C4PfJIym1RxAiL97aoLB3Qa6reXymHK0QM2ojpJXJwmzTVHcRlsXwC0QV5nJFuqgTBU+Z
	 7So7tEY1bf36syaQG+YutiZReyqUqz6YhahbcaAPjyG5QTFTTY6pu7e3Nqhjq1atgHgy4
	 e2N2ugkKkhPx7Ro70C/N+lbXuk5Pgdy7k56vwgIk6j0zVdXdXW7sfWYv5H+lx17+nIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483839;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+HbM2fnAiuFc369BfM90FYmeo4ajL0do8Ug+Pa2Ga0c=;
	b=VBlFkZUOU5KjIWJ1AUiLS4Mgs5RtgW1khDAHyvi6QTW/CkF73dCGWw/eWe0cNkW+/TCC
	 /Jo5JynmNiSISxSQhRjAWUqFdDMvQ+Rcnpf85MA2HJPsey6UIsAPJvNKUnDrLekKwWLhI
	 m87SC2fGsUgD6gtGG7/NsfEifHM+1TMgqBO0TESvuSE4pGcsUf+2mFoln8Whr5VF+yIwo
	 5Tm+8kwBAg4s2JRNUgPT2/WD0GNwU/0Mtf6en66Lyw8zAcRKL/Fp7YuZtGLP2t5Pv+ocH
	 RzlMgNcCahUjNzX2lHGsqePpQUPUz3+NsA42ru6hFEFD86hwRotkFYgvQmHZep73cwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ux3Twm3l;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919F606A31B;
	Tue, 20 Oct 2026 08:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8919F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ux3Twm3l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792483839; x=1824019839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=25f8hy5Y2bKimiVXz8+NoWweTrntm2IbNIZ2eSjEsrA=;
  b=Ux3Twm3lWqKkq9revxlKs9uXUgjTF4o4K8iYNi2gJZBnyyr6zbXRPXYN
   /TSP2n4B7mJCZ4JcE7XavYfKhhf30JDN2MHIrQ7OtcShEJt72OZJ5y9/1
   vo+Iy03WJNtXIkMpinecWjV/eKF9CAmld/+K0hoznlWpHSC4gt4Sv8K2I
   9LUIStgxNhoB+dBqWb/rq1JV4b3xSx/bmlr+sUx+MQ0UMYfE6k+4mDzmq
   1Fnb9DdKO8l9Jd74MvzchotMcEw7nWwjkpcXZdf8Eo53Zd+qKIwnF2OS4
   EOCeLp26p8VS3E/RQ+lXiVtPigy1NvJvje0BnHMmzrwuwjfcPGu+8ZBYK
   A==;
X-CSE-ConnectionGUID: 44Jm8SJ+S2yxYPQmnQHshQ==
X-CSE-MsgGUID: qPCzpZ8DQuenhk3sUqESVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1187391"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1187391"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:10:38 -0700
X-CSE-ConnectionGUID: K9icsDRHSsS/miovNg3cTQ==
X-CSE-MsgGUID: Qrstw2AtSp+MKb3a3XZzuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3115888"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:10:35 -0700
Date: Tue, 20 Oct 2026 11:10:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: vidhu.linux@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <atch-NQ78VUdfgxW@ashevche-desk.local>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
 <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
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
In-Reply-To: <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 12:03:43AM +0530, Vidhu Sarwal via B4 Relay wrote:
> 
> Add a driver for the Benewake TF-Luna, a single-point time-of-flight
> LiDAR distance sensor with a range of 0.2 m to 8 m, connected over I2C.
> 
> The sensor is run in trigger mode. Each read starts one measurement and
> waits for the timestamp register to change before reading the result.
> In continuous mode a read can catch the sensor in the middle of updating
> its result registers unless it is synchronised to the data ready output,
> which this driver does not use yet.
> 
> When the signal strength is too low the sensor reports a dummy distance
> of 0, so such readings, as well as overexposed ones, return -ENODATA
> instead of a distance.

On top of my previous reply.

...

> +static int tf_luna_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tf_luna_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int mode;
> +	u8 signature[4];
> +	u8 version[3];
> +	int ret;

It also makes sense to have local variable here

	struct regmap *map;


> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;

> +	data->regmap = devm_regmap_init_i2c(client, &tf_luna_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize regmap\n");

	map = devm_regmap_init_i2c(client, &tf_luna_regmap_config);
	if (IS_ERR(map))
		return dev_err_probe(dev, PTR_ERR(map), "Failed to initialize regmap\n");
	data->regmap = map;

> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");
> +
> +	/* Boot time is not documented, about 350 ms was measured */
> +	fsleep(500 * USEC_PER_MSEC);
> +
> +	ret = regmap_bulk_read(data->regmap, TF_LUNA_REG_SIGNATURE, signature,
> +			       sizeof(signature));

Make it split logically and taking into account the above either

	ret = regmap_bulk_read(map, TF_LUNA_REG_SIGNATURE,
			       signature, sizeof(signature));

OR

	ret = regmap_bulk_read(map, TF_LUNA_REG_SIGNATURE, signature, sizeof(signature));

(perhaps you can shorten the 'signature' to 'sign' to fit).

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read signature\n");
> +
> +	if (memcmp(signature, "LUNA", sizeof(signature)))

Hmm... No. Please, make signature to be __?e32 and use a definition for this
FourCC [1] in the hexadecimal with the comment, and compare as regular integers...

> +		dev_info(dev, "Unknown signature %*ph, continuing\n",
> +			 (int)sizeof(signature), signature);

...and here use %*p4c?.

#define	TF_LUNA_SIGN	0x... /* "LUNA" in ASCII */

	__?e32 signature;
	u32 fourcc;
	...
	ret = regmap_bulk_read(map, TF_LUNA_REG_SIGNATURE, signature, sizeof(signature));
	...
	fourcc = ?e32_to_cpu(signature);
	if (fourcc != TF_LUNA_SIGN)
		dev_info(dev, "Unknown signature %p4c?, continuing\n", &fourcc);

where '?' represents either 'b' or 'l' depending on what you have and what you
want to see printed.

> +	ret = regmap_bulk_read(data->regmap, TF_LUNA_REG_VERSION, version,
> +			       sizeof(version));

	ret = regmap_bulk_read(map, TF_LUNA_REG_VERSION, version, sizeof(version));

(or 'version' --> 'ver', for example).

> +	if (ret)
> +		return ret;
>
> +	dev_dbg(dev, "Firmware version %u.%u.%u\n",
> +		version[2], version[1], version[0]);

Yeah, I need to post my series to also make this to be a pointer extension.

> +	/*
> +	 * In continuous mode a read can catch the sensor updating its result
> +	 * registers unless it is synchronised to the data ready output. Use
> +	 * trigger mode and start each measurement on demand instead.
> +	 */
> +	ret = regmap_write(data->regmap, TF_LUNA_REG_MODE, TF_LUNA_MODE_TRIGGER);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The sensor silently drops writes it is not ready for, so check that
> +	 * the mode was set. A write takes up to 100 ms to read back.
> +	 */
> +	fsleep(100 * USEC_PER_MSEC);

msleep() as it's known to be big enough.

> +	ret = regmap_read(data->regmap, TF_LUNA_REG_MODE, &mode);
> +	if (ret)
> +		return ret;
> +
> +	if (mode != TF_LUNA_MODE_TRIGGER)
> +		return dev_err_probe(dev, -EIO, "Failed to set trigger mode\n");
> +
> +	indio_dev->name = "tf-luna";
> +	indio_dev->info = &tf_luna_info;
> +	indio_dev->channels = tf_luna_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tf_luna_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

[1]: https://en.wikipedia.org/wiki/FourCC

-- 
With Best Regards,
Andy Shevchenko


