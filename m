Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03055B5AB;
	Fri,  6 Feb 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383161; cv=none; b=os+Gwz/YRUI/PS6sB79ACf4Ze3Dd9j3BgAZeHwe77F4m1EIAyOxBp7jU0gCWl4i6VFDiVRyG0r+1OmN/hayWsT8XgLodw4GTA4D1bTtDHvtqPd1qOD6jPRFO7yZJdICl3f+/apCkesxZ0RtNIny1upVhWmMcUSNuZpRqwa44hek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383161; c=relaxed/simple;
	bh=T3ezfEtlx8wx+dPQAozxmush5kOuQwr+6KjLAqzdkqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEJ0cTAnEXg9Fvq0qaL33yHGrJTshMGZEO4fBClVUgSO8NYHzQCQu/FmR1k1otfiSbmJXX2eZP8oDweyMv4nkdYDiPK14+WWcGfKHOt9Qi7Q25IMhLEJchVY/lzDwRBY140S8ZTd2oNS43Unp+1GqRJ0yC7AtdNlkaPXqfSyRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHpeYPUX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHpeYPUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBC9C116C6;
	Fri,  6 Feb 2026 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770383160;
	bh=T3ezfEtlx8wx+dPQAozxmush5kOuQwr+6KjLAqzdkqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHpeYPUXB+BWsKaYOYEy867dRtgMyvNnRwugbHnvVlEaQ72WxfLRDzLiHoD/RQvFo
	 9di36gC906aBOm9KAFobXjh0WgJ4sZl3r85kQtJgZXOLFa0u71Z+GoCnk37RmoNhTL
	 wpam3tKYoY6EuBUJbt4zWPK7hhQcuI7GyMrhZ86nK2MevOIkzDSFzjBOZLFVpr2Bob
	 SemC5hhQEQOmqyhiX66aF2eK2NpmTTRFyhm9uBrRB6T/VNBxeZq/knTuh+Eb47Xi8f
	 fZX5ATSoCya9cnrMmxUXmhyAAP2clADU6EVaEOduIFxJFa6FOoDmlVQtniiXZq1sFh
	 b9IprCmsA2hLw==
Date: Fri, 6 Feb 2026 07:05:59 -0600
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	marcelo.schmitt1@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 6/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20260206130559.GA30712-robh@kernel.org>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
 <4b879f53450e87739afc0dbd832dab5a3f83efb1.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b879f53450e87739afc0dbd832dab5a3f83efb1.1770309522.git.marcelo.schmitt@analog.com>

On Thu, Feb 05, 2026 at 01:48:55PM -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> and A1) that set one of four possible signal gain configurations.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v6 -> v7
> - No changes.
> 
>  .../bindings/iio/adc/adi,ad4030.yaml          | 70 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 564b6f67a96e..3890cd4ba93e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -19,6 +19,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -31,6 +33,8 @@ properties:
>        - adi,ad4630-24
>        - adi,ad4632-16
>        - adi,ad4632-24
> +      - adi,adaq4216
> +      - adi,adaq4224
>  
>    reg:
>      maxItems: 1
> @@ -54,6 +58,14 @@ properties:
>      description:
>        Internal buffered Reference. Used when ref-supply is not connected.
>  
> +  vddh-supply:
> +    description:
> +      PGIA Positive Power Supply.
> +
> +  vdd-fda-supply:
> +    description:
> +      FDA Positive Power Supply.
> +
>    cnv-gpios:
>      description:
>        The Convert Input (CNV). It initiates the sampling conversions.
> @@ -64,6 +76,13 @@ properties:
>        The Reset Input (/RST). Used for asynchronous device reset.
>      maxItems: 1
>  
> +  pga-gpios:
> +    description:
> +      A0 and A1 pins for gain selection. For devices that have PGA configuration
> +      input pins, pga-gpios should be defined.
> +    minItems: 2
> +    maxItems: 2
> +
>    pwms:
>      description: PWM signal connected to the CNV pin.
>      maxItems: 1
> @@ -86,11 +105,29 @@ required:
>    - vio-supply
>    - cnv-gpios
>  
> -oneOf:
> -  - required:
> -      - ref-supply
> -  - required:
> -      - refin-supply
> +allOf:
> +  - oneOf:
> +      - required:
> +          - ref-supply
> +      - required:
> +          - refin-supply

Why is this moved under the allOf?

> +  # ADAQ devices require a gain property to indicate how hardware PGA is set
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: ^adi,adaq
> +    then:
> +      required:
> +        - vddh-supply
> +        - vdd-fda-supply
> +        - pga-gpios
> +      properties:
> +        ref-supply: false
> +    else:
> +      properties:
> +        pga-gpios: false
> +
>  
>  unevaluatedProperties: false
>  
> @@ -114,3 +151,26 @@ examples:
>              reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,adaq4216";
> +            reg = <0>;
> +            spi-max-frequency = <80000000>;
> +            vdd-5v-supply = <&supply_5V>;
> +            vdd-1v8-supply = <&supply_1_8V>;
> +            vio-supply = <&supply_1_8V>;
> +            refin-supply = <&refin_sup>;
> +            vddh-supply = <&vddh>;
> +            vdd-fda-supply = <&vdd_fda>;
> +            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> +            pga-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>,
> +                        <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> -- 
> 2.39.2
> 
