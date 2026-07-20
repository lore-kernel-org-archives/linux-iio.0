Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713835AC34
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546862; cv=none; b=qxNMDchITgBUswCDcrFWHFIGm7pQZaVqEdGL4mWZXCi8BuXIjD5njY9/GKR5Njg+h33g88HjBGMk0izmT5S5EWUnuqBL0963iWzF0/sVt34Pyc+o1jPsstLFfhyUr8ddGFlr6hZ9K+OIfvcjER4ayls3uzAogpYFc8GK+u4Go4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546862; c=relaxed/simple;
	bh=qI/gD3S/qEjfbGthvRe3SjVSZjglCA1htCHrVUZuZAI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trlepaAEp/PD/MfMt2JAj4x93lRjzmg+2tm2lGzFdaTcOiSvtcLMmNpFNbMVNixlnuXaZoG9pHr1xtlevXKsH1T9ttZpZDyNg0MShjbENWcb8tuTlWLvlfdJH9kulEm8o5cSPHJez9Hat1aq/P7J9F4bysof/DpXYxfSKOKmgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU+eO18w; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU+eO18w"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso16369315e9.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784546859; x=1785151659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ut/zni2FSakEBKycZIcRJa3SE8OV8p37C4rVCye8Qx4=;
        b=hU+eO18wd94d4svp3DO2RZI+4Ikvxy7JuhCV58sXvoln1sGYHq+sk6o7RUqRiZFg4g
         tfTo8uK3+fn1QXbWXr/PMFRc21/N96mWtcD11ddBUtwJYhTxJWqmHPQFCz07KVggI1Bk
         xTuaDA0ga1D9yb8hHy4muiXxvAdjcmOcJgPpjnBFyqBUpKOYc1N/F+lMgDPUBnN05sLp
         deGQ3V1eNONzrIO+Jqa0IC8qxODpK3xruK4e3NTdiAlfINE4CPbHl9DiEWm/OjrX9nup
         hPfkv/SfzBpB4FhhdhPUuvrW6kDmdJZPqSQYzbI7ui04fi7ONAhpJNUXpqVk8uAWLLDl
         7Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784546859; x=1785151659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ut/zni2FSakEBKycZIcRJa3SE8OV8p37C4rVCye8Qx4=;
        b=s5SDJN3JpdW1Us6RGY0imw0X2BcCXJe4pPF+AOvTNydrgw11tpsLelEN4ISEJuua75
         bpU5yaL83kz87cAevGkGjOzVtg1OXx0tYQ3mZD2uvw0gH0vA3CKR6aeZORCLg6fVJow4
         Ycb2wLZ4OYTGsYIhfBpLLV+4zn0p8hWs7HI3I78kMfhx2ABOweJlfUx+hPrL3FTR5ZmV
         ErPwsp+V2zOXLR/x3Ov6+BqBlzG4Wf84emdLMfCNIHxlrutKX4RDQCMl1kaQhdVZ3BRH
         Szg1HE4SVOL8t50u1wJGnfj/PHDt7eoaMdclN2dl44Hy8BG8FCJbFoMhePN1IOgQxvvw
         J1uQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpac0FWvGLLx++L7KOFxhUl6Cy84EKTrRtrCuNe9iDhzJf1YDFQLadxuTjy9nGwFloXdSj2yVE6K3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvU319z6EvAc6RvPttYoAen+ji9D/1tM8OuXmOTRsfDwf2Hlbu
	rpKTt1plDaE6xDb7XbPn1RF7Y8mIWopZNBKL754a+o4AzGx8jY0rwf7urOjZy8ZB
X-Gm-Gg: AfdE7clRW67wveZxPAlIX/jGQbTBUOR2AAH9d0b+keDpRUj2Tj3mFUOdIcSZfCf8j5w
	wz6jx6CZxTu3CTofxTGQmefnd1qH3PA6sx7WOIDuCy2SD4T7HnAehLIrllSCkW4RGyAFt5qlbJk
	TUA+dnDHjjZOr6KTFvqee/k93rgIW6i63T2cg+1Bi7NWHBA6ECapaocWFBLVr4S2F+GTqLwvkiP
	abTXOxJHwNCDxeoFuljwR+PpGe9yovL3am2eZdldto/lhC573qsxkUdmTlT8r3BFN3rkJJyIvm7
	pW3//RjeCjedR3CGVsN+4GYF6KgRcxtMeRzeHwb8Zn9G4G4zVxp2ZPQmhv4Mjkl4ZFoJrKWi5/6
	y0IA/upF74Zur5jr3Fsh09vDi9bjC9+Pi/ie3VA3CIbhr1twIGBwkOqeMavC7y+2H/lwNd0XwiE
	5j+/yhHhiMm9fBvzUT+2DVPf2omTvA7ImR1MOpQwY5TrHVlbkTm+9w1Ieoa/afJFarPqANpIAMm
	qiX4w==
