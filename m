Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1338A70C
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005714; cv=none; b=RVBFQTXzbcZs19oo5/8sHaOtblSiYizMDuwqWKuBATrJo8BbWZaIwCaABfzxxh2LykIWryIi8HZYTxiVOt0+M4yDIUkdBQBpiXDenVQ/u8+rLhk2FOG46Zj9/hOaLkXZpL8VuIEguSYNCSJwclvH4pSI/og+ZY4hm+T96As2zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005714; c=relaxed/simple;
	bh=Kap1NF8qAwfz1jNFb4It5HyW+OIdruVv+i8Ry9pr2sE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kezHXiGVUwrVGfrVYu+3VufQx9TsSHkuA/EGobdAdBlpKkMLRn5Vr5bzcZzcGj6qJ75qvYZ7lqCkZhVHpd+4r9SY2k98f1B3vl7wIktiN+xImtbpHIagpuhcW7mRb16gljTw5B4eHFhV547UeY8H0f+25a2pssaGuli6wcIj5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftubBwgO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftubBwgO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82995242934so1353619b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774005713; x=1774610513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SERTDDOETwbnm5ZBLxTdhDL1QG1xN74dj065fjHNw4Q=;
        b=ftubBwgOlOvPTOD5rXOwU03Pym/MvP6Q+NRhDnbJzjOmMRuzkt3EqbDB8EcGg+fUz/
         D6VJAzhHEIEP6W31jCtBd380YedyJb9c6X9LOEYsfGnL7arXoDotLzhGeAaBGJErJWc/
         ykucukgM/DDHmTw4fDTFmZe2RhrF3PZgIIjQ56WKk04xcfyIQWcyQqmcjz3nuzwwzilI
         2kADyuL9iMN1r7K+J2KSX2VOUV4vx0Adm+nHHI1velzqZl6WU/5fWphySMYayYyd+Vp3
         2aiCBjEQapuhkBuq7Iqf708W+R9NZ7oaEPk7igu48gg2XesuodFn7f+RZtaIMlSNUSq5
         119Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005713; x=1774610513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SERTDDOETwbnm5ZBLxTdhDL1QG1xN74dj065fjHNw4Q=;
        b=JD8DegYAQWMIhN8ea1BE/CaKRjT/nRC7227aIk+YrWV5BZKaB2jxcmnVV7IaTEv8Am
         UPUMO3D3FhEeAkowkCREFzINpj1kbrHAaGTaEupRIprgkfT9bKTLn44ud/Cdm0epy1wR
         UczcZ/zGJETOMWrVDqYgZHYeKcybva9VdI3Ufd+D5bQYa73RobRwdJSa1CiUWNRnPY71
         3gdS3rsG7TSnxR3rP/BRpS37ziZJoyLe00hpS9hQJy++JKjHmfwWyQohVnz+1BJkm/nz
         npdvnXt/HvvMhn13ydxi6aLXnRZhlgGAbFOWoL4H1tCTnC1KaerY5yyua8i5XWbERZ9w
         azGg==
X-Gm-Message-State: AOJu0YxIHwwkAZyvpFmzS4NVWPhaM+Nfa+6t6Eiil+z+V3YmuAFxKeTe
	+X8f5wMHU+ihLFcbAnvv3qUi3flilr0EtU1DcGT7vgFlI7PPs6ZFVZwL
X-Gm-Gg: ATEYQzx+i/SFBoYbF9b0sqKkiXbZuy0DXwVUaRf12N/o1FSwggDnkhPQ9rx6mcPoGdP
	6DHdl7YVvBTiJnSCuOMBbzRAnFWqabIMI1hgb6YCCLYXjzO1J7akTHvNlD1wS/keTTyl1udE9X9
	JRYlqUHJD5OsV2FICTGaKYOmhzcCiBRLVQAKTivdyO8/Sc7oLbm/sjPyX72MgPXjHut7EBkQmsr
	2hVkrlp/1psMPKFA2CjzOwE4IdKY8o8wE3lXNOD+l7/sq92ZKuetApaNvt3i3xkhT3dgkGuo3ah
	iZOjiz4w1Xyv6nlIsxmHwFWaAXu386KvVO6cHDTiMJ6ruwZOfwSVrHdI+zMPGzwx5x/uEt41rIL
	O9wPWMCL/5bNR8Z8e472FU+ypywvaIkTpi9lH9jE5VPnXVVpWgA7pWQoBqYP5qCRWtlKbSjDC5b
	RxNbp8p6MIGUgNkvxkp8RBFa/88CApKV6ZE2YIqfN4POtdop4JAeRnFRhXH7IXfe8vw4pieCgn4
	+d/YqUlMuXpIFelegQ8oyH5BRGuvfrK44f9LtdV2+SysGHH2Bw=
X-Received: by 2002:a05:6a00:3a18:b0:824:b304:2d1e with SMTP id d2e1a72fcca58-82a8c2a1df5mr2016480b3a.8.1774005713032;
        Fri, 20 Mar 2026 04:21:53 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f582sm1790118b3a.33.2026.03.20.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:21:52 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 20 Mar 2026 11:21:37 +0000
To: Conor Dooley <conor@kernel.org>, rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 1/9] dt-bindings: iio: frequency: add ad9910
Message-ID: <zi7ifl45h5fu76rlbdubkeq7wa7gtve5wsdruo574gzj5qbfu6@fl6rh3soaj74>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-1-e79f93becf11@analog.com>
 <20260319-annex-varying-afbddcb825b7@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-annex-varying-afbddcb825b7@spud>

On 26/03/19 05:25PM, Conor Dooley wrote:
> On Wed, Mar 18, 2026 at 05:56:01PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> > configurations for clocks, DAC current, reset and basic GPIO control.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

...

> > +
> > +  clock-names:
> > +    oneOf:
> > +      - items:
> > +          - const: ref_clk
> 
> s/_clk//, not like it can be anything else!
> 
> > +      - items:
> > +          - const: ref_clk
> > +          - const: sync_in
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clock-output-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum: [ sync_clk, pdclk, sync_out ]
> 
> I'd say same here, but then you've got some issues with differentiation,
> so idk.

so I've got the names as they are referred in the device pins in the datasheet

...

> > +dependencies:
> > +  adi,charge-pump-current-microamp: [ 'adi,pll-enable' ]
> > +  adi,refclk-out-drive-strength: [ 'adi,pll-enable' ]
> > +  interrupts: [ interrupt-names ]
> > +  clocks: [ clock-names ]
> > +  '#clock-cells': [ clock-output-names ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> 
> Worth pointing out, you haven't made either clock-names or
> interrupt-names (when interrupts are used) mandatory, so the properties
> cannot be used by a driver. I suggest you make clock-names mandatory and
> interrupts depend on interrupt-names.

the dependecies is not enought make them required then? understood!
 
-- 
Kind regards,

Rodrigo Alencar
