Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9433FE36;
	Sun, 17 May 2026 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017303; cv=none; b=D+TQa7NIYrGcKp3LguxFIb5fdeiFfu+HZEAkNsxVhA6X8yrZ3h+9DPtaz9SSVyowYKrkM5azyUFGKrAlC/tE/iRicF9Z24ayKH5KLkRI60ba62c7e9oIvWSvLII3ulbwQ+5SP5hs1qmKjKJtnRqM4wgtizycpY+o+UA65IGsBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017303; c=relaxed/simple;
	bh=KcNvT7BcIl8NisKKlV/eyp/qQCTgEFziF510D13FF4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flHyOQUg7BKZOpBRkJEE/yH+S92KrytJxv+VzB7ernV+n2/EdKDtayIKzy7Z2BWD2RqqFrlWEjP14F4s7VZT7gTEiI9A9A4+G1/dVcojRBfnBv8ECgMOHLl5DypPsuVHIkW5e6g8JpkPDS4Hp0GEObJ6vTdBKLXUrWdnu6CTsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofui2bo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofui2bo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E0C2BCB8;
	Sun, 17 May 2026 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779017303;
	bh=KcNvT7BcIl8NisKKlV/eyp/qQCTgEFziF510D13FF4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ofui2bo7j4q0bK7Dir1kRTuLoBbL1+Vgsjluahla4glSPrpBgveRfISD8tSTaw6p6
	 oiXZzC895nfcpp/huflcZkj2TbodMpOiYcdmRJWkS/EJe6Q1i3r3gu5gBXG6KJllHJ
	 uwUk40mYzrARXpnWNAhrpTtmPQAPIYwfQAJSfUjPyyKGvwor6pizBS8jHtgHNXSRlc
	 Gwk5kauYtaMdPFXgC5dqMSEn1coj1mgsWnH2izZadI9auBeTx7u0Jt6IbszFA8CUcD
	 JrNSsMj/1Mxy4RXV8aljm+IrUtw1ZPXttnZIlCixfCV8tCC0qsXIByb2OnlRuFtQMd
	 BVgiKMbWU5qjA==
Date: Sun, 17 May 2026 12:28:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 01/10] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260517122815.15a64237@jic23-huawei>
In-Reply-To: <ikhp5dsb4ook2cx665p4xbqg5ykmnoytiaybv2cx5khyn3wngn@j752jkewd36b>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-1-d26bfd20ee3d@analog.com>
	<20260512193129.777d62a8@jic23-huawei>
	<vklczsi4vk3sqf53zifslhp5pysdmj3gfyhvdgrwo4bg3wdkxj@lnbftaf5jcbf>
	<20260516114022.58949a06@jic23-huawei>
	<ikhp5dsb4ook2cx665p4xbqg5ykmnoytiaybv2cx5khyn3wngn@j752jkewd36b>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 11:12:14 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/16 11:40AM, Jonathan Cameron wrote:
> > On Wed, 13 May 2026 16:09:24 +0100
> > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> >   
> > > On 26/05/12 07:31PM, Jonathan Cameron wrote:  
> > > > On Fri, 08 May 2026 18:00:17 +0100
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > >     
> > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > 
> > > > > DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> > > > > configurations for clocks, DAC current, reset and basic GPIO control.    
> > > > 
> > > > I think this is getting close enough now that for next version you should
> > > > drop the RFC (which is probably gating DT binding folk giving it
> > > > a detailed review!)
> > > >     
> > > > > 
> > > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>    
> > > >     
> > > > > +
> > > > > +  adi,dac-output-current-microamp:
> > > > > +    minimum: 8640
> > > > > +    maximum: 31590
> > > > > +    default: 20070
> > > > > +    description:
> > > > > +      DAC full-scale output current in microamps.
> > > > > +    
> > > > Can we use generic dac.yaml defined output-range-microamp? The base will be 0 always but
> > > > that shouldn't matter.
> > > >    
> > > 
> > > would that be fine even if we do not have those child channel nodes in the device-tree node? 
> > >   
> > I think I'd rather we generalized to cover the 'one shared value' case rather
> > then went with a vendor specific binding.  
> 
> I can't reference dac.yaml in node level as it forces the nodename to match a pattern:
> 
> 	dds@0 (adi,ad9910): $nodename:0: 'dds@0' does not match '^channel(@[0-9a-f]+)?$'
> 
> Also, I can't reference the property only, because it ends with *-microamp:
> 
> 	  output-range-microamp:
> 	    $ref: /schemas/iio/dac/dac.yaml#/properties/output-range-microamp
> 	    items:
> 	      - const: 0
> 	      - minimum: 8640
> 	        maximum: 31590
> 	        default: 20070
> 
> which gets me:
> 
> 	properties:output-range-microamp: '$ref' should not be valid under {'const': '$ref'}
> 
> so I will adjust it to:
> 
> 	  output-range-microamp:
> 	    description: DAC full-scale output current in microamps.
> 	    items:
> 	      - const: 0
> 	      - minimum: 8640
> 	        maximum: 31590
> 	        default: 20070
> 
> and not reference dac.yaml at all.
> 
That works. Thanks


