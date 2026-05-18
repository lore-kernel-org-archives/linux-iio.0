Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26731A807
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098615; cv=none; b=UCNjL3xrKh2Ud51x9JFC3lPhmMrCzg3Gj1GNojLmdEnzIJMRg721ciMZJh0BdnJGB+i48gCO8m5TLngDGnk5UApU3P7IIjXKnsyhB1dlA96fQ3WJ0AS93Eo4snWyDQRGsjmufx0Xz6qq0vL2YmqPgdpFDCcRypS4oBYm3y3xJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098615; c=relaxed/simple;
	bh=OlVnZ6hgBjl6Z4wjcdiU1o7je41o2bODQ8xTkDcLa3M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL3rjf3+nWEnys0/mWg3oZnm1GSxG79Ras39Mch365mUZqD3aJ5ixxrsuJN3u4BZLSvYbod2ecSXbKVTxxLkUugTJBvT76TjpsAS/UWe2aKimx+yb4NYKij5lxDzlJ5hT1ZrfE68BLzpFG0jf0RIVghjbaYN2wxO4hCXCd2+uGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l66c26y2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l66c26y2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9382e59c0eso456683266b.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098612; x=1779703412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ylC37SeHhzEHv6vV+fwrRGDdNjQ9Rkf4Ee3GfdjHs=;
        b=l66c26y2HCl2ofOgm8mN9gFQxNXJmjgUbaj22MJZalI0IQUYLh6KWDyebsE3k3jMG1
         3TDqvmqoFvE0YpYF+YFCq6cVfOWsS5cSJuvvHkQ9/xlT0IkabPsPohCW9jjhtv2dnwsH
         XR08ai3ORBF+584Xz55zcG0fFZVBORnNYeoMsQNOvQa34PT28d7ThEfQNEq8b8oTIh3W
         I4qn5rcyBLmOaYDyi0Hw6bj/8i6ge/vJP2MGZaYOMtkLFNCrCiF3yiQmbXlzQb2hgwFY
         pSqyyyUQ82tXkSN79KURiGMJfMKKeYblF/hanGGBiFoSWlZdcRTWUS69wLRKM7Oxy/eb
         m7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098612; x=1779703412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ylC37SeHhzEHv6vV+fwrRGDdNjQ9Rkf4Ee3GfdjHs=;
        b=G7D2YoIQbIOuxDH0Wlvs3eSkFy1yKH+LS33/Zp0ZBExb//4TYppZZMXhVO36lsrMfS
         lDQ2H2qrRxdC52fIJROmR/mKkQuzgxz81+u0qHVL/GHKREz2jZ8CbFuTCZTXc/rILtzM
         sSUKHB5frAU4H4w5eyeVJvnZg9ARlPiN1lI/znavWPUNVdI4NzOlcGat8pbeqd1Eveo1
         Qy3Yeh3nBKK+lYWrGKpxoA56gk32z9ZrJIxX31fB46O79DIzxx4S1krkJyS2u5euA8z2
         /bDxQlpkFYpqQiIgTUd5/XjI57IebDJiY/3dxuzDn12PrFLD6oBx2MuyVXJxkPBDlOqq
         6rIQ==
X-Gm-Message-State: AOJu0YyOTkislBkjhzv6FkGEqPcFH8vNOsp/aLIoedGDH4i+08H0eXNW
	u3V7SXc4nEL5Wj0z3hgOKYUi90xJiah2iry7yrU9KgkPX3q1W9ejzDcw
