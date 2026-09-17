Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B17369D5E;
	Thu, 17 Sep 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613633; cv=none; b=GjE3ZSAhL3ANsvmzpCSc4C7FJnRLqa9s1urGzpbK5PhaAfsD3Q8/FdsNLLXCsS5x767p2h2aAZipR4yQxvLSy72j41spiJqVzR+Ouihp34/KJ7ByFHmFoVnd3eYf5jV3QlDj4tV2nM+9xR/DpJ94UExOOXsYT5T48YtBx8Gpl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613633; c=relaxed/simple;
	bh=mj+9ZApnWyAqhPIPtqG/CskZDsRzRfpDp2LpPNOO6yA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seiyPxZhsXAow5t4Iyt/zC52kLcO15KH2ld3Kth9WEym0/FIVRCw5ofmEAJOkjZGHV/ed1nfvD8A/+adHyFwXXTNGdVRrPfhsRE45uS/hA2561rl63wcnswtau+XDlT10Cq3Lh9vaubjOSJ7VPDk00yvuJ2vYejsC4n7lOmsh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt5V0ITn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt5V0ITn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862931F000FF;
	Thu, 17 Sep 2026 02:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613627;
	bh=nJW8sToy+Vm9YERDVYBr4q9QXJkQsXqSFm6+U6QtoVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mt5V0ITn63VkHHJr+9WQ82sjjEFBYCEi+d1F4YPSitcCX9l7+5V5Q4nHjhTiuhmW1
	 PBeZW0krzbml5rXbOnZkvaTM28wusnxID8jlCggDZm3ZXL9fB3ZQqyx8E8UFdvz1gG
	 Vgqok6k3KarUcIu0XXwi0wBxLfMnjB/njv77Fd1EHbe5iyANWUSt5WWcHIHa4hlTT2
	 vf3kVqnGlJu5vZHjhQW17APTk7mqyxS9X0wvAWLo1sbXI0kdGjEi/m2QJr0ZrpWHYY
	 MiBUTmVr4eLbiWUgN1OH3b7NSE1pouqJFRxzmLW84SUdIuHVZdyPCLTzUtsWR0EWa9
	 I8VK3h2n3Igkg==
Date: Thu, 17 Sep 2026 03:53:38 +0100
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
Message-ID: <20260917035338.2ef5ded6@jic23-hlaptop>
In-Reply-To: <6e28ede2-686c-4972-8a15-348ae090cec8@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
	<20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
	<20260913040801.30e07d4c@jic23-hlaptop>
	<6e28ede2-686c-4972-8a15-348ae090cec8@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 09:49:01 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 9/13/26 05:08, Jonathan Cameron wrote:
> > On Fri, 11 Sep 2026 17:51:23 +0200
> > Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> >   
> >> Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
> >> these SoCs, split into two blocks:
> >> - ADC12 are tightly coupled (common registers).
> >> - ADC3 is managed independently.
> >> Each ADC is a 12-bits successive approximation analog-to-digital converter,
> >> with up to 20 multiplexed channels that can be configured as single ended
> >> or differential.
> >>
> >> New property "st,adc-trigger-sel " allow to make the difference between
> >> the ADCs and to apply the correct trigger configuration.
> >>
> >> STM32 ADC may be in a power domain: allow a single 'power-domains'.
> >>
> >> Restrict the last channel (19), as it is wired directly to ADC Vref+.
> >> It's meaningless to have direct measurement. Internal Vref with
> >> calibration data from bsec (nvmem) must be used instead e.g. vrefint.
> >> Restrict deprecated properties (st,adc-channels, st,adc-diff-channels,
> >> st,min-sample-time-nsecs).
> >>
> >> Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
> >> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
> >> Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>  
> > 
> > Hi Fabrice, all,
> >   
> >> ---
> >>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 106 ++++++++++++++++++---
> >>  1 file changed, 94 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >> index c4c4575d3fa9..0e0ceaa3d8d6 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >> @@ -23,11 +23,18 @@ maintainers:
> >>  
> >>  properties:
> >>    compatible:
> >> -    enum:
> >> -      - st,stm32f4-adc-core
> >> -      - st,stm32h7-adc-core
> >> -      - st,stm32mp1-adc-core
> >> -      - st,stm32mp13-adc-core
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - st,stm32f4-adc-core
> >> +              - st,stm32h7-adc-core
> >> +              - st,stm32mp1-adc-core
> >> +              - st,stm32mp13-adc-core
> >> +      - items:
> >> +          - enum:
> >> +              - st,stm32mp23-adc-core
> >> +              - st,stm32mp25-adc-core
> >> +          - const: st,stm32-adc-core  
> > 
> > What is this?  Given these all vary in features
> > why would we fallback to a generic match for
> > these new compatibles?  
> 
> Hi Jonathan, all
> 
> Ack, I'll drop it in v2,
> 
> > 
> > 
> >   
> >>  additionalProperties: false
> >>  
> >>  required:
> >> @@ -239,11 +276,18 @@ patternProperties:
> >>  
> >>      properties:
> >>        compatible:
> >> -        enum:
> >> -          - st,stm32f4-adc
> >> -          - st,stm32h7-adc
> >> -          - st,stm32mp1-adc
> >> -          - st,stm32mp13-adc
> >> +        oneOf:
> >> +          - items:
> >> +              - enum:
> >> +                  - st,stm32f4-adc
> >> +                  - st,stm32h7-adc
> >> +                  - st,stm32mp1-adc
> >> +                  - st,stm32mp13-adc
> >> +          - items:
> >> +              - enum:
> >> +                  - st,stm32mp23-adc
> >> +                  - st,stm32mp25-adc
> >> +              - const: st,stm32-adc  
> > 
> > Similar to above, what is this?  
> 
> same,
> 
> > 
> >   
> >> @@ -344,6 +388,12 @@ patternProperties:
> >>          items:
> >>            - const: vrefint
> >>  
> >> +      st,adc-trigger-sel:
> >> +        description: Selects the HW trigger configuration available on this ADC
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        enum: [0, 1]  
> > 
> > Magic value that is meaningless to see in a dts.  If they
> > are effectively not compatible, give them different compatibles and
> > drop this property.  I'm unconvinced this property is more
> > useful than that given just how opaque the description is.  
> 
> That's exactly what I was wondering about. As you suggest, I can remove
> this property, and introduce dedicated compatibles in V2, to clearly
> identify the differences.
> 
> Need to distinguish:
> - ADC12 are tightly coupled (common registers).
> - ADC3 is managed independently.
> Triggers are different between them. The purpose of st,adc-trigger-sel
> was to identify that.
> 
> Also MP23 and MP25 are also different (trigger list). Combining this
> would lead to introduce four compatibles, I'm thinking of:
> - st,stm32mp23-adc12
> - st,stm32mp23-adc3
> - st,stm32mp25-adc12
> - st,stm32mp25-adc3
> 
Naming wise, I wonder if it looks too much like adc twelve?
Not sure how to avoid that cleanly as adc1-2 seems odd too.

> I plan to update it in v2.
> 
> Thanks,
> Fabrice
> 
> > 
> > 
> >   
> 

