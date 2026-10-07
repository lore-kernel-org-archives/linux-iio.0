Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8244B126A;
	Wed,  7 Oct 2026 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380881; cv=none; b=GK4zgdkwyfYsdJHChoiB87lhSXUleNOCiTASjKQ5fMMhPHfGkTLTsto/0RZExy/kh7vd42DkhTnV6YgP/4/dJFmxX+5sLoc914McH0q4uuPCDZOC3FhTkXKaz0PrhIXLiPXV6vNbrTvYS8wKPCC9DC0zeiVZurVdXAHiwMlwt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380881; c=relaxed/simple;
	bh=zArLKlc/BPYviuyu16AzvuWjXjN7hfU2jtHhHzVZStM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtL11Hi+ZeZuwBTMtOvHdOTRtPGwt6nA6jR4Mo8jw/o6M/kwbPoTWJTu1tyDG0wIxlYL2GNrU7XXdNMcYEJ3bpM+QEHBj+8Gm++GKA0RiNDrm4XIMPh3rm71LQNTgeqKb1PL28rb0uw1woK4TZTWtmSEmiR5QmKpfFWJaq/CjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6HZBQ85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6HZBQ85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA331F0089B;
	Wed,  7 Oct 2026 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791380871;
	bh=EndcDYuYZFPo86frFhMu07n5NOlKZELpWsp9/YTTj4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O6HZBQ85bkZge2ZxJ5Fkhm/XMPYaxwbFiJsHQGs/JekNTNOHejiB5sTbxsdF8AQHA
	 aBFFYFjOeu6gsfYbmsRtgwRSlcE8lVeOn5N4xbvlIH9lVYmPwrzbAdUu3Mie+iG1Rn
	 ZD1EnlEYqSam5RIy51DCFG5p+0Qzjxg2FYB5xg0xRFIiy191eWnIkIPWKD413cqBg/
	 45SLo6ZDABFCsX2ZgW7WhMOWHBFXhsjMjd2ktEGbXWPRHIdjutEaPKs0hyYoTm2zB4
	 D4vobXc8ps3/MEgCAprmWV3iu+KrcKHLWDy44c8VdRMcwyewiEYZbEBmuy/+pI4+v4
	 z+9+d1PugI2Ng==
Date: Wed, 7 Oct 2026 08:47:50 -0500
From: Rob Herring <robh@kernel.org>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
Message-ID: <20261007134750.GC2792240-robh@kernel.org>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>

On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
> Hi Conor,
> 
> Thanks for the review
> 
> On 10/1/26 20:32, Conor Dooley wrote:
> > On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
> > > Add bindings that describes STM32 MDF settings to support
> > > digital filtering for Pulse Density Modulation (PDM) microphones
> > > and analog sigma delta modulators.
> > > 
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > ---
> > >   .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
> > >   1 file changed, 383 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> > > new file mode 100644
> > > index 000000000000..f2fbc3e150e8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> > > @@ -0,0 +1,383 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
> > > +
> > > +maintainers:
> > > +  - Olivier Moysan <olivier.moysan@foss.st.com>
> > > +
> > > +description: |
> > > +  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
> > > +  interface external sigma delta modulators to STM32 micro controllers.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - st,stm32mp25-mdf
> > > +      - st,stm32mp23-mdf
> > > +
> > > +  reg:
> > > +    minItems: 1
> > > +    maxItems: 2
> > 
> > This needs an items list here. The size of the regions seems like crap
> > to begin with...
> > 
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    description: Internal clock used for MDF digital processing.
> > > +    items:
> > > +      - const: ker_ck
> > 
> > This is pointless when you only have one.
> > 
> 
> I agree that it could be dropped. However, it is useful for using
> devm_regmap_init_mmio_clk.

I don't know what that function is/does, but that's not justification 
for bindings. Maybe you need a helper that handles a single clock. Or 
that function could take a NULL string for single clock? 

> 
> > > +
> > > +  "#clock-cells":
> > > +    enum: [0, 1]
> > 
> > Why is this not fixed? Also why are parts of your own device consuming
> > the clocks?
> > 
> > > +
> > > +  clock-output-names:
> > > +    description: |
> > > +      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
> > > +      but can be gated independently to save power.
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    oneOf:
> > > +      - items:
> > > +          - const: cck0
> > > +      - items:
> > > +          - const: cck1
> > > +      - items:
> > > +          - const: cck0
> > > +          - const: cck1
> > > +
> > > +  clock-frequency:
> > > +    description: |
> > > +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
> > > +      The frequency must be a multiple of the "ker_ck" clock frequency.
> > > +    maximum: 25000000
> > 
> > Should not be needed, the consumers request what they need.
> > 
> 
> The CCKx clock frequency depends on the maximum rate supported by the sigma
> delta converters (for instance a digital mic) and the expected decimation
> ratio on the bitstream. Typically this determines the frequency on the SPI
> bus.
> This rate is defined statically and shared by the CCKx clocks. So IMHO, as
> this rate is unique, it can look strange to let the consumer define it.
> Moreover, it seems to me that clock-frequency is already used to configure
> the frequency of a provider in some other bindings.
> For instance: Documentation/devicetree/bindings/clock/silabs,si570.yaml
> So, it's not clear for me, what is the restriction on clock-frequency
> property.
> > > +
> > > +  ranges: true
> > > +
> > > +  clock-ranges: true
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: mdf
> > > +
> > > +  access-controllers:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description: |
> > > +      Phandle to the rifsc device to check access right.
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  st,interleave:
> > > +    description: |
> > > +      List of phandles of interleaved filters. The indexes of interleaved filters must be
> > > +      consecutives starting from 0 (i.e in range [0..N]). The samples from interleaved filters
> > > +      are muxed in a single channel and retrieved through the device associated to the filter 0.
> > > +      The filters 1..N have to be enabled, but inherit their configuration from filter 0.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > 
> > No idea what these even are, but this is probably not the right way to
> > represent the relationship between devices. They're apparently ADCs, but
> > this is also an ADC so I'm not sure what's going on here at all.

I don't under it either, but regardless phandle-array needs constraints 
on the items. It's really a matrix with array of phandle+args arrays.

Rob
