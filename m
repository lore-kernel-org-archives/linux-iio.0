Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B73D9DD8
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840536; cv=none; b=jRoYTyZtiZ31crHvvO6dZnIAaYIqZU1xMlxk/Eg98/z8/EdyHEg1PgFK6/n3kAxp65Jm8fjYFwLM2LBJXxiQG2PEsBYr8qzqohTg7SCxIB0ODu9TgAxCNUF0mEbsKdRMu9uVJWhMk1xxrOwU0K3+t9NG9jjxxWDW3HCykJuu+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840536; c=relaxed/simple;
	bh=oSYYRF992xkNBj38UQH7xncuI48YTdNanxBrkb/gvBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOoQXZD2WrIF34B2JBgP+mxwipNIYx1p8Ciu4FXsfwDTnDIVZ+hZVunkhiPgjfD7st5elWa2SOqdn57JnTnwnD8R7tB6FXWZKkb9x6rFz2xUW89w7ImGH0Aoo9wLe6JuQMkGqHdiwiVM2R1BAR4u8SSWvAhl9i07+k/VvIHndU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGWAHvfN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGWAHvfN"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so503862f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784840531; x=1785445331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WrydZRpK44o17ihkahW3T+469O/DVylnzq9QG5iYeEE=;
        b=CGWAHvfNld7XhK4Z2WrpC57jFnQqYhEPB/Tyx3MmyVTifFCT1LN2OtUui8+xq76uFq
         +i2i0v1PBTPCKYCYjD9Igpy4KamP1SaHFrArp5k34sBlKlaL8DT2ZToulyOXDF2UOekb
         e5PSYxmVFulVHtG6JA81FYxt8/mm9v51xI37w7E//UnVWuWxrRAZLmSCFNOVL9Q/KgUc
         Uir+R8BLscjov5pyVMCvhHO6BWzSNpv5697yj44ipbjMsr5P1PKbl481xg9muKawuLo8
         y+rxT6YkXuI5MCVZ1HjWTd8bWIBs4lisvy9leKUsKKGCkKSMacZTWSKaUkaxKWMaNEWt
         V7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840531; x=1785445331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrydZRpK44o17ihkahW3T+469O/DVylnzq9QG5iYeEE=;
        b=rwg/0F4HakXRRm8EkFVsRdI7JhWTwJSigwKBeyH4iaPo6EOswddT9+XZty4/wT2rYN
         ZTcGOMYLccgkOaFb+cU4saQAE2byCXVkXJvTi8/f33oKAFPra5LhczZ3XAJOx53M9I+E
         pQJkVTRJH3LazfEf0MElfnOBaJjJ38LEz4GB122m3NvHQAspYYelLhTqxtCVnqhHrf0H
         eAqIjdHSpx4elbr7vLC1IdKnv0gEdR0Qzax1mlbn8SY2lgk8VZhRzOi/swAXqOZk/fnb
         9sVGGQAqDhlkkr8//FpxA3LSGOmppnHj3ENFQYlIkjX9D9Kc+2JzZAiVu1DqwwhdEKjV
         QEfg==
X-Forwarded-Encrypted: i=1; AHgh+RrsbmXkGbW5oBYOiWd5aBAKLqqTSLrxLcSUptlSszE4esuzj2aeA9OVeO9vpQ8EBZ8oDCT/zL8NMfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKk9QfTqvhjzW8y1H0ophXW01m9sDeliy5KuH9I9aLMrYGIzO
	ReQps3p/YUHcT6LHDx4DcvR3lBHYlwHTsY7PbdgTyLAq+OJjXWB6MU/R
X-Gm-Gg: AR+sD10xp3QIhMzsIz4essRCYeZxqBtZ4SlYmi3hU0esY2iPhqkRlImGMKmxeISXF/W
	kwfemIzYSd+YxE46lwV2yNd81/0O/Z0y3I1hpnsZR4tD+q6+BAanEHIo/IAvntjQGk5k03c6/w2
	Msq7QHXhDVxMacikRAl7pa6bxigFztlGpGxos16Am5DsHw5aRBADGDMpjP8lgvSOp7P43R4E1Fx
	dcShlVqp0pSALDb+M+43rommaVFyPAE+UOGj2Xn8d9s4Szth4eMWHfEyNPoCqL3cIVKCl2u26yF
	FwF8KYvuEu5EoBKVpGHIYmWXnxLayaszGiXb1Lr3dmoNttqmTU8vjYuHiriv5MiK1wT1NaUbaXH
	ZMr+CZxoqRLSu+9XpB6tGQhzMuT0UvBLI4AH8JMYC3gO7D3MkaDXgEUb1hqmfeaVhG6WkLT0R4j
	UrClsBCE2weO48haIuRlprW9XdviQ4N4keeDqeHqok/+rI0DoslyF2l56CgbuioqmQH5aYY246F
	Tarkz64AvFhCbB6/E4cY3iZsx/MOKJPY9BzyJ9cYBHTqE3ETDW7nT+vMu/N1xlJ02y431s80Exl
	3kIf1LvunehHM8ddCp+tYivMSkfoqvbV0kpVfhVncE9FxAlnXCkoZ8BpflX6Vw8kFjDUk+4bb5t
	a9+0uhLLcaIo=
X-Received: by 2002:a05:6000:29d1:b0:47f:91eb:342 with SMTP id ffacd0b85a97d-47f91eb0469mr3353431f8f.13.1784840530953;
        Thu, 23 Jul 2026 14:02:10 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c7880dsm19445591f8f.37.2026.07.23.14.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:02:10 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:02:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <20260723230209.05c9f482@systembl0wer>
In-Reply-To: <20260723-mcp47feb02_refactor-v1-3-ee59e63672bc@microchip.com>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
	<20260723-mcp47feb02_refactor-v1-3-ee59e63672bc@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:43:12 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of
> buffered voltage output Digital-to-Analog Converters with nonvolatile or
> volatile memory and an SPI Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---

...

> +#include <linux/device.h>

No need to include device.h, as struct device * is an opaque
pointer.

Instead, add dev_printk.h as you're using dev_err_probe().

> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

Don't include mod_devicetable.h, this header has recently been
added to spi.h, thanks to the effort of Uwe Kleine-Konig.

> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "mcp47feb02.h"
> +

...

> +
> +static int mcp47feb02_spi_probe(struct spi_device *spi)
> +{
> +	const struct mcp47feb02_features *chip_features;
> +	struct device *dev = &spi->dev;
> +	struct regmap *regmap;
> +
> +	chip_features = spi_get_device_match_data(spi);
> +	if (!chip_features)
> +		return -EINVAL;

What about returning dev_err_probe() and -ENODEV instead of -EINVAL?
It's about 50-50 in the kernel but -ENODEV seems more suitable as an
error code if spi_get_device_match_data() fails.

-- 
Kind regards,
Joshua Crofts
