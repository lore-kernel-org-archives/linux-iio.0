Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4243C4545;
	Thu, 21 May 2026 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363605; cv=none; b=nfe9vkPZzKFNdzIko/nLN3Uuh1AjNp2+YjG/QgOgxYHVTnoa26RKBNfRgFX0cmHApoTnBn1T/QW2oClVL2RolpmLfPsVw42Tv4yyB5fXwoc6HYvZaKF9mMKOvCr04ipRkCkBf7MgwnOJovvXVGXDX6fRglYKPyvJ4Cordhtkr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363605; c=relaxed/simple;
	bh=IDiYw0djEK/au5igOTCDUfr/k1Ua7CjJcp1MFpCuZ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ds5nhntuCZ49yP9lvDdiy/xZcxwtAy6VPqkki2mo+A/QFHzUrWAy2kMetiN5WYIiIUSjQ+EPQBnZHxc5GeMCaUg8B2bm+aebha1vzlcWWtfEwRICsgJUiQ3uWQZlTHCHsAWvxlR/VAwGoGxEXH8+s30E8upa8icydJQWfNNUJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awCqnuAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awCqnuAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C81F000E9;
	Thu, 21 May 2026 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363599;
	bh=CeOYrPTVePFZr3xZzwGmFzYkKR7fNxWsu1Wf5EAwa/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=awCqnuAlSwWS4bKxbduEZPHz9kAt1Z+O8Txb+ZgRkUjSVUH34bnh0U7AQysWN08qP
	 E0jhO8yS1ejBxC++aAZOu2p+V6eRPkn/i7GsIPq6Zp0veo4kTjeQzR3LI2Bq5AA4YW
	 Eq9eLMbenhhM9R2qmppefxyKcYYdwMtJ+kRJK0xrL3jn1EMrgMkGsnk42TSoiX4nrO
	 1rt42sXysZmzwCXL0ay/IAQ4unJXDfulyXFdFjMPbRft0OGFg+lVk8rG3eZeeAoABP
	 DKKRUDB4X8BFiBYCxUyclN04nZA6moac3frkyM/0sBAmcOzwG48GsYlg/JRLuJtnau
	 s/HkVokqob/HQ==
Date: Thu, 21 May 2026 12:39:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Message-ID: <20260521123949.20e3c0a8@jic23-huawei>
In-Reply-To: <20260521-growing-brunt-4e5a9f955a4f@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
	<20260518081852.116909-2-xingyu.wu@starfivetech.com>
	<20260518-elderly-barman-2b1abfc3755c@spud>
	<NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
	<20260519-undoing-ambitious-012d608ebd7f@spud>
	<NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
	<20260520-relic-chloride-c5cdb96696ce@spud>
	<NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
	<20260521-growing-brunt-4e5a9f955a4f@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 11:20:52 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, May 21, 2026 at 09:54:27AM +0000, Xingyu Wu wrote:
> > On 2026/5/20 23:15, Conor Dooley wrote:  
> > > 
> > > On Wed, May 20, 2026 at 09:43:02AM +0000, Xingyu Wu wrote:  
> > > > On 2026/5/19 18:00, Conor Dooley wrote:  
> > > > >
> > > > > On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:  
> > > > > > On 2026/5/19 00:24, Conor Dooley wrote:  
> > > > > > >
> > > > > > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:  
> > > > > > > > Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
> > > > > > > >
> > > > > > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > > ---
> > > > > > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++++++
> > > > > > > >  1 file changed, 62 insertions(+)  create mode 100644
> > > > > > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sara
> > > > > > > > dc.y
> > > > > > > > aml
> > > > > > > >
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > > > > radc
> > > > > > > > .yam
> > > > > > > > l
> > > > > > > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > > > > radc
> > > > > > > > .yam
> > > > > > > > l
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..ba8e19b72ad7
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb10
> > > > > > > > +++ 0-sa
> > > > > > > > +++ radc
> > > > > > > > +++ .yaml
> > > > > > > > @@ -0,0 +1,62 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML
> > > > > > > > +1.2
> > > > > > > > +---
> > > > > > > > +$id:
> > > > > > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.
> > > > > > > > +yaml
> > > > > > > > +#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Successive Approximation Register (SAR) A/D converter
> > > > > > > > +for the StarFive JHB100 SoC
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    const: starfive,jhb100-saradc
> > > > > > > > +
> > > > > > > > +  reg:
> > > > > > > > +    maxItem: 1
> > > > > > > > +
> > > > > > > > +  interrupts:
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  clocks:
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  resets:
> > > > > > > > +    maxItems: 2
> > > > > > > > +
> > > > > > > > +  "#io-channel-cells":
> > > > > > > > +    const: 1
> > > > > > > > +
> > > > > > > > +  upper-bound-mv:
> > > > > > > > +    description: The upper bound voltage value of the monitor.
> > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > +
> > > > > > > > +  lower-bound-mv:
> > > > > > > > +    description: The lower bound voltage value of the monitor.
> > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > +
> > > > > > > > +  scan-freq:
> > > > > > > > +    description: Number of the scan cycle interval.
> > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16  
> > > > > > >
> > > > > > > Can you explain why any of these three properties are something
> > > > > > > that should be in the devicetree rather than software controlled?  
> > > > > >
> > > > > > My intention is to be able to obtain the initial values from the
> > > > > > devicetree during  
> > > > > probe and preset them.  
> > > > > > Do I need to drop them and just set them through sysfs?  
> > > > >
> > > > > Unless the hardware configuration determines the values (which I
> > > > > can't really see being the case for scan-freq at least) then yes,
> > > > > you need to drop and set them via sysfs.  
> > > >
> > > > The ADC hardware can be set the scan-freq register to determine how frequent it  
> > > should scan its inputs.  
> > > > The calculation is:
> > > > 	frequency = 100/((register value) + 5) MHz, The register value should >= 15.
> > > > The maximum allowable scan frequency is 5MHz.
> > > >  
> > > > >  
> > > > > > > How are the bounds calculated?  
> > > > > >
> > > > > > The measurement range of this ADC hardware is from 0 to 1800 mV.
> > > > > > This set  
> > > > > value cannot exceed it. This explanation will be added later.
> > > > >
> > > > > I'm asking how this is calculated so that I can tell if you the
> > > > > property is permitted or not.  
> > > >
> > > > The calculation of bound is:
> > > > bound-mv = 1800mv * (register value) / 0xFFF  
> > > 
> > > These are the formulas, but how does someone know what the value for bound-
> > > mv needs to be? Why would someone not just want to always use 1800mv?
> > >   
> > 
> > Can I add the 'maximum' and ' minimum' to provide clarification? And the driver will also check.  
> 
> All that does is repeat the 1800 mV though, what I am interested in is
> how someone determines if they should use 1600 mV or 200 mV etc. What
> aspect of the hardware do the bounds depend on?

There are two options here 
1. This is critical stuff to avoid hardware damage. (If you are relying on
   Linux for that you built your system wrong but if we ignore that...)
   Then userspace control should not be possible - or at least should
   only be able to move boundaries in directions that make them tighter.
2. It is advisory only and not related to hardware damage - in that case
   generally doesn't belong in DT.

Jonathan


