Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344131;
	b=4c2zB2x0qCf06D4Lmko/Z3OC397TDlIF6JvgnZP1x+ROkNZd9wygsoqkJjE/XwF0vj8y
	 sWVq1qzWwgqrqZytW5vRB1kjWJwPXeiRz6/1ntdPup6de5O0xbK1MdDFBqn6lXdRcOg7P
	 jyUc3g9F8NBMRA1SrJYmDo8/nG5yydULr4hYlfIGhQ5beuQk6+cFtmgMvSjqB8EUZyM1l
	 rG7s+Cz8idNQ9P2ivulBewCtSjPmWhmmPWH/mppIMrPlC5CslXeX6fata/qPSpksEo73B
	 ALomvxxYNOCzo1DNndwUmixZF7pdlYSVIjnoLhS1sC2yJlOK+msfypyHRGI9NmFSAVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344131;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cpJktIS/K83y1xPql3Gq31z2aWfd5QklqTFKy4VWyVE=;
	b=Mj7a/YnVUNG+gbItX/eEZFBo6oRadm4yzYirrG8QcaHb1nAHrrNezHWUHU4IGNXNyE/2
	 ntHmXPP79Lt3J5ABJb6JqwljBUEZPX3ajmUKYh9oFIJcnXDGOLLVr9SQ1bbQKqomjkqKz
	 OOvKI+ZR1/qgolX/QoF4wOEJ1dA6TL5DrVOgMe6mzhU3TAl7rcjL0hSJNW6bYfkOhPzbt
	 sVJjXvlIlLxh2uAwuQpgd48XQGMHrubAXkUCKBvEakZcJI/pIJGhx9l49mivDLBEt06jH
	 HcHgZ0Tg1i32qFMosObXBihiv38hli7Ft6ySET4ijGeu2LZmFbaiBa25QN6q+jMIKKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xs2ZGbbh;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44766606A325;
	Tue, 10 Nov 2026 20:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44766606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xs2ZGbbh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794344131; x=1825880131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQd596kiI5N/MLyQovRLUrTr4aEsv6AfzbzldNGMwOA=;
  b=Xs2ZGbbhn/JIQn6CkTaWeOpYCIlJmk3SI5qXt7tsrLhtQRzZp+V973Rp
   +I1amN6Eurnm0qEr3tgM1+CvYnUgVUQwRyDEuY78JV4dFAZLSsIuPCXuv
   gWdiANouQqMIoi2soAzIha33IyXE1cygvY7VlmhIJTy3MU2vRB7GfscQ3
   SrCmKJnXdORaGnExsZRWJfK7AsUAZVx3gHcAvo2xntNWrFbM4vdYv+FiR
   sEg6QwHCgBWIbkSMLCbv1d0HE+ZmFZ68wMEcrnPODShiVA4coCX1dO1DM
   L7Mkyj5Sbt7t/gyz/PtP7/95gz2R4jq88nmpQBu06XuFE81s9zaqEeYWM
   w==;
X-CSE-ConnectionGUID: 6g905OkySVSobeZ2Ly873Q==
X-CSE-MsgGUID: wcnk18kRROGjEyOYXuUIng==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3139339"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3139339"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:55:30 -0800
X-CSE-ConnectionGUID: Ef/P9v+pRnydVd2ccHmcFg==
X-CSE-MsgGUID: 2+qVTP+eRUuz0XuCMwIKYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="10122675"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:55:27 -0800
Date: Tue, 10 Nov 2026 22:55:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <avOEvEdidRIjjnAg@ashevche-desk.local>
References: <20261110021442.410-1-johnerasmusmari.geronimo@analog.com>
 <20261110021442.410-3-johnerasmusmari.geronimo@analog.com>
 <avOEPk_cwJSqxECQ@ashevche-desk.local>
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
In-Reply-To: <avOEPk_cwJSqxECQ@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:53:23PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 10, 2026 at 10:14:42AM +0800, John Erasmus Mari Geronimo wrote:

...

> > +static int max30210_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask)
> > +{
> > +	struct max30210_state *st = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> 
> 		struct regmap *map = st->regmap;
> 
> > +		if (val < 0 || val2 < 0)
> > +			return -EINVAL;
> > +
> > +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> > +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> > +			return -EBUSY;
> > +
> > +		for (unsigned int i = 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i++) {
> 
> 			unsigned int mask = MAX30210_TEMPCONF2_TEMP_PERIOD_MASK;
> 			unsigned int value = field_prep(mask, i);

Ah, there is a conflict with above 'mask'. Something like 'm' and 'v'
would fit?

> > +			if (val != max30210_samp_freq_avail[i][0] ||
> > +			    val2 != max30210_samp_freq_avail[i][1])
> > +				continue;
> > +
> > +			return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> > +					MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
> > +					FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
> 
> 			return regmap_update_bits(map, MAX30210_TEMP_CONF_2_REG,
> 						  mask, value);
> 
> > +		}
> > +
> > +		return -EINVAL;
> > +	}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

-- 
With Best Regards,
Andy Shevchenko


