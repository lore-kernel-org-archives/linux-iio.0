Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE531F9A4;
	Mon, 10 Aug 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352313; cv=none; b=TWMm1OUF5wnk8V4ryLHRLZ2f7EAI6PXq20C9ZshC0ObhCqiWa8cKATktF8EVaVczllhxlrQzdGCGAFcanmex/djqlriL8/REv2CLlHF5vPXBYi6tPEBtEPrIvxqomvgbwSdh30A2hPcl2APlOMBz1rLyxe5ElNfsuFuQH/KOnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352313; c=relaxed/simple;
	bh=7h/IZXeRZ+8TPDxbd/lGM+08FtLKAe4+FQnWI6SkmN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHWgOneeFF/z8LkqdFnmm9XLiZGR61/Lv1ZWajTNZphrrwjZSQr0fZIVbcVTgxvFTNslv6ZeNPqknAcMiygei3aOb9W+BIgGtmhKFsUEyG1Vg90SjYlBp6wcQBRhdc+Q6R4V1zDjLyZ124L85FJNNokyrzL0yuwJ/Eo/iofnab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyJRZhFF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyJRZhFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786352313; x=1817888313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7h/IZXeRZ+8TPDxbd/lGM+08FtLKAe4+FQnWI6SkmN8=;
  b=XyJRZhFFf8snVJzFxB0JS2V86bL4RDVvJxttIFn2tAMQwUuJ/2gjWeU7
   C2W+1e9Hi9VuWh4e8hiC9Ru2kfB2oo1IEThnzFMhxIQqnH0V3+07K8ivk
   yRtSwutMiAxsSLZKVIR3FcYdvKz0HeypzejIe+9/g05teqeyRo3PHKQvy
   bQ5PjgH9bBsDliNf97CTWAhA7ZrHnMb75hbiggEUHuUmkYfIE+94vubqE
   +/CuiW8vLVbY3vEG37eyY6zAsQK9zXDHj3lapW6xArbeIQVFisc3IG0dM
   Nn+oLDeorKRFxDihjRpGVkl4JV5QiLaWtaZvu8ESqdeJCQHb2UWtIUkSy
   A==;
X-CSE-ConnectionGUID: mA1m4TzIRCq6pgfYFTkA7w==
X-CSE-MsgGUID: JnFs6KSETM2H+DyWPx589A==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86798976"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86798976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:58:32 -0700
X-CSE-ConnectionGUID: XZAhYGoeTf6gA7hzHkitqQ==
X-CSE-MsgGUID: Rh5zOVLkTlGD9a4cpoAxfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="259660854"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:58:29 -0700
Date: Mon, 10 Aug 2026 11:58:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
Message-ID: <anmSs_AHIt_cKacj@ashevche-desk.local>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
 <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-3-76e0d30e6c6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-3-76e0d30e6c6b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 04:19:48PM -0500, David Lechner (TI) wrote:
> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> mode the ADC itself is starting each conversion, so we add a trigger
> based on the DRDY interrupt to read each sample. This mode is also
> limited in that only one channel can be enabled at a time since the
> chip does not have a sequencer or simultaneous sampling capability.
> Continuous mode will only be used when this new trigger is the current
> trigger.

...

> static irqreturn_t ads112c14_trigger_handler(int irq, void *private)

>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ads112c14_data *data = iio_priv(indio_dev);
> +	unsigned int scan_mask_len = iio_get_masklength(indio_dev);

This is from indio_dev, which is defined two lines up, so this, longer one, can
be bumped one line up.

>  	u32 offset = 0;
>  	u32 i;
>  	int ret;
>  
> +	if (iio_trigger_using_own(indio_dev)) {
> +		i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
> +		if (i >= scan_mask_len)

'>' is redundant, '==' suffices.

> +			goto out;
> +
> +		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);
> +		if (ret) {
> +			const struct iio_chan_spec *chan = &indio_dev->channels[i];
> +
> +			dev_err_once(indio_dev->dev.parent,
> +				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
> +				     chan->channel, ERR_PTR(ret));
> +			goto out;
> +		}
> +
> +		iio_push_to_buffers_with_ts(indio_dev, data->scan,
> +					    sizeof(data->scan), pf->timestamp);
> +		goto out;
> +	}

...

> +static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;

> +	i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
> +	if (i >= scan_mask_len)
> +		return -EINVAL;
> +
> +	chan = &indio_dev->channels[i];

These lines repeat what you have in ads112c14_trigger_handler(). Perhaps
a helper to return a channel or error pointer or NULL?

> +	guard(mutex)(&data->lock);
> +
> +	ret = ads112c14_prepare_channel(data, chan);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				 ADS112C14_DEVICE_CFG_CONV_MODE,
> +				 ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_START);
> +	if (ret) {
> +		regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				   ADS112C14_DEVICE_CFG_CONV_MODE,
> +				   ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


