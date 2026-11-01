Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793492383;
	b=1EkGF2Q6pdx66kOx3EzbQ094uwBv3bGqRoxkE/mbJ0tFEkA6maxKIuwP21tQt7sqAuDp
	 viYwcIF+jXOL5K/8uFrRPI26kz6hOjqjQoncxHK9MZkqKOZko2pzc8lGc1zqHFijMnsG8
	 xvzOHL9wa+6RTAlNq6i9lzAVNJpX2GMMuZpO1WXRYaRLTYF63mOICnuBkJ4KjaTS/x7CP
	 zFo+rZnL8JZY+s+rOqs+nDnkO7xJzF17wKM80M+pTEI2oJXjNlivsJLvqSJYppnGBIAMd
	 nK/kGA/Nc/IOEGVXcu4QgJ/DdX9dt/YPOkDUvOsXmgHYAR1esoC71YwGjm/c0UEX8lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793492383;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Znj4jYqdJ9TOsG6jdqegXoGfsLpk9Em2KLPQH94MS8c=;
	b=4KvFjbCgqDupgRfxvM2tQn+PprLIz++8U1rIZgm8FNaZ0gePC94RUIg06tW7KDcjb/j9
	 6Pz9f5v2xHiLizzotypzUyk2bAmro/hjKlYCb42p6qh6ls0ZxUjNTS8guZryouC5iJwMj
	 cIQNZboeFQTQJQ8YskCnhklDHfi1vJzrR33xtRZYDBmEl+svxJITUX3Z/KLbuOAdqYugJ
	 uNGhAMifsty3hMKEcz69+O/9m69BGkL1orN0nVVyt72jCNzMzuuqt2EK7MaIt5id3i8k6
	 miXAekU5K/tyA5CzK3PbrN8LVRV32YOW87+FAkiRckvMfG9UTwTKR5c5KdOQUvduLPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sujhbtek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEA606A31A;
	Sun,  1 Nov 2026 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sujhbtek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870E1F000C1;
	Sun,  1 Nov 2026 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793492382;
	bh=Znj4jYqdJ9TOsG6jdqegXoGfsLpk9Em2KLPQH94MS8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SujhbteklN8J8n7KtZn+OdZ+vm3vIdeK1fl4/KNetrtd4nXnYsp1e/jeSHLyHWvHF
	 8iq1xQraBiRTSJFWRFsY4ZcKjnWYonENVURBHz96FfmWgOkgS2M5Pxdf8c+53U/wab
	 k2omhJwJd5Op1q5F0wI43bdSJX1mQ6IlJ7XaX/JemCtaREyauLRN8GS8M3A26ERbPn
	 MVDqIJo5z/r/u2dZVKoTLJIcO3bo/Y1yi6Y0x7dX1+y1l7RTkoNHglVCJaBMspn7D8
	 QUSye+dI7XoGO+evQCcOM+V65BuWI+2Q85mrwru6HrLtaNUnxYg8aUuDEYAaxn68bQ
	 RsGnS3lJjEYIA==
Date: Sun, 1 Nov 2026 00:19:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20261101001934.23588aa2@jic23-hlaptop>
In-Reply-To: <20261030031501.130290-2-cwweng.linux@gmail.com>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
	<20261030031501.130290-2-cwweng.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 11:15:00 +0800
Chi-Wen Weng <cwweng.linux@gmail.com> wrote:

> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add a devicetree binding for the Enhanced Analog-to-Digital Converter
> (EADC) found on Nuvoton MA35D1 SoCs.
> 
> The controller provides eight external analog inputs which can be used
> as single-ended channels or as four fixed differential pairs: 0-4,
> 1-5, 2-6 and 3-7.
> 
> Describe the four hardware interrupt outputs, ADINT0 through ADINT3.
> ADINT0 through ADINT2 are associated with the corresponding conversion
> interrupt flags, while ADINT3 is shared by the ADIF3 conversion
> interrupt and the ADCMPF0 through ADCMPF3 result-compare interrupt
> sources.
> 
> Also describe the functional clock, optional reset, optional external
> reference supply and optional DMA request.
> 
> Expose the controller as an IIO channel provider through the
> DT #io-channel-cells property. The cell identifies the logical EADC
> channel selected by the reg value of the corresponding channel child
> node.
> 
> Restrict the channel binding to features supported by the MA35D1 EADC
> hardware and use the common single-channel representation for
> single-ended inputs.
This description seems a little verbose.  Maybe only talk about the
stuff we can't tell from the patch. 

1. Why it needs a new binding and isn't similar enough to existing
   ones for reuse.
2. Any unusual aspects.  Calling out the stuff that I note below on
   the per channel binding oddity more clearly would have been helpful.

For the other stuff the reader can just look at the patch,

Thanks,

Jonathan

> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> new file mode 100644
> index 000000000000..97144a8eeb5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
> +
> +maintainers:
> +  - Chi-Wen Weng <cwweng@nuvoton.com>
> +
> +description: |

I think you only want to keep paragraphs. In which case > rather than |

> +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
> +  12-bit successive approximation converter with eight external analog
> +  inputs and one internally connected VBAT input.
> +
> +  The external inputs can be used as eight single-ended channels or as
> +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
> +  connected VBAT input is not described by a channel child node.

How would you have a consumer of VBAT given the io-channel-cells
comment about using the channel reg values for xlate?


> +
> +  The controller provides four interrupt outputs, ADINT0 through ADINT3.
> +  ADINT0, ADINT1 and ADINT2 are generated by the corresponding ADIF0,
> +  ADIF1 and ADIF2 conversion interrupt flags. ADINT3 is shared by the
> +  ADIF3 conversion interrupt flag and the ADCMPF0 through ADCMPF3 result
> +  compare flags.

> +
> +patternProperties:
> +  '^channel@[0-7]$':
> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      External EADC channel description.
> +
> +      For a single-ended channel, single-channel specifies the external
> +      analog input number (0 through 7), while reg provides the logical IIO
> +      channel index.
> +
> +      For a differential channel, omit single-channel. The reg value selects
> +      one of the four fixed hardware differential pairs: reg 0 selects 0-4,
> +      reg 1 selects 1-5, reg 2 selects 2-6 and reg 3 selects 3-7.

Sorry, I wasn't paying attention on earlier versions.  This is a very
unintuitive binding particularly as we may want to have a single channel
before a differential one.  Better I think to use the differential
channel bindings and restrict which ones are allowed to this fixed set.


> +
> +    properties:
> +      reg:
> +        maximum: 7
> +
> +      single-channel:
> +        maximum: 7
> +
> +      # Differential pairs are fixed in hardware and are selected by reg.
> +      diff-channels: false
> +
> +      bipolar: false
> +
> +      common-mode-channel: false
> +
> +      settling-time-us: false
> +
> +      oversampling-ratio: false
> +
> +    allOf:
> +      - if:
> +          not:
> +            required:
> +              - single-channel
> +        then:
> +          properties:
> +            reg:
> +              maximum: 3
> +
> +    required:
> +      - reg
> +

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        adc@40430000 {
> +            compatible = "nuvoton,ma35d1-eadc";
> +            reg = <0x0 0x40430000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "adint0", "adint1", "adint2", "adint3";
> +            clocks = <&clk EADC_GATE>;
> +            resets = <&reset MA35D1_RESET_EADC0>;
> +
> +            #io-channel-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                single-channel = <0>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;

This looked very odd and is why I had a closer read of the docs
above.  To make this a reasonable binding to read this
needs to do the full differential channel binding from adc.yaml
with reg just being an index and not specifying channels at all
(same as for the single channel case).

> +            };
> +        };
> +    };
> +
> +...

