Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE13A782B
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701820; cv=none; b=RKmHCcT1d/lpCXbyZmm/E/59DeKl3ZieepGWczfeCJDehr997n1rwuc8U652bpDS57+Oq95uRX/uNbBCpW6MNsqbCXwiVstntUsUdCCkc8NP2cgzj35EMtbyNTAircDCsBvchI4WXzkXfIqYgRQB2m7pGGryeBVkHvH1nV80wDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701820; c=relaxed/simple;
	bh=PKW1Xnnu9AKa7tuapvs9+DAbuoB4ZJthZ2NlWKW5Rwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuQmoGAwKaj6F7rIW/3K3w9APTguBbjDxgaG+bbKhhXl8+IEwxbPGBwEeQ9zkIn04pT5Ga4B1X/1xnRe4qB0bmEp1vTjrR/UejxzTWXRbzzZITBVwJxQw2Fa9707I1C0x5VJACgI60m4y44f6FW3bYmkc1WhhBOR0lPEMRwyeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjANaYkO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjANaYkO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49553515a8bso42506535e9.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784701817; x=1785306617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZ4Byl1njkQhav5fhUVKwKfbAOGMC8cCPs9+06LJMzA=;
        b=WjANaYkOc5NtbVqUkn0JymiMWcbfn1GrKvq3ygtRalPwTifw1VCTgli1aK1tliJ03w
         TDbctWQsAGNXzabgmT9sYa23UhT9GfIidxufRyXLKdyRMqezFY0AMSbqYM4BQUNI1DUJ
         cR5LSRX3hYuU1Lhm5GIWRFmTo9JyMACXI9gEWPF923wczI7+bQmk4hbvaGrTe2/AHI+F
         XZ14YNUJYLXcvu0UTqxlGg6INN//KiOII92Yk3T4PPpXj+vSYya3YiD5jtqQJcjzbrQH
         Pj787qNJmOFtQs/elTYU7OTiSxP3t+dJhunDyDTLphMEZBZEhruFc1YwRiJuc3bqTOyt
         y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784701817; x=1785306617;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZ4Byl1njkQhav5fhUVKwKfbAOGMC8cCPs9+06LJMzA=;
        b=mKO+zRvM5OHZmhdvME3A2YTlL/OmyKvVKSY2DenjHWVqkpohEjDv+yQzTYgKwNUt5V
         /YGg3v+fzMI2ajVRaDrUlshIa46AEAttML8MwjC1fP4hFR4WRfgSC2UywqI7rFr0rhbc
         vHXFx8MwF+TKYuHv4Mhw47rNItsDm11/0Fsu/Rec7IxhwU1I8JtAhvpYsL68d9ajw+md
         Qlv8+o3SHV/E3CUPMI7en0XHMDypS5b1TIXwpF+AFgN/sPXltz1YeKNfN9QPe9fDQJIy
         5tJtuvKex8hnbn3Bdq4HWMSSdxPY7lg9zJ21WCpFt5TrIHn3mf8UASdPLmZZ/mYmIsrD
         eQhA==
X-Forwarded-Encrypted: i=1; AHgh+RpGQLzX7OF93vXKK0dihjSSsr1o0GkrxJwpl4Tq8A8gj4486Qtez5PeHPmmskn70YMTzZI4ALMZw+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDPEjOHM6/3s/2aITu4IHcVlZT7+qbddez4EMearqUpGfp8TI
	WfeI3GH5+5VDGek3tAEkpdbuCc8nmqLoFd5EpbQD0yOAtHsrrbgZmA6/
X-Gm-Gg: AR+sD10W69HK5/I6clfT4Be2dPv1uU/d1ZLXqxXe8K4bs8pDLuXh2CBK3a9NkkI8RRT
	rWrcazIzcQMA2X01UOZcAD3Yg5RLGR4fMdpgyivQsGoucjdiDD/iyKAt0wN/FvEPsT9bk+EBKXn
	wCypCNFYEn9t7KTwp+hNgPPk55yNx8vJmL+x2NYDUqUv1pV0oHxiWx0x1nmVZ7VNzr5CWVRYBTT
	1a+QmFN10obmxxZ6+7p0mGXEIoG+wT+ab6FKADZHg1Z8LFQeoStsJ/TYP4jQom7gVuNMZFni469
	cDwDrrGkjl9rMN3RE/x5T8xt7K3M5z4IoQxfqTzCIczJaFwhhkYyyi7fygoI3VRN8i5/dKD7hXS
	frCxwrx12xQxVSN2KrTvX8rLOM1tOflJmQXbX6E1JnKVRjOjPbHCTX18wfNDn02r2SC4xajNUPI
	yow327pvwc7v4tUHMniuPuBdF5xA04ZwVpayN7xlBtbb4NW4vuCCRLnUhKP/B9xZFCiplk0MrmB
	Du7ZiIyDXckBfND5d93wUhdGFAitX+b5MQr8a0IvDZml33MTeHFk7YEqx6m3JxoqmE7mzAQMj6h
	fOFggVT+3/S5g6vicV/9ffE0SBUYoec/TnUwgowiZW3CUTHR1nD9W+AvLsen0VdrFlz+I3D54YP
	KqyBmFehI8B22
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id 5b1f17b1804b1-4954a402f91mr265320545e9.20.1784701816772;
        Tue, 21 Jul 2026 23:30:16 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab45df3sm32706965e9.1.2026.07.21.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:30:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 08:30:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260722083016.000062c4@gmail.com>
In-Reply-To: <al_a_pbITuYMg0KH@ashevche-desk.local>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
	<20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
	<al_a_pbITuYMg0KH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 23:47:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 21, 2026 at 08:24:39PM +0200, Joshua Crofts wrote:
> > The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
> > which communicates via I2C.  
> 
> ...
> 
> > +#include <linux/array_size.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>  
> 
> 
> > +struct mcp47a1_data {
> > +	struct regmap *regmap;
> > +	int vref_mv;  
> 
> _mV

ACK.

> 
> ...
> 
> > +static const struct regmap_config mcp47a1_regmap_config = {
> > +	.name = "mcp47a1",
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = MCP47A1_CMD_CODE,
> > +};  
> 
> No cache?

Hmmm, could you elaborate a bit more? I assume you're talking about
regcache but I'm not sure on how to use it here.

> 
> ...
> 
> > +static int mcp47a1_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct mcp47a1_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int reg_val;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);  
> 
> > +	i2c_set_clientdata(client, indio_dev);  
> 
> Is it used?

Nope, it isn't, good catch.

> 
> > +	data->regmap = devm_regmap_init_i2c(client, &mcp47a1_regmap_config);
> > +	if (IS_ERR(data->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> > +				     "Failed to initialize regmap\n");
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to read vref\n");
> > +
> > +	data->vref_mv = ret / MILLI;  
> 
> (MICRO / MILLI)

ACK.

-- 
Kind regards,
Joshua Crofts
