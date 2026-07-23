Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D97345ED9;
	Thu, 23 Jul 2026 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848306; cv=none; b=GNEGmSZrZbnwJNuN8EQu+J1YYqT3EkMFZB+VRzBoOICd1yGJ1K0zspGfXOA9yB8aR1h2qutp9f7IcNXBnbd8++3DO2X4xjwHs/wcabRT6PSCP0BJZ8O2f0DDxSshLsPvHeqttV9MtVTdycjtCPfjYKNLpn2X8mF2cfSj6Hgt5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848306; c=relaxed/simple;
	bh=tJE7QLmFm+TE3GEKwAzBI+AjFYpvW8DrXlfdJwgStfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIas0O6i7gkfbe2zCRlDvKc83UR1kNoaoZ+zyXP2X/JB9c/5JHdPmZZnV/ZDO4WJUwLbwyP+Tj0LcPuouhPmrB80yrmPE5cuOXDSdE7umHkgz2ebKODsjbwF4htNoOkVNiSoi0GXB/WttWPxk3R/XxXwYfGeZctJu09SYEqpvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do62ZEJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do62ZEJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3D1F000E9;
	Thu, 23 Jul 2026 23:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784848301;
	bh=1HQLCQ5a6IsgFhtsBNgUA+ogFOIV9X2KyIa89PgiQdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Do62ZEJoUn2WexzPaXHDOZc+lNZ+qErmVKlYAco6xgjtL5DwoAtkbNvvhTwVlhSUh
	 KYHnw3vYsdtUW9asvFQMyogJUunoSfRhfOK/4BNRBWjLoSNNdB8EU1k0TORpI/EJgv
	 i+XMyhDAWV9ow2Y76gbjx+U7M8LiOUohuzmIEiAAb/zBqjv71zQ+qVNgoFsAljRyLo
	 6keNo4CkDR2yTjeGLAkshG7ngHM/wT+01I2AcstOFJy2lS7YfTuaOiki/trvlw9R03
	 fBJc5zp6pQVCjvnNkN+Jph8cvLN7OmKe24hHlL9deNGG8NwiVCJNh1E1l0OGh0xBdl
	 NsXR/44KGbl2Q==
Date: Fri, 24 Jul 2026 00:11:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, Michael Auchter
 <michael.auchter@ni.com>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 4/4] iio: dac: ad5686: update device list and file
 header comments
Message-ID: <20260724001123.0e201f90@jic23-huawei>
In-Reply-To: <nxybhlqzbyz5jpwzam6hh72rst37fqcekxhtt6gjqge4t5gh7e@gbbm3g2pklim>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
	<20260719-ad5686-extend-dev-support-v1-4-841ec75cf5d8@analog.com>
	<20260719223035.0acb57d6@jic23-huawei>
	<nxybhlqzbyz5jpwzam6hh72rst37fqcekxhtt6gjqge4t5gh7e@gbbm3g2pklim>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 12:27:34 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 19/07/26 22:30, Jonathan Cameron wrote:
> > On Sun, 19 Jul 2026 10:52:00 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Update device list entries in Kconfig and remove device description from
> > > file headers. One can rely on the ID table(s) to check for supported
> > > devices. Adjust comment header accordingly and update Copyright notice in
> > > comment file headers with the current year.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---  
> > 
> > Main comments here are about the patch break up.  I think it needs
> > just enough modification for a v2 to be needed.
> >   
> > >  drivers/iio/dac/Kconfig      | 31 ++++++++++++++++++++++++-------
> > >  drivers/iio/dac/ad5686-spi.c |  7 ++-----
> > >  drivers/iio/dac/ad5686.c     |  4 ++--
> > >  drivers/iio/dac/ad5696-i2c.c |  6 ++----
> > >  4 files changed, 30 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > > index d6d560c09e25..ba2065241af3 100644
> > > --- a/drivers/iio/dac/Kconfig
> > > +++ b/drivers/iio/dac/Kconfig
> > > @@ -251,9 +251,18 @@ config AD5686_SPI
> > >  	depends on SPI
> > >  	select AD5686
> > >  	help
> > > -	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
> > > -	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
> > > -	  AD5686R Voltage Output Digital to Analog Converter.  
> > 
> > Given this is adding entrees that were in the previous patch, I'd have
> > preferred to see the more complex dance of a precursor patch before that
> > which did the reformat (and dropped the stuff form the c files)
> > 
> > That would then be followed the new stuff being added as part of the previous
> > patch.
> > 
> > Whilst the ends result is the same I think it is worth doing a v2 just
> > to clean that break down of patches up.
> >   
> > > +	  Say yes here to build support for Analog Devices Voltage Output
> > > +	  Digital to Analog Converters:
> > > +	  - Single-channel:
> > > +	    AD5310R, AD5681R, AD5682R, AD5683R, AD5683R  
> > 
> > Eagle eyed Sashiko spotted last entry is a duplicate.  
> 
> Yeah, one of the entries should have been just AD5683...
> 
> Also, that this AD5337R was missing, which I didnt add because I could not
> find documentation for this one. Maybe a device that does not exists or it
> was deprecated.

We've had a few IDs sneak in either through typos or because a part
existed on a datasheet but wasn't released in the end.

Good idea to just not mention it here though we might get someone
helpfully 'fixing' the fact it was missed in future :(

> > > diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> > > index 003541edb742..b4531b49cb22 100644
> > > --- a/drivers/iio/dac/ad5686-spi.c
> > > +++ b/drivers/iio/dac/ad5686-spi.c
> > > @@ -1,11 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /*
> > > - * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
> > > - * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> > > - * AD5684R, AD5685R, AD5686, AD5686R
> > > - * Digital to analog converters driver
> > > + * SPI driver for AD5686 and similar Digital to Analog Converters
> > >   *
> > > - * Copyright 2018 Analog Devices Inc.
> > > + * Copyright 2018-2026 Analog Devices Inc.  
> > 
> > That definitely belongs in the patch that made a real change, not one
> > that is just messing with comments.  
> 
> Will drop this one. As I was touching the file headers I assumed it was fine
> to put this here, given that I ended up adding a lot of changes to these files
> lately.

The change to update the copyright is fine.  Just do it in patch 3
instead as that is where you are making substantial changes and a copyright
update is appropriate.  If you were updating that for other recent changes
and didn't have any in this series, then separate patch where you can say that
it is about other recent changes.

Jonathan

> 

