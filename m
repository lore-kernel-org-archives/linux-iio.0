Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF94CA264;
	Tue, 12 May 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587992; cv=none; b=CcH0VeifxZIFa1xGPUROSyIXLnQgK2rdL6+hDMTxILnXkyb8veYk5LhekuE5E9wJfLbXYRSGXbhkIraJrASa8qMpkBXV2hCcfWAWanJtLLv+l5B7o2KA5W5agTkfwmTW3Zz2Fp91QeEVN5iTWiuCRls4/IOq9Z5WPhtsKmL1pMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587992; c=relaxed/simple;
	bh=90gPVaXUX043aZpt3IciW0YZ8X64lWOFu08om/VaSH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URCRy91ucqyZUYOiAtHvc9c+ncZpCMk9uJed1G/DkNPsEF2bDPSdsQAoCC4+GPdxwuwuH/fM7a872u2Xc5X4SP1juHPrUTzZfTBo4Fg130A7LlCo8714oZcAEMbSQRhgkgDrysRSQ0BJpN/zX5B521jD8omczBLBM1o744dG8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm4RY9h7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm4RY9h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F9DC2BCF5;
	Tue, 12 May 2026 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778587992;
	bh=90gPVaXUX043aZpt3IciW0YZ8X64lWOFu08om/VaSH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cm4RY9h7/bB7Tg3i50F60EaDjQJkRHaRxDXur7JWu/yt/GIK2EavC2/MSavqa98mr
	 zpjR18Ie/Al8F4B2Nr7IhfGwbmWGbm0C50akOIS9s4nX4nEiUHI5vUXkY+0XULxRHh
	 8UPMxxTIfeCQakzcxU9B2EFYnMrQYMKY7fvWBNvjPMeNMPhmrK4eDLKhmdYrt6mOCf
	 8VdONDF2Ky/akBXW+aQVHs+Uet+me8tlYYH8RLVbOjCNLdxfqKyy7Fkb0mgMtKGT3A
	 bd2IYSEVcpDQ60S9gyfza4nJA7R6wW6Wmjau7Y1MaJm4T5jVxieLtBpLbByjKLRUJm
	 xK9/A/gr/dZoA==
Date: Tue, 12 May 2026 13:13:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 v8 04/11] dt-bindings: iio: adc: hx711: add HX710B
 support
Message-ID: <20260512131302.48d71836@jic23-huawei>
In-Reply-To: <20260511174342.123820-5-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
	<20260511174342.123820-5-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 23:13:29 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add the avia,hx710b compatible and document the HX710B-specific
> DVDD and VREF supplies.
Hi Piyush,

Sashiko moaned about this on v7 (it's not caught up with v8 yet)
and is correct in a sense as the hx711 seems to have a dvdd supply.
Your are documenting extra stuff that is hx710b specific but
the actual supply is there on both chips.

https://sashiko.dev/#/patchset/20260510194947.31997-1-piyushpatle228%40gmail.com

> 
> Add constraints that forbid HX711-only properties on HX710B nodes and
> require vref-supply for HX710B, then add a separate HX710B example.
> 
> Keep the existing HX711-only binding extensions in earlier patches so
> this change is limited to the new variant.

This bit isn't needed in the patch description and as per the dvdd-supply
isn't quite true.  I might just edit this whilst applying if nothing
comes up in rest of the series (I will be waiting for sashikio though
given how successful it is proving an find stuff I missed!)

> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/iio/adc/avia-hx711.yaml          | 42 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 9134bbe41379..b2b5c7bdf05e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: AVIA HX711 ADC chip for weight cells
> +title: AVIA HX711 and HX710B ADCs
>  
>  maintainers:
>    - Andreas Klinger <ak@it-klinger.de>
> @@ -14,9 +14,14 @@ description: |
>    differential input channels. Channel A supports gain 64 and 128;
>    channel B supports gain 32.
>  
> +  The HX710B is a 24-bit ADC with fixed gain of 128. One input measures
> +  the differential voltage between the two input pins; a second measures
> +  the DVDD-AVDD supply voltage difference for battery level detection.
> +
>  properties:
>    compatible:
>      enum:
> +      - avia,hx710b
>        - avia,hx711
>  
>    sck-gpios:
> @@ -44,6 +49,17 @@ properties:
>        RATE pin state is determined by the board wiring.
>      maxItems: 1
>  
> +  dvdd-supply:
Ah dvdd is here and whilst your text is talking about hx710b constraints
you don't stop it being supplied for the hx711 so you can ignore earlier comment.

> +    description:
> +      Digital supply voltage (DVDD). For the HX710B, DVDD must be
> +      greater than or equal to AVDD. When DVDD is a battery rail and
> +      AVDD is a regulated supply, one channel monitors the DVDD-AVDD
> +      difference for battery level detection.
> +
> +  vref-supply:
> +    description:
> +      Reference voltage input (VREF).
> +
>    clock-frequency:
>      description:
>        Controls the SCK bit-bang timing. The value is used to derive the
> @@ -53,6 +69,21 @@ properties:
>      maximum: 2500000
>      default: 400000
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: avia,hx710b
> +    then:
> +      properties:
> +        vsup-supply: false
> +        rate-gpios: false
> +      required:
> +        - vref-supply
> +    else:
> +      properties:
> +        vref-supply: false
> +
>  required:
>    - compatible
>    - sck-gpios
> @@ -72,3 +103,12 @@ examples:
>          avdd-supply = <&avdd>;
>          clock-frequency = <100000>;
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    weight {
> +        compatible = "avia,hx710b";
> +        sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> +        dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +        avdd-supply = <&avdd>;
> +        vref-supply = <&vref>;
> +    };

