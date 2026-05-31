Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B93D3B3;
	Sun, 31 May 2026 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217648; cv=none; b=Afrslq0xf7p8sVMuWCyF7rY9xPq2aKI7Xp/rk5HLsoVDKo1zW62Hqa/hi3DKKsJ7P0c+d3iHCEg6KOi2bzXNian5vN6PopqdgnSlTGbTbJoHNoErDNHLLGJDDC+y6MYr7HASHaiWmCA4cN5MN2ZQRsRimAZwG8WDz++79AgyMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217648; c=relaxed/simple;
	bh=1yr8ncABSbFvzQAXz3ThAhXmcvLGt9Eepc/T2kJPm/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skyHl2TndKajx75DeW2B/D21LJI9+iOsjFN5PQDZ6dI/f0wqMCPJJWHqZCdxlr2BsLbYy7KVu3HA85M4UV3etENiatZYxS9CNPcf8l6Ib8tR94u9Irac/9jP+kfHKM2ZjrIWDQZuCGyfQCkTCN0Ap1ZMmMoC8T6S5448wk/L/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCHsHUi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCHsHUi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38EE1F00893;
	Sun, 31 May 2026 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780217647;
	bh=ZMuqlkLfvnYdsremHEwchyIncR+mKoa1Vob2oVnnRzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WCHsHUi82KtsGkiCVjzY7Mcb096smMCA4tYjQ6n8flevGLSvAKPeUq+B9u40Sk0OL
	 XsaUFAp1Kog/V8X8KUv0WNqWK+KN/QU15KkqhRThaBKoietvi2qWsmc0FvhOMW1hJF
	 QYgvfI5pllL+E1Ckvll+MIYwsmuuqapxW5HJHBP8svt9R3NsUYgt+T5JIsEvMYPtZY
	 NYtYLuK6pXoBEaXH85cceIQgBcWVCQ/bUnJFz+ItIaA0iD3K+1dIMQeRB+YJHMPt28
	 OD6As/sG3LmxKp3GveJasOM2FAnXu1XCOzzGSCCnm3nixk6lIn2Viyf49+W7JlgFsf
	 jhLUurxTk6tAQ==
Date: Sun, 31 May 2026 09:53:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Taha Narimani <tahanarimani3443@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: Add schema for AD7816/7/8
 digital temperature sensor
Message-ID: <20260531095357.29385752@jic23-huawei>
In-Reply-To: <20260531-mama-demanding-edf694ceb099@spud>
References: <20260530133126.54460-1-tahanarimani3443@gmail.com>
	<20260530135302.54688-1-tahanarimani3443@gmail.com>
	<20260530155817.6169e5e2@jic23-huawei>
	<20260531-mama-demanding-edf694ceb099@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 00:11:44 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sat, May 30, 2026 at 03:58:17PM +0100, Jonathan Cameron wrote:
> > On Sat, 30 May 2026 13:53:00 +0000  
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +    description: OTI (Over Temperature Indicator) interrupt.  
> 
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    spi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        adc@0 {
> > > +            compatible = "adi,ad7816";
> > > +            reg = <0>;
> > > +            spi-max-frequency = <1000000>;
> > > +            rdwr-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> > > +            convert-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
> > > +            busy-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
> > > +            interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> > > +            interrupt-parent = <&gpio>;  
> > 
> > You don't have any interrupts in the binding. So this shouldn't
> > pass testing.  
> 
> There is an interrupts property in the binding, unless you meant
> something else?
Huh.  More coffee needed. Odd I missed it!  

J
> 
> >   
> > > +        };
> > > +    };  
> >   