X-Gm-Gg: Acq92OHvulAdoM9Zxno9+knLbrgqtmZoMQbkpAtWem8yynLUZpKIPe7V2ClS+4Jtoaf
	GO+U/+V2glOoI268ohT8883Ylu6iOWqkTNoI6QoJjK+f0hbMwHwF51hHOXhJuZKTUuu2AzVaMTm
	K1LSWnybH9UwxFl7g5qEhfpfUg7/aplApSxma9Bx5kX4SUSQAEaj4ZHEGUNoUFepGpMzGLIs/4x
	+rfOsa5yVxUJ3VXtJuuK3w2DccJMnksCmBJQgyOtY6qK5VgNQmoQQxKfY7Az4+dzdGSXr4k/R+T
	qLNHB3eyjS6AEpm5iSCr/pK93pMI1QqYLvc5YpSMO69prr5Cj/xbI2lE37iU7Ngk9721N4Axw3R
	QDJcbOw4YMY2ODKC7ITq2TeX6OiyYlJt4e4pXVmpb4p2CNz1CBG2GKJXnDQlGYBgghWj6frUc1n
	pwdKoMOswgE+tRqVTer28Ev6zFvQPmDXu84UKBXdp3PlPylPp2DhPRjh0Br1ygI5fDuxB2hw/rD
	hT+y5HzpSZLPVbqnSSl02vLRYdwkQcL11SrUS9H8Zabzpq8xcIECeq5jSeRApBmE3W1kZY=
X-Received: by 2002:a17:907:1608:b0:bd4:9a55:18e2 with SMTP id a640c23a62f3a-bd51797a54dmr747720366b.45.1779098612039;
        Mon, 18 May 2026 03:03:32 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd2f67sm541480966b.7.2026.05.18.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:03:31 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 18 May 2026 11:03:25 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 05/13] dt-bindings: iio: frequency: add ad9910
Message-ID: <54aifnhtrlus35grvw2cgotvxwnp5p7peim3tke5wa5tjobmww@iiaajlvladrt>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-5-31599c88314a@analog.com>
 <20260518-zippy-ingenious-aardwolf-df46a2@quoll>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-zippy-ingenious-aardwolf-df46a2@quoll>

On 26/05/18 09:52AM, Krzysztof Kozlowski wrote:
> On Sun, May 17, 2026 at 07:37:49PM +0100, Rodrigo Alencar wrote:
> > +maintainers:
> > +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> > +
> > +description:
> > +  The AD9910 is a 1 GSPS direct digital synthesizer (DDS) with an integrated
> > +  14-bit DAC. It features single tone mode with 8 configurable profiles,
> > +  a digital ramp generator, RAM control, OSK, and a parallel data port for
> > +  high-speed streaming.
> > +
> > +  https://www.analog.com/en/products/ad9910.html
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,ad9910
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 70000000
> > +
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: Reference clock (REF_CLK).
> > +      - description: Optional synchronization clock (SYNC_IN).
> > +
> > +  clock-names:
> > +    oneOf:
> > +      - items:
> > +          - const: ref_clk
> > +      - items:
> > +          - const: ref_clk
> > +          - const: sync_in
> 
> So that's just items with two items and minItems: 1. Like you have in
> "clocks:".
> 
> You got this comment already at v2.

You're right! will adjust. For some reason I thought I had problems with
the dt-binding check without this.

> 
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
> Why are the names fixed? And why is the order random?

All of those would be optional. Having it in a specific order we would need
to register all the clocks even if only one (or none) is used?

> > +
> > +  interrupts:
> > +    minItems: 1
> > +    items:
> > +      - description:
> > +          Signal that indicates that Digital Ramp Generator has reached a limit.
> > +      - description:
> > +          Signal that indicates the end of a RAM Sweep.
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      enum: [ drover, ram_swp_ovr ]
> 
> Your "interrupts:" do not allow flexibility. Are you sure interrupts are
> optional in the hardware?

Good point, They are optional. Should I drop the items and descriptions in "interrupts"?

> > +
> > +  dvdd-io33-supply:
> > +    description: 3.3V Digital I/O supply.
> > +
> > +  avdd33-supply:
> > +    description: 3.3V Analog DAC supply.
> 
> Best regards,
> Krzysztof
> 

-- 
Kind regards,

Rodrigo Alencar
