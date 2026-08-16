Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3E33938A;
	Sun, 16 Aug 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786903197; cv=none; b=gblZ0xbdQulusi2ymiyJZOBtAR7XQCcFBi0XSZUEu4XxkvIuDU32EEoB3A3HgTiHuGkALrfcIhcUZqVM/z6/cunV3TFZAYtsNsx8rleGIzLKBa6hL3I6gl80l2hIChVJMPW9wvk/ZMJ9rlosqeA6Cdw9kt6yXRbML2XF3fdjw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786903197; c=relaxed/simple;
	bh=m+AHVyA4Fms6veJKynJ2Z9l5iklw6d82MDzPacYWLVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/dPIc4W/BJrcns78F+yIUWwBwLVHlhsiaa5vChOEbHrVWXVRX3IphgQOAuXZHLxNQnBV2c0y48eC+OzpSc5mc9RmKsduqo/i1AGpQ0PWzmp9A1hNnkgnEMN0/5uS5AR6woEKKVA7tPH+kgqznB/l4Rz36PECFKf3K/KpTji+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/fqgBsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/fqgBsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF211F000E9;
	Sun, 16 Aug 2026 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786903195;
	bh=ZeUQpdKTHvnxZxC1r+AH+HSymZUPMRMYHOUDemRgIsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F/fqgBsf8C8ahaHBhqfp9dSCSNtxQ0y1AECXGKd/OK3xPjZWcXfwtjvOJAEKRR5Jd
	 25RAjIm8VtccI9AD3r6L+yGJvjA51dyGM7d+ZeXS181hgErEc8atGijTFQW1U1DnFj
	 kSkREGZu6n6uNzJsfjsPlXSYg9kk11145w+r1uT08nVYc4reI51zbKdAtU0v7+L3Am
	 NLkXg6b17ab2su9lXnXQ3PRJr+NWrJSQWMudjTyZz/xxjWOSD8gnFmpNW0QU+7VmNt
	 P1cKbYbg4n4fbumrvHF7bcEr6JkXZ3gwvows0wsyb2j+EZeFfJ/8Bkpn2Bp+AdA1+2
	 86JjCOGUsae5g==
Date: Sun, 16 Aug 2026 18:59:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Michael Walle <mwalle@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 12/14] gpio: regmap: Add optional runtime PM support
Message-ID: <20260816185949.4205b507@jic23-huawei>
In-Reply-To: <an7TBThRam_n7hKg@ashevche-desk.local>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
	<an7TBThRam_n7hKg@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 11:34:13 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Aug 13, 2026 at 03:57:05PM +0200, Janani Sunil wrote:
> > Some gpio-regmap consumers share their regmap with a parent device that
> > may be runtime suspended. GPIO register accesses must resume that device
> > first.
> > 
> > Add an optional pm_dev field and acquire it before register translation
> > or access. Release it using runtime autosuspend after each operation.
> > Keep the device active across the complete direction-output sequence and
> > propagate failure when setting the initial output value.  
> 
> ...
> 
> >  static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
> >  {
> >  	struct gpio_regmap *gpio = gpiochip_get_data(chip);  
> 
> >  
> > -	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> > +	ret = gpio_regmap_runtime_get(gpio);
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> > +	if (ret)
> > +		goto out_pm_put;
> > +
> >  	/* ensure we don't spoil any register cache with pin input values */
> >  	if (gpio->reg_dat_base == gpio->reg_set_base) {
> >  		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
> >  		if (ret)
> > -			return ret;
> > +			goto out_pm_put;
> >  
> > -		return !!(val & mask);
> > +		ret = !!(val & mask);
> > +	} else {
> > +		ret = regmap_test_bits(gpio->regmap, reg, mask);
> >  	}
> >  
> > -	return regmap_test_bits(gpio->regmap, reg, mask);
> > +out_pm_put:
> > +	gpio_regmap_runtime_put(gpio);
> > +	return ret;
> >  }  
> 
> Instead of adding ugly goto:s, I would rather define the guard and acquire and
> use in the same way as other PM_RUNTIME_ACQUIRE*() work.
> 
Excellent point Andy.

I was thinking exactly this when looking at v2 just now (and feeling guilty for
being late to the discussion!)

Would need a local GPIO specific variant but that is easy to do - just copy
the way PM_RUNTIME_ACQUIRE*() works.

Given how much it will reduce the code churn + result in a more elegant result
for me this is a necessary change rather than a nice to have.

Thanks,

Jonathan
