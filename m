Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A944DB9D;
	Wed, 27 May 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903477; cv=none; b=uRNG51NhOu6Vf+si/o//NWunNt7am1yc/zgUzlcDNz/gKjAkCsUuGI0GzDpkW2EovVMW0Gh6ZeeC7He+sV+XcG/WU0y4mCwrsu4UirvuM7vuJm7eu5UbNcUprlpUHKV4hxA4jTKhuE2w/4WyqGmnPZ8i1B36fW1Mc0w+1z2Gx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903477; c=relaxed/simple;
	bh=td2SJk0gdtzh4kTEsbLj6HHcSst10tu3kLNneI7eRtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgJI9RiOS4UOlQBxXayNha5tquxqvFdFvycZLm+ExrOfq3O0qOX+tsCuf8p2NWVoQ8Wj/qYuvifOcoMWhmfsdl7McHEC2HgyGYMf39rYbJsSpLFR7cuf4BMoOxconcdCuzxVnjgJhbpQxXCNjj0FTFKbxtxNHvEd4cQUTXzRbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5AsmSVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5AsmSVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED411F000E9;
	Wed, 27 May 2026 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903473;
	bh=Q+UXiIM0QRIe2JfdvDglJPFUARr4QyxIv+emBog0HZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V5AsmSVeknM54Jb+SYkTPRjReyVIJmsl7BQ+JicvDiIqeDfIYLIgq5oE47bDXnOTP
	 cTekHlvaA5IFtDroDkBLqSzLHAe61dlFxj/IsTNLrH4veTFo35TSP2MELbqL1EHnpX
	 WufQcR6NT8v5JtNGsxo8u5ge0KCqwO5tYZREBZ2eZFeL10+CfvzPkxI6ibBhAedZLB
	 odz68anIjFA729jC3e2+1Mvpe1C0dxB7nxXatp8IehSG6fZRjpIpmxddhfGzL79F1T
	 nvxKpEgcQy9Uxq7Fi6DP2Vo0ABqKuNKwdudr5m61lsZsOFJWRzNhuasdT5Y0tKsXN2
	 5wHrXYI4g6iYg==
Date: Wed, 27 May 2026 18:37:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 04/11] dt-bindings: iio: adc: hx711: add HX710B
 support
Message-ID: <20260527183743.006f9baf@jic23-huawei>
In-Reply-To: <20260525105127.180156-5-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
	<20260525105127.180156-5-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 16:21:20 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add the avia,hx710b compatible and document the HX710B-specific
> DVDD and VREF supplies.
Sashiko has called out that the commit message is not in sync
with the current patch content. Rewrite it to not mention dvdd
as hx710b specific.

https://sashiko.dev/#/patchset/20260525105127.180156-1-piyushpatle228%40gmail.com
Also, I think it is correct that for this new device binding at least
dvdd-supply should be required.


I'm not sure about the other bit of feedback on correct way to match
compatible strings. What is here seems to me to work (I hacked the file
to test the constraints were applied).

Conor is that one right or not?

> 
> Add constraints that forbid HX711-only properties on HX710B nodes and
> require vref-supply for HX710B, then add a separate HX710B example.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/iio/adc/avia-hx711.yaml          | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 099235b5fd54..f0aeb15e9eb9 100644
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
> @@ -53,6 +58,10 @@ properties:
>        RATE pin state is determined by the board wiring.
>      maxItems: 1
>  
> +  vref-supply:
> +    description:
> +      Reference voltage input (VREF).
> +
>    clock-frequency:
>      description:
>        Controls the SCK bit-bang timing. The value is used to derive the
> @@ -62,6 +71,21 @@ properties:
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
> @@ -81,3 +105,12 @@ examples:
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

