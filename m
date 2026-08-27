Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AE42048F;
	Thu, 27 Aug 2026 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822358; cv=none; b=fpSFp2i1jhg3i5rrLNHMXtG2YbXSY/k3doNBG7T2i3+gwP/RjGwrIUDjjDwNF3cHtDdj6A4Ad6asfzaQnfnBDbvNz59i8QpIShMD1tlzNPXN75xfZKoiBvb7IYl4EulpYBAY83rfJGdRe1LZ8HfPWrT3buQalEA7bpaQrvVcVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822358; c=relaxed/simple;
	bh=MEUF1NgIQ2o8y07dT6rcSGit38kuev4FCU62GKNlPz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXWI1sz/Av2Vu3rD0RzzZmBPKiKNadIq5IJdZSWLt8oYoOltSL/hcwKhrMz7zvRxcozSEPgylQXHBgLrW9HiR1o4lyOWRAl6gQx9DZyQE0b8Yr2BKHvJfPU2YtdMfrbkmzEOJJT6b2LvQs6VOdmsDierf3KHOL+duNxLiu+PTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSSSkgwm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSSSkgwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787822351; x=1819358351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MEUF1NgIQ2o8y07dT6rcSGit38kuev4FCU62GKNlPz8=;
  b=aSSSkgwmfQOcpbsdCWHRW5KabGyjfAJdSv1AST4zGlMPmU2Aa4liPv8p
   DRynbVSwlQGhead7lRcfLs3gKlw6ucifpS1qCveMC/VDTk9/L/24uIE8O
   eWmyOUkaqsH66v74DQO1ABNbCitmm8B8oCbBiLt+7hJQHNKXDoBDOylwf
   QApHiLHiWnnGYHmXZQI6SXkJoeb/+sspRa7yVxyhExUumB4W+iubaUjB2
   j6lzYFgaxEBgV7dHetgBRW71DwOqa1UBIhn+htuNNujYvGwKSeNYFRxH5
   vtgdPl1yiFxxlAbHaGCRFEr3nq0rz86tJZ50i/ASyn6Sgcl5/bF5u73EW
   A==;
X-CSE-ConnectionGUID: 9yU5kLUTQ0+igbCyYSY3Cg==
X-CSE-MsgGUID: ryp5R3llQ/CapXrZf3Y69Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="105692541"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="105692541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 02:19:06 -0700
X-CSE-ConnectionGUID: PoVM2A/cQPiikVGo2Ndg3g==
X-CSE-MsgGUID: G9q0iJJkRr+am2kPlS0P/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="292657822"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 02:19:00 -0700
Date: Thu, 27 Aug 2026 12:18:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <apABAXL3OzSVc3AS@ashevche-desk.local>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <20260827103019.00002663@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827103019.00002663@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 10:30:19AM +0200, Joshua Crofts wrote:
> On Thu, 27 Aug 2026 09:34:48 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:

...

> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/iio/iio.h>
> 
> IIO specific headers should go after the generic <linux/*> headers,
> it's just convention.
> 
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>

When it's a single header we don't strict this too much.

...

> > +static int ad5529r_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct ad5529r_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_addr;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val < 0 || val > GENMASK(st->model_data->resolution - 1, 0))
> 
> There is a function for this - in_range(), in linux/minmax.h.

This is a trade-off and sometimes open-coded variants are okay.
I'm fine with either.

> > +			return -EINVAL;
> > +
> > +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
> > +
> > +		return regmap_write(st->regmap_16bit, reg_addr, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

-- 
With Best Regards,
Andy Shevchenko


