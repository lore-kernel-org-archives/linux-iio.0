Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF53A5E85;
	Tue,  2 Jun 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427943; cv=none; b=FH5fiDjTDwU8YkvdeJQseRDv8CcfQXX9/PDYZmT13nG4XYUPRTKCqdyYOdRsi5OpDxrKR5cLKEvGgW+wwh+R9sWhzoGOWSEOzg3KFEnHEc6neWXyMSUf1WVxmAp+yAxfFHdfa3Q/Ly+KtW4+dOg9NpwiDDegj/5Y/LqIhK0L4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427943; c=relaxed/simple;
	bh=5+victKJvf4xlYtUWm9ubefdyFRrnT6iLe597OdvJA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omN4ZYFi/0BmnS6MQUfJ9KdKIIW79/KWHMJ8cPMXwu8qGGPt00fwRjGeClRI4/pfm9ai4tW/MSH8vARAIRR8PY627XTgvj5vc97EQmqsmSuBvLKrzD9PqssV0HisS8UjEmkQqv/JFu+DNnTHM4q2BY9BCiSADLVr3f4s4aUUY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTJ9WrO6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTJ9WrO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780427942; x=1811963942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+victKJvf4xlYtUWm9ubefdyFRrnT6iLe597OdvJA8=;
  b=FTJ9WrO6NPwcHD3I31uB8V5KYQzN9042iCKR9GDJW12TVHfPsRp2y2Uv
   O4fRucToBPmM422q+Xlj5Hu8ldSktW8Gp8LBCekqpncE20ska8C/OdNeR
   HQJ2jhM9v3V2d7nUJt2q5eFgy4B3ERbtKObY4WDy5NXai/fqoQON3B2SM
   ZW0frhEAPdqeVL/CFrLqCY7t5osUmcMRLO0KE/awGAKO9F3RmkjpzZfJL
   YJqae7vQFXA62XX8Nv/ilFOkuLCI1dPdv5dBLsfyDcG3ISI2JP8brd3w+
   9FAhw+ERn+88pbCdfg0GNK20CxlnS8NYhGPNhPYOX0CCA297tvqImfCjY
   w==;
X-CSE-ConnectionGUID: Q40iNihzQ/ed+ooKEYNjPg==
X-CSE-MsgGUID: zDstIIGyQIWh34NgKIKCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83807583"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="83807583"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:19:01 -0700
X-CSE-ConnectionGUID: Gu1DLD3uQi2271mrqCg2EA==
X-CSE-MsgGUID: I+S8wWYYRgqi6xN4T8r3NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="237645579"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:18:58 -0700
Date: Tue, 2 Jun 2026 22:18:55 +0300
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
Subject: Re: [PATCH 10/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <ah8sn1APUA8_zTf9@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 05:33:57PM +0100, Rodrigo Alencar via B4 Relay wrote:

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
> +	int ret, ch, i = 0;
> +	bool async_update;
> +	u8 cmd;
> +
> +	ret = iio_pop_from_buffer(buffer, val);
> +	if (ret)
> +		goto out;
> +
> +	mutex_lock(&st->lock);
> +
> +	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
> +						      iio_get_masklength(indio_dev)) > 1;

Easier to read on a logical split

	async_update = st->ldac_gpio &&
		       bitmap_weight(indio_dev->active_scan_mask, iio_get_masklength(indio_dev)) > 1;

Or with a temporary variable where you keep the weight of the bitmap.

> +	if (async_update) {
> +		/* use ldac to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> +		if (ret)
> +			goto cleanup;
> +	}
> +
> +	if (st->ops->sync)
> +		ret = st->ops->sync(st); /* flush all pending transfers */

> +cleanup:

Bad label naming. Also may clash in the future with some overflow or wrap traps
(you can find interesting discussion with Linus on the implementation of that
 with Kees).

> +	if (async_update)
> +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> +
> +	mutex_unlock(&st->lock);
> +out:

out_notify_done:

> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko


