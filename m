Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E136317145;
	Mon, 24 Aug 2026 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554266; cv=none; b=P0A7BjEf9IIB4x5cAzarNed1RmC7qqIob+ZwVoZFtgXT3CNLv7TdJ5XzjmTKrcJh4U1/42ls+5cBAwwTUjAoFXbFZfTdP4t500trx49DwFUJ5FZDIwB29AizqamcG7h0hiBAYv68qiQ3/XAoUW1sKjm61DVr7d/FWO3hUrVvh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554266; c=relaxed/simple;
	bh=PmCq9l+GdcajybeMr9AKCenxdrr6SCannxV9wXityDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJJGT5irbhhM4lqNyARNzWG1+s9gyJuz5bKP/X1zo8j5YoZ6m40Uqgd9I6KbzPiIgs3Kkn2gR9V0qsjDXT2HUpejBfIqwZpwrj/9g3HvfXYmzNyIhk5xHHCUtzlpsQ69nuX4Ic8EQvNDbpVJocGsew10LhuojVo2VepzLmmm/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIsTtkIn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIsTtkIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787554264; x=1819090264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PmCq9l+GdcajybeMr9AKCenxdrr6SCannxV9wXityDA=;
  b=EIsTtkInXaPNpXAevgMIOxJ0w1HCRnDUay5ucuD6boOj1VrAVPV1sCDv
   GE1wxUpmJT+xDP33ZU2xUlGpDY6Hg9N7AG2ZF2VzxnoQ2xINknrDIDVjU
   ldWxDlKWc2WaTUwAYE9eUL95BkafL7SxS5PdlZzLbQMTghDy7iCA/uuh2
   022MTqWYscgNxDKuDP6Zsxy7ik3DI3UyGorutxpSc96fZu3LYXJiB0MsT
   aFn7ZNejzEp36KN/CHhKJLVlC52QvFZZmNEw9KRqXffAi8tkoLBzadDAk
   2hKcOBlIHmuxSU9fXhrWIh2QbEC0We2rqEue0/WfBKf6j+LU7E8pPocAr
   g==;
X-CSE-ConnectionGUID: TZqLTs1zQyKMHUNps9E70A==
X-CSE-MsgGUID: I2LOMDBGQJenrk40g9JL2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="90510503"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="90510503"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:51:03 -0700
X-CSE-ConnectionGUID: 9cfZ2DvdRJaOXHR/Mm4YQQ==
X-CSE-MsgGUID: ee11Ov6CTLmOraVBys4c/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="290444809"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:50:58 -0700
Date: Mon, 24 Aug 2026 09:50:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 07/14] iio: adc: ad7768: Add calibration controls
Message-ID: <aovp0Aoz86g_oYFw@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-7-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-7-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:07:00PM +0200, Janani Sunil wrote:
> Expose the per-channel offset and gain calibration registers through the
> IIO calibbias and calibscale attributes.

...

> +static int ad7768_read_calib_value(struct ad7768_state *st,
> +				   unsigned int base_reg, unsigned int *val)
> +{
> +	u8 data[3];
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_bulk_read(st->regmap, base_reg, data, ARRAY_SIZE(data));

sizeof() works good for byte arrays.

> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be24(data);
> +
> +	return 0;
> +}

...

> +static int ad7768_write_calib_value(struct ad7768_state *st,
> +				    unsigned int base_reg, unsigned int val)
> +{
> +	u8 data[3];
> +
> +	if (val > AD7768_CALIB_REG_MSK)
> +		return -EINVAL;
> +
> +	put_unaligned_be24(val, data);
> +
> +	guard(mutex)(&st->lock);
> +
> +	return regmap_bulk_write(st->regmap, base_reg, data, ARRAY_SIZE(data));

Ditto.

> +}

-- 
With Best Regards,
Andy Shevchenko


