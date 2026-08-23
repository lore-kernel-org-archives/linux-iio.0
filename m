Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EC270EC3;
	Sun, 23 Aug 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787474125; cv=none; b=l4pDiGprn2SPT9L7dRV2BXiHmI+F4Iz7iCMcOz92fWKM0C6AvYn+qCsX+spXd0iDTYhKurpqsJIBn5otl8N5tC4CWpBjJfkTpkOQG/bkc/XVz2xDWe3rGxdvdoZhbbU+lnz9nC/aQ38LGs4axQRp6Rg0bR75tFT0yqWtGkEVc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787474125; c=relaxed/simple;
	bh=xG4lz1yM7gf8EYfruFQf5zCEd4+W3L0sSo+itXvqSbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiCp7HhnwbsXqK2e53/PkbR8KBb22etinNO5XK8h1mEHA2SjSDVvE58bMSjlJWYNS0R/csuVRon+fmVIYNTioEb3qEl8s50+nJ1vWbRNkd93z5sq04fpvi02fMcChmeVaGM2Qk32ORmH1y5KxkVMpAx3eqw3SbVNpxorF75UskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPh+jaVx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPh+jaVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787474124; x=1819010124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xG4lz1yM7gf8EYfruFQf5zCEd4+W3L0sSo+itXvqSbk=;
  b=KPh+jaVxeX1nZWtrS4/fXlWZLh+2dGOvamYcEsFWnOEsg/2eNCyagoDg
   0CcWjLX7zCq+61j+qzPSspoIHRn/477k4EdUFapwgfJhZuOtdgLX9PGHr
   jlS72Y3wc3gK0DXpTnqC0ZN9z9fFPF4sfsf7PAzjHuG0dL2nn2hzRpSbj
   mLhlNNfh4Q6sya4hPkUoj2ZB2frEJTzod1tRiryHm+XUraRlmbcxXZeCG
   GSKqRt3G/GYGVUkc5TG63bkHZmVNw9UrtdkJDlN4G94yZVJYvG3owPUZ6
   1TQBCZzXoFoQSQaoDxHn6SRU9X83eeF/iwcrl8GOH6KPrN2nEufqOf+GH
   g==;
X-CSE-ConnectionGUID: aEE1nh1oRq6TaPFPmFS/tA==
X-CSE-MsgGUID: OaExqMfgSlGfzc5FAuo2ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="98545522"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="98545522"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:35:23 -0700
X-CSE-ConnectionGUID: 8059gAHgRv+SoNDPMdaYZw==
X-CSE-MsgGUID: COe38Vd3RdGV9O0IHUJe6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="263020648"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:35:18 -0700
Date: Sun, 23 Aug 2026 11:35:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v4 05/14] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <aoqww3LcT0yOLC-y@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-5-bb8fbd06d4eb@analog.com>
 <10d575af-2a2c-484b-82b0-0a00de1c50be@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d575af-2a2c-484b-82b0-0a00de1c50be@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 22, 2026 at 12:30:05PM -0500, David Lechner wrote:
> On 8/21/26 9:06 AM, Janani Sunil wrote:

...

> > +static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> > +				   const unsigned long *scan_mask)
> > +{
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	unsigned int channel_mask;
> > +	unsigned int standby_mask;
> > +	int ret;
> > +
> > +	channel_mask = ad7768_all_standby_mask(st);
> > +	standby_mask = channel_mask;
> 
> Would be helpful to have some comments to explain why XTAL gets special
> handling so that we don't have to look at the datasheet. (I see something
> similar later in the patch too.)
> 
> > +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> > +		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
> > +
> > +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
> > +		if (test_bit(c, scan_mask))
> > +			standby_mask &= ~BIT(c);
> > +	}

Make _mask:s to be unsigned long, and use direct operations on top, No need to
have for-loop I think.

> > +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> > +				 channel_mask, standby_mask);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
> > +		if (test_bit(c, scan_mask))
> > +			ret = iio_backend_chan_enable(st->back, c);
> > +		else
> > +			ret = iio_backend_chan_disable(st->back, c);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}

...

> > +	/* ADC start-up time after reset: 1.66 ms max (datasheet Table 1) */
> > +	fsleep(2000);

2 * USEC_PER_MSEC

...

> > +	clock_name = ad7768_clock_names[st->clock_source];
> > +	if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS)
> > +		st->mclk = devm_clk_get(dev, clock_name);
> 
> This needs an explanation why we don't enable the LVDS clock right away.
> 
> > +	else if (device_property_present(dev, "clock-names"))
> > +		st->mclk = devm_clk_get_enabled(dev, clock_name);
> > +	else
> > +		st->mclk = devm_clk_get_enabled(dev, NULL);
> 
> The NULL option should work in all cases since there should only be one clock.

I disagree on such an approach in general. We should not encourage NULL cases
for the clocks. Some drivers (IRL we have such cases) might have need more
clocks in the future and this becomes a problem. I think the NULL must be
simply dropped. Always require the named clock.

> > +	if (IS_ERR(st->mclk))
> > +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> > +				     "Failed to get master clock\n");

...

> > +	/*
> > +	 * The datasheet does not specify a wake-up time. Allow 20 ms for the
> > +	 * ADC and digital clocks to restart.
> > +	 */
> > +	fsleep(20000);

20 * USEC_PER_MSEC (don't forget to include time.h for these multipliers)

-- 
With Best Regards,
Andy Shevchenko


