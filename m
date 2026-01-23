Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B749350A21;
	Fri, 23 Jan 2026 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160509; cv=none; b=PcWZYRSGYIxTDtFr/BMZedjMKT9SsAkjJBEUgao+cM0oSPYhbyI5UolbSvUwrdXRf1kg2Zg195g7e2xQjfalZMl/6sSGDIWnPXIwGRcs8s4TamFt8xyrk/67gXeAGn0JwAtzZPcai8jkj0qB79qxIjZKV/YWY7haeoElzA1S5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160509; c=relaxed/simple;
	bh=ke87CicNIBzJitf1GLyB4AYrViCw7+226adczwrhkyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoW4QVO1L7lTJT+GlWrFg2NhUnt3mPAGqYvEBCdoLf7GBDngQdlwsSXYgEwWDCsi35BZXOA1Emt9RPRQHxeyPd4pgeYsj8I1rFmWr4eqnMbR37VMoznqZJXxfGzUYcvQzNiy8CFCnM7Rwi66D9zEqhb2af4RtFpk0xGvMdYjZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2uLL95l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2uLL95l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA177C4CEF1;
	Fri, 23 Jan 2026 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160509;
	bh=ke87CicNIBzJitf1GLyB4AYrViCw7+226adczwrhkyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J2uLL95ltP1whHjryoLrROiuLH8HtUt6oyF8O1TPoUfIlhSsWJYNFRG2l9OXyGZti
	 mzxGH0CNKlO4GaDEG4FcrevKsvzPk8dNACpXAlmPaWsF8ibDAgdG7Io+hFwsBH9VL1
	 LKC0AHV58OBpxyY77CsZWeLk122kv1i4s02dxnRt86uK9vGWdKZfLwMnRVhn2CQZou
	 EqhfVAqy//OI5SrF/fHlKTY9101Wb5Hg4ce+EzvHAG1sz58gnyNRzhAPq9pOunokaV
	 Hg+3fmJ3ZizR0rUNvvJ7uyghaWcBj2ACQji8qv0AaeJmH5JjqWSSP/EgQMjG8FVnB7
	 rQE+FwkvgmVHw==
Date: Fri, 23 Jan 2026 09:28:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260123092819.6ae81211@jic23-huawei>
In-Reply-To: <20260119-turbine-feminize-9dcd5c86feec@spud>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
	<20260119182424.1660601-3-o.rempel@pengutronix.de>
	<20260119-turbine-feminize-9dcd5c86feec@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 18:27:52 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Jan 19, 2026 at 07:24:18PM +0100, Oleksij Rempel wrote:
> > Introduce the 'maxim,rfs-ohms' property. The full-scale output current
> > of these DACs is determined by external resistors (Rfs) connected to
> > the FS pins. The driver requires the physical resistance values to
> > calculate the correct current scale (Amps per step) for the IIO
> > subsystem.
> > 
> > Keep it optional to avoid forcing updates of existing DTs; without it
> > the driver cannot derive a correct IIO scale.  
> 
> I don't really follow the logic here, if the driver doesn't work
> properly without it, shouldn't it be a required property even if that
> means existing devicetrees get new warnings? Warnings are preferable to
> the drivers malfunctioning on those devices, after all!

Agreed. The driver can paper over holes or I guess we could provide a default
if the datasheet has some reference value or similar?  

DT binding should require it.

> 
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/iio/dac/maxim,ds4424.yaml     | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > index efe63e6cb55d..b7af8464a4fc 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > @@ -27,6 +27,17 @@ properties:
> >  
> >    vcc-supply: true
> >  
> > +  maxim,rfs-ohms:
> > +    description: |
> > +      Array of resistance values in Ohms for the external Rfs resistors
> > +      connected to the FS pins.
> > +      - For DS44x2 (2 channels): 2 values required.
> > +      - For DS44x4 (4 channels): 4 values required.
> > +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).
> > +    minItems: 2
> > +    maxItems: 4
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.47.3
> >   

