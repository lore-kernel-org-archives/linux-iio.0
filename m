Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727173C8C46
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365657; cv=pass; b=DdvjjjGcpTnTGkRJpj5KI/bhk9gTbRaqJbmXnkhTwhVJWIGu2H1Q64t2GWUWd1XJg9X7IuwcUDv6C+ZyT5C82VP8GNfY3XUbZIKQKpyR+foWwfI+WtGyF4UF1OJ5eyPLCRDFUmaxrxeIbZn2YGdai/meXjsJxDW/EjwHq5bCiBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365657; c=relaxed/simple;
	bh=XcwwmNFeGKOz5wm9C4M8dp6d2E7Hb2byMKXE7ZZMrtw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTbH9C17DNqqbrIqyGsuCufLSiLM06wQyJl8e5g9srJ/4WBHJR1Brsrxkal5InyLzEKn3rUG0tIA2CoqeRJZc/wGncWyhf3g8F2Td/wfTVu53VrNUq6XUbmbSKkiUKQ++0V+zL7kbcmeGBZ+6vRr2RlsIUwuYHFWIgqaFtvxTmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Mj99HXVk; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Mj99HXVk"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd0209f25c1so1022837566b.2
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 05:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779365650; cv=none;
        d=google.com; s=arc-20240605;
        b=NTlJUoMPRRv62VytKaiI6eW7xj6cP0UYEavjeHxfv6FtRWpO3LQHGyM+Z19DUBh3tF
         VzCLRMMlWY7dktT9Dovatcubh4dqAgmBrzfg+EH78YtiHRpq+d0SN00o6yrt3m9HRZT5
         2hf7hfeqg/+W70LcAF9YSHMErQrhy5WY2lfS6Ok3WmIp9oKPFgEuRlXV/noOrNVDrYAY
         Lmw+uB6rHg1bDsUD4Hb7qZfOwsIYJf4CnUG/jrQeO3dsWC4M664gkJOmN9hccSNYk+PY
         0u4Ma02t7+HJK+geTPqDVf8/apAZ+4+BaSx+3unC6fKlKEP4WWlvHiEqUb9V1bJ+abyd
         BXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=kCAT/FSMB8tJhmNGpR3NQBa4aJk54FUzKfLnS0Vjt6c=;
        fh=j432/7n5QNoFdsOzuvIFmD4s3EjilXK+f/c8s6aNwHk=;
        b=TKF6TUgR37fDOHwkix3chy2Wk2I2ux6LwmBdPmJUHE4XGTxZjzpA0UPRYKQkq43xGV
         AUKVDdNO49/c5mH/6tTXHRtV5C1Tqqt0+ljWdoSN4prTec6OdMreR2aEsY08dbqbJj6M
         sOocT8ZPZ3mIDhKZ07NiBFySsYRrma9MGsAJXXYbMdEA3KJzG1ofeBvMyZgtMml2xNGj
         d0mS8K625zH9KlE1gcWy5i8Npvl1eKMvoS2OZGlNbWvqN5I7hbyfqP0jxdmlc/OFtBKD
         O7/Zj4gCYKbO0QCnOjhDyU9aOXfgYC/C5Lxl26FVlQJoZs3AoCweBZQfe6uq0imIQYqx
         vZdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779365650; x=1779970450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCAT/FSMB8tJhmNGpR3NQBa4aJk54FUzKfLnS0Vjt6c=;
        b=Mj99HXVkz+CzoXfHtHVoterzF7WtaGMSCY5VZzh3UZDOI/OagccuPLsayOnc7fUVPN
         h5liFIEP/G/uXqP6EgV0JqCbr432DqxGtJ6yO713aggPm2LAiyTGpHNSTmc4XPvLvvP2
         55YRYP2tmXuPm3I6t80MBEK5qA9noMSoW2z7cDXZsIYVYvx+LUmfcFZF3dK5sQH94tc2
         qOOXEzYQvvTc3e6ASmAB+X/wskYuJQK2nYVkRmzO5T+rngNf7B/5he95Dc76zV5ao+T4
         QoH0DJrNKfa82ODUMjBuRmZ7X3/0+908nu/qOwuNqRrygeQXeShiWrEHCgVMV/Wz3eVp
         0jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365650; x=1779970450;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kCAT/FSMB8tJhmNGpR3NQBa4aJk54FUzKfLnS0Vjt6c=;
        b=P8Sl/lIs54O1nyKlQiMnRG8GcNhiam+Px8YwPbAKjo40l6NeihkKiR1XLFI1RIb6Te
         ILXg7wUXFSjG/e06mtj8d4HvB86o19WEnUMZai73cH0TuBvYJJc3vbBxAgefLtKH3bpJ
         BwGC2t+09tsiNZ7QSedua1k+OkI0MWOTm72eaxdci+FycnRZi+Z6LkIXBrnoLCip2CK9
         /V12l96KwTlzaUhVMPkqE6SphPDY6ICIUITzTIGved6ZdftroVrQUDE7IOVHCnqwf5ve
         QvVb5UwseF4YP/bTUu1yt1/8J49yST5aSPQsRXtUT/fPI1vB5IG+lQ6UFBW6Q19hi+GO
         ylBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XwFeUlPrvWMaz15T5uOZ/OlrSwfsnvLzONVPXD9iZGW+WYNYGiF/0wNNAzRDjj2w6K8lqJ0In9HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnifZH4fO7VPaUuLi1oX1JnWJWrKH5GkgtKCHsM+2T/6UppOe
	dUJknMdKGAac5V9B1TfqwGVn1pkESZW3u730aPy+gqLfRJdK6a0HqpIp1tiGZUfPpY2BIhrbNlN
	Xoc+tVJd5j4XvfRUyAztBupCdygb9zSkWgK3FL78iqw==
