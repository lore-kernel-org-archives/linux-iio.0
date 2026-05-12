Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324C275AE4;
	Tue, 12 May 2026 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558278; cv=none; b=EIKqCj0NrxJuxwvOKU5n4rpUl4LdcneqrW3FUIVIB7icbXHksXvTtYMIJiznwCUk8TgqHbtrszBTcq4dencfiSP626gfYD1fsPJBK6Ml9iDva7fO7Ut8CtiUl5wpuSIH59NA3cl4ximfVzCgu9eouF7xskMXg+Z5xAFSJGG9cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558278; c=relaxed/simple;
	bh=X1nLH4CetOnQQJUP4BtGE7WFhHgvzfUYTHQaumR+N1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2Zfj7HYYDraWtaNFowtStyPGt1BgK1kjJUXqe1K3PW7cEmvcqFZm18/wg6dcfh0q64SlnV3C5V4oIsaqImXitXcA3rYMq3FATSXRICIWBuYXya2QrAprCWeMU1pGQ021AIv61ioELo5ZA/cVZAu+7xGQ2vrrwfFsZyu9nsKuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=pVbVIxXB; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="pVbVIxXB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Euouo/K/RbEumsaT1GH2JUlCYd6qzEvxZUoNiId5TT4=; b=pVbVIxXByLhlXqnNT+0d+CbEve
	TjY0bwKs+/AYKrfSWu8mPOnImLsJNhc0Lmg7JggF9Q0CQHzdtFogBgpRGiAHApaocHOFShgOykLpk
	eysv5YIBb4pLQGwd3tNAl0P0hkNNONnv6tunaHzK9+7s5xdYNkjistxxT9WqqgrZxsT6Zu2ALrdM3
	AsQU/uqgI02OxtyW9MujjNgIY8puI4mfJkKjBzRGF9Y1ClyabokNj/hczmAjrYBl98cuCOxACZ8tj
	U3qI9h+MUaJIXtZ6vaWGLQrxGcoorF8i1AF3Nt7sZl4X3kfR8kBKrhAk9fZ43pXn01ciUFFQJx9ee
	0gcTliDA==;
Received: from user-188-33-36-12.play-internet.pl ([188.33.36.12] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wMeFj-00000007kOo-3hb9;
	Tue, 12 May 2026 05:57:52 +0200
Date: Tue, 12 May 2026 05:56:54 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maksim Kiselev <bigunclemax@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add GPADC for Allwinner A523
Message-ID: <3aabrtlih2z3b4v5ec5jdb76cb4aesqm2grjudzxhlkk3iwzcn@bawiakcija6d>
References: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
 <20260510-sunxi-a523-gpadc-v1-1-4f6b0f4000fb@mmpsystems.pl>
 <e7269822-afc4-4a80-8408-297f9dbd6791@arm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7269822-afc4-4a80-8408-297f9dbd6791@arm.com>
X-Authenticated-Id: michal.piekos@mmpsystems.pl

On Mon, May 11, 2026 at 06:02:16PM +0200, Andre Przywara wrote:
> Hi Michal,
> 
> thanks for adding this!
> 
> On 5/10/26 14:57, Michal Piekos wrote:
> > Add support for the GPADC for the Allwinner A523. It differs from the
> > D1/T113s/R329/T507 by having two clocks.
> > 
> > Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> > ---
> >   .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 37 +++++++++++++++++++++-
> >   1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> > index da605a051b94..89da96cd705f 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> > @@ -17,6 +17,7 @@ properties:
> >         - items:
> >             - enum:
> >                 - allwinner,sun50i-h616-gpadc
> > +              - allwinner,sun55i-a523-gpadc
> >             - const: allwinner,sun20i-d1-gpadc
> 
> As Jernej already mentioned, the A523 GPADC is not fully compatible, since
> it adds another clock. The question to ask is: Can a driver only knowing
> about the fallback device handle this new device? For which the answer here
> is: No, it misses a clock.
> So add just a single entry for the A523 (plus adding it to the driver).
> 
> So looking at this I wonder if we should add some property to describe the
> number of supported channels, since they are slightly different between the
> SoCs:
> - The D1 manual mentions 2 channels.
> - The T113s manual (same die as the D1?) describes 1 channel only.
> - The T507 manual (same die as the H616) reports 4 channels.
> - The A733 has 6 channels.
> - The A133 has 1 channel, but it's channel 1, not 0.
> 
> So all of this is somewhat covered as channels are described as child nodes,
> and have a reg property. Ideally non-existing channels just wouldn't be
> listed, but I don't know if we want to rely on that.
> 
> So I am wondering if we should introduce a limit, or rather a mask (to cover
> the A133 oddity)?
> Either a DT property (channel-mask, as a single sell representing the bit
> mask), or derived in the driver from the compatible string.
> The former would avoid introducing different compatible strings just because
> of that, though I think this type of property is somewhat discouraged?
> 
> Any thoughts?

Thanks. I have missed that sparse channels are also possible. I think in
current implementation it will cause issue with lookup through
<&gpadc 1> as sun20i_gpadc_alloc_channels would effectively create
channels[0].channel = 1 in such scenario. I will try to verify if my
logic is correct and provide separate fix if needed.

Regarding DT property masking channels there is already precedence:
atmel,adc-channels-used is a bitmask of muxed and enabled channels.
Not sure if preferable though...

Michal
> 
> >     "#io-channel-cells":
> > @@ -29,7 +30,12 @@ properties:
> >       const: 0
> >     clocks:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> >     interrupts:
> >       maxItems: 1
> > @@ -40,6 +46,35 @@ properties:
> >     resets:
> >       maxItems: 1
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          items:
> > +            - const: allwinner,sun55i-a523-gpadc
> > +            - const: allwinner,sun20i-d1-gpadc
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> > +          maxItems: 2
> > +          items:
> > +            - description: Bus clock
> > +            - description: Module clock
> 
> I am not a YAML expert, but I think you can drop the min and max properties,
> if you just enumerate the cases. Same for the names.
> 
> Cheers,
> Andre

I will correct that in v2.
Michal.
> 
> > +        clock-names:
> > +          minItems: 2
> > +          maxItems: 2
> > +          items:
> > +            - const: bus
> > +            - const: mod
> > +      required:
> > +        - clock-names
> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names: false
> > +
> >   patternProperties:
> >     "^channel@[0-9a-f]+$":
> >       $ref: adc.yaml
> > 
> 
