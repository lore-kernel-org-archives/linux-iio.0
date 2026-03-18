Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258B3290D0;
	Wed, 18 Mar 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858522; cv=none; b=NeHMADi8egJyyUjApcnNCVCRajKSDYGtFEGjnGVAPg/bQJEddr+IGrvrfV6VoVj/cYqMs+bSTh8L+QyOhEG8Q91peMrU/w7P2jdO6CvHIdrBZyps6chUqC+StFaj9xBGUd0EgFPacFU8YZBfH40IUExeVEc4mI8g8MKlGTn8aY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858522; c=relaxed/simple;
	bh=XOaTiZHn9UMaLOFROLfov5TVFH+Ngph/fryjaROjd4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwKCkIbUBZNHn4F/b/02a3IvtOsw4JXXg23NT84DdQsEXDIrUHy48jF6ro2E1Y1rYcAz/89aTg/9J0Q/HWrIjoveBKELQs7p3Iwadil/XhJZajU2pnsQ8rtU/ARv/OTNVZ6Q7OkvxQqTsdm2l9UOrPYUBvD8ZGoGDnMrDB1hj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXInBPzU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXInBPzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773858521; x=1805394521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XOaTiZHn9UMaLOFROLfov5TVFH+Ngph/fryjaROjd4k=;
  b=lXInBPzUh85wcEapgU/wOJDLBR9uPwsu9p8Brl3kDxrfaZwdXLHpcqi6
   4YinRmdDShv6fY1CV9mzVIGFRHlPu379e+/3LY9Nq0sSIaODJuMNt5/Zb
   zItkJZylaVPOFC0xKX60ntrXuC24GqXsec0QkAXYcRuofPx2tlwOn2gWF
   e17lDcRrjCmqgUqyupDcojQ8aULnVrrS1d2hDs7cOMli/sl6HSD37ZTOW
   6QFJ9eem5rhZZc382E/oaPICB6LdT5uvQhwktKMzxfdWrCqsf0gkqcGzI
   7e/aq4WerRnSfFJsOnzJj5XR5NTHXWO6ZM4XILwDw9ub79r6Imj2pjFBW
   g==;
X-CSE-ConnectionGUID: hym9qKl0RIuwoh9yTiexIg==
X-CSE-MsgGUID: ON02GIcWRSCJiltue9JdCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78530243"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78530243"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 11:28:41 -0700
X-CSE-ConnectionGUID: UzIakgAVRrq12NOlHw5oXA==
X-CSE-MsgGUID: Zahpa9bsRB+EbyZpLr3K+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221952312"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 11:28:37 -0700
Date: Wed, 18 Mar 2026 20:28:34 +0200
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
Subject: Re: [PATCH RFC v2 3/9] iio: frequency: ad9910: add simple parallel
 port mode support
Message-ID: <abru0mNtpJSPSJux@ashevche-desk.local>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-3-e79f93becf11@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-ad9910-iio-driver-v2-3-e79f93becf11@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 05:56:03PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add parallel port channel with frequency scale, frequency offset, phase
> offset, and amplitude offset extended attributes for configuring the
> parallel data path.

...

> +	ret = iio_str_to_fixpoint(buf, MICRO / 10, &val, &val2);

I think here we just use 100000 as it's in so many drivers de facto use.
ideally this should be fixed on API level.

> +	if (ret)
> +		return ret;

...

> -#define AD9910_EXT_INFO(_name, _ident, _shared) { \

> +#define AD9910_EXT_INFO_TMPL(_name, _ident, _shared, _fn_desc) { \
>  	.name = _name, \
> -	.read = ad9910_ext_info_read, \
> -	.write = ad9910_ext_info_write, \
> +	.read = ad9910_ ## _fn_desc ## _read, \
> +	.write = ad9910_ ## _fn_desc ## _write, \
>  	.private = _ident, \
>  	.shared = _shared, \
>  }

> +#define AD9910_EXT_INFO(_name, _ident, _shared) \
> +	AD9910_EXT_INFO_TMPL(_name, _ident, _shared, ext_info)
> +
> +#define AD9910_PP_EXT_INFO(_name, _ident) \
> +	AD9910_EXT_INFO_TMPL(_name, _ident, IIO_SEPARATE, pp_attrs)

I don't see why you should have so many - lines. This TMPL should be introduced
in the first patch.

...

> +	case IIO_CHAN_INFO_ENABLE:
> +		val = !!val;

Only used once, why do we need this...

> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PARALLEL_PORT:
> +			tmp32 = FIELD_PREP(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK, val);

...and not just here?

> +			return ad9910_reg32_update(st, AD9910_REG_CFR2,
> +						   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +						   tmp32, true);
> +		default:
> +			return -EINVAL;
> +		}

-- 
With Best Regards,
Andy Shevchenko


