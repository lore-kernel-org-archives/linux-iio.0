Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6313E2ADD;
	Thu, 16 Jul 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190445; cv=none; b=fF+5cbsg/lpqkPmRQwXEDmRZ/2UX2HU/BueVaL5mL6vSrPJVLW9wDwlJ+RkRptQkVHPi4fFxd/mJNmdGp2CehikMKTGdrlVhLlfbGPCoauI2SVVtG4Js51AQgqQKdCkAHsMd31CWfRLn+4XTXizOitlH8Xw/U3hVFqrtMBpasF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190445; c=relaxed/simple;
	bh=5oa/5XioJ8flc5AgybunsF5G261OjV++bUe/mqwllp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbY4RWsPb932JUBX8/E43gJQ04OTyVv2z88ETWIWbAkySufPPWbIet4US1gsVQqtyvdL5rx9zmrt4rZ+hCMJlAFvpphxjGVZk+0bN1eNaLuJ0UkS35TzFUqTNxi/Wvov0tuH3v66H62TlbLWbpfkqzeKP6yI2/q9FIg+UCkey/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbLBWoW9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbLBWoW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784190443; x=1815726443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oa/5XioJ8flc5AgybunsF5G261OjV++bUe/mqwllp4=;
  b=LbLBWoW9hYteGJO1g6kb+rNXvnzHotpWxJAQyKv6r+PzITlLRzpRnO3V
   aLnaMeMLwq6OYQSaBgsvCSqCXhbrEq9S66yV6Ma/G8eKjoNnlOxj0QA4p
   BR04vcTY3pLurBhUSIQjd4/lBUMT6WTYqSYc/s8s5nQg+fs9IAVNzPESI
   2u5eeRw/UMzi86WXgQmpnOaaFteyt1GqugfOUaKwhgm4KNQ8BlS3gS7+2
   5TwKEbowRF6e9mq5CiUH87GergTBEx0oL1q1/idk2oNmIpu6jZ8MrTokt
   sYHducRI9kbHfIT7NyAxqAbYF219fN12yg3UsOrxHRDjxFfNjNk910Ol/
   g==;
X-CSE-ConnectionGUID: h2w9YV7GQRKEI+wCoWcAtw==
X-CSE-MsgGUID: ogzYXKXyQoumUmo0B/p3CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83826036"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="83826036"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:27:22 -0700
X-CSE-ConnectionGUID: 43hHWRy4SXmvtkTrwMjpSw==
X-CSE-MsgGUID: stKbAuGLSyOVXOgq7dl9xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="279701626"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:27:16 -0700
Date: Thu, 16 Jul 2026 11:27:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: Michael.Hennerich@analog.com, afaerber@suse.com, andy@kernel.org,
	brgl@kernel.org, conor+dt@kernel.org, cy.huang@realtek.com,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	james.tai@realtek.com, jic23@kernel.org, krzk+dt@kernel.org,
	lars@metafoo.de, linus.walleij@linaro.org, linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-realtek-soc@lists.infradead.org,
	mathieu.dubois-briand@bootlin.com, mwalle@kernel.org,
	nuno.sa@analog.com, robh@kernel.org, stanley_chang@realtek.com,
	tychang@realtek.com, wbg@kernel.org
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
Message-ID: <aliV4u6_xzx9D9Aq@ashevche-desk.local>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716062614.1507243-1-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 02:26:14PM +0800, Yu-Chun Lin wrote:

...

> >> > -     ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> >> > +     ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base,
> >> offset, &reg, &mask);
> >> > +     if (ret)
> >> > +             return ret;
> >> > +
> >> > +     ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_WREN_OP,
> >> base, offset, &reg,
> >> > +                                &wren_mask);
> >> 
> >> What constrains these two to provide the same value back for reg?
> >> To me it seems like the write enable might well be in a different register.
> >> 
> >> >       if (ret)
> >> >               return ret;

...