X-Gm-Gg: Acq92OHcTiTpKW2Z8fCcktiiQFSwZRJN6lAZtGSGGgLlklKJ24x9Jhy2TzFEicoCs0u
	RZW/Cuw3E1UFwFgwTI/ZlGs9nAfDXywMeVG4l3IDmGAq6QxsIyjhBR+5gHddC0BppVKm2FUoRj5
	u4GlL/P8aJodpgq8JiO4tVGPNlS+7wqVeWyxrzVekfAmAG8so0mkZsHwzw9qYWnuK5FKJ2DjmPr
	biKveSelc+PitSK9JiugH02T+xOZbLo2oJHiXyJc56BvvRtNHa8tPHqBiXTSDFKCJCcMU7ZFJ7G
	6KO7El52NL7xbJlnqeao/t0uugC41ZK8C/l0
X-Received: by 2002:a17:907:6d27:b0:bd2:e940:db38 with SMTP id
 a640c23a62f3a-bdc17d23987mr141007766b.28.1779365650245; Thu, 21 May 2026
 05:14:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 05:14:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 05:14:07 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-11-fcdae50cf51a@baylibre.com> <agTe7vZ94DnmD4Ed@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <agTe7vZ94DnmD4Ed@ashevche-desk.local>
Date: Thu, 21 May 2026 05:14:07 -0700
X-Gm-Features: AVHnY4KQ9snIXNmFVw7beAhQpkjp4lsWxF_SmKnG6LJVzoen_-CkRZHjCww1Cio
Message-ID: <CALSJ-wBbjwrhTEpfKm-JHox7-E1YRQ=kTj1JN+KyiucTTu7c3A@mail.gmail.com>
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

Hi Andy,

just few points below, the rest has been fixed:

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

checking size in ColdFire arch with last kernel.org gcc had no benefit,
anyway put regmap before

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

i decided to stay inside 80 in all the file, is it ok ?

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

same as above

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
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Regards,
angelo
