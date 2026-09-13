Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5033C188;
	Sun, 13 Sep 2026 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268885; cv=none; b=pMFwXOkOI7IFjmRz/Amm+tdF20B+vuj05CF5aHasCtfPcf0N4zmKLuMDAy1PJdvot2+ZHARMy7pcLgNDUGdImj9QRZRaIbvEz8fAXjnd3xPY/BMC3DU0Vq2e0BAhl4d8Qt3rHsBbmJmaNtmb5uFYtU6/qNKT9+Ys/JubwLHwsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268885; c=relaxed/simple;
	bh=3DpC5fAqPzgDVYnJ4QOP27eZciLZfkNkbE4TdtLp4gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTVnBfIzHgQMRcmBYCqnU4SdYb7aG5WYs+5w7mDgLQuyXFU8gmC0lksYJT/aOOHOO/xU/1J8FUcDm2twCgxsmQHMWQEdUwqbhL518MWVUX9FKaf/giyWdSdKT3Pl4C2x2wsyAPSt/Y5FKZ3qeP5pIvH5uIgIfcgIKQv+fw7rmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oaa4gO4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oaa4gO4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B21F1F000FF;
	Sun, 13 Sep 2026 03:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789268883;
	bh=QfRWUQCp+Q9jZWQdZZIZ+ZqK7VdJimPtv9TXeKqBn7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Oaa4gO4FbG6dwppp2A3ab7SdRzilnBk/R0hmIGU3lxFZDENPF7krAMbXN5L2HPocy
	 lKMxoA28NRQl7opHvLcrEGjHfeOajKSzxEkd2gC6kbnMWnNjxVJ7aVy3dco9+5Sbr+
	 NkH10R8HZGA+spTvcc7HfPglHmNy5rnVRss4nnrMV0uHjeW/kU5vBtK2qz4rbVIw/H
	 omX2decLigXEsqeSAa2CY4rlbk8JRJN6HZKTi8HJ2KADvr6HYLdg6U2sf35VtcpYMx
	 RBKmu1Yiv7X85bxxxegZTxBrtF2aAZ3jNTuXK1zzzztb7lDlEUKNtAe5v+BX1DDxdz
	 U8bprd4dW1pZQ==
Date: Sun, 13 Sep 2026 04:08:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Cheick Traore <cheick.traore-ext@st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
Message-ID: <20260913040801.30e07d4c@jic23-hlaptop>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
	<20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 17:51:23 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
> these SoCs, split into two blocks:
> - ADC12 are tightly coupled (common registers).
> - ADC3 is managed independently.
> Each ADC is a 12-bits successive approximation analog-to-digital converter,
> with up to 20 multiplexed channels that can be configured as single ended
> or differential.
> 
> New property "st,adc-trigger-sel " allow to make the difference between
> the ADCs and to apply the correct trigger configuration.
> 
> STM32 ADC may be in a power domain: allow a single 'power-domains'.
> 
> Restrict the last channel (19), as it is wired directly to ADC Vref+.
> It's meaningless to have direct measurement. Internal Vref with
> calibration data from bsec (nvmem) must be used instead e.g. vrefint.
> Restrict deprecated properties (st,adc-channels, st,adc-diff-channels,
> st,min-sample-time-nsecs).
> 
> Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
> Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi Fabrice, all,

> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 106 ++++++++++++++++++---
>  1 file changed, 94 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> index c4c4575d3fa9..0e0ceaa3d8d6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> @@ -23,11 +23,18 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - st,stm32f4-adc-core
> -      - st,stm32h7-adc-core
> -      - st,stm32mp1-adc-core
> -      - st,stm32mp13-adc-core
> +    oneOf:
> +      - items:
> +          - enum:
> +              - st,stm32f4-adc-core
> +              - st,stm32h7-adc-core
> +              - st,stm32mp1-adc-core
> +              - st,stm32mp13-adc-core
> +      - items:
> +          - enum:
> +              - st,stm32mp23-adc-core
> +              - st,stm32mp25-adc-core
> +          - const: st,stm32-adc-core

What is this?  Given these all vary in features
why would we fallback to a generic match for
these new compatibles?



>  additionalProperties: false
>  
>  required:
> @@ -239,11 +276,18 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        enum:
> -          - st,stm32f4-adc
> -          - st,stm32h7-adc
> -          - st,stm32mp1-adc
> -          - st,stm32mp13-adc
> +        oneOf:
> +          - items:
> +              - enum:
> +                  - st,stm32f4-adc
> +                  - st,stm32h7-adc
> +                  - st,stm32mp1-adc
> +                  - st,stm32mp13-adc
> +          - items:
> +              - enum:
> +                  - st,stm32mp23-adc
> +                  - st,stm32mp25-adc
> +              - const: st,stm32-adc

Similar to above, what is this?


> @@ -344,6 +388,12 @@ patternProperties:
>          items:
>            - const: vrefint
>  
> +      st,adc-trigger-sel:
> +        description: Selects the HW trigger configuration available on this ADC
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]

Magic value that is meaningless to see in a dts.  If they
are effectively not compatible, give them different compatibles and
drop this property.  I'm unconvinced this property is more
useful than that given just how opaque the description is.



