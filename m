Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04664D9571;
	Mon, 19 Oct 2026 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405250; cv=none; b=K0DtWsQXtx7cJfeyixuZU0qJoyQPrNpY4J9m0PxRe+sVtsFuGBP5/maeqNKIMuJjUE22GGrywWMYL6+vR3FwnIER4ywCAPHogueUA3QzwxJgtxyPL9uXYS64bYRrgRaCpRLNdwym0YSt7xAO+N4I6vlhuALS0zpS2zk2NTU/1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405250; c=relaxed/simple;
	bh=8+x3JF0CputmdqIFNuNpkBBjNU4R4OHLw0Kt93RKWx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/wENWVVBpcEhOz1p2YK7UFfxOME7xi4MW98RQoaV8LTm1VQrlZ1eBhSTYNXLcUPkAr/TOi/z+D3eESe/olaheIRxr2eZBGlqt95f7+F1PnNRKbtmXvO49NJW2E3PFXlREOrXzzBDIF8N0zBjmwGtdCiCYUR4/hZX6l8xu1/ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlpERV1w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlpERV1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792405248; x=1823941248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+x3JF0CputmdqIFNuNpkBBjNU4R4OHLw0Kt93RKWx0=;
  b=UlpERV1w9UEN1/bexsVtpnPTiYKWwH639RvVNzxiaia9Q5ZM8BLPx7sb
   jBwd8jjPsVVGjdC24BeuSPAkPSRGDZ6bHNFag3v5wvKUiJOzyASHJtP4K
   sYLaZ8b2schzYoKVy3OxDMOTJhP63/kUwyIUkMLNp00msnkhrycc2xPRe
   1rSvUNPAt9He6GIzuvTGRiiuQ7SCzEwe7qs/FwOHZf13Fl1MOCQcNFRhZ
   8zduKY3IlI9xyeNClyu9yBxxdUMuzbHvodksIrlrkbIFSTGzTcW4K/wbj
   rD5GNfToAw87iXRNRjcFR60QmbhbMx/Bb0D81LICj/BEP4M0/rFkM9QdJ
   w==;
X-CSE-ConnectionGUID: 5lUsqzchTbCizw1tU5RA7g==
X-CSE-MsgGUID: jWb2DVJ3RaChJT0EzxABeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="965787"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="965787"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:20:48 -0700
X-CSE-ConnectionGUID: opklmjYkQlmlpkQzQyWhWQ==
X-CSE-MsgGUID: IZIP1jzyRh6P/BxW3iBaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4258953"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:20:44 -0700
Date: Mon, 19 Oct 2026 13:20:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: berringtoni36@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: adxl345: separate event state from query
 errors
Message-ID: <atXu-v1i-xfbEpr8@ashevche-desk.local>
References: <20261018-adxl345-event-state-v3-1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018-adxl345-event-state-v3-1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 09:42:00PM +0800, Wenqiang Zhao via B4 Relay wrote:
> From: Wenqiang Zhao <berringtoni36@gmail.com>
> 
> The activity/inactivity query helpers return either a boolean result or a
> negative regmap error. adxl345_read_mag_config() converts the latter to 1
> with !!, reporting a failed read as an enabled event. The disable path
> also turns a coupling query error into a successful write.
> 
> Return query status separately from the boolean result by passing bool
> output parameters to both helpers. Rename them from is_* to get_* and
> update the event read, disable and link-bit callers to check the status
> before using the result. Preserve the successful coupling-mismatch
> no-op when disabling an event.

...

>  	switch (type) {
>  	case ADXL345_ACTIVITY:
>  	case ADXL345_INACTIVITY:
> -		return coupling == ADXL345_COUPLING_DC;
> +		*matches = coupling == ADXL345_COUPLING_DC;
> +		break;
>  	case ADXL345_ACTIVITY_AC:
>  	case ADXL345_INACTIVITY_AC:
> -		return coupling == ADXL345_COUPLING_AC;
> +		*matches = coupling == ADXL345_COUPLING_AC;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	return 0;

Replace 'break;':s with the direct 'return 0;':s.

...

>  static int adxl345_read_mag_config(struct adxl345_state *st,
>  				   enum adxl345_activity_type type_act,
>  				   enum adxl345_activity_type type_inact)
>  {
> +	bool enabled;
> +	int ret;
> +
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> -		ret = adxl345_get_act_inact_en(st, type_act, &enabled);
> +		ret = adxl345_get_act_inact_en(st, type_act, &enabled);
>  		break;

It's better to spread

		if (ret)
			return ret;

here...

>  	case IIO_EV_DIR_FALLING:
> -		ret = adxl345_get_act_inact_en(st, type_inact, &enabled);
> +		ret = adxl345_get_act_inact_en(st, type_inact, &enabled);
>  		break;

...and here...

>  	default:
>  		return -EINVAL;
>  	}

> +	if (ret)
> +		return ret;
> +

...and avoid adding this one.

>  	return enabled;
>  }

-- 
With Best Regards,
Andy Shevchenko


