Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6E3AF666
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907294; cv=none; b=Xl7dGqfP3ItEn5Fq9gJyzqlQiT6fYBac/yT17oovwep5SWSOH1Pq2GvCkBykaQGHl4ewQnP3TTquafybNekP9NmHd9DbL0eiYQ1A8kW83J3xJ5LDiKML9iJIsuySkdfReUrJ3zDv1Bwh4jspUtqQ+ugM1g2JDj+cCaTeo8ER4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907294; c=relaxed/simple;
	bh=1wZNWjUwc+vC0bVgQ0ZlbNdOYECuxeaY+pojCpm9HA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkoKpVyh6kjomPGURgYtfs8rPbHiukUkcp7/g1tmS8VMeYgUNxEZS+EV6zOPIVdCdzS5jTM5aI4S/yOKS4/5wwwwuPr8NjX0Vcl9bnh3IhXsPYbCm4lVtZWTT7YS1zAohWGI48704OVoza1xd2LBmB0kZ9afbA693iYJWu8SHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRxHhS86; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRxHhS86"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46019edc13dso1805145f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780907288; x=1781512088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPeReRpnLBnfoJVjUD6XA7EpJ91dRyU67u4RwbeYW+E=;
        b=pRxHhS86/i5lFqEWxQzb0O+X8Zyp37Hv3tGh3OHmku2+J0DMTShEIoDFPF5+g16XoX
         0/xzJY28v1rymS9yzI7KHMRk0IeziIOkWIPqVfkUye8wZJttEFW/FcI+aU86Rikvat9l
         3jA+YliBw41w8GQE7xKZ9EQjOQQbL+YYnxuJjX4jf3aPIR1WfHhJPQdJZuBSe+xnUAl+
         dtoBA37i1x1kYXtM5lfvLefrGVE01DMzYBPcoep0q9+uZ3Eny3uorpfzkgRxuco4ZTbC
         bxYoIh5Qr9/yxZVLN5ZvPQHKjtMWM/Z9Lf1PsHtLLKLv1nCCj0WS1WBtDAK3sVV2iqwl
         OY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907288; x=1781512088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPeReRpnLBnfoJVjUD6XA7EpJ91dRyU67u4RwbeYW+E=;
        b=L2zC+4RK1iKUU8WmXn/QnbyG5q4PkrRXbRTAaTFBR/qEeVwy9DnR73UFG4DcqOkakH
         iVaLFT4qQtchFnRnM7Jvnd/30qNowDAdDcPLsLbLh1AGoPhzOyDqfXvA5EGXDufzLdWs
         Rq+NerulkfDEvB7VM/+WqtyTfjUU7POn6fZYm9ELInPIIzAXWmFUp6BukKNwlr76w5D6
         EoHlY6KHa3K4QcSHMf63NjTqtaCD9cUThvV7KPgtkTVgiWbDlJGX4oNcn2JUlz+dMQzk
         sIqfW/mIjfslbYlt/98ABULd5V0JS4N3pByVWeO6KnPTdklnz9LEClgqTnk5aLCn6KmS
         je7g==
X-Forwarded-Encrypted: i=1; AFNElJ8PTMAWgZQPMoTHlG2h1Ef31cTk8cKVn+xlySeDmbeM7cGEIYjeHPT7WtnDOeGdcA9vfJMroVmVbkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrP2YGY1kf69cJSicsFpaIuptrcSkf5W01zCBjg6Qt3qmxeewQ
	QGh0CxeAYxnM1yqRtrcF7+E6v3OnBx7xS8UTx2Q4EVaXtQWZcQAK9NWi
X-Gm-Gg: Acq92OFD3RflbL1J0fJDToka/TwDE53Oyc+jh311RCd7l9oo7owslXM+nMEbghz/Ief
	lbhVrV66f4YtNMWI9Gv0rSviBJpMOUVPoHTntmZAkNl9oL+sROChNpOi2x3UQtKrZOk/dfnEtia
	/46biSx31VyIprea+DSeaHDlB4lfYv6FvQ2AdVKHG086coNCI/JnQO/H/WA1IAHhpptRRXS3R/D
	Ty+97uNPit7MQ8RbU/STR5TyEK6kl0IbiU4rpKx+M9Y2gKjNVUJPbHZrtNEXye6/d9dY8B94QzO
	SlriQ/EmQuzTNbqNxazcvg9dzirY6xBBRJ5SFFth4lXcp7LBzYjhVAxPfitsRi/Unal4P/vKBj0
	2IurJv6KChFAWXVRJviTIr8DaPlPpVZG+bKaXGK7RzSp8BF81PSgzAOhV/7Z5f0of10hRpiaXVQ
	D9G7xbCBhSGSxNqVKLu4BHshJKlg==
