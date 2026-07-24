Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60C3E2ADF;
	Fri, 24 Jul 2026 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930267; cv=none; b=Vhw/pQp5/XDmwCFRtzV6QIUAPtljADNDdd8+BVCtGItHjxBPIms27Gc7ucNHzyQdWq8MwflcQEpl3YJ+C4eB0ntCc3QkwN+4KC/mEN1kKjEzXthdRD8vIXO3lyJhBWWeaj8T/CvaJVpHRaTB8bNw1Usx/yH/oascfofCxYoyakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930267; c=relaxed/simple;
	bh=0BY50gfX3IV3AjY5VIUDPj3EpOnUHJGP2zN9gJgTgno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWykAKmAo1l404lA1ZBK1GTdkSIBbqNOAzWFW6hslfCFuDKwaqRHwAlJkrkpV8K6NRdt7RisR+J9/0J/we+tUryQJD+zb6UvpydfWdwXQZ6ZmpEZLdu7vt9qMCIxwwiQfPlJDZ5IizBaf7n0TMauVydOeQyW13kcabI+MWltA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjAOJeri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjAOJeri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DA51F000E9;
	Fri, 24 Jul 2026 21:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784930260;
	bh=GaxkUdDDiUx1gETchgnM4L8LeQZVjdyc/N5mIpGCFws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SjAOJeriP9IeRwB7lxmdWRbBF5Nr9Aae0vgEQCXO8aLYBGB02rpeNt7/qUc1Xmfzp
	 jSlyE9xRE+wO5/LVGpHxem0prfhwvFethBw61dxbicv68LVv+zmzq6YnvTPitnTURY
	 bwDPqd4DweCRpbibzCCw4oLuJul3H8PQfFos8ZKYZUDxCl+UcoWV3FkUnRTfJfHk0k
	 OjBGfoPOEHqQN/rLN3ckqAzy6Bo3CzWenigqOtf7YUqt35MCZ162W+IPMFrHuYGGKB
	 3m/DWRGo21bszDMyYlCG5mr5OU4JxXidWWlP16q1grlTDfa3le5L8R3fyxjS9d0O2w
	 XgOeHfonD3Pvw==
Date: Fri, 24 Jul 2026 22:57:38 +0100
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
Message-ID: <20260724225738.2e090842@jic23-huawei>
In-Reply-To: <20260721-clustered-jolliness-30d70a2acc49@spud>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
	<20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
	<20260721-clustered-jolliness-30d70a2acc49@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:52:10 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jul 21, 2026 at 04:47:11PM +0800, Kim Seer Paller wrote:
> > Add device tree bindings for the Analog Devices AD5710R/AD5711R
> > 8-channel 12-/16-bit Configurable IDAC/VDAC.
> > 
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++++++++  
> 
> > +patternProperties:
> > +  "^channel@[0-7]$":
> > +    $ref: /schemas/iio/dac/dac.yaml#
> > +    type: object
> > +    description:
> > +      Represents the external channels which are connected to the DAC.
> > +
> > +    properties:
> > +      reg:
> > +        description: Channel number
> > +        items:
> > +          minimum: 0
> > +          maximum: 7
> > +
> > +      adi,ch-func:
> > +        description:
> > +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
> > +          output or CH_FUNC_CURRENT_OUTPUT for current output.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [1, 2]  
> 
> Please make this property a string.

It's an existing binding.  I guess it is generic enough that perhaps we
should make it a generic channel property and as part of that we can
flip over to a string.

We may need to create a top level channels.yaml to cover both ADC and DAC
channels though and reference that from both files.

I guess we don't need to do that yet though given this is a DAC only device.
The original place we added adi,ch-func is a combined ADC / DAC and 
has a lot more possible functions.

Jonathan


