Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC3346AD5;
	Wed, 25 Feb 2026 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020220; cv=none; b=IppTcLrAYkJq7Z5Po8nwsSwD1hskl3f8tkEUAmNBGOCd0J6dHbDCvbzw440euZIgqhWGG1ZsdDJZSUs8Uv3oN/9psA1pG4hGVYD+xoHv7q4+6drRPuiZfTS0Ka3b2a4yqWrwUuzQ2TEcULeqtb8cXVJAxUl0nSt4eWbnZwA4c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020220; c=relaxed/simple;
	bh=H1Twf5rJOxs6QUVyb5yvbyBQV7Zfjgli6zTGRfb2Iz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TejZkHCg4b1Tj0p7WzvmWnVdoyW9UlZluJVWlKJfE/ZWGzvYUutE5TMJ7Z042xy2jP8FnP+X+3IyMCgu5l36BTbNGuGpTw2PzbFskM2CfpuM0pIbB0frPxeXlLOelr+8jqaeuq9/FiPiyYqQ8+bvT+mjeb+kXGeglN+Pb1Ye3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEKnbAw0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEKnbAw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772020217; x=1803556217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1Twf5rJOxs6QUVyb5yvbyBQV7Zfjgli6zTGRfb2Iz4=;
  b=fEKnbAw0cUd6m/Sc3ywVgZDtXKiBPFcIpuHJAdQ+Fq7g1rpjx7SUSYzr
   y32IIWwRPaN98w5OOzZxTjOG29EjKBXISCVk3cCkkktlcPCox2oCcyKk+
   TKVDY8d63a5XOKPwV7R05cLzJKSASsUknpBnWir3vEiZbQsRxH9Vkpzo/
   2GZ23hO+vJsjMlX3U2aWhTq6cb+47Lw5x2wRWxbXOp/02lOLJSOIDqQsS
   mz/YlXjVQpRZpNr+KfUAvVdzidAhLo5E0hPNvwgwnUt+yBxNGC2nMaaLq
   5YzrQEJH7zhZ71gQPa8mh2mT+JhCmZ7MKPn6ehwkqfAIg7nsucu+Jlq2i
   g==;
X-CSE-ConnectionGUID: I7HDnSZdTvmKDjbcpDhDBQ==
X-CSE-MsgGUID: P18Z21usQ3m/Vm4Xh5FFFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="95672380"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="95672380"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:50:16 -0800
X-CSE-ConnectionGUID: EuMaicO/TG2pZuSbepyANQ==
X-CSE-MsgGUID: KDGrsOafRKKhQ/ICmMGshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="246765988"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:50:14 -0800
Date: Wed, 25 Feb 2026 13:50:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <aZ7h8zJW6FWKLYPb@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101814.2368431-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225101814.2368431-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 11:18:13AM +0100, Francesco Lavra wrote:
> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.

...

> +int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name)
> +{
> +	const struct st_lsm6dsx_sf_settings *settings;
> +	struct st_lsm6dsx_sensor *sensor;
> +	struct iio_dev *iio_dev;

Maybe

	int ret; // choose better name if any

> +	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	settings = &hw->settings->sf_settings;
> +	sensor = iio_priv(iio_dev);
> +	sensor->id = ST_LSM6DSX_ID_SF;
> +	sensor->hw = hw;
> +	sensor->hwfifo_odr_mHz = settings->odr_table.odr_avl[0].milli_hz;
> +	sensor->watermark = 1;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->info = &st_lsm6dsx_sf_info;
> +	iio_dev->channels = settings->chan;
> +	iio_dev->num_channels = settings->chan_len;

> +	if (snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name) >=
> +	    sizeof(sensor->name))
> +		return -E2BIG;

	ret = snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name);
	if (ret >= sizeof(sensor->name))
		return -E2BIG;

I find this easier to read and follow.

> +	iio_dev->name = sensor->name;
> +
> +	/*
> +	 *  Put the IIO device pointer in the iio_devs array so that the caller
> +	 *  can set up a buffer and register this IIO device.
> +	 */
> +	hw->iio_devs[ST_LSM6DSX_ID_SF] = iio_dev;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


