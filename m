Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59C18DB01;
	Mon, 24 Aug 2026 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559231; cv=none; b=XDwxnDhbnywbJMmA767qsg1LO+NH7IRqAGa3FbyILHYsn64U0iCauN0Xw9dvNrhGY6X7mX+tWTmNH++vRr16GGxCU0PnxjJ7Xtm3vSh8oVraP/8L8iu9cOu4ytJDA6mw/tsq4uRIojUEgdIcMzMnczS6s8ndI2myiD+aNdh0FQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559231; c=relaxed/simple;
	bh=28tdcNeYvivqfO6xmJCs3eQvMTf7EWGHzRJJZsjamd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSz20zDbQRMpLxWQDQl6bj8R7Jj8JB/v7nq4r/m/T4E8OQmoh+GlpiMVdVm0uHJbvOkY1Rlz1//kGjehdEZ2IrcZqHd1PyRY/+PwZnqgqh1JjggzKCIZj0koWMdMK9rKKMd8ZofwXaA6PsOU+gmFOi8Zm+OLjIl5w1pnRRMwEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDItu8eq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDItu8eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787559230; x=1819095230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28tdcNeYvivqfO6xmJCs3eQvMTf7EWGHzRJJZsjamd0=;
  b=MDItu8eqZgxNg0K32gVYOof0GEcNswvu+FDJJMUEZfc2ETr4t9QKOxFd
   GfDyqBoZazd/9SlS5+rbjPnfrvNGkP1zbxhMs1PSgfC+iSkhKCVHjCVeS
   VSyvZ/p6z1HTOojqrd1Z0tP/8Odmf8zR242Vd+QWJmaLcLFnEfQySrotn
   IpDC/pIg4qXYbndhL5g1L8Lf3d1k80+N+kvnQP+W6BqEJiB7mN8zJVhrQ
   ukSvWAvMLZwOuCUi9LpuKGQOuyW8BZWPGluYc4cJ9dugbpcZPeXNwdfkp
   z/LE/KeEFQnee2lnxnLrq97q54bWDZeGpvIq/55L87a5WVhj3GjjG96E/
   g==;
X-CSE-ConnectionGUID: q8YICUUMR4SVgMjSdZcWgg==
X-CSE-MsgGUID: Fd0ezUfCQdmyBcXDOMYEag==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87769170"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87769170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:13:49 -0700
X-CSE-ConnectionGUID: NYnPaUjXT9K2smj8J4yUxQ==
X-CSE-MsgGUID: ig49bFpbSOKtqUFni+Zl3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264316491"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:13:44 -0700
Date: Mon, 24 Aug 2026 11:13:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
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
Subject: Re: [PATCH v4 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
Message-ID: <aov9NcmRhx3XgJpl@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
 <20260823203947.3ecdc448@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823203947.3ecdc448@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 23, 2026 at 08:39:47PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Aug 2026 16:07:06 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
> > The AD7768 provides five GPIOs controlled through registers shared
> > with the parent IIO device. Register an auxiliary gpio-regmap driver
> > and use the parent device for runtime PM.
> > 
> > The device has separate input-state and output-latch registers. Add a
> > reg_mask_xlate() callback that checks the line direction and reads the
> > programmed output latch for output lines while retaining input-state
> > reads for input lines.

...

> > +static int ad7768_gpio_probe(struct auxiliary_device *adev,
> > +			     const struct auxiliary_device_id *id)
> > +{
> > +	struct device *parent = adev->dev.parent;
> > +	struct gpio_regmap_config config = {
> > +		.parent = &adev->dev,
> > +		.label = dev_name(parent),
> > +		.ngpio = AD7768_NUM_GPIOS,
> > +		.reg_dat_base = AD7768_REG_GPIO_READ,
> > +		.reg_set_base = AD7768_REG_GPIO_WRITE,
> > +		.reg_dir_out_base = AD7768_REG_GPIO_CONTROL,
> > +		.pm_dev = parent,
> > +		.reg_mask_xlate = ad7768_gpio_reg_mask_xlate,
> > +		.init_valid_mask = ad7768_gpio_init_valid_mask,
> > +	};
> > +	struct gpio_regmap *gpio;
> > +	struct regmap *map;
> > +	int ret;

> > +	map = dev_get_regmap(parent, NULL);
> > +	if (!map)
> > +		return -ENODEV;


^^^^

> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(parent, pm);
> > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_set_bits(map, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_UGPIO_ENABLE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	config.regmap = map;
> > +	config.drvdata = map;
> 
> Why not do all this in one place rather than init then later
> modify?

See above the answer :-)

...

> > +	gpio = devm_gpio_regmap_register(&adev->dev, &config);
> > +	return PTR_ERR_OR_ZERO(gpio);
> Could do
> 	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&adev->dev, &config));
> 
> Though maybe it looses some readability?

Fine with me. Taking into account my previous suggestion (in another reply)

	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &config));

which bumps readability back to track a bit.

> > +}

-- 
With Best Regards,
Andy Shevchenko


