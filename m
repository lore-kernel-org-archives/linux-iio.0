Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3683C061F;
	Fri, 24 Apr 2026 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032049; cv=none; b=DA8++jnjacp+Px74Rqac5Cve2CKPbRsfPbr/4B5kzfIooMHRqCSz0m0eBLa1fv+NSTNXxTZdBLLf3FKuvBRpFLDHbiKWD8XfUfL32q+UIp12hdPbwHECTzgJW092iksKpz2HVQnpXE6+QBbbMqYJirXH4M8p3CnQud0X0bvzdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032049; c=relaxed/simple;
	bh=IFZrcF0uJ5hMM3jSMUxI6whRQJ9dhBG7wBPm7cSIoAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJKsVzHDOZStgj1spGvMgDJ/9Xf7hI3YFIlUwaPutdHS3XL34BLR3yHybuYlSiA8aYGkE5R+JMAwYeC4/ocIPOG3FVFb/lDWaCFy2R4UUz0Qn6hjhW9e5/GsxYW8ivtItPP2/00XPn1bIRFBlkmsXipOp2AKDLFlVX5E3YJVi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU1U1rFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU1U1rFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D162C19425;
	Fri, 24 Apr 2026 12:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777032049;
	bh=IFZrcF0uJ5hMM3jSMUxI6whRQJ9dhBG7wBPm7cSIoAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KU1U1rFw6o31e6hyLZ/iHYq4hn3qiTyMX3nBXcb6k1TNtvk/McEoR7n2PxVnXB0d9
	 jaxlu8PmF2WNA1Ka6tDw1oBTLUgARVQRCVA2ECqPLArowBX3DjFLMVSn8BgKJCU6BN
	 1usHjhlrTBkgZ48PCbZAEct+Ih/QJn70qnyCF0FQzG/A4UVWPWO9vJ3pYTjEAk83+/
	 QE/iBoEDOd6LyIehQDIR45YMxxWMK0Rgqyb2I+VnZROoebFuXMo45YNHXGJYB55MXB
	 rd2Tu2ynt/rFs+REYblXzsBv06Z8v8wjNwBCy/z3rSa5dbiaH+ZQ4W0/2mfa0dqcwD
	 BMfMoWNTfTMWg==
Date: Fri, 24 Apr 2026 13:00:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <20260424130039.34a21887@jic23-huawei>
In-Reply-To: <20260422175910.1258579-2-piyushpatle228@gmail.com>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
	<20260422175910.1258579-2-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 23:29:08 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> The HX710B shares the same two-wire interface as the HX711 but differs
> in its channel and gain model: gain is fixed at 128 and the number of
> trailing PD_SCK pulses selects the input channel rather than the gain.
> 
> Add avia,hx710b to the compatible enum. Document the chip differences
> in the description and add chip-specific supply properties (dvdd-supply,
> vsup-supply) for the HX711, a rate-gpios property for the HX711 RATE
> pin, and an allOf constraint that forbids HX711-only properties on
> HX710B nodes. Clarify the clock-frequency description to reflect its
> actual purpose: controlling the SCK bit-bang timing.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

Sashikio had some more comments...
https://sashiko.dev/#/patchset/20260422175910.1258579-1-piyushpatle228%40g

First one looks correct to me about the hx710b clearly having a DVDD supply
given we are measuring it.

> ---
> Changes in v3:
> - Drop the vref-supply mention from avdd-supply; no such binding
>   property exists.
> - Drop the clock-frequency sentence that repeated the schema default.
> - Restore the example node name to weight.
> - Remove the separate HX710B example.
> 
> Changes in v2:
> - Remove driver implementation details from the description and describe
>   hardware behaviour only.
> - Drop unrelated punctuation cleanup.
> - Add dvdd-supply and vsup-supply optional properties for HX711.
> - Add rate-gpios optional property for the HX711 RATE pin and forbid it
>   on HX710B.
> - Add the allOf if/then block forbidding HX711-only properties on
>   HX710B nodes.
> - Clarify clock-frequency as SCK bit-bang timing, not a crystal or
>   external clock input.
> - Sort compatible enum alphabetically.
> - Remove redundant example comments.
> - Update the HX711 example to exercise rate-gpios.
> 
>  .../bindings/iio/adc/avia-hx711.yaml          | 50 +++++++++++++++----
>  1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 9c57eb13f892..0c7c5843b8d2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -4,24 +4,24 @@
>  $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: AVIA HX711 ADC chip for weight cells
> +title: AVIA HX711 and HX710B ADCs
>  
>  maintainers:
>    - Andreas Klinger <ak@it-klinger.de>
>  
>  description: |
> -  Bit-banging driver using two GPIOs:
> -  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
> -    and up to 3 cycles for selection of the input channel and gain for the
> -    next measurement
> -  - dout-gpio is the sensor data the sensor responds to the clock
> +  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
> +  differential input channels. Channel A supports gain 64 and 128;
> +  channel B supports gain 32.
>  
> -  Specifications about the driver can be found at:
> -  http://www.aviaic.com/ENProducts.aspx
> +  The HX710B is a 24-bit ADC with fixed gain of 128. Channel 0 is the
> +  differential input and channel 1 measures the DVDD-AVDD supply
> +  voltage difference.
How can it be measuring something including DVDD if that supply isn't
allowed for the part?

>  
>  properties:
>    compatible:
>      enum:
> +      - avia,hx710b
>        - avia,hx711
>  
>    sck-gpios:
> @@ -40,13 +40,44 @@ properties:
>  
>    avdd-supply:
>      description:
> -      Definition of the regulator used as analog supply
> +      Analog supply voltage (AVDD). Also serves as the voltage reference on
> +      both chips.
> +
> +  dvdd-supply:
> +    description:
> +      Digital supply voltage (DVDD). HX711 only.
This is the confusing description. 
> +
> +  vsup-supply:
> +    description:
> +      Supply voltage for the on-chip regulator (VSUP). HX711 only.
> +
> +  rate-gpios:
> +    description:
> +      GPIO connected to the RATE pin (HX711 only). When driven low the
> +      output data rate is 10 SPS; when driven high it is 80 SPS. If
> +      omitted the RATE pin state is determined by the board wiring.
> +    maxItems: 1
>  
>    clock-frequency:
> +    description:
> +      Controls the SCK bit-bang timing. The value is used to derive the
> +      delay between SCK edges; keep the SCK high time below 60 us to
> +      avoid triggering chip power-down mode.
>      minimum: 20000
>      maximum: 2500000
>      default: 400000
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: avia,hx710b
I'm fairly sure the sashiko comment on this is wrong given this
looks like standard way of doing this.

> +    then:
> +      properties:
> +        vsup-supply: false
> +        dvdd-supply: false
> +        rate-gpios: false
> +
>  required:
>    - compatible
>    - sck-gpios
> @@ -62,6 +93,7 @@ examples:
>          compatible = "avia,hx711";
>          sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>          dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>          avdd-supply = <&avdd>;
>          clock-frequency = <100000>;
>      };