X-Received: by 2002:a05:6000:29d6:b0:460:3233:beeb with SMTP id ffacd0b85a97d-4603233c00bmr13957776f8f.43.1780907287945;
        Mon, 08 Jun 2026 01:28:07 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm49104616f8f.12.2026.06.08.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:28:07 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:29:07 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <aiZ7mVMImugYwOVq@nsa>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
 <ah_k9A9535Vz6PCw@nsa>
 <20260603130833.007c1526@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603130833.007c1526@jic23-huawei>

On Wed, Jun 03, 2026 at 01:08:33PM +0100, Jonathan Cameron wrote:
> On Wed, 3 Jun 2026 09:28:26 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Tue, Jun 02, 2026 at 05:33:53PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add RESET pin GPIO support through an optional reset control, which is
> > > local to the probe function. Also, include delays for power-up time and
> > > reset pulse width.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  drivers/iio/dac/ad5686.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > index 4a8c587ff116..345ca2436332 100644
> > > --- a/drivers/iio/dac/ad5686.c
> > > +++ b/drivers/iio/dac/ad5686.c
> > > @@ -8,12 +8,14 @@
> > >  #include <linux/array_size.h>
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/dev_printk.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/export.h>
> > >  #include <linux/kstrtox.h>
> > >  #include <linux/module.h>
> > >  #include <linux/regulator/consumer.h>
> > > +#include <linux/reset.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/wordpart.h>
> > >  
> > > @@ -471,6 +473,7 @@ int ad5686_probe(struct device *dev,
> > >  		 const struct ad5686_chip_info *chip_info,
> > >  		 const char *name, const struct ad5686_bus_ops *ops)
> > >  {
> > > +	struct reset_control *rstc;
> > >  	struct ad5686_state *st;
> > >  	struct iio_dev *indio_dev;
> > >  	int ret, i;
> > > @@ -506,6 +509,16 @@ int ad5686_probe(struct device *dev,
> > >  		return dev_err_probe(dev, -EINVAL,
> > >  				     "invalid or not provided vref voltage\n");
> > >  
> > > +	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> > > +	if (IS_ERR(rstc))
> > > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > > +				     "Failed to get reset control\n");  
> > 
> > On top of what Andy stated, I'm fairly sure
> > devm_reset_control_get_optional_exclusive() returns with the GPIO
> > asserted.
> 
> We've been getting reports on that not being the case from Sashiko
> and when I last looked into one of those it definitely isn't documented
> as doing so and I got the impression it is a reset controller specific
> thing.  Do we are fine here because the gpio reset controller reset_gpio_probe()
> includes:
> 	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> 	if (IS_ERR(priv->reset))
> 		return dev_err_probe(dev, PTR_ERR(priv->reset),
> 				     "Could not get reset gpios\n");
> Which I guess puts it in to reset?
> 
> So do we assume gpio reset or not for this sort of driver that specifies
> in the binding reset-gpios. Now if the following is implying we need
> a deasserted to asserted transition (maybe?) then we'd need to force
> a deassert first.

Yeah, fair enough. I think in practice it works but we are relying in
internals of other piece of code for it to work which is not great.

- Nuno Sá

> 
> Btw I used claude to explore this and it hallucinated the reverse polarity
> providing otherwise correct code for what was in reset_gpio_probe() but
> oddly editing that one line.  I was being lazy and using the web UI rather
> than a version with access to my git tree so maybe it scraped some
> buggy code from a downstream tree.  Anyhow watch out for subtle garbage!
> It also took a few requests to get it to figure out the logical nature
> of the GPIO signals rather than assuming they were controlling whether
> the line was high or low directly.
> 
> Jonathan
> 
> 
> > 
> > > +
> > > +	udelay(5); /* power-up time */
> > > +	reset_control_assert(rstc);
> > > +	udelay(1); /* reset pulse: comfortably bigger than the spec */
> > > +	reset_control_deassert(rstc);
> > > +
> > >  	/* Initialize masks to all ones */
> > >  	st->pwr_down_mask = ~0;
> > >  	st->pwr_down_mode = ~0;
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > >   
> 
