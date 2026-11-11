Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406178;
	b=UgWn2M4E1ecV8XgxgTXMCud9vT6xoorXRcDeMX+gc5mcthCHTxCD0exk0w4sQwZpCu1c
	 eWbHFqmki1la8o7pfeD+L77ZaxZ5UoJISEs4qk9tegs9laiTdri1cNMf9xK0ZcIaA04pt
	 K9ZFBOO812j3v+FIsx9KGgDjV/8GUPj5z6o7Y2hsDiYNHYwurPefBsRVY97ih3W+UDuJZ
	 H1xa+oj9V86rLvYRrN1RsoIP18ilZBQJQhJ8adrPrbsYaJPpM8oMnrIccQYLc8ST5W4E2
	 ZAVB5LTAt89HdL+1/HtuIOdoPMVVRrMckod+JzFPWp715Qg90gv6lGuyK7Qkv6p0Beg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406178;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=8DesGRSfhXlZCjmGjMokMq6GoKYbaT2UUMGxhxDBCuE=;
	b=WNaQ0vooQdLJ+1JDCir53MQL9cTpmCjvUXDWGf09Wz62ZrL9ew0I8SkBQzQnfESKJmHJ
	 VdFxXkBIuCg+D616wvdz8ruh8xji7wkG+qaJkH1W5EMilNAQdWRgCtMwFNwYXVNy3FGUi
	 seMC5rGNPDRr2bRxskwG9SxVGfKJTH/vYrz700mpncFo7BENRSxLHXEP/uqUvdmMATHak
	 C8rVYpRKmkECoUGDxZfiJGLX78RSr3mk+zQRqzmXdAaHshi2idMDJ+Lqs73p2lINavcD6
	 NsREexGf6o42lAIUd8W6V6bIH9pzuJGUZ+GcD4Xsy2MOZKeMEOZ+msQGKW49GNdFNYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiy3Xgmp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A684606A32A;
	Wed, 11 Nov 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiy3Xgmp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928321F00A05;
	Wed, 11 Nov 2026 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406177;
	bh=8DesGRSfhXlZCjmGjMokMq6GoKYbaT2UUMGxhxDBCuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aiy3XgmpfyjCjuk/rD7loYedjjja3RMhWIcC14Eq50auyX7VqFqYnODkIl3XvNezk
	 j7RgruZpswsyba2r5AzHHx4o/JDTcRw8kevs4FylFyrlH7+bN27GdLyas8cvIWqoay
	 UkcDgQkpW4vBceaJKqChrD7b7pN2cDbYlr1JaQBVIOlJewxerJ8BvJiWexbKOKUZ6u
	 6tKtwzMFJAIjPO8V/4JR+A+6hXR5RqZbL/HxsKRUfUY0DNL8xdxvSByGWBWSVcqHcF
	 xWWnRRnuBj5PpSnYpkqtFgxF1vEfQCWZPQhnWCQr0rKEBngz1GskoGNy8RwnLaOlCs
	 gXvrmKWvswkPg==
Date: Wed, 11 Nov 2026 08:09:35 -0600
From: Rob Herring <robh@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20261111140935.GB1476246-robh@kernel.org>
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
 <20261104091136.151269-2-cwweng.linux@gmail.com>
 <20261110190827.GA1322356-robh@kernel.org>
 <f01f7e4b-8c71-461b-bd1f-28de2594abbc@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f01f7e4b-8c71-461b-bd1f-28de2594abbc@gmail.com>

