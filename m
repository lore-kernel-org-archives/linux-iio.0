Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1553358CD
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587353; cv=none; b=YjhntbW/trQRaRbdGbumzt4QsGUBDZWFvPtWIsLNulehlKm21KCMTcASLu2+L/eZPMe1ZkJhE8PpZ4ti3ODSNesH1u5aTVHEVzXP9woIjenfyyIhnwvRWb+M+DfzdcPWMPeqwXYvjXVZDg/PYHiuU8+dMGJxGLk4MsK5IrK2VAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587353; c=relaxed/simple;
	bh=vzLbqsrJXpQk1rZTedA54L5eBl7mKGWmonFrkudmtA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZgHmOkAFe7U1y2Zs8tqi0j72Fwu0A0XEBNXu4XBbcGHOGPSpqVSYEC4EnWWt+jsOW1aNHqWes/8xJf4aPBFbx9AhzsM2j/HYDUFVyDfRzhHEI1T8ONhQ6RTxunUM51wks7uSWelB81N4ixVRs3iPNZnF+4wvvpD5g9BN5UAKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=un9QM/9z; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="un9QM/9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=/6kS6UXU7s2teckxYIdOZyT52Pzin9Ij/Q3t+1VU1b4=;
	b=un9QM/9zZ9v0zxq66pjrebjJNsfdCCAzriDvze3mM5Nx/4Edemmo3BOfOIPUf5WkjhtAE7/qZExb7
	 4EW9rTTEwweXH4Jiu6s9JIlTMROplDTfQY8Cjcq/CL7Qi/zwbKqYoPuoLoT6Q9WjqKM6G9DYlMGdtb
	 fomCMxhVvvINfIqOzQWWxYOlVQk9pQR5ojb7++TATQz+IERR6gRc4Yo+lWbQP+liWnlU5TDm7rUjd/
	 GyyskrDuuxGBBCo53MLO7LLKn/HH4+DZhs8eHAzpoQEzCc4u88OLWmnPeW9jbYONWIgBOW4gx1cCAV
	 fBuA2jTGFCnLTLFJq/G5NHawhzHs/Pg==
X-MSG-ID: 8702a83c-fc1f-11f0-b52c-0050568164d1
Date: Wed, 28 Jan 2026 09:01:18 +0100
From: David Jander <david@protonic.nl>
To: Conor Dooley <conor@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260128090118.5c1d7906@erd003.prtnl>
In-Reply-To: <20260127-rockiness-finalize-e0b50b9d823f@spud>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
	<20260127060939.3914006-3-o.rempel@pengutronix.de>
	<20260127-consonant-vividness-13707c7cf8f6@spud>
	<20260127-rockiness-finalize-e0b50b9d823f@spud>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 19:55:26 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jan 27, 2026 at 07:49:20PM +0000, Conor Dooley wrote:
> > On Tue, Jan 27, 2026 at 07:09:33AM +0100, Oleksij Rempel wrote:  
> > > The Maxim DS4422/DS4424 and DS4402/DS4404 current DACs determine their
> > > full-scale output current via external resistors (Rfs) connected to the
> > > FSx pins. Without knowing these values, the full-scale range of the
> > > hardware is undefined.
> > > 
> > > Add the 'maxim,rfs-ohms' property to describe these physical components.
> > > This property is required to provide a complete description of the
> > > hardware configuration.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > > changes v2:
> > > - make maxim,rfs-ohms a required property as the hardware range is undefined
> > >   without external resistors.
> > > - add allOf constraints to enforce 2 vs 4 items in maxim,rfs-ohms based on
> > >   compatible string.
> > > - drop explicit $ref for maxim,rfs-ohms to fix dt_binding_check warning.
> > > - update example in binding to include the new required property.
> > > ---
> > >  .../bindings/iio/dac/maxim,ds4424.yaml        | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > > index efe63e6cb55d..400afd8771aa 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > > @@ -27,9 +27,44 @@ properties:
> > >  
> > >    vcc-supply: true
> > >  
> > > +  maxim,rfs-ohms:
> > > +    description: |
> > > +      Array of resistance values in Ohms for the external Rfs resistors
> > > +      connected to the FS pins.
> > > +      - For DS44x2 (2 channels): 2 values required.
> > > +      - For DS44x4 (4 channels): 4 values required.
> > > +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).  
> > 
> > Add here
> > maxItems: 4
> > minItems: 2
> > 
> > Are 40kOhm and 160kOhm actual max/min values, or just a suggested range?  
> 
> Datasheet for the ds4424 seems to imply they're actual max/min values:
> "Input resistors (RFS) must be between the speciifed values to ensure the
> device meets its accuracy and linearity specifications."
> In that case, consider also adding something like:
>     items:
>       maximum: 40000
>       minimum: 160000
> 
> Although, that would complain about the 5100 Ohms you're using. How come
> the example lies outside of the "typical" range?

Sorry to chime in here out of nowhere with this, but 2 things:
1. Rfs for DS4402/4 has a different "typical" range than DS4424 (different
Vref and different output current range).
2. "Typical" or "recommended" ranges should not translate to a hard limit in
the driver. IMHO, no max or min value should be enforced here.

> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > +  - maxim,rfs-ohms
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - maxim,ds4402
> > > +              - maxim,ds4422
> > > +    then:
> > > +      properties:
> > > +        maxim,rfs-ohms:  
> >   
> > > +          minItems: 2  
> > 
> > Remove this...
> >   
> > > +          maxItems: 2
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - maxim,ds4404
> > > +              - maxim,ds4424
> > > +    then:
> > > +      properties:
> > > +        maxim,rfs-ohms:
> > > +          minItems: 4  
> > 
> >   
> > > +          maxItems: 4  
> > 
> > ...and this. The outer-most constraints should be in the definition and
> > the if/else bit just adjusts whichever bounds it needs to.
> > 
> > Cheers,
> > Conor.
> > 
> > pw-bot: changes-requested
> >   
> > >  
> > >  additionalProperties: false
> > >  
> > > @@ -43,6 +78,7 @@ examples:
> > >              compatible = "maxim,ds4424";
> > >              reg = <0x10>; /* When A0, A1 pins are ground */
> > >              vcc-supply = <&vcc_3v3>;
> > > +            maxim,rfs-ohms = <5100>, <5100>, <5100>, <5100>;
> > >          };
> > >      };
> > >  ...
> > > -- 
> > > 2.47.3
> > >   
> 
> 



-- 
David Jander
