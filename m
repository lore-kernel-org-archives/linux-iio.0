Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5A324B31;
	Tue, 16 Jun 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606552; cv=none; b=SSgXpbTRmkvqkfvgWBYctmTW+N7WKIjfejjLiIr/slY6TqqWfokGBHpucJtCAwnAVtaY32Ea4lXeg+UI1+cmCGfDpanG1pkgKNNg/w+pO6UKltHNekWI4dKwUb/dX0lJOCqpWnxcmZuI+79Cmv94A42QopGlJk0us/ShJV6K//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606552; c=relaxed/simple;
	bh=ssYO1V20hdK+hsJaiyDQjbwF8nhSLuRtFNz1lPldtWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoO5EW2jyBxt08KNar4X9cf/A/n3hvB5oOoa0PtfZnNV9eSla7eSyLC1Pf2tDy/Hkrh/z/0r7dphMfJVSTla9m9g2mVoJRVOYshXHTdWfgBv8b6J4xIRNQEr9/dLTRaukiK0G+gyw08MOdt87cas7Ff1/IPZmrP8qdSVrLlZJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWil/F4A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWil/F4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781606552; x=1813142552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssYO1V20hdK+hsJaiyDQjbwF8nhSLuRtFNz1lPldtWM=;
  b=BWil/F4A6Hma9caQ3gE1B6D7fUE4w3C6iKvPb9XoehEFHdlzIm8t4ggB
   mYTeEEqEVNK1WlAoRvTIqU5/LKk+Lrwyb1rcUcueYc05aKuKz08w8vPa9
   4+abSRKD/S1svpyQJW6twhqwhosu4v2ZrDz7qZB1czlc7CHitJ60Ux18X
   a3PfSxtVJslWOH4Ic7FZvYJD4R49OahbXYUTLmcS+2NuYtrcP9NgyaY5M
   u45n0DhQ3T3/EFE2Iue/GEAboJfk5RktO+5xHABLIjqMemAgng6DJtvdK
   EF5dsP+EbLrjZwbEXZ45IHZ8CY3k4zjNE7cy1SbipNKgkXUtLaP95uD7O
   Q==;
X-CSE-ConnectionGUID: aY1OqcWhSfu5M8fAYvpTcA==
X-CSE-MsgGUID: 41OAQk4WRFSAPookEKrk8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93039561"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93039561"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:42:31 -0700
X-CSE-ConnectionGUID: ln1Hr2ySTha2mrHZQOwupA==
X-CSE-MsgGUID: sq+pS3fERO6t7gt9mMsS/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252039591"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:42:27 -0700
Date: Tue, 16 Jun 2026 13:42:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 10/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <ajEokMTOBX--PINl@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-10-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-10-f829fb7e9262@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 09:21:16AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Implement trigger handler by leveraging the LDAC gpio to update all DAC
> channels at once when it is available. Also, the multiple channel writes
> can be flushed at once with the sync() operation.

...

> +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	u16 val[AD5686_MAX_CHANNELS] = { };
> +	unsigned int scan_count;

> +	int ret, ch, i = 0;

Decouple assignment and definition. Also do 'i' and 'ch' need to be signed?

> +	bool async_update;
> +	u8 cmd;
> +
> +	ret = iio_pop_from_buffer(buffer, val);
> +	if (ret)
> +		goto out_notify_done;
> +
> +	mutex_lock(&st->lock);
> +
> +	scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +				   iio_get_masklength(indio_dev));
> +	async_update = st->ldac_gpio && scan_count > 1;
> +	if (async_update) {
> +		/* use LDAC to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> +		if (ret)
> +			break;
> +	}
> +
> +	/*
> +	 * If sync() is available, it is called here regardless of write
> +	 * failure to allow bus implementation to reset. In that case, partial
> +	 * writes are unlikely as the write operations would just queue up
> +	 * the transfers.
> +	 */
> +	if (st->ops->sync)
> +		ret = st->ops->sync(st); /* flush all pending transfers */

'ret' is set but not used. Always compile your code with `make W=1` and both
GCC and clang.

> +	if (async_update)
> +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> +
> +	mutex_unlock(&st->lock);
> +out_notify_done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko


