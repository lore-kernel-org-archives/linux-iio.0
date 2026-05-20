Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85B312825
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298299; cv=none; b=Oj4+ZbEpcEH1HCHtw5MMJT/l05PwSFSDMfKt74iLFzdEHiQaeGYqY2ZTXHYRc+agPAm/1qZUAGc5hTI0IHY2aZdbWHH90V+w68NKzONv1A+JyEAsjSLsrIyqnJcVuDqqEPe1L795zyqgxGwTQJ9dovzrfmy9L6iRkfg+VvWnmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298299; c=relaxed/simple;
	bh=bq8bw6vwJh2kQuhVxT3kCdfwUyONAsS13CxP4mbE1Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxGnkx88gJ4VQPmURrrojX9sz7MttuEBO6Q+U+rCphB9BNzhizW9J++meA8eI3CPBxadG5TghiNe32h9EQHIt3e7aSsvehaTtzvs5ajh+1xh0lnPb5ZsANh/f513OxWsQkfJD0er8kec0+QNr1QwO4Bdi48caRX6U0tHdZlYVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvu5+nsP; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvu5+nsP"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-57533363201so1580641e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779298297; x=1779903097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoU4YuxRQKK2zoh0YbbDzimdEIINpcIXLiLGPEgByIY=;
        b=qvu5+nsP9XbziYrVP6CzDF8NtvaCdxIwczfLCUgZYA4jcRzTFSVQWy/NOcaF9UyCZR
         XPZMhvLKll04OVZYQUi4CCTzPJn60FCDJCLH/e6RW0HRS0FVQe0wBvaz9gh9UrpwN5Zb
         e30eBdjokRApvXsaGMzcmuK4LwXD0UUhTomO+PqrFmo5KaIq5dHx9APNzj6LXQPcww4Y
         ubJHeUAgaAU89Yu7o7xPXK8uqIE1guFBRfb37jlPV0qWZDDQP5JINghRD04AfdIQQJoa
         bMN1lHUjUdjTjhXf9Co2xI5mnd79XBzQ90P0rhZ/y2eebtPeGkcIajKja6BuvVp1jIJb
         ucMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298297; x=1779903097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoU4YuxRQKK2zoh0YbbDzimdEIINpcIXLiLGPEgByIY=;
        b=kxh8zedARRS7kfrP7w2aNOKNokqdo3vvfk007cjC5liF5l+kJx844psQ2RtfWqz4Eh
         C/Y2QWZ3Z2NBYWt6vaG/Pa/u1xvqCDCDP43LhYAnGUSYQm1LVvbhXcYx5drtnhVad7TK
         wWW5ODUL1xKQ/PXaIe7mTA5FFL80cammBhoq9eFjijxABbHWXixMUYAL/5CMu5AvzgOP
         wDwlcEaqUtU59MTxbJRQj9ELClicu1dSzZJzdn2Hy0VWIjGyYXWe5V+iKB16U6rIedm1
         4MwM3LnHMNn2JtAXnxwM2xbGrx5RCPIy1ocgTrMMfzIUUZQoZ4NXf97KS4KtspalmD0n
         ETaA==
X-Gm-Message-State: AOJu0Yx9u8oxBkknN7Go5DMItPCJPI03+tOgl48oU/u0k2U5wF5yUaUJ
	WOAK4BdAHUeHcy2NmbKFut+a7Q0ADEEkcA7NykvuBlrtKdZia6MUdA3c
X-Gm-Gg: Acq92OEkHrUgC2FRVjWCeBvbp1HRK+XSrapAznVjAwLODLimqF8gqM0D8kobKWOCGsh
	S+AOcBdUzxNnsvOUhnmeM/Xj3Ua3WD+cPr7PDhwcAgUTComCADfVpyKm+jY9PO5VOTkFMTkenhU
	JMFOiVBVYsv7o7IJ5zUjLwtsuWZIW4uWpkXSTjSkccR50gVSKNCJD1VDVZLfbkqq4igG34mMxUn
	LPBAWpekxKmKgn5K+Fmdjw64uiT/oKWpJ0pAUQU8NJOHsQsIbguJTznXxLLJJbfzY/ZyAiLMGOV
	2vesdYijTg/lm0NDzbAg3sSXYFtfBbHZAbQZoJizkfJh+YCeaq+FJ8mn51eanl8KtUkarUBYzaZ
	Za5AqP+BhrKDuQo9Vb+nGb4cSYa8GlauFM8kCQNYfNS7lJyTZvrRqNnsvHRL/bmWH/+APsNSX7u
	+0nR2DrhnfDOFHao6DgpHpqZuNZ814z+G3
