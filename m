Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F143DEC3;
	Thu,  1 Oct 2026 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834210; cv=none; b=rek1L6VQiVLgLPDGNcG1Qe+IdFb4Zfadc7NFtHoSkoYf97vpMPhCn9WYv0L2TRK/VkUD1uM0WO/67uZm2/vt5lbaZsMIVk9HG/pxGnJsUDullYbBXSoccgDitv255g8Cq2ooePA6oGm8goeD2+xX4rgSulc6BtaISd+ZRFDjMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834210; c=relaxed/simple;
	bh=ik+Cp8ugqNlf3IEj/bbQ98LnQF2Ga/sG5mZZjyRkadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtATkLFayexngWDN9NJP+rfGuWT90LFST9I/U+qLRiW2pQk9jGCSZFU7TEuo2qFhIK3Lx0Oz97w5v2NREASpdet7dvGECWLGpg3euJxrMORJ3/VaoBU8UYljtX0mMpRldT+N3Mb8cta78K4mhl61/EoZNG3QwZUC5+5DeyAsno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS1OLHY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS1OLHY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB81F000FF;
	Thu,  1 Oct 2026 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790834209;
	bh=ZDxsokV5obQ5C8QUjCgm5Et9Kq1WK82QzPRqqhS1oSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JS1OLHY7AHmn7gnE2QX4jLhMDKzXZfIViXHr4j4k0n84XCeGcPItrHrlq4kwPc/g7
	 VWuc+LL0Aw0XmJSh9tYVPvlj28ZO6K7GVqrPD75ctqrAeWX3eNL4SYtrnYDgCRwiiH
	 pGhCtHnoJpzsIIVWMaW35sYlNJLZXFMxRTtI/dBNg172RjS0GPVSBjmVlIAFeA4wI+
	 R+Zsy0mRxV+xjjEcNMWcQccSGH6piG6qRlp4MkMI8VX+H0CQ1gXQ6LfAafU4ZSTj6w
	 GrbimXZxT3+1HTdKmwMey2dnVlNCcLPFTtzNr6xvjrXjxzWxsvuw49o8uWT8ZsIYIA
	 fp+L5qpppAvSw==
Date: Thu, 1 Oct 2026 07:56:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Message-ID: <20261001-obedient-stimulating-worm-0ae11c@quoll>
References: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
 <20261001-ast27xx-adc-upstream-v1-1-5ace57533418@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001-ast27xx-adc-upstream-v1-1-5ace57533418@aspeedtech.com>

On Thu, Oct 01, 2026 at 11:28:44AM +0800, Billy Tsai wrote:
> The ADC's reference-voltage trimming data lives in a System Control
> Unit (SCU) register. SoCs with a single SCU instance let the driver
> locate it without any additional information, but SoCs such as AST2700
> that expose more than one SCU node need an explicit phandle to
> disambiguate which one holds the trimming data.
> 
> Add an optional "syscon" phandle property, and require it for the
> AST2700 compatibles since they are the first multi-SCU SoCs supported
> by this driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-sonnet-5
> ---
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> index 249101b55cf4e..0d6b10450cfa8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> @@ -67,6 +67,11 @@ properties:
>      description:
>        Inform the driver that last channel will be used to sensor battery.
>  
> +  syscon:

Missing vendor and descriptive name. Please read writing bindings.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Required on SoCs with more than one SCU instance (e.g. AST2700).

Describe the purpose, not open code schema.

> +
>  required:
>    - compatible
>    - reg
> @@ -74,6 +79,18 @@ required:
>    - resets
>    - "#io-channel-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - aspeed,ast2700-adc0
> +              - aspeed,ast2700-adc1
> +    then:
> +      required:
> +        - syscon
> +
>  additionalProperties: false
>  
>  examples:
> @@ -95,4 +112,15 @@ examples:
>          #io-channel-cells = <1>;
>          aspeed,int-vref-microvolt = <2500000>;
>      };
> +  - |
> +    #include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +    #include <dt-bindings/reset/aspeed,ast2700-scu.h>

No need for a new exmaple for one new property.

Best regards,
Krzysztof

