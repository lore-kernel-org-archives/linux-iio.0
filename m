Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403383B71C6;
	Mon, 17 Aug 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955323; cv=none; b=DL3z29UiRQ+tqO4FInAhTLaUvzci9zoiNgPNYay+yHC+qKAssjYRWKlEf5fpBe8/TuprpmoaapShKSrvJHumD6hdR7MRxlBN3C8kj20tXZQn5eQ91739tyKdLeKPheiSTVPVr0z625msA96uerADnlrndsj/oxmf/sRLpfO7WXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955323; c=relaxed/simple;
	bh=l6oIOVkmn4KQdGwGIXOHPfjm7X5b/7AH2NUJtfXKx+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh5ri/RCBA/vJddolU85V6+akkS+uF6x7+ZdyLdBPcy3So8FkAilMraUek4PsIdMzRgpvOfw4oadzzz1kYHBoup04xTzPra4KCj5iCu8UOhR52cgLMPbMKuccj+p0aIX1JpcVgGugFul+tENDU+i6dVNbqad++PtcR8XdwZeMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfbWr1n5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfbWr1n5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786955321; x=1818491321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6oIOVkmn4KQdGwGIXOHPfjm7X5b/7AH2NUJtfXKx+Y=;
  b=GfbWr1n5FkTQI33Fjwb5weMDPLlYHvEVY3ngar3GYg/+TCtDzF7IwvHv
   cGLd2kOLbMQpX+qYcQj6rVmf5DsolpCuQgNDpeEVZ0hBZC6QhCsM01uLv
   95ajYV6sqrXsBygtNl6w/jX14//6dg4SSoUPNLOxmR4hR8ONLX8Kr4shM
   d17dHM26Dnjj3e204SSyVHzN4nkD5ZfSUM21rI/IGRr71/SLnYtF8imHl
   IdbbDo1QjjDw+BO13lYr3BJwxq3CYyQVvC1C1yTMrFeZQ+NWcYKbMAuJP
   OPjQ/FObiQYwxAHIOQHQC0CcLBUQAqBtZ3Kq8CuePxQtFHt91dz7yP0DJ
   w==;
X-CSE-ConnectionGUID: 6uPEcSUOS5WNQcxE9FqI0w==
X-CSE-MsgGUID: CoewDrgOTcSSj3ZBq2PdiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87550549"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87550549"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:28:40 -0700
X-CSE-ConnectionGUID: tskCHk9QSB2FITl7ChsXtw==
X-CSE-MsgGUID: rk5dc8QMSUSFXX7cgSKjfg==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:28:37 -0700
Date: Mon, 17 Aug 2026 11:28:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v4 2/3] iio: imu: inv_icm42600: log whoami mismatch
 instead of failing probe
Message-ID: <aoLGMkHJZVeyTKxU@ashevche-desk.local>
References: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
 <20260810191157.125550-3-jorijnvdgraaf@catcrafts.net>
 <anoqWLNK9_MzU1YP@ashevche-desk.local>
 <20260817031859.31212035@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817031859.31212035@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 03:18:59AM +0100, Jonathan Cameron wrote:
> On Mon, 10 Aug 2026 22:45:28 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Aug 10, 2026 at 09:11:56PM +0200, Jorijn van der Graaf wrote:

...

> > >  	if (val != hw->whoami) {
> > > -		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> > > -			val, hw->whoami, hw->name);
> > > -		return -ENODEV;
> > > +		/*
> > > +		 * SPI interface has no ack mechanism.
> > > +		 * 0xFF or 0x00 whoami means no response from the device.
> > > +		 */
> > > +		if (val == U8_MAX || val == 0)  
> > 
> > This is strange to be here. If hw->whoami happens to be 0x00 or 0xff (let's
> > assume some hypothetical future case), this check will become invalid for them.
> > 
> > If it's guaranteed to be not the case for any HW (including the future variants)
> > this check should be outside, no?
> 
> Hmm. This one has both worked in favour of finding connection trouble
> and bitten us in the past. I vaguely recall a device that indeed
> had a WHOAMI of 0 (though it might have been a hardware bug) and
> tripped on such a check.
> 
> Personally I'm not that fixed either way on this. If the device isn't
> there we should know the moment we try to get any data anyway.

My point is that the nesting checks are not needed (assuming 0x00 and 0xff are
bad values for WHOAMI).

Something like

	/* ...the comment... */
	if (val == U8_MAX || val == 0)
		...

	if (val != hw->whoami) {
		...
	}

> > > +			return dev_err_probe(dev, -ENODEV,
> > > +					     "invalid whoami %#04x expected %#04x (%s)\n",
> > > +					     val, hw->whoami, hw->name);

-- 
With Best Regards,
Andy Shevchenko


