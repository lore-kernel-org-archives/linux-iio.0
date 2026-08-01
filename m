Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364F3AA1AE;
	Sat,  1 Aug 2026 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785551418; cv=none; b=N/0TTAyU5jOSc4gvZwZZqUvYFl5drK+t9kGj33sDsHQDBfo4k/GPAiqfYuQzktIBSXmPa+ZiPInEvOiWhWg9o/OPqv3gP+41do2Y4oteRK7A1GjU3hsxxNyjmv8qYjJKIYPSWAKGvjzzZ8WI9sz7mb6W4DckwnsTuG8SAu5bltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785551418; c=relaxed/simple;
	bh=Rq0oBTe+Mcs5biEmmS9SrC3jXkeu48lEvrmGrGx/NQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RN0t7aO4zTRUa538YH1Dp3IY2EOV5waJrWEig30igEbqyoA2+rYG0/QhnggeSF+vo59CQvOak63HJfDqdFVmv0Pff5ShX0M2rQ1FO/FSNVwM1VhXpTZv1BIT1kkpyINCiPdWF8dROoOMrXnbKM5osrSu3gQuz0zsEUa7/MzsGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9yYBGWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9yYBGWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35E51F00AC4;
	Sat,  1 Aug 2026 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785551416;
	bh=3PHsBdYoVSlgCeOS6877ND0yWjnfwO/dHJ0X8pqb7Ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e9yYBGWwynpwuqkVlhWTaVy4UxS2X98FgEIBOd7mx/7peLMRimi7Y/WdqpD9Ig8Cl
	 qGmYCi4xM4d4X4z+75ZcZLxRDjiPKMGzCspurWXHM4D3nuGzYzd4/HPRKh8KgGh6oM
	 C57i6ntAWE1067cNSsvzu3qbWE0v/z2Ieh5xclfyCFZeyiO6duI2zPhXZ2lpeKaeIV
	 4MQc3s3Kg8wJhERMIB3Op8v8vpkuLFzOEkKwdJt8urANoBLUYXhelttlJpA5p92jQ9
	 Hp3U5inVS2yYvsvYUTMKRJegIj0vifShohtD2z6Ry7kfdQLXoixPRxqlhACM9k6OL8
	 MHdpH17NFzFGg==
Date: Sat, 1 Aug 2026 03:30:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260801033013.19ef2b2f@jic23-huawei>
In-Reply-To: <20260728151559.000067ef@gmail.com>
References: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
	<20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
	<20260727184226.DFC1E1F000E9@smtp.kernel.org>
	<20260728151559.000067ef@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 15:15:59 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 27 Jul 2026 18:42:26 +0000
> sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Potential off-by-one in DAC scale calculation denominator.
> > --  
> 
> Responding to Sashiko's comment.
> 
> > --- Patch [2]: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device ---
> > commit 38bec2fbb020c3f749c52a26e5cc3e78e72eeaf5
> > Author: Joshua Crofts <joshua.crofts1@gmail.com>
> > 
> > iio: dac: mcp47a1: add support for new device
> > 
> > The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
> > which communicates via I2C.
> >   
> > > diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
> > > new file mode 100644
> > > index 0000000000000..140e93ff2ba01
> > > --- /dev/null
> > > +++ b/drivers/iio/dac/mcp47a1.c    
> > [ ... ]  
> > > +static int mcp47a1_read(struct iio_dev *indio_dev,
> > > +			struct iio_chan_spec const *chan,
> > > +			int *val, int *val2, long mask)
> > > +{
> > > +	struct mcp47a1_data *data = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (mask) {    
> > [ ... ]  
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*val = data->vref_mV;
> > > +		*val2 = MCP47A1_MAX_STEP;    
> > 
> > [Severity: Medium]
> > Does this code use the correct denominator for the scale calculation?
> > 
> > Since this is a 6-bit DAC, shouldn't the scale denominator be 64 (2^6)
> > instead of the maximum step value of 63? Using MCP47A1_MAX_STEP (63) here
> > introduces an off-by-one error that could cause userspace to calculate
> > output voltages with a ~1.5% LSB scaling error when reading the sysfs
> > attribute.  
> 
> Yes, the max amount of steps is 64, which should be passed here. I'll
> add a separate macro for this in v3.
I'd just use + 1 at this location given the clear relationship between
the maximum value that can be taken and the number of steps.

> 

