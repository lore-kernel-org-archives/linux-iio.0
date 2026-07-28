Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B302E7380;
	Tue, 28 Jul 2026 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271495; cv=none; b=QgZ8wLEX4pFCF6xx+cDL1n90w5gDf4+txTuXI5NubXUTXFfNmmN2FRuqrxp08tv8Gr16q4WVTD8YTdhPjLnyA7KXsf4PPsN9KTphLePWlkuJ8X4RARxnz4395ZivArBMcPJJ2/6sjP4HdkUS1/ey2qf8AEJwgXFGGkBPgZF473M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271495; c=relaxed/simple;
	bh=84MbF9Uq5djPmt2mJekMTbLk9dlBMdAdd+mLwDfsdjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p91j5h2xeyyzesW4EaphASyb6XOpF9e71oNK88c3ji92n6X/KNM/OdoYSMaQqrb7KymwS2W20SJdtN0LZJwiHwBHr6FSb3u++aLvm6ePWvVueX2G+DoBpipNnshxOmRvjG+AgrvrVM4N9xrY4waVLco2qCFLfywp5CaBMsZfZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNHTiOlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNHTiOlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE11F000E9;
	Tue, 28 Jul 2026 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785271493;
	bh=udc3Z7QxavxY+CTl8l3b556WiYIERFaKbNKPYKH4sWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TNHTiOlZap0ZA8HaUF5w1iewrcNTRdbWujGhtB35AU351pS6W3w3Pb6vVCqm37sBa
	 TDLJEXytDEwxGVVb7cH7Q0ia3jAatF67tZdICxw+4bU+nzZaD05ACRVkTjJTw75e1u
	 Yzbv+KJwq6bejUW59GM7DnyLt70GMUpUDhcbuP0IbnhPBBgIrq9kpc1hgKONfWv0cx
	 7A06XoqgCm+Qivpn7/OFaYnuG+s73Q09LTqmbL7luxidy3XDgUrpe6kD2LVcLo7Aet
	 BGzQlX/sN9NIK5boZNyDltMO7TmRAr1A3V7M2GpjGLP0n3dWBNcl72ClAj2x7cTW2Z
	 XTe6xMG3Ys+cg==
Date: Tue, 28 Jul 2026 21:44:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260728214450.121b6a69@jic23-huawei>
In-Reply-To: <20260728-selected-pancake-8fa8a066f95d@spud>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
	<20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
	<20260721-clustered-jolliness-30d70a2acc49@spud>
	<20260724225738.2e090842@jic23-huawei>
	<20260728-selected-pancake-8fa8a066f95d@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 16:41:26 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Jul 24, 2026 at 10:57:38PM +0100, Jonathan Cameron wrote:
> > On Tue, 21 Jul 2026 16:52:10 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Tue, Jul 21, 2026 at 04:47:11PM +0800, Kim Seer Paller wrote:  
> > > > Add device tree bindings for the Analog Devices AD5710R/AD5711R
> > > > 8-channel 12-/16-bit Configurable IDAC/VDAC.
> > > > 
> > > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++++++++    
> > >   
> > > > +patternProperties:
> > > > +  "^channel@[0-7]$":
> > > > +    $ref: /schemas/iio/dac/dac.yaml#
> > > > +    type: object
> > > > +    description:
> > > > +      Represents the external channels which are connected to the DAC.
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: Channel number
> > > > +        items:
> > > > +          minimum: 0
> > > > +          maximum: 7
> > > > +
> > > > +      adi,ch-func:
> > > > +        description:
> > > > +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
> > > > +          output or CH_FUNC_CURRENT_OUTPUT for current output.
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        enum: [1, 2]    
> > > 
> > > Please make this property a string.  
> > 
> > It's an existing binding.  I guess it is generic enough that perhaps we
> > should make it a generic channel property and as part of that we can
> > flip over to a string.  
> 
> Ah, if it is something already established then it can stay as-is.
> 
> > We may need to create a top level channels.yaml to cover both ADC and DAC
> > channels though and reference that from both files.  
> 
> I mean yeah, that was one thought I had originally about the
> spi-device-address property. I'm surprised there's already not more
> commonality to begin with.
> 
> Just how common is some sort of "channel function" property and how
> many devices are bastardising other properties like diff-channel with a
> virtual channel to achieve the same result?

I don't think it is that common to mix different things that can be
read on the same pin beyond a simple ADC / GPIO that we tend to
handle by just not having the ADC channel specified.  Still there
is clearly a non zero number of devices that do.

I can't immediately recall the virtual channel trick you suggest
being used except when it is routing from a different place
in a SoC which to me is a different input via a mux, rather than
mode of the channel. 

Jonathan

> 
> > 
> > I guess we don't need to do that yet though given this is a DAC only device.
> > The original place we added adi,ch-func is a combined ADC / DAC and 
> > has a lot more possible functions.
> > 
> > Jonathan
> > 
> >   

