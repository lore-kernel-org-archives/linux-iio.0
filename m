Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD4245005
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051892; cv=pass; b=fqtJQ5EjWvp9frvdtxuZUyh3XapBehcUMSQU1XliFOX6kYSAOz6cpIhyytgoGTfXmsLx7Nlthsh9Gsbfy3Fg/hjaPgCqC/ivQed5UlLomYbtVESnKaak9gD+IpFESlWYlStcP2nSC8CIb40chiE/blHLFM/Fu12qh5xC6GLFi9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051892; c=relaxed/simple;
	bh=8Y7tVyTdZBcAIIySBt03TMMlzrrlO8mFfiBOXkd/HWc=;
	h=References:MIME-Version:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IegXSpZjmeASbSHcI8fGhMI5lsATUJ80jY+Ag4alNSYXoabk5tmHcDvr98t+sdlrgbz3mSQkb9w4WJM6rTg/dpdwAKm8kwy0GBXOizgA2H2fnFYDk0I8hkohTDQKax2NJRmG5SX7s9TBnT5VXmEZI8D4Fb5TcD19xABYlfpFwCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=KfNdSrQ6; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KfNdSrQ6"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9d9971d059so225087066b.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 14:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779051888; cv=none;
        d=google.com; s=arc-20240605;
        b=eU485aGyG2VV0+T2Uy0ZzXXagh1E6jRJlAJKRLx01ETO4V+HxUEKey7x1C4mKQTQYs
         ozwXIttj8x06fm0UxMj0UAMHLIIOSuRNC+LMjALvZh+O+aOnbjebG7oQRt/qrdjE4sG8
         W4wOHfV+nsfng6+cdueBs1oAhGJtCBOYeX0n9bAaxvkjomsurVX9BM/ZZ8JaFhSyZyNz
         oZyV2JcKlKBAuWHSumRoJf1B+X/2n/cmsRHtwDNvFnjMdnSxF6dYyvrg1isJqnc211Co
         Oe9hp7nG+askNlY6e50EZN2RYngH5Np9ZboN++9d1xEAtIsJ3ju/CcScbrRNGTRfWTDZ
         LV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:mail-followup-to:dkim-signature;
        bh=hDbYh8nveG6AJ4qGTnJ5WMHjZoY6FKTJ3XlYsYDU5zY=;
        fh=WiuPjogJx2Fo/+BFPAqFLkvfiAE3hJxgUia4R9U2Sxk=;
        b=jVvryByuqvPPxKpz2bwZOjet2Cak6GbV1wDizDMl7st3xuhD63Ot8uGDpcnGhEYQ0T
         l94lLokfOWWsPvUaxhEtaeqNLmLxjpm/UKCOl1h4+bxBlb0MHUhXL0oYwqT3M/SEpLwC
         va99dUraPADnhCJ/gfQIO53ePidMnyFNSSrMazNe2M1ZKHhaBqphPKV/801c1EJdB//X
         D7KAXsbC0Q30LaUO3rgBD5p5vpkA8s27e6wKlYVO68Y4IHx7spTc7DsNscSjRogydUH7
         hmxfLP1yu9FrQNywKVZ5HUUilXmY1X5nwL87NeV9psFwAlpYqXXp4tr5uAnzUOzxIvkP
         bOQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779051888; x=1779656688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:mail-followup-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDbYh8nveG6AJ4qGTnJ5WMHjZoY6FKTJ3XlYsYDU5zY=;
        b=KfNdSrQ6RVsQ5LkF8t+sI0Xl5/dgeKBEeX0LH7mTqrmUEdSUvfJpOVzfrJa0yyGLZG
         myvLqmgN9hi8ckT40VYuIWc+Oj4s5MXYTuUgozClENy50u/bxzRKIVYw7E+8WRxWjHv+
         lFqg9Yro8N2ChFgWzNWpfUS1Xy9F94m0A17+Xe3KHraEaGcIYnz6u41eQb/jQrBdZaeA
         ASnOCV+WLJI6t/ketCAJGGEmWOJ1CiQSYPZUDxWOUK1GkmDjucN2l4oSwKsBg13I2MBK
         UEVEbinN6Jjp6oVF5nvHYXrSMfr4kGkXjn83wtLYO+PkN2/mzEEeqIgx1Uk0LdpO83Xc
         5HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779051888; x=1779656688;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:mail-followup-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDbYh8nveG6AJ4qGTnJ5WMHjZoY6FKTJ3XlYsYDU5zY=;
        b=MYuf4eNEUqkhg40O8BXkzq7goNnpEiYrj/syToV0SgQdS/GANBNS1pg/RlLEZd0z0N
         CNdIcSRyH1sXpUDrqzzMn7EF86iQ7HA+32fH2dgSVgwBUGL0xESggdrwoKYFKkOwxO2f
         vrO6Bumffu97HGMiENXPAg1ien2V0VByF9ZvGx84/Gh0vXWFkMYEusWWaeNgzv9+rjhi
         XhazC7SWhQusZvtcQYwWml0Ehkk1+2tDahSc33OdHXJimSWIEMkeqsm7LFgUdPkFy4At
         xRKDSQv0QYQayl9POemXsnhkewKGhiOoKE/L9LjzFnyF/PTL6rS9ZjRDiyxuXO7gPOfG
         7YNg==
X-Forwarded-Encrypted: i=1; AFNElJ9mSQdIXUr/+15TYXZktujIurj6pni/2fM5pD2/iIaY3HeA/jJdtDSlhPxNMUF40aF09r/fNjSzO20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpvzdVU2tkumK45ZtgIQYbV28BbNd7A20CmIHYW8tzAfyTLkh
	SVGrhUZY5fuiphtPAOUtvsxsRv4N+1O3oOTbVuqBmx+nM0MFsgeBQW4W7UXseWbfaFX4sHFhyqr
	3JmevE+EbVeu9Lt2AH2B0f9PuGaWZXrbA8KcAc1sekw==