X-Received: by 2002:a05:6122:e18c:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-5760be4b464mr13831128e0c.5.1779298296647;
        Wed, 20 May 2026 10:31:36 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760faa5645sm12288301e0c.14.2026.05.20.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:31:35 -0700 (PDT)
Date: Wed, 20 May 2026 14:31:51 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 3/4] iio: adc: ltc2378: Enable high-speed data capture
Message-ID: <ag3wB-dAHnm67kZu@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
 <580ce8e03cdbda8ec20fed2e26f2226872ffcef3.1779117444.git.marcelo.schmitt1@gmail.com>
 <20260520172740.783c8866@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520172740.783c8866@jic23-huawei>

> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 70fec8e3e891..b5368ee783f7 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -944,6 +944,7 @@ config LTC2378
> >  	depends on SPI
> >  	depends on GPIOLIB || PWM
> >  	select IIO_BUFFER
> > +	imply LTC2378_OFFLOAD_BUFFER
> >  	help
> >  	  Say yes here to build support for Analog Devices LTC2378-20 and
> >  	  similar analog to digital converters.
> > @@ -951,6 +952,17 @@ config LTC2378
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called ltc2378.
> >  
> > +config LTC2378_OFFLOAD_BUFFER
> > +	bool "Offloaded data capture with LTC2378"
> > +	depends on SPI && LTC2378
> > +	depends on SPI_OFFLOAD=y
> > +	depends on PWM=y
> > +	depends on SPI_OFFLOAD_TRIGGER_PWM=y
> > +	depends on IIO_BUFFER_DMA=y
> > +	depends on IIO_BUFFER_DMAENGINE=y
> 
> why do all these have to be built in?  In general I think we need to jusitfy
> why this driver needs to work on systems with out this stuff being built.
> I.e. why do we need the separate optional file at all?

Hi Jonathan, thank you for your review.

I've applied fixes to all issues reported by sashiko, except for Kconfig
configuration (see below) and the is_visible() thing I'm still working on.

My intent with this design choice was to keep chip intrinsic dependencies
separate from SPI offload dependencies. The indented benefit is to enable using
the device without having to enable SPI_OFFLOAD (which is boolean and might not
be supported on all platforms). The offload feature is indeed highly desirable
hence the imply on the main driver Kconfig entry. The other symbols are tristate
so, if we keep this approach, will drop =y.

The separate optional file is part of the push for dependency separation. It
helps avoid #ifdef in c code. If the proposal is not far from something
acceptable, I'd like to have another try of making it work. Still, it's arguable
that the real interest is only on supporting the offload thing. Also, since I
don't have any request to support these without offload, I think it will also be
okay to have everything combined into a single driver. 

Will follow all the other suggestions.

> 
> > +	help
> > +	  Say yes here to build support for high speed data capture with LTC2378
> > +
> >  config LTC2471
> >  	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 1814fb78dde3..2fa5dce0ceea 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -82,6 +82,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
> >  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> >  obj-$(CONFIG_LTC2309) += ltc2309.o
> >  obj-$(CONFIG_LTC2378) += ltc2378.o
> > +obj-$(CONFIG_LTC2378_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o
> 
> Hmm. This is odd. The driver can be modular but not this and it's build seperately
> rather than as part of the module. I think these bit needs a redesign.
> We definitely want this extra support to be part of the module.  See how something
> like the ADIS IMU library in iio/imu/Makefile is done.

Will check this out too.

> 
> >  obj-$(CONFIG_LTC2471) += ltc2471.o
> >  obj-$(CONFIG_LTC2485) += ltc2485.o
> >  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
