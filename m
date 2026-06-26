Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30503F20FC
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482167; cv=none; b=Ptry1vTyFeYjeihb+V5iQARyuIg6dvh+15buD2+O47/UdktPPUe7ONjlsbPSWQoSnypK7DGAQ5wZmXyd/CrpYUVHuvc3VTvkZXu5BjgAPbfqo/ijWyqPDywC2adjXBFCe0a9P1Oq3rPRNHGRpE/vELmXupWCxlZa5UZvTthhl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482167; c=relaxed/simple;
	bh=Ypj8YbpZh8DLGxiE+bf5181FYshu9+mBWbj2UyK6dBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbdZW2qd3KGRQ6GEivaDdzTz/ho4xinF2SQE7Gaf+P5/ho9Teg0+csQpSa++RNSJPhn2Tdo5Gj8gF2fnTX4wc++Iag4p/ooNNejEsa6AX1Fto7i53EQx1z5DQHY9QHfTQS6WCG0dbBk0yxGSJwDmumdLHPja8h3rmzaK6gsrlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPcS9bjK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPcS9bjK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7156965e9.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482163; x=1783086963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALRbLCeBb0+qAmaWCzzB4bdRKDNWwVqd2KysEaQO224=;
        b=YPcS9bjKZ0ny9A+W8Q9q9bPxRextRu5ido9d0TX0rQRzbBDbM9yK4DvdiyVlz93kPo
         uGUu3aBR3uKHqr3JsBKk8vJDH/sHXLUOV6HMi9FH0YEIrjtO/IvCAOdlDi+ZFhUA+Cn0
         Fx/lTt087Bp41q4KFWLoIPjYbTyb6Yqr3QGds8XxTFbBt8ckb1r9kazHG97uvXGE9n/t
         95FOobmMno82zIVQLaLL6i6k0N9s6GqzksdzpCTHvjdxH9wSxwc2+IS6sY28ATlbyMuO
         Z3LCQjT5E+dk0GqQk+Iskz2W4w4sbRQRk/RyQD9XpLjtKTa/drfzmu0YPAXUqw4fDGj5
         8SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482163; x=1783086963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALRbLCeBb0+qAmaWCzzB4bdRKDNWwVqd2KysEaQO224=;
        b=RwSK9lyjLedc1cbv6aR4qgfg2QxQucv2hCPLhCWHZ4G0SS0mNwvO/QzyBdlcdSC4j4
         bibvG6mEK+mj9GhEqn+91gqtZIgO8GrSuKK3+vFR6QiHEsPbpvzhwb8w3vOc+SsalZMR
         4azhOLrSa1bL3XdGC8M+KsMkxXKvUO7Uutywxhmm3jy8Hi5fdLtP4Fd9+cSQAPo5G9m8
         BKDWr74p5dHdtN4NqEoU3uQCtb8KbMBMVpHgF8k/24RAoiDx7NC0BW525vLrPHwOZN5t
         9vp8tNZf2xzqfpqIyHaSVi/ZKq2r+rr1FQgtC63hhkqUUcTQ/H/rip0/TwW4ggbLaQGy
         kUMw==
X-Forwarded-Encrypted: i=1; AFNElJ+0Qrq3/mI71h7MkL1tQvwn/eGJWatsiN28Csb57fOQh+IZSv1A2CgyWWUme7NmwTiObU+SGB2e4mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39sYXhyrV/l7ZY5Q3cazJygbcHtwSQBTbikS/+xVskBY7SwVQ
	Nkz9Owa8QL+kste2OxN4E9YT0QmtWdMcx2jJHx5MPBwNtiTWJzuMZ0Dc
X-Gm-Gg: AfdE7ckvZLC5Iqgj6oJckQhXjf7qBCo/lPaRlyoIpy+DKBnrJdYIgJPpV34o/UandU4
	PpkgGN+FW2IV2pEQSLkAVFJ16QbSDxrWeFr70CunIxW+MSrFZ43mXaGZSePclpLq4eXehLzy4vh
	xbG7twhSoXqTNGRsabUERk0PX/7Mtxd1evbN+wwAY3dYJt40YG4zzYmJ6fGgCNWfm6JMKl/7OHX
	pSq/XZXdFY05npVPG2HcN4aiVVJ/mEzJTip1Dtq/GYq+vlisc7sWkMm2I/UUgiiSf343+Wwq0jb
	rSOzjk7RUqS7tCXf1yuqBZlaRRp4Tp7R/S34R3uc+9t7RcLDRcqR+ljj7Lr86irEjpTqgLv6vWx
	HYwFbh0Vf0o2JldbYSg2dtHsh62X3Vq6dBPJQwM8MBkVl39DYqgfe3XsD43slCv1fXqRNza494H
	RR95SW
X-Received: by 2002:a05:600c:e557:20b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-49266862d71mr72584745e9.6.1782482162608;
        Fri, 26 Jun 2026 06:56:02 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926f94f213sm20636875e9.12.2026.06.26.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:56:02 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:57:05 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <aj6EhyuOxBqDDf0X@nsa>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
 <aj5v3rDRlY7H39Tq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj5v3rDRlY7H39Tq@ashevche-desk.local>

On Fri, Jun 26, 2026 at 03:26:06PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2026 at 09:38:07PM +0200, Joshua Crofts wrote:
> > This series adds REGMAP_I2C support to three AL3xxx ambient light
> > sensors that were previously missing this dependency, causing build
> > failures.
> > 
> > To reproduce the build failure, run `make allnoconfig` and `make menuconfig`
> > in which you select IIO, I2C and any AL3xxx sensor and `make .` will
> > fail with errors such as:
> > 
> > drivers/iio/light/al3010.c: In function ‘al3010_probe’:
> > drivers/iio/light/al3010.c:185:24: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Wimplicit-function-declaration]
> >   185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
> >       |                        ^~~~~~~~~~~~~~~~~~~~
> > drivers/iio/light/al3010.c:185:22: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
> >   185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
> >       |                      ^
> > drivers/iio/light/al3010.c: At top level:
> > drivers/iio/light/al3010.c:48:35: error: storage size of ‘al3010_regmap_config’ isn’t known
> >    48 | static const struct regmap_config al3010_regmap_config = {
> >       |                                   ^~~~~~~~~~~~~~~~~~~~
> 
> Now all is better. The only thing is missing is Cc: stable@ line.

I'm not sure we have a defined policy for that in IIO. Now that you
mention it, maybe time to ask...

My understanding always was that Jonathan takes care of Ccing stable
but maybe he just does it and being nice about it, does not complain :).

So, Jonathan,

Should the sender take care about Cc or not? Or it does not really matter
:)?

- Nuno Sá

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> > I made a separate commit for each driver, to ensure a proper Fixes:
> > tag is appended for easy backporting. Let me know if you prefer
> > squashing!
> 
> I prefer per-driver patches, but let Jonathan to handle that.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
