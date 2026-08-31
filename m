Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F9304BCB;
	Mon, 31 Aug 2026 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160235; cv=none; b=Zp+QsUF0tEUkNaIkePT1r0DRNsXDcLBojXLoct7ipFfmbUpvuUf9eP+DGbXKbmj9c1sgZArNMW2A2zdfh6EUnwYew7qgm9+MuwSaw55bMsH286KWUHcXLLijlYfOxkpEWlcXOz9qmCbu3g36WsaPV7K/UMwHb/+4J64kqhr2rag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160235; c=relaxed/simple;
	bh=/DCGlvKDUkP1G/KwYWNTX6WcOhRQbdg3ohXwUPm4DSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqj5JiX6QT1Epp8/Wnr/dBHbdhO/jGq7CD+22BEkh6uCgWCCPu5P+0G06hulgkAG1WZuc8GiS2cfx8O4OQaiT7pMaUl3VOVNHxyvG6/0aU7Zc0imKH27sMg7aLIxky7WL8OH7iOpYMnLIOCxtSKThAW7CZR8x4J+B5Wq9UYReXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivpasfrN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivpasfrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160235; x=1819696235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/DCGlvKDUkP1G/KwYWNTX6WcOhRQbdg3ohXwUPm4DSI=;
  b=ivpasfrNO1/khff6083xpgkd1i0d0/Sm4B2lCkiK+3WLSUSZakArggIx
   /Z50XhmEuZApu5PugQ+oHzatXFauzbOiEeBKsSDYCwvUyMR2n0Jhkmftj
   hNNR3aDvuGmcISqcLqTapbaN6BDO0iYbdfSlk1HWUrMzpSGeVo04jDfs6
   lV9EPDHE3Osp2zqjySS6ZB9iimCAd73TJRrmteA7qCcl4CMVSsUcVYH5f
   RjSsP1vWctd+mA21UKWNYBIaSAuvjxA9f02rdc+fgXN2sSi4B7xdL6zhk
   7KY3QtweKV8BtC8+HXY43iah3EGphtfBJhUpj1XtHw5vT2OPySrQXTwx5
   w==;
X-CSE-ConnectionGUID: YlqQ7oUERB69DxGTG55Umg==
X-CSE-MsgGUID: Da8nYTSuQJiSGhYBRtTw6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88583721"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88583721"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:10:34 -0700
X-CSE-ConnectionGUID: RdRENIHISO+A1ZRClSZCcw==
X-CSE-MsgGUID: /uYFfDbIQOe5kO6KqRv6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="265478049"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:10:28 -0700
Date: Mon, 31 Aug 2026 10:10:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
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
Message-ID: <apUo4afCh5LhUqIO@ashevche-desk.local>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <ao_z9QTJC_q8gH0v@ashevche-desk.local>
 <178813177252.2788519.10940489053707901297.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178813177252.2788519.10940489053707901297.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:16:12AM +0100, Jonathan Cameron wrote:

...

> > > +	device_for_each_child_node_scoped(dev, child) {
> > > +		if (st->num_channels == ARRAY_SIZE(st->channels))
> > > +			return dev_err_probe(dev, -ECHRNG, "Too many channels\n");
> > 
> > Okay, this actually better to be ENOSPC
> > 
> > > +		ret = fwnode_property_read_u32(child, "reg", &ch);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret,
> > > +					     "Missing reg property in channel node\n");
> > > +
> > > +		if (ch >= AD5529R_MAX_CHANNELS)
> > > +			return dev_err_probe(dev, -EINVAL,
> > 
> > and ECHRNG is here.
> 
> That one is getting rather creative even though I guess the description
> does fit rather well.  So I don't object, but also feel -EINVAL is
> probably good enough for an invalid property value.

But missing property message propagates the fwnode return code (which will be
EINVAL IIRC). So the above is not about missing property, it's about wrong
channel. Note, I have checked uses of ECHRNG in the kernel, and many of them
are fine with the suggested one.

> > > +					     "Channel %u exceeds maximum 15\n",

-- 
With Best Regards,
Andy Shevchenko