> >> > -     return regmap_update_bits(gpio->regmap, reg, mask, val);
> >> > +     return regmap_update_bits(gpio->regmap, reg, mask | wren_mask,
> >> > + val | wren_mask);
> >> >  }
> >> >
> >> >  static int gpio_regmap_direction_input(struct gpio_chip *chip,
> >
> > My initial design indeed assumed that the WREN mask and Data mask reside in
> > the same register.
> >  
> > Regarding WREN support, especially if WREN and Data use separate registers, I
> > came up with three ideas. Which direction do you prefer?
> >  
> > Approach 1: Provide Custom Callbacks in config (Let consumer driver handle it)
> > We can add '.set' and '.set_direction' function pointers in
> > 'struct gpio_regmap_config'. If a driver requires WREN, it can implement these
> > callbacks itself.
> > 
> > static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset, int val)
> > {
> >         struct gpio_regmap *gpio = gpiochip_get_data(chip);
> >  
> >         /* If the driver provides a custom set (to handle WREN), delegate to it */
> >         if (gpio->set) {
> >                 gpio->set(chip, offset, val);
> >                 return;
> >         }
> >         /* ... existing generic regmap logic ... */
> > }
> >
> > Pros: Clean core, no need to touch existing drivers' xlate signature. The consumer
> > driver handles its own locking for different registers.
> > Cons: It feels a bit strange and inconsistent to expose only '.set' and
> > '.set_direction' overrides while keeping other operations entirely abstracted.
> >  
> > Approach 2: Handle separate WREN register in the core (with locking concerns)
> > We keep the 'XX_WREN_OP' in 'xlate'. If someone needs WREN and 'wren_reg != reg',
> > we write to both.
> >  
> > static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
> >                            int val)
> > {
> >         /* skip */
> >         ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, base, offset, &wren_reg,
> >                                    &wren_mask);
> >         if (ret == -ENOTSUPP)
> >                 has_wren = false;
> >         else if (ret)
> >                 return ret;
> > 
> >        ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
> > 
> >        if (has_wren && reg == wren_reg) {
> >                mask |= wren_mask;
> >                mask_val |= wren_mask;
> >                has_wren = false;
> >        }
> > 
> >        if (has_wren)
> >                ret = regmap_set_bits(gpio->regmap, wren_reg, wren_mask); 
> > 
> >         /* ignore input values which shadow the old output value */
> >         if (gpio->reg_dat_base == gpio->reg_set_base)
> >                 ret = regmap_write_bits(gpio->regmap, reg, mask, mask_val);
> >         else
> >                 ret = regmap_update_bits(gpio->regmap, reg, mask, mask_val);
> >  
> >         return ret;
> > }
> >  
> > Pros: Keeps all WREN logic unified inside the core framework.
> > Cons: Introduces a locking issue. writing to 'wren_reg' and then 'reg' requires an
> > external lock to be atomic, which seems to defeat the purpose of relying on regmap's
> > internal lock. 
> > 
> > Approach 3: Assume WREN and Data always share the same register
> > 
> > static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset, int val)
> > {
> >         /* ... */
> >         ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, base, offset, &reg, &wren_mask);
> >         if (ret == -ENOTSUPP)
> >                 wren_mask = 0;
> >         else if (ret)
> >                 return ret;
> >  
> >         ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
> >  
> >         ret = regmap_update_bits(gpio->regmap, reg, mask | wren_mask, mask_val | wren_mask);
> >         return ret;
> > }
> >  
> > Regarding this approach, I would like to ask from your experience: Is it
> > actually common for hardware designs to place WREN and Data bits in completely
> > different registers for GPIO operations?
> > 
> > If they practically always share the same register, this simpler approach might
> > suffice.
> 
> If there are no further concerns, I will proceed with the third approach and
> send out v6.

From the above list I tend to the approach 2, but this might require to have
GPIO regmap level of locking. I'm a bit lost in the context, though. I assume
we need a fresh start, id est issue a v6 with approach 2 or 3 in place and
summarize the choices in the cover letter, so we can understand what has been
considered.

-- 
With Best Regards,
Andy Shevchenko


