Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54547A0DD;
	Wed, 30 Sep 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777077; cv=none; b=E53/eCI/vhwdeapqe/YPmzEyagNvr1axJPWvHhQIVspL8kOpmPIjerXQb8We/nH2ZW+VkL+aPQV0PocJ0pextdUvuw7gWqzsZCCi6YFtndKJjMyxyy70IRoiOvusFNJH3nvV+Fw6VPMMUON4igL/26S3UcYhZV08iZASgO2qgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777077; c=relaxed/simple;
	bh=PhQX3sDUfwrI0ZOYgYs28c4fyJcMzrHQbMgRhhbqRDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ8qWz0pNpuL4FAljUvpVWX94hsTmaUu5SNJsytJn4/FVrmK0ZoXA2KcbawRV4WxUW9lC6aukT6bD7OM6KFLNWIafMylJmqo25/k/HmEZ/QweEd8N9HPldAplG9QLdy8PczvnAWgb7KI0pdQ7o7x7jo82nEA7msJk+lglZtNjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b51FCUDK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b51FCUDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790777067; x=1822313067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhQX3sDUfwrI0ZOYgYs28c4fyJcMzrHQbMgRhhbqRDk=;
  b=b51FCUDKuchfIMWaTRNC8NmZlozyT3Lcb+32tV+aCYum94JduesiQp2f
   p6gJhUJXMo/4bDKWJqbUDxT0roCG1pFyfxZvGXTY9Gkgi/UPeIqlhwKr6
   xB+NscdPOWBg3xMWVmfZnWZaUW98ho7XiFGfTacmWhX82RP2nQqOeW7va
   vAnz4LfWcc7/3hdg9fAZFxK29WCZLn6l/HV4b9/R+FVPv112WY6iiFwBv
   EMfFUtJd+rEoBUiIhokzteUW+e+iLgO+H/kyihiUJOvvvwgnF44LMVZjE
   OtwvBnw6BO6VgHZ+ZsyLAYfeIXMSO2TxY3i6MEj1y6AAgRjG7Xeky0wHS
   w==;
X-CSE-ConnectionGUID: kbUj7QxjQO6JIvP9ovAMog==
X-CSE-MsgGUID: /77HhMQQR3+fes702tSKYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102040774"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102040774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:04:19 -0700
X-CSE-ConnectionGUID: ipLzaATGQN+0d7jhXNYabA==
X-CSE-MsgGUID: YujcAwxgQu+JZgssQ7YN+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="305201745"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:04:14 -0700
Date: Wed, 30 Sep 2026 17:04:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <jan.sun97@gmail.com>
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
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: dac: Add AD5529R DAC driver support
Message-ID: <ar0W2xQ56wMFvtaE@ashevche-desk.local>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
 <arzTnOTaL97GudZM@ashevche-desk.local>
 <a57399f0-4c47-4b32-bf6a-7761d9b57320@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57399f0-4c47-4b32-bf6a-7761d9b57320@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 03:51:26PM +0200, Janani Sunil wrote:
> On 9/30/26 11:17, Andy Shevchenko wrote:
> > On Wed, Jul 15, 2026 at 01:41:08PM +0200, Janani Sunil wrote:
> > > Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> > > from Analog Devices.
> > > 
> > > The device communicates over SPI and supports per-channel output range
> > > configuration. An optional external 4.096V reference can be used in
> > > place of the internal reference.
> > You haven't added a given tag, why?
> > 
> > In any case I have noticed that there are a number of (not so critical) issues
> > are still exists, so I have to withdraw my tag. But please, answer the above Q.
> 
> I intentionally did not carry the Reviewed-by tag from V5, because V6
> included substantial driver updates. I should have mentioned this in the
> cover letter, but I missed doing so.
> Some of the points mentioned here have already been addressed in later
> revisions and are now present in Jonathan's testing branch. I will send a
> follow up patch for the reset of the items.

Good, thanks for taking care of that.

-- 
With Best Regards,
Andy Shevchenko


