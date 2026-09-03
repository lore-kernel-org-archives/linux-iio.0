Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2A3EAC71;
	Thu,  3 Sep 2026 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417084; cv=none; b=CjSA1oUYm5Gbp1+v9LnaJloH/98yDts8MpzryEj0sw0Fe9VhlrX/u3C/2JiEcaCj3znodrTThWA80ivqME7wCBzTTmsSSXe32MK4ydvJYYPBJHb22pqEIG8Nw4naCReBk3tTvQgJPRDsCJnVbd01Dx9jQwuxOLfPrAIfW3R4hf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417084; c=relaxed/simple;
	bh=KnGPxRYqa+YU4j0JBli/anSpWWwJeLJkR2/WWMw4sTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBNQ6tpKfzoME6WnLx7EV7q1W5VaHisyLPOp8ymMUNv+m2eSbMZolYcyV9IkeCvWGTY7tuhgsee9h5uWEJp/k7Yt19DkxBUPa4tzlMwihNNbN5/D6mlNZ5Damf6fYE9XD1zOoD126CQqh5qESAIVIRcPph2gW2VJR1hqa4iY0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3zTTyuv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3zTTyuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417083; x=1819953083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KnGPxRYqa+YU4j0JBli/anSpWWwJeLJkR2/WWMw4sTA=;
  b=m3zTTyuvBf1WI8AipTiYiJgkrq2/CbdKDZlVY2mTZuYIN5h4RjIlNHHZ
   3rZAzqMRLCbh0HUNZHdQ60Zde2vpl1aU796yqqh00scn/Zqt6ddgbzW25
   vDKQC3a3n+kBFWjnYOzy+AXnnyEf8qnFA4UkK9wzrYGL1d7oOq05i6NhW
   p0329FXIuZS+lsM4mzyeeaOK9Sv0i7fNlplAM+GH0Cba/DLKGAuuCmDPU
   6+PFXwSgFu2ehMS6CF5cLkyZ6UGi1skMswPY19mY+TDf1SMXQ61CecokS
   J/CjlD2fVOC0n53rsWowpzWx0pPwM/QNDHeDGy/apyHRAHt4i42zrz5TN
   A==;
X-CSE-ConnectionGUID: O4juEVl8R42tcs2+MwavoA==
X-CSE-MsgGUID: XIVNHyeLQk++fLOwjfRlCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106252730"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106252730"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:31:22 -0700
X-CSE-ConnectionGUID: Zenm2r2LRiKoIs5Vpnc1fg==
X-CSE-MsgGUID: SUe2Q2yKQD+335Nz2YKkZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="263451694"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:31:19 -0700
Date: Thu, 3 Sep 2026 09:31:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 06/13] iio: adc: ad4134: Add support for digital
 filter type selection
Message-ID: <apkUNH9qCcfTNZqU@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <058e82fb421c6794cc3002bde25d9e3485f74be2.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058e82fb421c6794cc3002bde25d9e3485f74be2.1788368334.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 02:23:22PM -0300, Marcelo Schmitt wrote:
> AD4134 supports four types of programmable digital filters that allow users
> to choose between different output data rates and input bandwidths. Enable
> basic digital filter configuration by providing a way to select which
> filter type is activated for each channel.

...

> +static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4134_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
> +			   &ad4134_filter_type_enum),

Make it a single line (it's only 82 characters).

> +	{ }
> +};

...

> +static int ad4134_get_filter_type(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan)

int

> +{
> +	struct ad4134_state *st = iio_priv(indio_dev);
> +	enum ad4134_filter_type f_type;

enum

> +	unsigned int mask, reg_val;
> +	int ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	ret = regmap_read(st->regmap, AD4134_CHAN_DIG_FILTER_SEL_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	mask = AD4134_CHAN_DIG_FILTER_SEL_CH_MASK(chan->channel);

> +	f_type = field_get(mask, reg_val);
> +
> +	return f_type;

field_get() macro...

I think you can get rid of temporary variable if it's not used afterwards.

> +}

-- 
With Best Regards,
Andy Shevchenko