X-Gm-Gg: Acq92OHyGEEcAaWpVox6xZWccEisOspbQ7WNL4SoIT8oCs36YB8gOvCKPG0elx6sL5C
	PJc4QDnz+sVca1jsL3t3IfDe5K0OdyJkS410holxXiqkoFUiYCcPXGLaP6cqqhYIYgd53TjVlRk
	JF/jA1/a6v0lzNbqiawDEThk5oZHZKu+K6kh34jTKI0mB3nO69KufXksqOnDB8s++VfL2Bse1pO
	5M7krtkyW8g1N2Vp4NJny86idvI57KIZtjIR6KOwSyaJkJNYuLGlaoVtHchFQf6xMCPbYEfwLS3
	SQd4P36Egngg0vc9B2JauQRLu703cemhJo8L
X-Received: by 2002:a17:907:e143:b0:bbf:74d7:1c4a with SMTP id
 a640c23a62f3a-bd51797a62amr374507666b.40.1779051888479; Sun, 17 May 2026
 14:04:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 14:04:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 14:04:46 -0700
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
esFrom: angelo@archlinux
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-11-fcdae50cf51a@baylibre.com> <agTe7vZ94DnmD4Ed@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <agTe7vZ94DnmD4Ed@ashevche-desk.local>
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Sun, 17 May 2026 14:04:46 -0700
X-Gm-Features: AVHnY4LhOGXoyOJyplIGodv_eunK_4nruqdQdyOYVyqkdOdxsDpZTI4SCFL0VTw
Message-ID: <CALSJ-wB4=fTTTExQf2pdoQVz7v5NjaaYQgwGwE+qoZNb6uzAqA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] iio: dac: add mcf54415 DAC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

H Andy,

On Wed, May 13, 2026 at 11:28:30PM +0300, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 11:14:35AM +0200, Angelo Dureghello wrote:
> >
> > Add basic version of mcf54415 DAC driver. DAC is embedded in the cpu and
> > DAC configuration registers are mapped in the internal IO address space.
> >
> > The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
> > analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
> > consists of a conversion unit, an output amplifier, and the associated
> > digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
> > are respectively 0 and 0xfff, left untouched in this initial version.
> >
> > This initial version of the driver is minimalistic, "output raw" only, to
> > be extended in the future. DMA and external sync are disabled, default mode
> > is high speed, default format is right-justified 12bit on 16bit word.
>
> ...
>
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/compiler_types.h>
> > +#include <linux/delay.h>
>
> + err.h
>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
>
> ...
>
> > +struct mcf54415_dac {
> > +	struct clk *clk;
> > +	struct regmap *map;
>
> I believe that regmap pointer is used more often, can you check with
> bloat-o-meter that swapping these two (by the order) gives any benefit in
> object size?
>
> > +};
>
> ...
>
> > +	.max_register = 0x1F,
>
> No definition? What datasheet says about this? Perhaps define the MAX as per
> last defined register in the datasheet?
>
> > +};
>
> ...
>
> > +static void mcf54415_dac_init(struct mcf54415_dac *info)
> > +{
> > +	/* Keeping defaults and enable DAC (bit 0 set to 0) */
> > +	regmap_write(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_FILT |
> > +		     FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1));
>
> Seems the whole driver ignores IO errors, why?
>
> > +	/* DAC is ready after 12us, from RM table 40-3  */
> > +	fsleep(12);
> > +}
>
> ...
>
> > +static void mcf54415_dac_exit(void *data)
> > +{
> > +	struct mcf54415_dac *info = data;
> > +
> > +	regmap_update_bits(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_PDN,
> > +			   MCF54415_DAC_CR_PDN);
>
> regmap_set_bits()
>
> > +}
>
> ...
>
> > +static int mcf54415_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask)
> > +{
> > +	struct mcf54415_dac *info = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val < 0 || val > 4095)
>
> Do we have a definition for the resolution? I'm fine with the plain numbers,
> but it's better to add a short comment to say that this is "based on the
> resolution of XXX register per datasheet".
>
> > +			return -EINVAL;
> > +		regmap_write(info->map, MCF54415_DAC_DATA, val);
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
>
> ...
>
> > +static int mcf54415_dac_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct mcf54415_dac *info;
> > +	void __iomem *regs;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	info = iio_priv(indio_dev);
> > +
> > +	regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(regs))
> > +		return dev_err_probe(dev, PTR_ERR(regs),
> > +				     "failed to get io regs\n");
>
> One line.
>
> > +
> > +	info->map = devm_regmap_init_mmio(dev, regs,
> > +					  &mcf54415_dac_regmap_config);
> > +	if (IS_ERR(info->map))
> > +		return PTR_ERR(info->map);
> > +
> > +	info->clk = devm_clk_get_enabled(dev, "dac");
> > +	if (IS_ERR(info->clk))
> > +		return dev_err_probe(dev, PTR_ERR(info->clk),
> > +				     "failed getting clock\n");
>
> Also can be a single line, but this one a bit longer than above, gives
> 88 characters.
>
> > +	platform_set_drvdata(pdev, indio_dev);
> > +
> > +	indio_dev->name = "mcf54415";
> > +	indio_dev->info = &mcf54415_dac_iio_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = mcf54415_dac_iio_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(mcf54415_dac_iio_channels);
> > +
> > +	mcf54415_dac_init(info);
> > +
> > +	ret = devm_add_action_or_reset(dev, mcf54415_dac_exit, info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}

Thanks, will look into all the above, together with sashiko, and issue
a v3 in short.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Regards,
angelo