X-Received: by 2002:a05:600c:48aa:b0:495:4589:cea6 with SMTP id 5b1f17b1804b1-4954a516530mr91898995e9.34.1784546858909;
        Mon, 20 Jul 2026 04:27:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a3e2a9sm271951985e9.4.2026.07.20.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:27:38 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 20 Jul 2026 12:27:34 +0100
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 4/4] iio: dac: ad5686: update device list and file header
 comments
Message-ID: <nxybhlqzbyz5jpwzam6hh72rst37fqcekxhtt6gjqge4t5gh7e@gbbm3g2pklim>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
 <20260719-ad5686-extend-dev-support-v1-4-841ec75cf5d8@analog.com>
 <20260719223035.0acb57d6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719223035.0acb57d6@jic23-huawei>

On 19/07/26 22:30, Jonathan Cameron wrote:
> On Sun, 19 Jul 2026 10:52:00 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Update device list entries in Kconfig and remove device description from
> > file headers. One can rely on the ID table(s) to check for supported
> > devices. Adjust comment header accordingly and update Copyright notice in
> > comment file headers with the current year.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> 
> Main comments here are about the patch break up.  I think it needs
> just enough modification for a v2 to be needed.
> 
> >  drivers/iio/dac/Kconfig      | 31 ++++++++++++++++++++++++-------
> >  drivers/iio/dac/ad5686-spi.c |  7 ++-----
> >  drivers/iio/dac/ad5686.c     |  4 ++--
> >  drivers/iio/dac/ad5696-i2c.c |  6 ++----
> >  4 files changed, 30 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index d6d560c09e25..ba2065241af3 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -251,9 +251,18 @@ config AD5686_SPI
> >  	depends on SPI
> >  	select AD5686
> >  	help
> > -	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
> > -	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
> > -	  AD5686R Voltage Output Digital to Analog Converter.
> 
> Given this is adding entrees that were in the previous patch, I'd have
> preferred to see the more complex dance of a precursor patch before that
> which did the reformat (and dropped the stuff form the c files)
> 
> That would then be followed the new stuff being added as part of the previous
> patch.
> 
> Whilst the ends result is the same I think it is worth doing a v2 just
> to clean that break down of patches up.
> 
> > +	  Say yes here to build support for Analog Devices Voltage Output
> > +	  Digital to Analog Converters:
> > +	  - Single-channel:
> > +	    AD5310R, AD5681R, AD5682R, AD5683R, AD5683R
> 
> Eagle eyed Sashiko spotted last entry is a duplicate.

Yeah, one of the entries should have been just AD5683...

Also, that this AD5337R was missing, which I didnt add because I could not
find documentation for this one. Maybe a device that does not exists or it
was deprecated.

> 
> > +	  - Dual-channel:
> > +	    AD5313R, AD5687, AD5687R, AD5689, AD5689R
> > +	  - Quad-channel:
> > +	    AD5317R, AD5684, AD5684R, AD5685R, AD5686, AD5686R
> > +	  - 8-channel:
> > +	    AD5672R, AD5676, AD5676R
> > +	  - 16-channel:
> > +	    AD5674, AD5674R, AD5679, AD5679R
> >  
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad5686.
> > @@ -263,10 +272,18 @@ config AD5696_I2C
> >  	depends on I2C
> >  	select AD5686
> >  	help
> > -	  Say yes here to build support for Analog Devices AD5311R, AD5337,
> > -	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
> > -	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
> > -	  Analog converters.
> > +	  Say yes here to build support for Analog Devices Voltage Output
> > +	  Digital to Analog Converters:
> > +	  - Single-channel:
> > +	    AD5311R, AD5691R, AD5692R, AD5693, AD5693R
> > +	  - Dual-channel:
> > +	    AD5338R, AD5697R
> > +	  - Quad-channel:
> > +	    AD5316R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
> > +	  - 8-channel:
> > +	    AD5671R, AD5675, AD5675R
> > +	  - 16-channel:
> > +	    AD5673R, AD5677R
> >  
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called ad5696.
> > diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> > index 003541edb742..b4531b49cb22 100644
> > --- a/drivers/iio/dac/ad5686-spi.c
> > +++ b/drivers/iio/dac/ad5686-spi.c
> > @@ -1,11 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
> > - * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> > - * AD5684R, AD5685R, AD5686, AD5686R
> > - * Digital to analog converters driver
> > + * SPI driver for AD5686 and similar Digital to Analog Converters
> >   *
> > - * Copyright 2018 Analog Devices Inc.
> > + * Copyright 2018-2026 Analog Devices Inc.
> 
> That definitely belongs in the patch that made a real change, not one
> that is just messing with comments.

Will drop this one. As I was touching the file headers I assumed it was fine
to put this here, given that I ended up adding a lot of changes to these files
lately.

-- 
Kind regards,

Rodrigo Alencar
