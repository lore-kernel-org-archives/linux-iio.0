Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA2235BE2;
	Mon, 21 Sep 2026 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956356; cv=none; b=fXehjt4UoRAun7CiS/t8VrnPdpLmx07w1hwMKRdlodR/O7P9w9JjrcFSXfag+RYqgbUJy7XRlT1VucE7Ve3Deypzmej4BPBAVtasvv1N0StSc2zxxRmhyed+xT8lHAXJulBo1IXxs8ioZJE6Qz/oGMHUhTt9esu7nR3q0w/vrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956356; c=relaxed/simple;
	bh=55LU5E5arv0NuHchabANuHElzHfLTFJEby021ctAXRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQdYO/2qQrh5D+gmBUemCCpuRvbazO6TKEntSJcQfO26wwDIN+79O2W/du35cjd1wZaPK1MtR1Ee+JjjghSRQykOgmL6YfZU8jG4x68C1Z1d+mSwmSba1AsqFgYqKMpurQvTkvcP5OqryD3LPZM7mkF82cI0HedHtTTAJ+VymOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLGXGx/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLGXGx/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF591F000FF;
	Mon, 21 Sep 2026 02:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956354;
	bh=uikkSmrumHAqGpsS77IAH7yKBMssXnftH2z/L0nZR7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nLGXGx/9rS7szEc3KLwMSNkACxLS7aBM6MZ2WuBpUCNbb10PeIQyJNh+f255zDV4B
	 81x0Wp1ESuGMCcArEtxuxgxQ+AIEqHX+1t9xacnYxV19VCpqlX5lKztXK++pwxNAh4
	 IubwkaPXp5URZ+l/0RKAGyDk4MqF45h/9dlPSgeC/LW3aD5b3bdNrMt82us3l7odaD
	 MCajDY46F4fcDFFMrqwSzVBYxJrwZz0Vs0p85f39r2NZLKu5tlqcZEgep3pnPm4hCG
	 /tfytr6E9VNyJ1N17tqr2/ZZ54JX/cBg6fhNigRFYBW6GsS4DIV9VhT0G8uq68aarp
	 bNqAsBfFSub5Q==
Date: Mon, 21 Sep 2026 03:05:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Cheick Traore <cheick.traore-ext@st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
Message-ID: <20260921030546.73800535@jic23-hlaptop>
In-Reply-To: <f1f9db42-f022-45da-a6fa-132d54d07716@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
	<20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
	<20260913040801.30e07d4c@jic23-hlaptop>
	<6e28ede2-686c-4972-8a15-348ae090cec8@foss.st.com>
	<20260917035338.2ef5ded6@jic23-hlaptop>
	<f1f9db42-f022-45da-a6fa-132d54d07716@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 09:27:10 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 9/17/26 04:53, Jonathan Cameron wrote:
