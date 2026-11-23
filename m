Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432687;
	b=Nvm9yyiJzz3MuLY8NnBmOAcah83IJdhlH/4Z3f7mrxKHeVkLok7KP/XOJxRenwImz45k
	 kmlV1qncAO+RJNUujQwAxXw/jrrh9hKMZDS4ilEi0rmyPe4Rb1MKY44tp6qK6hn2EfqBB
	 +CMlP/R0yGImEtZxJHAM5c4ixcihH0CtL7xFR9a3jBA8D61/YkZXDVXaxHPsnKQO0V/v8
	 m+4oGKBCbLCHHbQ9o1lOb1HDCken8uLzGWbBpnm1beZk9+9stHAyEumOeEg/3qfGcXvkT
	 VzaQA53Z6vNPZvmIWHHVd8uC+qNoSKY5VD+2I3yptbft8gortLJYGHWj9gn7MCnEUpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ohtcBLlPglNaSWfxorY5RBquMUE4iyKajaz9tnVakOQ=;
	b=ssTc97Z0VNO0RNlCKuQEB7l8+3XE2D4PpX/8MEHBtDWCTIvOWixmOucG7y3lJlb04vTO
	 M95EIEvAKFvPJu6ZNEUdgWLuWMQ4F4E0EmCMTxnxtgHnJD8EQAytwRS12bIUAL6AmCJGc
	 4BkHr/UtJt1k5+m5B8jnvDmW9C2A4IN8UORRR/2wlJWA+dk5TaLLAUgpbAsnDIVrq8kRK
	 jiXkQ4y0iCAe+ty+3VOltLg//Yl2yKGcNX1ijbIBm8j0A3GDSvy23HppxBN1X6IDiAKR/
	 fg1VlnllZ2zpFGULsPIQPzPuLasNdqibgNoA8vyBxoSZDBE2R47Cjy5pyavJhKe5Nsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EcH9GZqP;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B0606A31A;
	Mon, 23 Nov 2026 11:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 982B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EcH9GZqP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795432686; x=1826968686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lZ50IOVZhd0vYYFq5GokMpkOYdrVYZjYUfUkwEWKF/M=;
  b=EcH9GZqPwDhRTLLPIR1YN44i83nBqQrqYJnLCcOWU+k8GYT4dOHlRudE
   tsQlLEb7Etjj/XXqbDL1JGKyj2k3egMvb/vxQ76i0QqxNGkgtvSpJ00RO
   ISjF9Jd5+ibEZ0te08QqBb/MTFymSrIYdAdIU2xVjoVdSWAdqlqm0iurc
   aygAfCaI5jvX5/3cf2m7L2yj1DEQhoP4R1gJ+cFZRMWxrUOAALVJqJCrL
   sB8gwFmlqBNs37fs9/vyUWaRBzwvOx5GYGAXeew4LT4qSR5XI4FHI0V0x
   ajiYYHFXgDisehxVNhcXzdkyL9vfihHyASs70tpJZaaN5HK6rfrlxv2Sw
   w==;
X-CSE-ConnectionGUID: eja871JDQDiFOghLtJMy7A==
X-CSE-MsgGUID: qfXd5ZvER5WY2cXjhVfUtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4287360"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4287360"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:18:06 -0800
X-CSE-ConnectionGUID: 47MqAyMpR/erWcCBw1YXWA==
X-CSE-MsgGUID: kNqU2imxTmeaFcMHgIeNow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11360226"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:18:03 -0800
Date: Mon, 23 Nov 2026 13:18:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: proximity: sx9324: reject negative
 hysteresis values
Message-ID: <awQg6X1ay0zyyyaf@ashevche-desk.local>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
 <20261122074649.239441-4-kapoorarnav43@gmail.com>
 <awQgWmI3HmyqTcrS@ashevche-desk.local>
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
In-Reply-To: <awQgWmI3HmyqTcrS@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 01:15:42PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 22, 2026 at 01:16:43PM +0530, Arnav Kapoor wrote:

...

> >  static int sx9324_write_hysteresis(struct sx_common_data *data,
> >  				   const struct iio_chan_spec *chan, int _val)
> >  {
> > -	unsigned int hyst, val = _val;
> > +	unsigned int hyst, val;
> >  	int ret, pthresh;
> >  
> > +	if (_val < 0)
> > +		return -EINVAL;
> > +
> > +	val = _val;
> 
> You can validate assigned value instead as there are no side-effects.
> But while I wrote it, I have noticed that there is actually one, we
> modify the sign of the value. With that in mind maybe better to have
> 
> 	/*
> 	 * Assume only positive input, negative, after conversion to unsigned
> 	 * is unsupported. // or something like this
> 	 */
> 	val = _val;
> 	if (val > INT_MAX)
> 		return -EINVAL;

On the second thought, the original < 0 check might be cleaner... Dunno.
Jonathan, what do you think?

-- 
With Best Regards,
Andy Shevchenko


