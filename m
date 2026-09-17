Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0955A984C;
	Thu, 17 Sep 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661232; cv=none; b=BIv64Sxn3hXG3WW3a41sFFlc+eos9lgI33ILMcB/cBpORhrmmzJViJV8m1uBiBehwqQc/jFeCC3kdHcgacb6XE8wPhmNwwqroOaqwTkyx/PyZ8SUlYGDmuq/BGVlkDCCPiVNZO+b24wk2iOh/kkZ/+26UmW5AJNdcQPmN7TGzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661232; c=relaxed/simple;
	bh=gZTQDfssG3JSeIbNDaL+hZhNynXUXtxvLheslOYFtXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZdpn1XRVAUHdhtb8witM/gOg08GT2bcZ1GlOuffHclDu9/9emz+Fh4uctuetL6883egq2LNcTyXWb0/hl34fdoAT9iUK5B5e700yYuosAPSST4tZLSKyrTa3GDU3ExY8S+8n4aWnB7r6k1U79HSwYUfPeBU18xkwJenvSq3l6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCujllDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCujllDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6584F1F00898;
	Thu, 17 Sep 2026 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661230;
	bh=2WPSeI4su/Zj4GP4rAx2i0HpZhjWDOesF6/jU0yhbLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jCujllDUQQhcDIpWQcUouXW3noiDfnusff3oUO1BGRjb9SJFXkIeVnEFfAAdmebn2
	 fVvwl3eBVce5agfUFCDOp+YOcgRahtpdHvCGSWRF9lyugT/4azydcvlPVQ1BdEh8C5
	 DrWvKxmLgRq+kH1LCoP9xg0nbw+zupe/4urJVAA2d5Zx6X2+7LjHgRHja1sAstU5G7
	 Oglk9aV9McP31FJmaECDTc26WMUaMQKPkKdUY4vA9QaJBknH272dtjdRxzv7EBNGKt
	 c7peyepbBkqQpgKIET+MalACOUO5HB9UCebqU/05yo+y+eIKsXWaA8iLyn+gWadX59
	 9uU4+v2hdBlwQ==
Date: Thu, 17 Sep 2026 11:07:09 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 09/15] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20260917160709.GA2294753-robh@kernel.org>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
 <20260916160025.GA382310-robh@kernel.org>
 <20260917043039.6b9fc505@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917043039.6b9fc505@jic23-hlaptop>

On Thu, Sep 17, 2026 at 04:30:39AM +0100, Jonathan Cameron wrote:
> On Wed, 16 Sep 2026 11:00:25 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Tue, Sep 15, 2026 at 04:14:44PM -0300, Marcelo Schmitt wrote:
> > > Document how AD4134 chips are connected to the host SPI controller
> > > according to different wiring configurations.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v1 -> v2:
> > > - Set default for adi,spi-mode property.
> > > - Added '#daisy-chained-devices' property.
> > > - Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.
> > > 
> > >  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
> > >  1 file changed, 44 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > index ea6d7e026419..012e09decf7a 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > @@ -131,6 +131,26 @@ properties:
> > >      enum: [ free-running, gated ]
> > >      default: gated
> > >  
> > > +  adi,spi-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > > +    default: no-cs
> > > +    description: |
> > > +      This property indicates the SPI wiring configuration.
> > > +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> > > +        line is not used (tied to GND).
> > > +      * 4-wire: Specifies a conventional SPI wiring configuration.  
> > 
> > Absence of this property should be conventional mode.
> Hi Rob,
> 
> Unfortunately we missed this in the binding originally so we are left with the default
> of what the driver did at the time.
> 
> I wouldn't be against merging a change in that default as a fix though if we
> don't think this is yet in heavy use (merged in 7.0, but given not a complete
> feature set yet, maybe?)

Ok, it's fine then. Just make sure the commit msg has this detail.

Rob
