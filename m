Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FC3F0AB8;
	Wed, 18 Mar 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861263; cv=none; b=eimtSYMJh+tDXePRVNdpI8kcmOUxioKOj8Cr5OqaGKJnlzSFLH4sQpiIngixn0746GKRlO9rgukEwRSfa/bWgqdZSA5eSIBmto61rz6lKNVWrGExmLxuClbD2tZl5zQ542narpVCfYln+rBUqE1tFlUyarxPXBzYebRFc7TJWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861263; c=relaxed/simple;
	bh=iaMJc/x0hbL4+hGkHwPxGwqgMJ633NGk0/QTlyPgmQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDJYmiqCj0YwnwK+oZ6ATBcdvvRKz+olIS759dHJ7bFBrIYokOKcJKxOzGDLOFUV7s+TSEnbQsWMXvurobbhegKqiGKCNTKG7AqZJ5wEaM8Jo/B/a5L92a3OKF7SIbJNXSXzv6yXgXKm3OpZIYL1J//3TiVxVc+cdUEI/CtfauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+Iodw/R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+Iodw/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773861261; x=1805397261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iaMJc/x0hbL4+hGkHwPxGwqgMJ633NGk0/QTlyPgmQ0=;
  b=D+Iodw/R+pUMFEEAmMSZd59qwBs2KYY7W9Q89uuvyOn5lh0UPm6IFhL2
   XFPRVzTUlxf7CyQ9qUGk9NQxZ5etTGa8QTWz9g0ELmtgvop2Hq+fXGfm+
   uhft2F+bgEAf6xAPjP2olF5fVDUrLybeownqcDInnnck6zGlTXHgdng4M
   OxLCF/4dbNGA/a5gPwcreGrAFXYE2hSM9S37prRohATKay+Sms6Kgp8lz
   FCZKXVT/MNQhdBExgMczItiYi5ahXudSThIrRU5UyGxnGqhyRGmRz+dLC
   8TWYiLx8OhloKnttEIwVVgVl6C6Q5x3COrb3C585vmIxVlJXX02/1jS33
   w==;
X-CSE-ConnectionGUID: 7mz/3sHJSUWPzcRndmInjA==
X-CSE-MsgGUID: XtDaBOo8QempVQET6jOWgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="97536673"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="97536673"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 12:14:20 -0700
X-CSE-ConnectionGUID: qojLmZmzTe6qpnWD1m/YZA==
X-CSE-MsgGUID: 3YcMJB16TIqoozb7h5nrpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227423817"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 12:14:16 -0700
Date: Wed, 18 Mar 2026 21:14:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 4/9] iio: frequency: ad9910: add digital ramp
 generator support
Message-ID: <abr5hoBIQLlcOk_v@ashevche-desk.local>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-4-e79f93becf11@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-ad9910-iio-driver-v2-4-e79f93becf11@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 05:56:04PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add DRG channels with destination selection (frequency, phase, or
> amplitude), operating mode control, configurable upper/lower limits,
> increment/decrement step sizes, and step rate settings for the digital
> ramp generator.

...

> +static ssize_t ad9910_drg_attrs_read(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     char *buf)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	unsigned int type;
> +	int vals[2];
> +	u64 tmp64;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (chan->channel) {
> +	case AD9910_CHANNEL_DRG_RAMP_UP:
> +		tmp64 = FIELD_GET(AD9910_DRG_STEP_INC_MSK,
> +				  st->reg[AD9910_REG_DRG_STEP].val64);
> +		break;
> +	case AD9910_CHANNEL_DRG_RAMP_DOWN:
> +		tmp64 = FIELD_GET(AD9910_DRG_STEP_DEC_MSK,
> +				  st->reg[AD9910_REG_DRG_STEP].val64);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (private) {
> +	case AD9910_DRG_FREQ_STEP:
> +		type = IIO_VAL_INT_PLUS_MICRO;
> +		tmp64 *= st->data.sysclk_freq_hz;

> +		vals[0] = upper_32_bits(tmp64);
> +		vals[1] = upper_32_bits((u64)lower_32_bits(tmp64) * MICRO);

Not sure if wordparts.h fits here, esp. taking into account...

> +		break;
> +	case AD9910_DRG_PHASE_STEP:
> +		type = IIO_VAL_INT_PLUS_NANO;
> +		tmp64 *= AD9910_PI_NANORAD;
> +		tmp64 >>= 31;
> +		vals[0] = div_u64_rem(tmp64, NANO, &vals[1]);
> +		break;
> +	case AD9910_DRG_AMP_STEP:
> +		type = IIO_VAL_INT_PLUS_NANO;
> +		vals[0] = 0;
> +		vals[1] = tmp64 * NANO >> 32;

...open coded approach here. I think the open coded calculations.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return iio_format_value(buf, type, ARRAY_SIZE(vals), vals);
> +}


-- 
With Best Regards,
Andy Shevchenko