> > On Tue, 15 Sep 2026 09:49:01 +0200
> > Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> >   
> >> On 9/13/26 05:08, Jonathan Cameron wrote:  
> >>> On Fri, 11 Sep 2026 17:51:23 +0200
> >>> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> >>>     
> >>>> Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
> >>>> these SoCs, split into two blocks:
> >>>> - ADC12 are tightly coupled (common registers).
> >>>> - ADC3 is managed independently.
> >>>> Each ADC is a 12-bits successive approximation analog-to-digital converter,
> >>>> with up to 20 multiplexed channels that can be configured as single ended
> >>>> or differential.
> >>>>
> >>>> New property "st,adc-trigger-sel " allow to make the difference between
> >>>> the ADCs and to apply the correct trigger configuration.
> >>>>
> >>>> STM32 ADC may be in a power domain: allow a single 'power-domains'.
> >>>>
> >>>> Restrict the last channel (19), as it is wired directly to ADC Vref+.
> >>>> It's meaningless to have direct measurement. Internal Vref with
> >>>> calibration data from bsec (nvmem) must be used instead e.g. vrefint.
> >>>> Restrict deprecated properties (st,adc-channels, st,adc-diff-channels,
> >>>> st,min-sample-time-nsecs).
> >>>>
> >>>> Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
> >>>> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
> >>>> Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>    
> >>>
> >>> Hi Fabrice, all,
> >>>     
> >>>> ---
> >>>>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 106 ++++++++++++++++++---
> >>>>  1 file changed, 94 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >>>> index c4c4575d3fa9..0e0ceaa3d8d6 100644
> >>>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >>>> @@ -23,11 +23,18 @@ maintainers:
> >>>>  
> >>>>  properties:
> >>>>    compatible:
> >>>> -    enum:
> >>>> -      - st,stm32f4-adc-core
> >>>> -      - st,stm32h7-adc-core
> >>>> -      - st,stm32mp1-adc-core
> >>>> -      - st,stm32mp13-adc-core
> >>>> +    oneOf:
> >>>> +      - items:
> >>>> +          - enum:
> >>>> +              - st,stm32f4-adc-core
> >>>> +              - st,stm32h7-adc-core
> >>>> +              - st,stm32mp1-adc-core
> >>>> +              - st,stm32mp13-adc-core
> >>>> +      - items:
> >>>> +          - enum:
> >>>> +              - st,stm32mp23-adc-core
> >>>> +              - st,stm32mp25-adc-core
> >>>> +          - const: st,stm32-adc-core    
> >>>
> >>> What is this?  Given these all vary in features
> >>> why would we fallback to a generic match for
> >>> these new compatibles?    
> >>
> >> Hi Jonathan, all
> >>
> >> Ack, I'll drop it in v2,
> >>  
> >>>
> >>>
> >>>     
> >>>>  additionalProperties: false
> >>>>  
> >>>>  required:
> >>>> @@ -239,11 +276,18 @@ patternProperties:
> >>>>  
> >>>>      properties:
> >>>>        compatible:
> >>>> -        enum:
> >>>> -          - st,stm32f4-adc
> >>>> -          - st,stm32h7-adc
> >>>> -          - st,stm32mp1-adc
> >>>> -          - st,stm32mp13-adc
> >>>> +        oneOf:
> >>>> +          - items:
> >>>> +              - enum:
> >>>> +                  - st,stm32f4-adc
> >>>> +                  - st,stm32h7-adc
> >>>> +                  - st,stm32mp1-adc
> >>>> +                  - st,stm32mp13-adc
> >>>> +          - items:
> >>>> +              - enum:
> >>>> +                  - st,stm32mp23-adc
> >>>> +                  - st,stm32mp25-adc
> >>>> +              - const: st,stm32-adc    
> >>>
> >>> Similar to above, what is this?    
> >>
> >> same,
> >>  
> >>>
> >>>     
> >>>> @@ -344,6 +388,12 @@ patternProperties:
> >>>>          items:
> >>>>            - const: vrefint
> >>>>  
> >>>> +      st,adc-trigger-sel:
> >>>> +        description: Selects the HW trigger configuration available on this ADC
> >>>> +        $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +        enum: [0, 1]    
> >>>
> >>> Magic value that is meaningless to see in a dts.  If they
> >>> are effectively not compatible, give them different compatibles and
> >>> drop this property.  I'm unconvinced this property is more
> >>> useful than that given just how opaque the description is.    
> >>
> >> That's exactly what I was wondering about. As you suggest, I can remove
> >> this property, and introduce dedicated compatibles in V2, to clearly
> >> identify the differences.
> >>
> >> Need to distinguish:
> >> - ADC12 are tightly coupled (common registers).
> >> - ADC3 is managed independently.
> >> Triggers are different between them. The purpose of st,adc-trigger-sel
> >> was to identify that.
> >>
> >> Also MP23 and MP25 are also different (trigger list). Combining this
> >> would lead to introduce four compatibles, I'm thinking of:
> >> - st,stm32mp23-adc12
> >> - st,stm32mp23-adc3
> >> - st,stm32mp25-adc12
> >> - st,stm32mp25-adc3
> >>  
> > Naming wise, I wonder if it looks too much like adc twelve?
> > Not sure how to avoid that cleanly as adc1-2 seems odd too.  
> 
> Hi Jonathan,
> 
> Indeed, so could introduce one compatible per Soc/ADC ?
> 
> +          - st,stm32mp23-adc1
> +          - st,stm32mp23-adc2
> +          - st,stm32mp23-adc3
> +          - st,stm32mp25-adc1
> +          - st,stm32mp25-adc2
> +          - st,stm32mp25-adc3
> 
> There are some other differences between adc1 and adc2, e.g. in the
> reference manual:
> - ADC1 is connected to 18 external channels + 2 internal channels
> - ADC2 is connected to 14 external channels + 6 internal channels
> - ADC3 is connected to 14 external channels + 6 internal channels
> 
> This is resolved currently by channels child nodes with labels for
> internal channels. So maybe better to name all of them (future proof) ?
Yes. Ideally the binding would be constraining the channel nodes
and we'd need the compatible to do that.

Seems like we have a winner - separate compatibles :)

Jonathan

> 
> Please advise,
> Best Regards,
> Fabrice
> 
> >   
> >> I plan to update it in v2.
> >>
> >> Thanks,
> >> Fabrice
> >>  
> >>>
> >>>
> >>>     
> >>  
> >   
> 
> 

