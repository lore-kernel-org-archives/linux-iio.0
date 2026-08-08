Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AF155C97;
	Sat,  8 Aug 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786220353; cv=none; b=GQHOfODWNaA+b43dvW6xte40XsGFIoxgPpJ031CxP8MTZV9rjXCR/m2ihYxhhdr7+w6Bp4ZJAcEM3SjAjdzfPdZBIlIiPrp+mlukDeeF8H4EsRTw9TOv50NkjESSAcd4TcLp4sqiXmz+wwgs5sCT7yHpbpk75gC6EUdmNWBSRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786220353; c=relaxed/simple;
	bh=9nz7IOusqEHgstHGnKEeX2Jy1TVSdKmxQ5tYWtxTVj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXv4VBFu81tNDVC4XR2yrIBxjbjlyUshguhque5PveavKSe7YQMujL39ouuQgNIzl7lJ1Cz9adfH18jEX6iaU2ZtUYxGE3Kv3mPmeRPaiiRWnXahXKB+MnISE2YV6JgdVeKGRgupZX+uD3sLnhZiHccNxx5OWYRTDGagMH2ExAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BClHq0hL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BClHq0hL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786220352; x=1817756352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9nz7IOusqEHgstHGnKEeX2Jy1TVSdKmxQ5tYWtxTVj0=;
  b=BClHq0hLJviCeTnU8fAuG+SZFt4+QN4OOhBkqrRHnSO9GV3QfJ4mLANC
   79jJ35n3cRYeAHGRPeBGyqoNKTh6EZPlo9nYsnePOtCxemaCre3eDSKAA
   tQLIb5FqFR1e0Pm6SBWmM9DvOi7A2x5ouCX4AJSnxtqusa6R9UeeQerFh
   GJZhzjR1Wfy8rVJPlMUqtOk4xIAJ7Kq/V3dzXgZmSEFVEMn7JaIduciXj
   WR4NROlSaYGqJjChmBvRM4kCDWr9CUPGmlJVCJ7B4IHNdJfxjZpsA5V4V
   GgCdMO77uFUJjMgeDG3HU9aU3kGg6nGpRjB1XT6+H2gCZzvpl3wUYH1Mk
   w==;
X-CSE-ConnectionGUID: Q7neAhXeSiuFsuudJGatBw==
X-CSE-MsgGUID: BipdgJZaRPeKyCoHQj0gbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="112340851"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="112340851"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:19:11 -0700
X-CSE-ConnectionGUID: UdLkuQCyROGcgzqBYFhGUg==
X-CSE-MsgGUID: qw/wz0LvRiG1iNvfBEn9pw==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:19:07 -0700
Date: Sat, 8 Aug 2026 23:19:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: ltr501: Add ltr329 driver support
Message-ID: <anePOQh3F2cWds1o@ashevche-desk.local>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-5-c6b768c7c745@geanix.com>
 <GosXsaKWx6E9mVl9UgD6Bm-yOPFZHzktTL8zxE7yEucs3KmgSRhnP5q1undPbc8-rr0hYUCiTQBFM36MfhR8sQ==@protonmail.internalid>
 <anT-9vI9jD8V0Q0_@ashevche-desk.local>
 <87ik5mxt7c.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik5mxt7c.fsf@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 09:53:11AM +0200, Esben Haabendal wrote:
> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > On Tue, Aug 04, 2026 at 07:02:16PM +0200, Esben Haabendal wrote:

...

> >>  	if (client->irq > 0) {
> >> +		if (!ltr501_has_irq_support(data->chip_info)) {
> >> +			dev_err(&client->dev, "chip does not support irq\n");
> >> +			ret = -EINVAL;
> >
> > Can this be
> >
> > 			ret = dev_err_probe(-EINVAL);
> 
> Sure can, if that is the preferred style. But it will probably still be
> two lines due to line width considerations.

Even older kernels' checkpatch won't complain on that long line (as ending by
a sting literal). But it's up to you.

> And personally, as it would not take advantage of the -EPROBE_DEFER
> logic of dev_err_probe(), I find the dev_err() style more clear.

The point is to use the unified template for the probe error messages (that's
why you may find a patch against dev_err_probe() documentation that allows this
kind of use).

> >> +			goto powerdown_on_error;
> >> +		}

-- 
With Best Regards,
Andy Shevchenko


