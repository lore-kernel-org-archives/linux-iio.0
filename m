Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A725A2B5;
	Sat,  4 Jul 2026 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783207371; cv=none; b=n3Ai99HWXUYLYBrP3SI0tI3WEaLK2z/EnkpHJG+LOJF/TX66HT1E1eJKBXGwkYr8n+YF29Ii8T7iPKLewkn2pWRoRrJVbTs+o6iIyjuj65JxIAj9NEfV1gmKhud3xHE0pN7AxD0tBC4wuGq1xMrj07WVuqNeUgbv3GsGmMoyAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783207371; c=relaxed/simple;
	bh=dwDN44R/Njw08faeZa4RFZtVqZR7XIpo1XUlmfYuv/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSks+x4wwOQUwo+Zn69iPky8o2l3jAJToQTQQ6cTud99hj6bMn9nSamD0aRe7wO1FajLBNl3D3jUI/ZtcLUO7KA4zaTiFXrr91ifSUUAZHmEDowWqHToZoRFr574g3ZKZ4rFnLqe/1DlRFBUyHwqug+jKiVBBF9ZkI25UPfo0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbQvE9Yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbQvE9Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2881F000E9;
	Sat,  4 Jul 2026 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783207369;
	bh=dDIjFGwktWeR8Qv782scHj+hlc3n4lybflEX0wE94YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AbQvE9YlG6go9/u8KeV1QkAukZcRNs4spqONcG7lUVKp67aFfNJdQYh4vx8FYJog2
	 7DV6ed2b0mM1hrWlnsvI/AGxSayl2BXEditQqLr6jfZv2DJ1/cCQop2r8U4mQUR1Jv
	 Yw6IfVvz2lkD3qr/K+7qLN0JYLxjLd8XS0Dd8xPPho8dG9cXAIqfiditF+DfqMPRjz
	 6TpNoJuKtigNVwvoe9VVEJPRo2LNdXfmROfMdan1ZWJswblXQGLJ3FiqAMCxKuMphI
	 slt0G8PVAfktJihwFZ5z/i/2cJ7YqaQxmJv8WQZiPC4nHQEHmhLJYefZDBuKK5H+Bm
	 pxleECTMTxUOQ==
Date: Sun, 5 Jul 2026 00:22:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260705002244.59a9c4ca@jic23-huawei>
In-Reply-To: <akfuCoai4KAlt5QZ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
	<724f2408cb84bf4546115408fc9857777e6f2fd7.1783028033.git.marcelo.schmitt@analog.com>
	<20260702220223.C717E1F00A3A@smtp.kernel.org>
	<akfuCoai4KAlt5QZ@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 14:14:50 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 07/02, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > - [High] Hardware protocol violation: CNV is held high during SPI read
> > - [High] SPI bus not locked during ADC conversion phase
> > - [Medium] Incorrect scale calculation for LTC2338-18 and similar ADCs
> > - [Low] Undefined direct mode macros lead to build failure
> > --
> > 
> > commit b74b536d18af0084ea31bd1e1e8cf9454da5e29c
> > Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > 
> > iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
> > 
> > This commit adds support for the Analog Devices LTC2378-20 and similar
> > analog-to-digital converters. It introduces a new IIO driver using the
> > SPI subsystem.
> >   
> > > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > > new file mode 100644
> > > index 0000000000000..b5cf2e974daca
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ltc2378.c
> > > @@ -0,0 +1,404 @@  
> > 
> > [ ... ]
> >   
> > > +static const struct ltc2378_chip_info ltc2338_18_chip_info = {
> > > +	.name = "ltc2338-18",
> > > +	.internal_ref_uV = 4096000,
> > > +	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
> > > +};  
> > 
> > [ ... ]
> >   
> > > +static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
> > > +{
> > > +	int ret;
> > > +
> > > +	/* Cause a rising edge of CNV to initiate a new ADC conversion */
> > > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> > > +	fsleep(4);  
> > 
> > [Severity: High]
> > Can this sequence cause data corruption on a shared SPI bus?
> > 
> > The CNV pin is toggled and an fsleep(4) occurs before spi_sync_transfer()
> > locks the bus. If another SPI transaction occurs during this sleep window,
> > could it toggle the SCK line and prematurely clock data out of the ADC?  
> Makes sense. 
> > 
> > Should the conversion-and-read sequence be wrapped in spi_bus_lock()
> > and spi_bus_unlock()?  
> Because these chips don't have CS line, it seems that locking the bus actually
> makes sense.

What does it even mean?  If there is no CS then the bus can only sensibly
have one device on it. I'm not sure if the SPI core enforces that but
in practice you should never see a board that has multiple devices.

Hence locking could be at the device driver level rather than the bus.
I guess bus locking would provide the same conditions and maybe acts
as documentation.  

Jonathan
