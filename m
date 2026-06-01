Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC12212554;
	Mon,  1 Jun 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323011; cv=none; b=Hso2LhRdL+18DlL75GZBzw6wcYs51vDK0e43G9lOxk5rKvlYSnEehAFwCAg+w5itmRofWBCz1tO5uUArQWnEpjjJxiTrTqHL1TM1ZN+dZrozVN0z4Nww53XE1s33Equsk3mn9/1rXGWt3QOEMuC6fYLgKmZWQbLTdhExRfEQbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323011; c=relaxed/simple;
	bh=7j6NV7kfXv8dtdgSgMpa5bT8s26mUNMEsiXKJCzRFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQf2KUEExxRwzWLNkFgW34AbTiKLeuILe/SCq0oRsLICaYYlR9YSWz2IFL2PHdDc1W6ntlj4wEetjabDOQNDxMvPbPd+85MHxa14wwiGh0apquz+ZouMnRyDqmOcT1k09b8axZUiSRws90HzdqL10HnZXbFApw4ZqAS+xeBbVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRiVH8xL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRiVH8xL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61F1F00893;
	Mon,  1 Jun 2026 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780323009;
	bh=cN67D5iV2/BkWrnjvbPCF/3VZQLDfqDjfnERusdSnUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GRiVH8xLGzIYLQBZv5kQ5hZomhaS8WT/MkSSqpJMmHx9xGtrpXrAKY2vcILilBu0m
	 hJARmuev29yWazEsKT4Hh1WKpSak8E3A5r18rH7nQYAE7c02kv7PESALJQeLWmzuJd
	 T9gX034QIOafxT41RMF6UjmooU6tzb072Ig6FYkouhG6HtJukOVG1L+/aNUfrKx2Wz
	 Ishms7e598n0VuOFJHBQYTfNpl03VrH2GvcuBon5guQpVzbFEeM8xODqBcqcl6nIKd
	 PGxdESxKYof/CBHC89qIbVUYy1HNEGv+8+A7VudhRydlfZvwE4HuZXKHrFvZNyGopB
	 JJuL9hr88kZqQ==
Date: Mon, 1 Jun 2026 15:09:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260601150959.49bbf125@jic23-huawei>
In-Reply-To: <20260601-banana-narwhal-of-music-0b4d3a@quoll>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-3-wafgo01@gmail.com>
	<20260601-banana-narwhal-of-music-0b4d3a@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 13:53:23 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:
> > Document the bindings for the Sensirion SLF3S family of digital
> > liquid-flow sensors on I2C.  The family currently covers the
> > SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> > 
> > The driver auto-detects the variant from the product-information
> > register at probe time; the per-variant compatible strings exist
> > for documentation and dt_binding_check purposes.  
> 
> Here...
> 
> > +description:
> > +  Family of digital liquid-flow sensors from Sensirion with I2C
> > +  interface.  All family members share the same register map; sub-types
> > +  differ only in the flow scale factor and the calibrated measurement
> > +  range, both of which are detected at probe time via the
> > +  product-information register.  
> 
> And here...
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sensirion,slf3s-0600f
> > +      - sensirion,slf3s-1300f
> > +      - sensirion,slf3s-4000b  
> 
> And here something else. Confusing. Didn't you say device variants are
> auto-detectable? So you have only one compatible sensirion,slf3s.

And then future fallback compatibles can never work. 
Basically as far as I have ever been able to establish this is why
generic compatibles are almost always the wrong way to go.

If we get a future part with an unknown ID and don't have these existing
specific compatibles, then we have no way to specify which one it is
compatible with.  Given these are providing scaling info that means we
can't realistically support such a future part with a fallback at all.

That would only be possible if there was feature level discovery. A single
whoami register with no structure to the value is useless for this.

Note for this type of device I absolutely expect there to be future
parts with different IDs and same ranges as here, the unknown is whether
sensiron will change the interface or not.

Jonathan

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        flow-sensor@8 {
> > +            compatible = "sensirion,slf3s-0600f";
> > +            reg = <0x08>;
> > +            vdd-supply = <&reg_3v3>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 06a8c7457..222a03b6d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24187,6 +24187,14 @@ S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
> >  F:	drivers/iio/chemical/sgp40.c
> >  
> > +SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
> > +M:	Wadim Mueller <wafgo01@gmail.com>
> > +R:	Maxwell Doose <m32285159@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > +F:	drivers/iio/flow/slf3s.c  
> 
> Basically almost the same comment as before. Drop. There is no such file.
> 
> > +
> >  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
> >  M:	Tomasz Duszynski <tduszyns@gmail.com>
> >  S:	Maintained
> > -- 
> > 2.52.0
> >   
> 

