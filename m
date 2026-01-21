Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D313587C4;
	Wed, 21 Jan 2026 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983043; cv=none; b=uktB0WstTF8Wl23C4vnMyaP3TDpmX6fLHXo9odWYRPx1i0z9nU1KG7NMR6FKQflitSuZKxGlgFWLYknQ/DYe2Xe3hc1s/F9HE9Pq5VvX1GtUpPIlIXs/9XIi7uJoh7I88Odf/53fOEVtX+mZg6GoMsKw9kl+tz3x16MnoOslBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983043; c=relaxed/simple;
	bh=r4zOPzV7E/g8Vx7+FbnIqyKLv0U8+MchrTaQd10CpsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntjY3pJ2SPEsE/I+oRbUJRA8AxIL/67okmQNGvOfJ2D2M69pIEkp6wlAYMWGAJR2l9Q8URBbBDfBOkUuuIqEdoyhw1Z+vCU3NcWckCa169tGChRSr+X+wTg8Beq74CwQlV4tyNaJFRTtEF4iI1EQuCi5aCVuKDi7mzbDhQ8v3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sttF+rPI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sttF+rPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E38C116D0;
	Wed, 21 Jan 2026 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983042;
	bh=r4zOPzV7E/g8Vx7+FbnIqyKLv0U8+MchrTaQd10CpsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sttF+rPIUrLYBixoUtYhpB7EPzIDsY3XF+R4VfXXWru9Zd0mIglnLskC73Nrzce3B
	 V3n7uK8zlXBS1EfCb5dg/sKE34KVDigA6UIVt4mHNTgDA+sJ8GAzM+Xu0OLrAiMjaT
	 vRWtqFh351cnOJrZNzggu45idh+OUh8JawOJesLVkleyiWfbeN/lntbucDAwCJLUf+
	 dHJ+UhfFzBYKJ4XmU+i1k9vlSUvvVEK60IntZcjTmGTh2hApqZNZH1tKgrMaEifVZv
	 hSTmMQridSQ6gnWcb82fBdFGy4DDGcls+N1iCv+HB0mMLrw7tU1ucPA3OgUzmuJNni
	 skZDqhmiZAIVQ==
Date: Wed, 21 Jan 2026 09:10:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: iio: amplifiers: Add AD8366 support
Message-ID: <20260121-merciful-exotic-panther-eca1b0@quoll>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
 <20260119-iio-ad8366-update-v1-2-8044e23e964a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-iio-ad8366-update-v1-2-8044e23e964a@analog.com>

On Mon, Jan 19, 2026 at 02:36:56PM +0000, Rodrigo Alencar wrote:
> Add device tree binding documentation for amplifiers and digital
> attenuators. This covers different device variants with similar
> SPI control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,ad8366.yaml        | 85 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
> new file mode 100644
> index 000000000000..7477bb9b5071
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad8366.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD8366, similar Gain Amplifiers and Digital Attenuators

s/,/and/

> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Digital Variable Gain Amplifiers (VGAs) and Digital Attenuators with
> +  SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad8366
> +      - adi,ada4961
> +      - adi,adl5240
> +      - adi,adrf5720
> +      - adi,adrf5730
> +      - adi,adrf5731
> +      - adi,hmc271a
> +      - adi,hmc792a
> +      - adi,hmc1018a
> +      - adi,hmc1019a
> +      - adi,hmc1119
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Regulator that provides power to the device.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO pin used to reset the device.

Drop description, redundant, said nothing more other than what property
already said. This cannot be a something else than GPIO and cannot be
used for something else than resetting device.

> +
> +  enable-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO pin used to enable the device.

Drop description.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      amplifier@0 {
> +        compatible = "adi,ad8366";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        vcc-supply = <&vcc_3v3>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {

Drop second example. It's the same as first.

Best regards,
Krzysztof

