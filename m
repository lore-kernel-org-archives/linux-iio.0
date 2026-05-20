Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910832701C4;
	Wed, 20 May 2026 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303514; cv=none; b=eWwV1D46arI6qJ+egC3mmKqbKwBZxj8JxepzmxVBL94ZViRYGTJPlJ0XumY3XXbDFbwkDHTeuGH+mcpNPbnmoSPHLQGDNyu+KNbqMQgLO2NLtxHUyGjX2gxt1P9pPcg3lXLnh9ekRmlATEVm8L+QTZN/p+NpOWcJe38wPTVjhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303514; c=relaxed/simple;
	bh=g8ARzZZplRFCCw5mAhE4rnYD32JwcQ9twUtXcgPIOoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvkoxdSsd+0pPxMA26xKvs5uCqlMHpalmRaff+eXm+wRo7+x8DSjeVzRM6dBBxksdEHpVtoyFX2B6/KxWK8W8bqK7XbEU/on6tbt/0S7yh54kwf6jGYWZWXBxLsqXeqlgBeHdEPXqAx2bXldchsYW4K7KrYBj/wR8ZmbUo8m8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To391V5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To391V5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8F91F000E9;
	Wed, 20 May 2026 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303513;
	bh=FxJ/JthfCMKn/1Vz2RVfV2EGcIa2+pZDdNovaeFcIBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=To391V5alUIcyijicmPW8ZT+NSY73HPuWaUBC9CezoIFYve7RYd5SIQG0knFbR2k8
	 ndKICDdsSjh+C2tHrruoVQOGI1m+SS9ie6b4WQaiujqH4DEYOUqH6VGRpm8ccOa0j7
	 kd7bDya/TSJR31IRWhai6goUW6WCPhrgpXGqy7IUB7za9haDtuunBPeheQJuBNOTSV
	 Xubxzkst2rkf/iec8sUfwfuRh8QNzMyFqtqC7451/3+2SZOLr9bUWW8m9Y+IT51P1W
	 0xLJ034AbBZAuk0JxGU1ePTIsxwtsiyi7657rT8YnStckT4qDmo9vN/hFCGk2QkDoK
	 Zl/Shf2evXPIg==
Date: Wed, 20 May 2026 19:58:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/4] iio: adc: ltc2378: Enable high-speed data
 capture
Message-ID: <20260520195823.43b9ff2f@jic23-huawei>
In-Reply-To: <ag3wB-dAHnm67kZu@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
	<580ce8e03cdbda8ec20fed2e26f2226872ffcef3.1779117444.git.marcelo.schmitt1@gmail.com>
	<20260520172740.783c8866@jic23-huawei>
	<ag3wB-dAHnm67kZu@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:31:51 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 70fec8e3e891..b5368ee783f7 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -944,6 +944,7 @@ config LTC2378
> > >  	depends on SPI
> > >  	depends on GPIOLIB || PWM
> > >  	select IIO_BUFFER
> > > +	imply LTC2378_OFFLOAD_BUFFER
> > >  	help
> > >  	  Say yes here to build support for Analog Devices LTC2378-20 and
> > >  	  similar analog to digital converters.
> > > @@ -951,6 +952,17 @@ config LTC2378
> > >  	  This driver can also be built as a module. If so, the module will
> > >  	  be called ltc2378.
> > >  
> > > +config LTC2378_OFFLOAD_BUFFER
> > > +	bool "Offloaded data capture with LTC2378"
> > > +	depends on SPI && LTC2378
> > > +	depends on SPI_OFFLOAD=y
> > > +	depends on PWM=y
> > > +	depends on SPI_OFFLOAD_TRIGGER_PWM=y
> > > +	depends on IIO_BUFFER_DMA=y
> > > +	depends on IIO_BUFFER_DMAENGINE=y  
> > 
> > why do all these have to be built in?  In general I think we need to jusitfy
> > why this driver needs to work on systems with out this stuff being built.
> > I.e. why do we need the separate optional file at all?  
> 
> Hi Jonathan, thank you for your review.
> 
> I've applied fixes to all issues reported by sashiko, except for Kconfig
> configuration (see below) and the is_visible() thing I'm still working on.
> 
> My intent with this design choice was to keep chip intrinsic dependencies
> separate from SPI offload dependencies. The indented benefit is to enable using
> the device without having to enable SPI_OFFLOAD (which is boolean and might not
> be supported on all platforms). The offload feature is indeed highly desirable
> hence the imply on the main driver Kconfig entry. The other symbols are tristate
> so, if we keep this approach, will drop =y.

I can see there will be platforms where SPI_OFFLOAD doesn't make sense, but 
are there cases where it can't be built anyway?  It's not that big and doesn't
seem to have dependencies beyond those of SPI.
> 
> The separate optional file is part of the push for dependency separation. It
> helps avoid #ifdef in c code. If the proposal is not far from something
> acceptable, I'd like to have another try of making it work. Still, it's arguable
> that the real interest is only on supporting the offload thing. Also, since I
> don't have any request to support these without offload, I think it will also be
> okay to have everything combined into a single driver. 

I don't mind the separate file, but I do mind the need for so much to be built
in rather than modular. So I think the Kconfig needs some changes rather than
it being a fundamental problem.

Jonathan

> 
> Will follow all the other suggestions.
> 
> >   
> > > +	help
> > > +	  Say yes here to build support for high speed data capture with LTC2378
> > > +
> > >  config LTC2471
> > >  	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
> > >  	depends on I2C
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 1814fb78dde3..2fa5dce0ceea 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -82,6 +82,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
> > >  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> > >  obj-$(CONFIG_LTC2309) += ltc2309.o
> > >  obj-$(CONFIG_LTC2378) += ltc2378.o
> > > +obj-$(CONFIG_LTC2378_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o  
> > 
> > Hmm. This is odd. The driver can be modular but not this and it's build seperately
> > rather than as part of the module. I think these bit needs a redesign.
> > We definitely want this extra support to be part of the module.  See how something
> > like the ADIS IMU library in iio/imu/Makefile is done.  
> 
> Will check this out too.
> 
> >   
> > >  obj-$(CONFIG_LTC2471) += ltc2471.o
> > >  obj-$(CONFIG_LTC2485) += ltc2485.o
> > >  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o  
> 

