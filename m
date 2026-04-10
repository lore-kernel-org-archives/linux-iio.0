Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EEB1A6806;
	Fri, 10 Apr 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796090; cv=none; b=CkG5ycIE92ge38gaZhMe+LXZmOritNsA4cTDjaCW8gTvvWbdyVBGsxJlFeGx3ro1JFn4W1ggr/Do+G9Q/AJtFIolrwdtORoBumT3xM0URBXs+dIuPMIJ51DjKSI7v9ePZQH43rcV2lFWmdS/ODokjP49Ca8OFFO1xOiy/C5NYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796090; c=relaxed/simple;
	bh=otSg5k8DKpkHBXxp8Ri0nGPCGBLgyeepWMGyUfxtkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htirMI4gNeIWTSCTRM3nWVpoBOfBcmeJGuz3yrxNA3he1OVqWRbWPxTK/CIh3wL6UUpTEPH+dPXJP8JMjv6A72dIh1z7DBQXr+Ja0sZK8VSs7rkmpisQ1mtuqaMt3Ce25fjh0tpDHVRQeAee78QbtyRv+LrclLXXXcEMe9kW32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EW88khza; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EW88khza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775796089; x=1807332089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=otSg5k8DKpkHBXxp8Ri0nGPCGBLgyeepWMGyUfxtkvU=;
  b=EW88khzaQSUBjWusAPOjB/QGZlZo3+hsjMqK3R47baFiTrPNrxuS1zvw
   BWItRWpDgPI96mmm3XaEuLs0yvp1aNX9VXRxc+3dKzYg5H6mRB2FchvAr
   qRuGRVUOUqdEw/GnWmL5svXrlBnb4GuEQpuGlBiS9f3pMmbcWR7w1xrNY
   6k08ywUF9/OIM4Ywv8JZKgr6dDiUWFzDX5jt4+bf4krnFlEbPFvq++3ff
   Tzu+jKcyWHyYMXCwITzQ4dWSyvcxWRhXSTIyRHoA5gn7rjQ592eatKpnu
   9Nkp5KgBRrufLdAK0ZTcMu2IYejqOLrqjRLSc7/yYxJL41pSPM7Z91Qa8
   w==;
X-CSE-ConnectionGUID: Nn8p1lwTRGSStwdRiCwUiw==
X-CSE-MsgGUID: Au0/Y1MVQniiKgOxkLjPyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76882781"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76882781"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:41:28 -0700
X-CSE-ConnectionGUID: u/m46udhSHi4Zk0yDaB7WA==
X-CSE-MsgGUID: XFWpufY6TwekADUMsE/pFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="233907358"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:41:26 -0700
Date: Fri, 10 Apr 2026 07:41:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <adh_c1GG17zCbBdu@ashevche-desk.local>
References: <20260410-dev_ad5706r-v6-0-f3fda5921fe4@analog.com>
 <20260410-dev_ad5706r-v6-2-f3fda5921fe4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-dev_ad5706r-v6-2-f3fda5921fe4@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 10, 2026 at 09:33:56AM +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed

Still the same issue...
After addressing it in full feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int ad5706r_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes, val;
> +	u16 reg;

> +	reg = get_unaligned_be16(data);

But this has the similar issue... Validation has to be done before the access.
(also theoretically possible to have count 0, so even for byte access we have
 to validate the input, strictly speaking)

> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.len = num_bytes + 2,
> +	};
> +
> +	if (count != 4)
> +		return -EINVAL;
> +
> +	val = get_unaligned_be32(data);
> +	put_unaligned_be32(val, &st->tx_buf[0]);
> +
> +	/* For single byte, copy the data to the correct position */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		st->tx_buf[2] = st->tx_buf[3];
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}

-- 
With Best Regards,
Andy Shevchenko


