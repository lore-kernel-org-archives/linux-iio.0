Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A2221277;
	Fri, 22 May 2026 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455843; cv=none; b=H40cGiOWKMGkIG6oGfjD8pMIRc4L0UZIkKhXlwdHt+v3iAb0IZjW/Bta2sGmYqsIFn3IRHVfVMrS9l6MwW/RjnkhAsOMmvJY5TJWIaOJsILQjcCbTTxjuZA33hyETGppeoJTUX6Ls4hw/G322JiC0f91+eqQcbOG5wStcRUGZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455843; c=relaxed/simple;
	bh=FHA/5YnKM+ju0Yv16K5OZn9Qekx4YG8PvVVGBS27O4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReMgY4YaVQZ7Yw6z986IXPmQgFzMSR2xPFrR/rIr3ZimsgmrjMpqaOjkPO3ZV4qSWLDtH5b/Howa7tw8XOtOzgLuCtnAT3w0Nr8n7+pAWX17RSb6UN5AGpxDUtlKgF4CDccF09e1D90yWhu1csrZ3ir4633DcujaBbB6KexmE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuwxv6i5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuwxv6i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80EB1F000E9;
	Fri, 22 May 2026 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779455842;
	bh=1vnGYDFz5BiZ1313f55STSAAcAOy4rqKWFtVxYoP/2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cuwxv6i5dA9uQqtD3Y87WnIlQaliQpJ6Q9by4leW7yXOHaWl9pYl5m2g8yY4t0TYM
	 upzQLZ4adFCPAhudsAG04pk/KnNUzbGSA6Ey6qZHjfZkwi6jjPodEkk8lz9xlvb9lr
	 dzGJAOW099UrBrlsjnfuYPGbqqS7qz5WchbexOVJJ0S1+3qBg2RT1BNyopvJZRRE1h
	 K80DLn4h34NXcnt/KLjlQYFuQAcAbfwynzTSLWpp7AZpWdfUK1XuBD80Gzdoyr8Obs
	 UgdzfjZs+p6wIGlaS33eKlWaM63QfrNWCPt+Fdi7i91cWUNG9yLX8fNjJ+fGSNa1N5
	 0yvqSNlLwnZcA==
Date: Fri, 22 May 2026 14:17:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: temperature: Add ADT7604
 support to adi,ltc2983
Message-ID: <20260522141710.3cdbf28e@jic23-huawei>
In-Reply-To: <20260522114259.841-1-liviu.stan@analog.com>
References: <20260521182308.4E2731F000E9@smtp.kernel.org>
	<20260522114259.841-1-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 14:42:53 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> On Thu, 21 May 2026 18:23:07 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Low] The new compatible string 'adi,adt7604' is omitted from the existing conditional block that disables '^temp@' nodes, violating subsystem guidelines.
> > - [Low] The schema allows invalid 'adi,sensor-type' values in '^rtd@' and '^thermistor@' nodes for the ADT7604.
> > --
> > 
> > commit fbbcd3bcbfbb106e48a6545868dd2b27a56b39b5
> > Author: Liviu Stan <liviu.stan@analog.com>
> > 
> > dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
> > 
> > This commit adds support for the ADT7604 to the LTC2983 binding schema. It
> > introduces the adi,adt7604 compatible string and adds two new sensor node
> > types: copper-trace@ and leak-detector@. It also adds conditional checks to
> > restrict unsupported nodes for the ADT7604 device.
> >   
> > > diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > > index a22725f7619b7..14cfa28809edd 100644
> > > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml  
> > [ ... ]  
> > > @@ -477,6 +597,22 @@ allOf:
> > >        patternProperties:
> > >          '^temp@': false
> > >  
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: adi,adt7604
> > > +    then:
> > > +      patternProperties:
> > > +        '^thermocouple@': false
> > > +        '^diode@': false
> > > +        '^adc@': false
> > > +        '^temp@': false  
> > 
> > [Severity: Low]
> > Since ADT7604 shares the ^temp@: false constraint with the existing devices,
> > should adi,adt7604 be added to the existing compatible enum block instead of
> > duplicating the ^temp@ restriction in this new conditional?  
> 
> I think keeping all ADT7604 related constraints in one block is more readable.
> For the block above it's different because ltc2984 and ltc2983 share the same
> constraints.

Agreed

> 
> > 
> > [Severity: Low]
> > The commit message mentions that ADT7604 repurposes the custom RTD sensor type
> > (18) and custom thermistor type (27).
> > 
> > However, the schema doesn't restrict adi,sensor-type = <18> inside ^rtd@ nodes
> > or adi,sensor-type = <27> inside ^thermistor@ nodes for the adi,adt7604
> > compatible.
> > 
> > Should these restrictions be added to this block to prevent invalid device
> > tree configurations from passing validation?
> >   
> 
> This makes sense, we could restrict sensor type 18 and 27 for the ADT7604, even
> though the driver's supported_sensors bitmask already rejects them.
> 
> I could add something like:
> 
> - if:
>     properties:
>       compatible:
>         contains:
>           const: adi,adt7604
>   then:
>     patternProperties:
>       '^thermocouple@': false
>       '^diode@': false
>       '^adc@': false
>       '^temp@': false
>       '^rtd@':
>         properties:
>           adi,sensor-type:
>             not:
>               const: 18
>       '^thermistor@':
>         properties:
>           adi,sensor-type:
>             not:
>               const: 27
> 
> What do you think?
> 
Seems like a nice to have.

> Thanks,
> Liviu
> 

