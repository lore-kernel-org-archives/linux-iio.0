Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4B35AC14
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868640; cv=none; b=mgxFWEB/y+MhcGML4LdmLFnZ+Kn2DfkG/kpA4GnITyL91VSBD3ZJYKJ3IWejIAuxnPcrOhCBQ3jTtGC/eSj4FHi08E/nt3gTxP4Uh4fvWAGY92TJz9/P10qymtRfLEPrPAqN0KqCgMdbT4JVNIeO0vtYsDj5Lb7nS+l+avEP6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868640; c=relaxed/simple;
	bh=tKL3KAbOmbB0KsPGhd6YoyVBMOUEnR4k+bBexPz+8pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0AWYChHYPHIs4cOCMDtps0bsD1T6KqFEuVWtQknEY1bMRR68PY0/EYJz3xM38PhCfpRdXa23KQwtory2rAXD+mk1pZO9RR36Y2K+os/nWl2QBQP9MZYDNZP2yA+mlTd55ln5pecZ2T3J06e68zyCpAQE9fLjQfBvgf7gVHSs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOmJGB0H; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOmJGB0H"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c029505b389so548230466b.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781868637; x=1782473437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TucRX2gfPFMDDoN8Mlfxd7xl20UMCrUn0QTYPFwhHT0=;
        b=WOmJGB0HxidhB6JY0wFdD+DwEFWzo9UC1OREqh5rf0lT/YNOJl25bT2Hi5ZaMMHW3E
         FZkpEUU8mSVfQJqx5anHT3vmLkYTNHRlDToZqENjX+NiKbINQ3hPtbVcEn18+4wznF2f
         QbpqBzb2V2yrWtGcj3vysumziQsL2EYQ2dBdqEKDnDh1SwKB5cDnFTOa2efFQILbAK9P
         s2ABtPQ3w3NiatjFIGaeEuzQ+WwQ2do26nUk3oFANjmx1NSgZKjWkO9hAdOFcE8lFl4l
         5yfwagFK4AkUGnVAVz7V/7sTFe6Rw3NsFyhyWXUTMEpYLR7mlnWhylixx3bqcZbqumS6
         jKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781868637; x=1782473437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TucRX2gfPFMDDoN8Mlfxd7xl20UMCrUn0QTYPFwhHT0=;
        b=A/alzVCBAg0QD3GsGmWpyrVZ6wbuYk0ual8mdryL5XLpvfLbkG4NhUe3zBPn/j510V
         mZLCDVRohz86BP6ukyFM4h1eygt36l9SA2vYycVxJcehq79ASMx2tLdoz2EIO8kKy6ny
         vWbflYW8vF9V0wrV+iNPLdjdnMle8qxIp0nyw37z5Tf2KjLixg5OfyaXGJ2EJknkX0A9
         RtT1r9EluwSy2tMihT87UkJMSfM+0UT/Z+V2j5a1gdYuv3nyJRlxxVkcTo6rD+FgLK89
         Eedolaz5dv1lo7RolvAgyj6Pj+gEUCjEqy3SY3W2IVNZReA/p/kFZJhsF121wJtgFdtl
         zp0w==
X-Forwarded-Encrypted: i=1; AFNElJ8FJzkLLRHTL9tmb1TO3ixcbZc8EF5SGHBIjeyGk64iLvh2FVPBIivSgG51G4k8tl9HYxR8j29n1lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOS57mZz0k0ryk8897KUCiHsbvpn4xtF8xUHl5/5imFj7kvmRT
	B5MP9+QSlufGMWh8L8UGENfN/O3Rm/yx4pNMkAp6GT3s26+fyNP1jUkmFj0OmA==
X-Gm-Gg: AfdE7ckIkKHFYM9HqMk/hBCzdrA6x0jyqNWxbToS/cPVPVu+IfoSSC5WxYpnZ3SqV8i
	WLHSbUkSWRmBuxA5hYOIlTIxIBbmK5K9y6JCRfQfhKWXR1CmGlciK03f9ntwNMcqh6P7YhVIrgV
	jEvaZGQfhgN6pM8VjURfo0cLOf60VLjHjXQ8JXzhMpsYG1XW2q6jSABX23EQzeeZCHF7x6nCS3Z
	zwuMy2OZnpd+QPBEqv+QqIERv4goqyIjs+9Qucb/WZmLCD9HqRZGpXT24/SOIz4yyVVNip/CRWZ
	lmW+P07HxA01nGELUo+AX16iSDziNOFAmN/8BxYVFg+qKL0Mj6nT1axA2XhtV2PKVrdqBh155JP
	7h07rH17t7br70Gi9RGlHYz2NopGBWk38Im2pVdrwHrEUIqHwRxLk58KnyMKqWcQubnDzC3JJXS
	57yZO7
X-Received: by 2002:a05:600d:84ca:10b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-492409fbfb9mr28275055e9.3.1781868623638;
        Fri, 19 Jun 2026 04:30:23 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245711032sm16710165e9.0.2026.06.19.04.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:30:23 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:31:24 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <ajUniw8HEuAIBr-a@nsa>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
 <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
 <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
 <20260614204455.408c4d40@jic23-huawei>
 <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>

On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:
> 
> On 6/14/26 21:44, Jonathan Cameron wrote:
> > On Tue, 9 Jun 2026 16:47:23 +0200
> > Janani Sunil <jan.sun97@gmail.com> wrote:
> > 
> 
> Hi Jonathan, Rob, Krzysztof, Conor,
> 
> One possible model that would also allow mixing the 12-bit and 16-bit variants would be to treat the parent node
> as the shared SPI transport only, and let each dac@N child carry its own compatible.
> 
> Rob, Krzysztof, Conor — wanted to get your input on whether this is an acceptable binding pattern.
> 
> properties:
>   compatible:
>     const: adi,ad5529r-bus
> 
> patternProperties:
>   "^dac@[0-3]$":
>     type: object
>     properties:
>       compatible:
>         enum:
>           - adi,ad5529r-16
>           - adi,ad5529r-12
>       reg:
>         minimum: 0
>         maximum: 3
> 
> With a DT example such as:
> 
> ad5529r@0 {
>         compatible = "adi,ad5529r-bus";
>         reg = <0>;
> 
>         dac@0 {
>                 compatible = "adi,ad5529r-16";
>                 reg = <0>;
>         };
> 
>         dac@1 {
>                 compatible = "adi,ad5529r-12";
>                 reg = <1>;
>         };
> };
> 
> The downside is that it introduces adi,ad5529r-bus as a compatible that does not correspond to an actual
> standalone device variant - it would require a parent driver to manage the shared SPI transport and enumerate the
> child devices. The actual DAC functionality is handled by the matching per-child compatibles(12 or 16 bit).
> Is this an acceptable pattern, or is there a preferred way to model this type of addressing scheme?
> 

At some point, I wondered if we can't just have this at spi level? Like
(in the simplest terms) a new spi-peripheral property that would allow
devices to share the same CS. Then we would need an adi,pin-id kind of
property for this device but the bindings would be pretty much as if we
only supported one device.

I see Mark is already in the loop, maybe he has seen this kind of things
before.

- Nuno Sá

