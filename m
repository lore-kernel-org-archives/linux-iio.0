Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578452;
	b=rMAPdkks9ONzoHzsT/6jhUbowRH3vOMvWRpd5fYumefj3IEDrIhe4f0pVkKtADXelHdl
	 eOY7DZ1quXuu//6jlwqA1j4IWE0KESophCppPei+wpoZ+eei3eTOsR6QleKpsGnBoSAwq
	 VLDx8qPk0pqqth9AsLymAR3Gab8ojnb3Durm3BmwzHxCEXWg6gW5XlqMPiyG/F5nY2ceZ
	 W1Vw5kaJ/mBCZ88NlHA5oRH/aWeSd5g7NdnS2fP8AiARQvv49XZtOo0RzxG68KA297Xyv
	 3HDUu1O831MECvQiMKsrGPXoeRrAPCudlVTmKOy78tcQ6PmhR2jw/DQ7M9KCdI+ORPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578452;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=txeTBM5DNYw87/QZmQaWisxC446w2wy1hoG7oJJBzos=;
	b=Axv3VXNJd3Jcoh67tks4xpNE83KgFiUgFSimCS75v+kyqJPedpv0iN2wU21ypvHtZETY
	 9P1ZkG07AR8rPa/xY1SFz4bm029Kq/1iqoT1mscPreNo6k7jI1rGgtuOTcOY6Dx2pm/8n
	 QWwywPvvWeO4gAr5ISK8vBDchGRvd/yxmjsAMaeDnfSKxdCoRfsr8UjDGkJQVl/adAKQH
	 J180WduO/GwhA18veV9e3zobEsbYupropvWxdY43ejaZM8dxXh9Pwwr7LZw528N9oqVxh
	 0A+VF/gzkAPQi95YUvkRbd/Ld/XyKxaV17+USfKwxaqbOjsFMMyUEBmgWelitJGHFXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LX68vSiL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA5606A324;
	Mon,  2 Nov 2026 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LX68vSiL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCDF1F000C1;
	Mon,  2 Nov 2026 00:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578451;
	bh=txeTBM5DNYw87/QZmQaWisxC446w2wy1hoG7oJJBzos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LX68vSiLQI5taqCAPofyzh068CAZcRz/6kB78FNnDwla6ujrgxkTcU34cXGeoLMt2
	 jX2of1Q/3Ek+iAapCy+27jCbWOBs+/D/HQbcjDP+s0ov6wjXmcHIa+ntj87nkO2NKb
	 PVVTxBEf2PIRujJiNZjUpKbqDFOhUcC3fsYQdO1QLrQSZWawdEGMbJWf5B0XCsPDSn
	 WCLuyTYDTtAaczj3PoR+1z+Ii0Iuv+E1IRtSDct4XCtyAqCabzbuKkOh2OVNgTgIGU
	 /L+XBuPvoIm/SOqiiYxXyR7ZfYHo4BvXhsGSopsxe2NM4bOQIvPMuhDLHT0MImZa0h
	 3+dkvZ5KCtBTQ==
Date: Mon, 2 Nov 2026 00:14:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: adc: ti-ads1298: add ADS1299 support
Message-ID: <20261102001405.5798b110@jic23-hlaptop>
In-Reply-To: <20261028022652.31121-1-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-7-stephanbrrs8@gmail.com>
	<20261025233429.23b02702@jic23-hlaptop>
	<20261028022652.31121-1-stephanbrrs8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 23:26:52 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> On Sun, 25 Oct 2026 23:34:29 +0000, Jonathan Cameron wrote:
> > A few things in here feel like they should be in precursor
> > patches because the implication is they apply just as much
> > to improving support for the ads1298 as they do for the
> > new device.  
> 
> Agreed. DVDD and PWDN become ADS129x patches, binding and driver, before
> the ADS1299 ones.
> 
> > > +	if (FIELD_GET(ADS1299_MASK_ID_DEVICE, id) != ADS1299_ID_DEVICE ||
> > > +	    nu_ch > 2)
> > > +		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", id);  
> > How do backwards compatible parts with fallback compatible of ads1299 work?
> >
> > Generally we don't reject on simply an who am I value mismatch.
> > Note the existing driver may need relaxing on that point - we used
> > to do this before DT maitainers pointed out what it broke!  
> 
> Today that works only within a family: the channel count comes from the
> ID, so ti,ads1299 serves the -4 and -6, and ti,ads1298 the ADS1294/6
> and the R parts. A part with a new ID is refused, as the existing driver
> does too.
> 
> For v3 I'd do, in a precursor patch for the existing driver: the
> compatible's chip info is what the driver trusts. If the ID is a known
> part of that family, it still gives the channel count and the name; if
> not (another family, or a reserved channel code), the driver warns and
> goes on with the compatible's chip info. The channel count from the ID
> has to stay, since ti,ads1298 has been the only compatible and existing
> boards with an ADS1294 or ADS1296 depend on it.
> 
> Does that match what you have in mind?

Yes. That sounds like the best way to handle this mix of
discoverable and not.

> 
> > > +	/* The ADS1299 comes out of reset with its inputs shorted */  
> >
> > What is the case for the ADS1298 - is this just harmless or does
> > that have similar behavior?  
> 
> Harmless. On the ADS129x CHnSET resets to 00h, normal electrode input,
> so the write changes nothing. On the ADS1299 it resets to 61h, input
> shorted, and without the write each channel reads its own shorted input.
> I'll make it ADS1299 only, through chip info, unless you prefer it
> unconditional.
> 
> > > +	for (i = 0; i < indio_dev->num_channels; i++) {  
> >
> > 	for (unsigned int i = 0;...  
> 
> Will do.
> 
> Thanks,
> Stephan
> 

