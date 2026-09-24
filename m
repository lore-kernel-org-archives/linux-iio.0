Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82035477E;
	Thu, 24 Sep 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259619; cv=none; b=WdA7F9lzhgv5s/kS5dyXyhcSYwjXtYGn4MIfjIKN/7gxJG0OyCGThTX0/cnoO8WI77XWCnxqCWtOoTAPuEeaWofEPh7PH3Y9tlENrQ0cMkgYBimxdqPMYX9Ihk7Irqa4iDypVADk4ztH00X4icZZWmUM2VyJw2hDPosHU2UFlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259619; c=relaxed/simple;
	bh=19iHWkEpFPvmd+e9vblK7kPi4i0KB+Ordmxy7jIlkZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGpqM3C5JDYZJsdymhEO3M8iXJu2rItWBuCHs8OhKndmCD+8IYzuX1J0ghtvwyWfWhaMc5NGGTJ7XYZgZYP8jcfULRYhsL0mwEYJKwr147WgJk8BbYL19fQRTudkT3CrnLAFV56lHDh9PS8yhJ+bE2YiDt5Vq5hGuV6cC1pTZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/gFik3o; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/gFik3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790259616; x=1821795616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=19iHWkEpFPvmd+e9vblK7kPi4i0KB+Ordmxy7jIlkZY=;
  b=M/gFik3oho3fQRkfkahRqjg8gZkEbmYCqNUatcGFBhlA5KRR8/z+glJJ
   UJw8I57ZAJsYLz+80XVnrrlILC5EFDIAa+ufIONLq0u2JoKjWnzkxTEzB
   GCLAWIyhK6C5U9l46qTeuu2eLHWMuvln5uqyWxp9+OkVSj7IzWBf4zo21
   e1dI9B8mEtycc/qhBh9VumHqZ1k5rbAdcFaclHROHJPhe9oLl5U6UO4d3
   St/MhnluwxhOAS/MnyYTKESFb6WCyZ/2vGOz3MwMkq2veEdaRsBnVFOpJ
   u2rM74BGI6vQ6sE5bfYqLRcTMvpazY0R21q0T2zw2lAL+EWYGR02RUkBa
   g==;
X-CSE-ConnectionGUID: mLtlkxLbQNS9EkmeTx2nxA==
X-CSE-MsgGUID: H7aHnZtNTWONqQSquOlZbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90895802"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90895802"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:20:12 -0700
X-CSE-ConnectionGUID: ixFFKZK6R1uHjwIJ59Mw/A==
X-CSE-MsgGUID: zzAvVh1DQ/ykLau3NaZlkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="300321657"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:20:09 -0700
Date: Thu, 24 Sep 2026 17:20:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Message-ID: <arUxl7QeiEzFlI7O@ashevche-desk.local>
References: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
 <20260923-topic-sm8x50-iio-max34417-adc-v1-2-41d4ba1bfc41@linaro.org>
 <20260924095457.00006ed6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924095457.00006ed6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 24, 2026 at 09:54:57AM +0200, Joshua Crofts wrote:
> On Wed, 23 Sep 2026 21:10:23 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:

Joshua, below also something to you to pay attention to on top of the good
parts you covered already.

...

> > +/**
> > + * struct max34417_data - max34417 specific data.
> > + * @regmap:	device register map.
> > + * @dev:	max34417 device.
> > + * @lock:	lock for protecting access to device hardware registers, mostly
> 
> Nit-picking, but... Device, MAX34417, Lock.

Generally speaking it should be consistent with whatever style is being chosen.
If we go with the first capitalized letter, then yes, otherwise below should go
to small first letter. In any case MAX part number should be capitalized (or
someone might think of it as struct max34417).

> > + *		for reading common accumulator count and control register.
> > + * @input_correction:	Correction based on the Rsense value from channel nodes.
> > + * @input_label:	Channel label from channel nodes.
> > + */

...

> > +static int max34417_read_voltage(struct max34417_data *max34417,
> > +				 const struct iio_chan_spec *chan, int *val)
> > +{
> > +	uint16_t voltage;
> > +	uint8_t buf[3];

uXX types, please. Everywhere.

> > +	int rc;
> > +
> > +	guard(mutex)(&max34417->lock);
> > +
> > +	rc = max34417_accumulator_update(max34417);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 3);

sizeof()

> > +	if (rc)
> > +		return rc;
> > +
> > +	voltage = buf[2] | ((uint64_t)buf[1] << 8);
> > +	voltage >>= 2;

Not sure what is in the buf[0], but verbatim the above is get_unaligned_le16().

> > +	*val = voltage;
> > +
> > +	return IIO_VAL_INT;
> > +}

...

> > +	power = buf[7];
> > +	power |= ((uint64_t)buf[6] << 8UL);
> > +	power |= ((uint64_t)buf[5] << 16UL);
> > +	power |= ((uint64_t)buf[4] << 24UL);
> > +	power |= ((uint64_t)buf[3] << 32UL);
> > +	power |= ((uint64_t)buf[2] << 40UL);
> > +	power |= ((uint64_t)buf[1] << 48UL);

get_unaligned_be64() / be64_to_cpu().

...

> > +		fwnode_property_read_string(node, "label", &max34417->input_label[index]);
> > +		if (fwnode_property_read_u32(node, "maxim,rsense-val-micro-ohms", &rsense))
> > +			rsense = MAX34417_DEFAULT_RSENSE;

What if the property is there, but some issue has happened?
We have an idiomatic

	if (_property_present()) {
		rc = _property_read();
		if (rc)
			return ...rc...;
		...
	} else {
		...apply default...
	}

-- 
With Best Regards,
Andy Shevchenko