On Wed, Nov 11, 2026 at 10:15:51AM +0800, Chi-Wen Weng wrote:
> 
> 
> Rob Herring 於 2026/11/11 上午 03:08 寫道:
> > On Wed, Nov 04, 2026 at 05:11:35PM +0800, Chi-Wen Weng wrote:
> > > From: Chi-Wen Weng <cwweng@nuvoton.com>
> > > 
> > > Add a binding for the Enhanced Analog-to-Digital Converter found on
> > > Nuvoton MA35D1 SoCs.
> > > 
> > > The controller has eight external analog inputs. They can be used as
> > > single-ended inputs or as the four fixed differential pairs 0-4, 1-5,
> > > 2-6 and 3-7.
> > > 
> > > Use the common ADC channel properties to describe the physical input
> > > independently of the logical channel index.
> > > 
> > > Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> > > ---
> > >   .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++++++++++++++++
> > >   1 file changed, 163 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> > > new file mode 100644
> > > index 000000000000..85b0feac0236
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> > > @@ -0,0 +1,163 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
> > > +
> > > +maintainers:
> > > +  - Chi-Wen Weng <cwweng@nuvoton.com>
> > > +
> > > +description: |
> > > +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
> > > +  12-bit successive approximation converter with eight external analog
> > > +  inputs and one internally connected VBAT input.
> > > +
> > > +  The external inputs can be used as eight single-ended channels or as
> > > +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
> > > +  connected VBAT input is not described by a channel child node.
> > > +
> > > +  The controller provides four interrupt outputs, ADINT0 through ADINT3.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nuvoton,ma35d1-eadc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: ADINT0
> > > +      - description: ADINT1
> > > +      - description: ADINT2
> > > +      - description: ADINT3
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  vref-supply:
> > > +    description:
> > > +      Optional external reference voltage connected to the VREF pin. If this
> > > +      supply is absent, the controller uses its internal 1.6 V reference.
> > > +
> > > +  dmas:
> > > +    maxItems: 1
> > > +
> > > +  dma-names:
> > > +    const: rx
> > > +
> > > +  '#io-channel-cells':
> > > +    const: 1
> > > +    description:
> > > +      The cell selects the logical EADC channel identified by the reg value
> > > +      of the corresponding channel child node.
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  '^channel@[0-7]$':
> > > +    type: object
> > > +    $ref: /schemas/iio/adc/adc.yaml#
> > > +    description: |
> > > +      External EADC channel description. The reg property identifies the
> > > +      logical IIO channel index.
> > > +
> > > +      A single-ended channel may use single-channel to select an external
> > > +      analog input independently of reg. If single-channel and diff-channels
> > > +      are both absent, the external analog input is selected by reg.
> > > +
> > > +      A differential channel uses diff-channels to select one of the fixed
> > > +      hardware input pairs: 0-4, 1-5, 2-6 or 3-7. Each single-ended input
> > > +      and each differential input pair may be described at most once.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        maximum: 7
> > > +
> > > +      single-channel:
> > > +        maximum: 7
> > > +
> > > +      diff-channels:
> > > +        oneOf:
> > > +          - items:
> > > +              - const: 0
> > > +              - const: 4
> > > +          - items:
> > > +              - const: 1
> > > +              - const: 5
> > > +          - items:
> > > +              - const: 2
> > > +              - const: 6
> > > +          - items:
> > > +              - const: 3
> > > +              - const: 7
> > > +
> > > +    allOf:
> > > +      - not:
> > > +          required:
> > > +            - single-channel
> > > +            - diff-channels
> > > +
> > > +    required:
> > > +      - reg
> > 
> > The allOf and required are effectively covered by adc.yaml already.
> > 
> > Rob
> 
> Hi Rob,
> 
> > The allOf and required are effectively covered by adc.yaml already.
> 
> The channel-level required list is redundant; I'll remove it.
> 
> For the allOf, adc.yaml currently has:
> 
> anyOf:
>   - oneOf:
>       - required:
>           - reg
>           - diff-channels
>       - required:
>           - reg
>           - single-channel
>   - required:
>       - reg
> 
> When both single-channel and diff-channels are present, the inner
> oneOf fails, but the reg-only branch still satisfies the outer anyOf.
> Removing the local constraint would therefore allow both properties
> together, which the driver rejects.

Oh, right.

> 
> Should I keep the local check, or move the mutual-exclusion constraint
> into adc.yaml?

I think what you have here should replace what's in adc.yaml.

Rob
