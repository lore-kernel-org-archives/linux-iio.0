Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC130E82D;
	Thu,  2 Jul 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008778; cv=none; b=Hm6jXi2bAD8/MjOoRdQ/CGLhqTCSZJHvhQfi0zr2cbjClDcN+Jec3zUeXzlo+iQYjGmp+DLTMw5CUbpjGXhL/zC8GNDfdzM+UO2EB0zNVKB52BpwC5W7C7KXx4DqhDAMca5dSGeqkntaA7DyNcDUGUCZfjYmWiSO//4/Eu0jVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008778; c=relaxed/simple;
	bh=Zh3mLY54aGC7XZ1QXAM+vF14TG/FCYJr3S1ymEdMxb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEQ9j+mQuTBETPgtwCpFMtavoTbpbqp5eGTVEQm3bhyKx9upWt3acDk8gDRAfLOfhKYhxuj4hcDrkJwNhBH/2FpDV/y4uMw5VpRA+H8M8rCMAppOiOJ18loMoyd2JwecrDV7Dy3/cGe63dcQuwshbj1PjPaVaQCdWHMxVd1Nc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGC65vUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGC65vUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CEC1F000E9;
	Thu,  2 Jul 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008777;
	bh=jgZ5PGASijShP5pC5l8zHhdOpozcuS9KxV5TuCHWvA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGC65vUGDqogOIGJx6iAzvePK4nQgsbNW6n2puBfcxRlF/iW6l85Ti0n4337btxCs
	 AAhgmXx0m+4kppoTDcvJUeuFBYvHbveuMHtPWIDt/aLgi/W5g766w4uHI4NCNLbY+Y
	 o55EovSIK51IrXtGhUckpB+JwHC/yjMiyxVG9I3HanKrV69OXNsstHmewI3Lk7N+9H
	 pr04fOotyHQtLJ29VRJPP56stS74kaIr7IL2eOM6AeMlWINKJJ75OVokh38/8Auf08
	 9hDw9O4qyE8W2H15CY0fDS69UReoN+tPNueMI79ooE1XbbQNBgcic36HvhYi35cUzn
	 8Vdoq7K2fGplg==
Date: Thu, 2 Jul 2026 17:12:51 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <20260702161251.GA2108533@google.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
 <ajJ30lHG5lEXri7I@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJ30lHG5lEXri7I@ashevche-desk.local>

On Wed, 17 Jun 2026, Andy Shevchenko wrote:

> On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly.
> 
> OK, let's go with this variant.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Some side notes below for the record.
> 
> ...
> 
> >  	struct lm3533_led *led = to_lm3533_led(led_cdev);
> >  	unsigned enable;
> 
> Oh, besides using the old way of declaring unsigned int, it most likely
> just needs to be kstrtobool().
> 
> >  	u8 reg;
> > -	u8 mask;
> > -	u8 val;
> >  	int ret;
> >  
> >  	if (kstrtouint(buf, 0, &enable))
> >  		return -EINVAL;
> 
> We should unshadow error codes (it may return more than -EINVAL).

Right, this masks -ERANGE.

We should fix that.

> >  	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
> > -	mask = LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;
> >  
> > -	if (enable)
> > -		val = mask;
> > -	else
> > -		val = 0;
> > -
> 
> ...
> 
> > -	if (kstrtou8(buf, 0, &val))
> > +	if (kstrtou32(buf, 0, &val))
> >  		return -EINVAL;
> 
> Like in the previous case we should unshadow error codes.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Lee Jones
