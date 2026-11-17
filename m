Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942387;
	b=arvYb0Bc2K0EsjsbSseLL9q3GWIW8hQVwRof9X/I3Mr3K9I0ZLO6uhfmF8oIIJOwnGZM
	 lYdhw9zf/0prf2RwJe2WyedpqjJW7nyCDfkoV3jTjpiVbmsLwtMtH+OUZUIGp07SWb5ms
	 yoYzerw6cLErH11pYgH0DIZHtby8m2MQmM+p9RBSvmMWNRDWk8cgux/mmdrs6TUEHILB4
	 4qB/1Um0FQRPqzX4gWcyiH/K+wk6iBCOvxfguPvQh9wg2MCAiMQLH9z5tVtolqsZ9Tq0V
	 otsFcng0j0P1+yT3mmqQ+CVY5peB9z0ipC1qLQpvsU+2oOiRGMu+YO2Lu1DynysCR+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942387;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ONV8yidisx/RIQoXMY9+iP5IXiVVLo6SvS4RZj3FJfk=;
	b=boCDHir35SaUENiDKb/xRDEGSUYOxtHxiHcwN9wisyLARybUEB0Pv+VRcS5VyYNjtgTW
	 c0TBOEzVmHONBbWcNYdKnGLkWLkoroBvTYlYDo8ajeOr7HWM6ew/9BqHJwO/vPY/wvU7y
	 KLwunu1tS9HhAq6EoejH9vSgYKNFzA0eUOKajpUvn5Erxrd06M1DDp61EeFEKviOUZTit
	 VDFWpmczBbMu7WCzEvWSTY2RzjshpMeQS55pJcFlB6MQVOvd68PM7wdGTM6tHW/E4F22u
	 eU/hZqT9ocrNnd46UZ0aVgf3VZrXkTx4GSNh+OvTMzJT8wmJMn+QllemOhA/ettY0kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YBdSkgGP;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92622606A31C;
	Tue, 17 Nov 2026 19:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92622606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YBdSkgGP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942386; x=1826478386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lpi+TTbxwx568hEuDzt3sLnsrTMp++AYoozCyuX0ehc=;
  b=YBdSkgGPltLUKshcORYrtFLdMpOqLzEc9ScSaMfLx3G7uCS4Bh73a8LE
   JbjMEQVgRIF0agbq4jtJwTRCyazAsEqnAYbtYVDna2D3csSZdxYND85gS
   S0E+aK1Nga7v73n6fnMlX6kaW6kEabKqCm7VetzUtfL2gNVjo7DKAt3+i
   /Us51oI9DjOINh//jvPRmL5jP1TKJCYrsXgBw67EV2eFvJnIrL13d9aqz
   FsqkQ3dEDGes1rnssPrv2NZpDobUMI6pWQ5JMJACx3RRYHj4mlYhlp4ZL
   hNfvI/DIZpyg8mLS2KfLTdVGPvRV4PXRnAfj4PKKauKVJ80BFn0sgbUGw
   A==;
X-CSE-ConnectionGUID: NHs2o3yDQOOLHywGB6mj2Q==
X-CSE-MsgGUID: zxuiPNOVRHefUmvFdw8Z/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3650906"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3650906"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:06:26 -0800
X-CSE-ConnectionGUID: KEH076GzQMuK8nmGl3WZww==
X-CSE-MsgGUID: MVdfJmBvSU+PA7xzAc0CNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11846763"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:06:23 -0800
Date: Tue, 17 Nov 2026 21:06:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: adux1020: return early on unsupported
 channel types
Message-ID: <avylrU1cexaQp1mM@ashevche-desk.local>
References: <20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com>
 <20261117-adux1020-guard-v2-2-89707fa070c9@gmail.com>
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
In-Reply-To: <20261117-adux1020-guard-v2-2-89707fa070c9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 07:11:02AM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> 
> Now that adux1020_read_raw() and adux1020_write_raw() can return
> directly, check the channel type with an inverted condition and return
> -EINVAL early instead of nesting the work in an inner switch or if
> block. This removes one level of indentation and makes the two
> functions consistent with each other.
> 
> While at it, drop the stray semicolon after the closing brace of
> adux1020_read_raw().
> 
> No functional change intended.

...

