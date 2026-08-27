Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F03E3152
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819424; cv=none; b=vGnHujJvYHGU0A7X/pM6o7kDUThDhkO/U3aU9gSvKk6SOBzJFUUcYkK6trtf+EpOHgI57IwNJn1prRncrrzW/x+sePhD/8dlK51TbkYLpyHupa3agqU7xiMQ+KD26a9qppnPQ5oxNfqciE9LDHOhxRBbDnBbpS2L13h/WnrUIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819424; c=relaxed/simple;
	bh=yJpyF+5Tc3G8tE31WpMqXfWM3y43ClMVTYl+eMZsTmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkoY2lkckZ7+8xLtPUnAozJE/MoTkmrK33LMxBOix/FiV/YBNiWUj53u6eTVbgmCVXPq34IHpKy1lvsh/k5uw54UCJRtNOR4Gqv7mKGNEDVEgtL9KICFPv+eQNTe4cxdZluS5RYu3YsVdQIr8dLVEaX1j25xSz+JPA/PigpWo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJamGOWR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJamGOWR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4956869750eso11959605e9.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787819421; x=1788424221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gv10IZgS+I8/TcY7gcREpSsUvzMsxKqW3sbwG8Jb3QY=;
        b=aJamGOWR4RskmKAgdzroTT/6XZdn0jLXN4eI42AFneeGhUeKClD8v+xJHo6cd5//dR
         l+7TljvSWDuY2EkxK7lCpsSrJbgYwL9U7KqMIDJ4IH7QYhvaVE/3Gb/lzDwSVHjgr0pu
         nBm86C3Bg69rJtasMMPnQgTISlRCTkJ0O6l1sOvee7utl6ZiIrNh6LxGsqMaHE66u6rN
         AEPpTQoKZSnri660Aqi9iWkuaIVfG/kJwvOd7VKTc7Dic3OkMayKLuXFThQ4bCRN4qZf
         PNQcWp0xRtx18Z1Cs+wQAlxRcMFLCLMTQMnwQz5yukSyzYipkXQkcDT+XGnyPgSma9Zm
         BNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819421; x=1788424221;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gv10IZgS+I8/TcY7gcREpSsUvzMsxKqW3sbwG8Jb3QY=;
        b=YY6hCsy6BJKkLBv8gBdKtFhNV5rMrJtgn/VpuSgXpa661THS7hPM7UBGlVmHNjxPva
         NlToD6oIOVp4p3SZBaHM0TBlUjIIsb5It5J2iY75xa0oX5PDWYt314iFJ7jY8zqgaAyP
         w3qLRdzZHl3nF8jYypJjSVAQzWrySA66w4MdEx6IX4obTUCYr0jqfm6Ic8Rdn4XBk9h9
         YPrtLJc13khzAvX7q47Q6h+ufzsGg9xkwUFd7g0TC43wjLJGXNWqvjl3jPQwrqtnIiVU
         dFCmB248vKY/uEReunAHiJn2Ol6+gaEzzLHo96XWDwAZHGwtxlhj4tF/CL1lvKbWkEZk
         FjXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNyp+atFXzJFJfmJlIYSLt9lTRGyJi+H9ydDeq+nDN0mh6DKq1477UsvN5ad/lgpeEvHWFXzEeN5k=@vger.kernel.org
X-Gm-Message-State: AFuF++kySkXjMd+bbG+2nGdCgqk8vTFfio9wkBq86ivNlA4RhRaNk7B5
	nRbEi9mM5frxbPfxHcX3JnbnUOSTF3AjZ7JwR7u7P+NjzW0nMuN8SMoY
X-Gm-Gg: AR+sD13bYUT43yhFI0arw0XsQZ9JXbC2lvstja4s0YXDSuJ3hZvNpVwXS6ZcYwkS7et
	tXT75/pjqZbaXCxR0TOnuL//0DxDSC3UWpI6fxa95H68+P6/9SlVQXc6+JwX5uKfNpCf7fExQ7q
	VNAbXoCPQQ6bZ1PxvAdke8/5eq3zjWLUhTPnsHwwO0CGkzIi7JEd5lp0VKCYEp6eAvZvgESYPqh
	3CLo4SLwdoEKMGjG5LdvcCtuTk9fWZamJBbyZiNHCwFhB3Td77lN6LoHImUrjvnO3a4beIb91RH
	e75qcrGAJpl46RrLH6mrRuLMGtvWMnXPS9CK0UZQ627njAoMG9eWFLVJvXFNmpNYU74h/5sCPBF
	FmIdb7Y3OTLvOIqe93hpfZWklo+AyQs6BB5oVP5n/+W22b185t62Y4UhKDQHBhBxb4TznSghCkl
	bAZRZMzg+OknMjiK7I5l3PS4QtuvnSOveZ9yTkGjjE5Ak+lx90SYQb3Drv1Us7JN/Rc/239j7eM
	l9jmOGfduupLI0ZnalIBn2NlEudFS5P50+CQrVd45z3kvqWqGBU8+cc33k+KuJQlA2WRXRMCzCE
	3YaWoNLa9rQ0Fz32QcbSAkrWJaBVxH0Ltt59F2aIEsHKKsLx16H+y3pzRHgpQr0XTTQ4lX7ya3w
	2Vc5JvVKF8x2GG8Usx4uAUnRq9QbYplHktiTFWQntm6DWY2y8kp7SbApU2UfIyn9v1SVO/i85zN
	WeVx0X
X-Received: by 2002:a05:600c:a0d:b0:499:bdf1:7578 with SMTP id 5b1f17b1804b1-499dc6e9b00mr152209385e9.3.1787819421205;
        Thu, 27 Aug 2026 01:30:21 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd56826bsm53438315e9.4.2026.08.27.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:30:20 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:30:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark
 Brown <broonie@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 "Marcus Folkesson" <marcus.folkesson@gmail.com>, Kent Gustavsson
 <kent@minoris.se>, Conor Dooley <conor.dooley@microchip.com>, Daire
 McNamara <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 <linux-spi@vger.kernel.org>, Kent Gustavsson <nedo80@gmail.com>,
 <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260827103019.00002663@gmail.com>
In-Reply-To: <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
	<20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 09:34:48 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/iio/iio.h>

IIO specific headers should go after the generic <linux/*> headers,
it's just convention.

> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +

...

> +static int ad5529r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ad5529r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_addr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > GENMASK(st->model_data->resolution - 1, 0))

There is a function for this - in_range(), in linux/minmax.h.

> +			return -EINVAL;
> +
> +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
> +
> +		return regmap_write(st->regmap_16bit, reg_addr, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

-- 
Kind regards,
Joshua Crofts
