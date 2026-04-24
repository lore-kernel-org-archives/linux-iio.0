Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971D33E34C;
	Fri, 24 Apr 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050288; cv=none; b=QRrv+9RJzmUXgbWhFVXvic66GFHljD/6wHeTfE74lksfEI1F3w5Pr0jrNQ3e1IwTtRrBbG4NYGa8pgFL5tIelef1TZe4iRnxjzjhEmQY0roWbu6I0Dg8+WJHuzgrh2En5TTJk5e5VtTpPvh3JNms4p9AC5wFtLuMc8r40tljjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050288; c=relaxed/simple;
	bh=fjDu/mnC+1ECscvmaAHzDugmAtICITz9ijc9sTxrptU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLtIS4+Atx/4svnBOetNHs9q4XFC3f24dzmuSMJ9jbgSu6712H0TdOCp40CIqHtyW6BcS22lT4dL4NH31YNi4BfR5k2dfz8smPCtgx8PBqhmXiPmDmvflXFx0bepqhiVDcNEF0HLaMTcDptAiZjou1HNNc08FvZ88VoVVJCbqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlUMvdU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlUMvdU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5C7C2BCB2;
	Fri, 24 Apr 2026 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050287;
	bh=fjDu/mnC+1ECscvmaAHzDugmAtICITz9ijc9sTxrptU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BlUMvdU0LWN/zizjRxBsqPek5wICbHxttHFypwL1gPQUAHSK/BVyqIJiI8ORZi/1n
	 KcGCThTbrcPYZ5ucD06T6X4i0KBHb0bvpoNbefhGqehu4u4uqyR8knaNqnDmUj9eck
	 c/s5CiCQbqItjqxyABtBc6mRa/898xgV7yd+3+fbCevWOsN2fvISSUKtkogIQFHpKV
	 nwGBBYVHMmJu0E4sd1usu3xJtFwfyvivZkK2anoWVgyDEW2uLT6tyZn039u4yTBh/o
	 Q+mieUDgW0Z8QJSwqQnLhqMuuxOMUK7cr8/3o0ruxNG2mcPWRmJ60PFSkxCKDFe38Z
	 PeQuOUhP0iXIA==
Date: Fri, 24 Apr 2026 18:04:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/22] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <20260424180436.674fc09e@jic23-huawei>
In-Reply-To: <g5a3zky54agp5juxbpn4yy6abhugazgzbyfau5va6r5bmrebxz@o4c5kf6ki24h>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-3-ed7dca001d1b@analog.com>
	<20260423184723.54ddbd67@jic23-huawei>
	<g5a3zky54agp5juxbpn4yy6abhugazgzbyfau5va6r5bmrebxz@o4c5kf6ki24h>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 08:44:21 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/04/23 06:47PM, Jonathan Cameron wrote:
> > On Wed, 22 Apr 2026 15:45:37 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> > > property is deprecated.  
> > 
> > Please provide some information on why? Was it always just wrong and that
> > naming was never used for any of the supported parts?  
> 
> yes, vcc does not exist, none of the devices describe any power input with
> that name. The name is also misleading as it sounds like the input power
> supply. It is being used as an external voltage reference, which is called
> vref. Will add some of that to the commit message.
> 
> vdd should be required, but that would break the dt-binding ABI.

If it's required to correct operation I'm not bothered about breaking that
backwards compatibility (as long as the driver keeps working with older
dts).  We just need to state that clearly in the patch description.

> Also, vref
> should be required for parts that does not have an internal voltage reference
> (the one with no 'R' in the end of the device name), but that would break
> the ABI too.

Likewise.

>  
> > > Certain devices require vref-supply to be
> > > available once an internal reference voltage is absent. Still, this patch
> > > does not add those as 'required' so that the ABI is not broken.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  .../devicetree/bindings/iio/dac/adi,ad5696.yaml     | 21 ++++++++++++++++++---
> > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > > index f286e5072abc..21b80fe597d1 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > > @@ -38,9 +38,22 @@ properties:
> > >    reg:
> > >      maxItems: 1
> > >  
> > > +  vdd-supply:
> > > +    description: Input power supply.
> > > +
> > > +  vlogic-supply:
> > > +    description:
> > > +      Digital power supply. If not supplied, it is assumed to be the same as
> > > +      vdd-supply. VLOGIC may be hardwired to VDD in some board designs or
> > > +      internally connected in small packages.
> > > +
> > > +  vref-supply:
> > > +    description:
> > > +      Reference voltage supply. If not supplied the internal reference is used.
> > > +
> > >    vcc-supply:
> > > -    description: |
> > > -      The regulator supply for DAC reference voltage.
> > > +    deprecated: true
> > > +    description: Use vref-supply instead.
> > >  
> > >    reset-gpios:
> > >      description: Active-low RESET pin to reset the device.
> > > @@ -88,7 +101,9 @@ examples:
> > >        ad5696: dac@0 {
> > >          compatible = "adi,ad5696";
> > >          reg = <0>;
> > > -        vcc-supply = <&dac_vref>;
> > > +        vdd-supply = <&dac_vdd>;
> > > +        vlogic-supply = <&dac_vlogic>;
> > > +        vref-supply = <&dac_vref>;
> > >          ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> > >        };
> > >      };
> > >   
> >   
> 

