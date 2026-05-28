Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78333ACA65;
	Thu, 28 May 2026 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960050; cv=none; b=AxIAN9CoSmHI5IUGFKKYrwJiKqLPnz0V3eXSFQ9Ve65Rjqqic+NFUEIqilGHEuVWpTj01Cq2uCYmGOnO0rhdU9ZDEeToFhh9ZhAAPc1HQpRcdGIsFqzoKl/XTy4QCmNvKPHNgc128reqDLIr9cJ7CPc34R3VbrM4s2Ozl07YOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960050; c=relaxed/simple;
	bh=S9VJxhPYHS2OZ9gn5S8iwI0JSzVdLtsnoZulqXMRRv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0jZG68k9257WVSG2cCNVs/BPFLGB4Me5i6HYnD9Rp+SC5NXlFjOGku8umDyVBAEVLepZqbtuonEpyMy6vlYrpwq3ZzNJLIE65rhHz48FpATonS09W5UJ70vgPhCi/MiJdIPmLuKZ8Ic59hvAwoXA2iScCeJZfynbn9LuUdoXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHMa1GKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHMa1GKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7001F000E9;
	Thu, 28 May 2026 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960049;
	bh=Z7KAwZZAJhZtKzXaCCO25+o/tdhyNQUizD1vsw7HVAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fHMa1GKgJEMPvnD+F81GppZwBFXbouiOAa2LjDVlpYg3ZXDvliqKxVl4vAFQIiW3w
	 g/qkUqHna0cp11dJMK/FZM/N9DJdT7YyR3DZenv9jarg1sgsaFpewCljU/qF3KsTWV
	 a/Th/beKx6gZ0scg9hupueVAXki/ZapDamHtQACnDNap7KWVbGnEbLoj+ORT7nMxJl
	 0mNg3h/pxcJ+rrOz7dAqjWfAVFUBMbvYb3RWMZ6dywpa51/csFPi7RVyCfwkNQfhAU
	 GKOBOh89EMmrSKMGvvQUutiVTCnVsKk+7JuzEkyrRxP+DoE6SRE7Z6jv5Hdy1sN+pe
	 jUpzwNkvjCTlg==
Date: Thu, 28 May 2026 10:20:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add Axiado AX3000/AX3005
 SARADC
Message-ID: <20260528102034.58fc2486@jic23-huawei>
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-1-345dd5f6608a@axiado.com>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
	<20260528-axiado-ax3000-ax3005-saradc-v1-1-345dd5f6608a@axiado.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 01:10:23 -0700
Petar Stepanovic <pstepanovic@axiado.com> wrote:

> The Axiado AX3000 and AX3005 SoCs include a 10-bit SAR ADC controller.
> AX3000 supports 16 input channels, while AX3005 supports 8 input
> channels.
> 
> Document the compatible strings, register region, clock, reference
> voltage supply, and IIO channel cells.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
Hi Petar,

One minor thing inline. Otherwise looks good to me.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/axiado,ax3000-saradc.yaml     | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
> new file mode 100644
> index 000000000000..54592353a7b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/axiado,ax3000-saradc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Axiado AX3000/AX3005 Successive Approximation Register ADC
> +
> +description:
> +  The Axiado AX3000/AX3005 SAR ADC is a 10-bit ADC with sixteen input
> +  channels on AX3000 and eight input channels on AX3005.
> +
> +maintainers:
> +  - Petar Stepanovic <pstepanovic@axiado.com>
> +  - Akhila Kavi <akavi@axiado.com>
> +  - Prasad Bolisetty <pbolisetty@axiado.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - axiado,ax3000-saradc
> +      - axiado,ax3005-saradc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  vref-supply:
> +    description: Reference voltage regulator supplying the ADC
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#io-channel-cells'
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      saradc@806a0000 {

Generic names for nodes in DT. So just adc@806a0000

> +        compatible = "axiado,ax3000-saradc";
> +        reg = <0x0 0x806a0000 0x0 0x400>;
> +        clocks = <&pclk>;
> +        vref-supply = <&vref_reg>;
> +        #io-channel-cells = <1>;
> +      };
> +    };
> 