> static int adux1020_read_raw(struct iio_dev *indio_dev,

	struct regmap *map = data->regmap;

>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		switch (chan->type) {
> -		case IIO_PROXIMITY:
> -			ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
> -			if (ret < 0)
> -				return ret;
> -
> -			ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
> -			if (ret < 0)
> -				return ret;
> -
> -			*val = buf[0];
> -			return IIO_VAL_INT;
> -		default:
> +		if (chan->type != IIO_PROXIMITY)
>  			return -EINVAL;
> -		}
> -	case IIO_CHAN_INFO_PROCESSED:
> -		switch (chan->type) {
> -		case IIO_CURRENT:
> -			ret = regmap_read(data->regmap,
> -					  ADUX1020_REG_LED_CURRENT, &regval);
> -			if (ret < 0)
> -				return ret;
>  
> -			regval = regval & ADUX1020_LED_CURRENT_MASK;
> +		ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
> +		if (ret < 0)
> +			return ret;
>  
> -			*val = adux1020_led_currents[regval][0];
> -			*val2 = adux1020_led_currents[regval][1];
> +		*val = buf[0];
>  
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type != IIO_CURRENT)
>  			return -EINVAL;
> -		}
> +
> +		ret = regmap_read(data->regmap, ADUX1020_REG_LED_CURRENT,
> +				  &regval);

		ret = regmap_read(map, ADUX1020_REG_LED_CURRENT, &regval);

> +		if (ret < 0)

While at it, drop ' < 0' parts for regmap error codes.

> +			return ret;
> +
> +		regval = regval & ADUX1020_LED_CURRENT_MASK;
> +
> +		*val = adux1020_led_currents[regval][0];
> +		*val2 = adux1020_led_currents[regval][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		switch (chan->type) {
> -		case IIO_PROXIMITY:
> -			ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
> -					  &regval);
> -			if (ret < 0)
> -				return ret;
> -
> -			regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
> -			if (regval >= ARRAY_SIZE(adux1020_rates))
> -				return -EINVAL;
> -
> -			*val = adux1020_rates[regval][0];
> -			*val2 = adux1020_rates[regval][1];
> -
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> +		if (chan->type != IIO_PROXIMITY)
>  			return -EINVAL;
> -		}

> +		ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
> +				  &regval);
> +		if (ret < 0)
> +			return ret;

Ditto.

> +		regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
> +		if (regval >= ARRAY_SIZE(adux1020_rates))
> +			return -EINVAL;
> +
> +		*val = adux1020_rates[regval][0];
> +		*val2 = adux1020_rates[regval][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}

> -};
> +}

Strictly speaking this doesn't belong to the patch, but since it's intrusive
enough and the change is in the same (touched) function I don't mind it be
here.

...

> static int adux1020_write_raw(struct iio_dev *indio_dev,

>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (chan->type == IIO_PROXIMITY) {
> -			i = adux1020_find_index(adux1020_rates,
> -						ARRAY_SIZE(adux1020_rates),
> -						val, val2);
> -			if (i < 0)
> -				return i;
> -
> -			return regmap_update_bits(data->regmap,
> -						  ADUX1020_REG_FREQUENCY,
> -						  ADUX1020_PROX_FREQ_MASK,
> -						  ADUX1020_PROX_FREQ(i));
> -		}
> -		break;
> +		if (chan->type != IIO_PROXIMITY)
> +			return -EINVAL;
> +
> +		i = adux1020_find_index(adux1020_rates,
> +					ARRAY_SIZE(adux1020_rates), val, val2);

Split logically.

		i = adux1020_find_index(adux1020_rates,
					ARRAY_SIZE(adux1020_rates),
					val, val2);

or make the first line longer

		i = adux1020_find_index(adux1020_rates, ARRAY_SIZE(adux1020_rates),
					val, val2);

> +		if (i < 0)
> +			return i;
> +
> +		return regmap_update_bits(data->regmap, ADUX1020_REG_FREQUENCY,
> +					  ADUX1020_PROX_FREQ_MASK,
> +					  ADUX1020_PROX_FREQ(i));
>  	case IIO_CHAN_INFO_PROCESSED:
> -		if (chan->type == IIO_CURRENT) {
> -			i = adux1020_find_index(adux1020_led_currents,
> +		if (chan->type != IIO_CURRENT)
> +			return -EINVAL;
> +
> +		i = adux1020_find_index(adux1020_led_currents,
>  					ARRAY_SIZE(adux1020_led_currents),
>  					val, val2);
> -			if (i < 0)
> -				return i;
> +		if (i < 0)
> +			return i;
>  
> -			return regmap_update_bits(data->regmap,
> -						  ADUX1020_REG_LED_CURRENT,
> -						  ADUX1020_LED_CURRENT_MASK, i);
> -		}
> -		break;
> +		return regmap_update_bits(data->regmap,
> +					  ADUX1020_REG_LED_CURRENT,
> +					  ADUX1020_LED_CURRENT_MASK, i);
>  	default:
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	return -EINVAL;
>  }

-- 
With Best Regards,
Andy Shevchenko


