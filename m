Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809B44D696;
	Tue, 28 Apr 2026 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398582; cv=none; b=nQfM5teD0T0GucPbliqiTMUiVulDOcpnTtOtiC7gQ8RD86XQvieeajzrqON4PI47OM1gEQsE4SD8nkn+fLBrT8OyULsxj7/2KWTcNAU9RHoXZNv9+4Q5BNWkwlxnAkVAo5ZpxEyxpdf1HmfXxoqpaO+VP0di33CSNU6rZorCh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398582; c=relaxed/simple;
	bh=EkSW1r8JzoHe52BJQrjtUZwAVYmHhXjAZqebDcSpL58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPo+wApJ051+FdTf53qHPoIAqb0qkDZKhqMOJHmWJy2AHAmGgyFBc8In/xFqU70yG3/0OxQ94ELg3Z9mbDfxLSajQbo3yoWHAbu3wU1aQ9KCM/eN6FdVhMPgfq9tgjPbN2Jk+aM9y29j9sfmHWQJzouieico7QKrlNvFfX50cb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6fw16wk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6fw16wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA62C2BCB8;
	Tue, 28 Apr 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777398581;
	bh=EkSW1r8JzoHe52BJQrjtUZwAVYmHhXjAZqebDcSpL58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H6fw16wkK3Omz9bJiXliKlgQlGkUoJZ//AahZa1NMSM0fPOkv7/7oU4sJtYfX98BZ
	 pOIrKRzXeDNyVL4SPqrkwcOhPsQG4+QYrsyTcFiozpdojjVG4f9wvZTiqYhwF8O5/j
	 6zT3PoWsPehZfcYB0TBqeLc1UOmAxA6dlXUUnrYKpuB1Y3Z4hQ2Xr8W3JUaPZ2ZwyR
	 RTOPkHdgyGqCB6G0vz41K4EluSoYsxMx6v+8dcOJhWIg87pvH+w4jReIhusHZtHpo8
	 WZVUg1dD8URaXEGt5QWxrKO3ya3OCKxOBXCZLepcVZn4aCM+lzn0OYv/BzVgDcwke7
	 xR+FrYMpG1L2Q==
Date: Tue, 28 Apr 2026 18:49:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <20260428184931.2be4baab@jic23-huawei>
In-Reply-To: <20260427100950.33936-2-piyushpatle228@gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
	<20260427100950.33936-2-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 15:39:32 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> The HX710B shares the same two-wire interface as the HX711 but differs
> in its channel and gain model: gain is fixed at 128 and the number of
> trailing PD_SCK pulses selects the input channel rather than the gain.
> 
> Add avia,hx710b to the compatible enum. Document the chip differences
> in the description and add chip-specific supply properties (dvdd-supply,
> vsup-supply, vref-supply) and a rate-gpios property for the HX711 RATE
> pin. Add allOf constraints that forbid HX711-only properties on HX710B
> nodes and vice versa. Clarify the clock-frequency description to
> reflect its actual purpose: controlling the SCK bit-bang timing.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

Hi Piyush,

This is doing at least 3 different things. See below for why I think
it needs to be 3 patches.

> ---
> Changes in v4:
> - Add vref-supply for the HX710B VREF reference voltage pin.
> - Remove dvdd-supply from the HX710B forbidden properties list; the
>   HX710B has a DVDD supply and the DVDD-AVDD channel relies on it.
> - Add allOf block forbidding vref-supply on HX711 nodes.
> - Add an HX710B example showing vref-supply.
> - Update description: avoid specific channel-number references in
>   hardware text.
> 
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
> ---
>  .../bindings/iio/adc/avia-hx711.yaml          | 82 +++++++++++++++----
>  1 file changed, 67 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 9c57eb13f892..fddd296bfaca 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -4,49 +4,91 @@
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

Do this in two patches. First one changes like this that apply to existing
HX711 binding and second one that adds the HX710B elements (and any text
about stuff being specific to the HX711 as that only makes sense when adding
the new stuff.

>  
> -  Specifications about the driver can be found at:
> -  http://www.aviaic.com/ENProducts.aspx
> +  The HX710B is a 24-bit ADC with fixed gain of 128. One input measures
> +  the differential voltage between the two input pins; a second measures
> +  the DVDD-AVDD supply voltage difference for battery level detection.
>  
>  properties:
>    compatible:
>      enum:
> +      - avia,hx710b
>        - avia,hx711
>  
>    sck-gpios:
>      description:
> -      Definition of the GPIO for the clock (output). In the datasheet it is
> -      named PD_SCK
> +      GPIO for the clock output (PD_SCK in the datasheet).
This cleanup goes in that first patch.
>      maxItems: 1
>  
>    dout-gpios:
>      description:
> -      Definition of the GPIO for the data-out sent by the sensor in
> -      response to the clock (input).
> -      See Documentation/devicetree/bindings/gpio/gpio.txt for information
> -      on how to specify a consumer gpio.
> +      GPIO for the data output from the sensor (DOUT in the datasheet).

As does this.

>      maxItems: 1
>  
>    avdd-supply:
>      description:
> -      Definition of the regulator used as analog supply
> +      Analog supply voltage (AVDD). Also serves as the voltage reference on
> +      both chips.

Don't talk about 'both' chips. Also it doesn't if vref is supplied.  So I'd
drop the sentence entirely.

> +
> +  dvdd-supply:
> +    description:
> +      Digital supply voltage (DVDD). For the HX710B, DVDD must be greater
> +      than or equal to AVDD. When DVDD is a battery rail and AVDD is a
> +      regulated supply, one channel monitors the DVDD-AVDD difference for
> +      battery level detection.
> +
> +  vsup-supply:
> +    description:
> +      Supply voltage for the on-chip regulator (VSUP). HX711 only.

This applies to the existing hx711 binding rather than being related to the new
stuff. Separate patch with an explanation.  This isn't just tidy up so needs
to be the 2nd patch after tidy up and before hx710b addition.

> +
> +  vref-supply:
> +    description:
> +      Reference voltage input (VREF). HX710B only. When omitted, the driver
> +      assumes VREF is tied to AVDD on the board.

Is it an external pin? If so no such assumption. It should be specified.
If both end up pointing at same regulator that's fine.  This is for
a new device that wasn't supported before so we don't need
to be careful with backwards compatibility - can do it right!

> +
> +  rate-gpios:
> +    description:
> +      GPIO connected to the RATE pin (HX711 only). When driven low the
> +      output data rate is 10 SPS; when driven high it is 80 SPS. If
> +      omitted the RATE pin state is determined by the board wiring.
> +    maxItems: 1

This is new binding applying to hx711. Put it in a separate patch with
explanation of just this bit int he patch description.

>  
>    clock-frequency:
> +    description:
> +      Controls the SCK bit-bang timing. The value is used to derive the
> +      delay between SCK edges; keep the SCK high time below 60 us to
> +      avoid triggering chip power-down mode.
Should be in that first hx711 dt binding clean up patch.

>      minimum: 20000
>      maximum: 2500000
>      default: 400000
>  
> +allOf:

Bring all this in as part of the hx710b addition patch as first
time we need constraints.

> +  - if:
> +      properties:
> +        compatible:
> +          const: avia,hx710b
> +    then:
> +      properties:
> +        vsup-supply: false
> +        rate-gpios: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: avia,hx711
> +    then:
> +      properties:
> +        vref-supply: false
> +
>  required:
>    - compatible
>    - sck-gpios
> @@ -62,6 +104,16 @@ examples:
>          compatible = "avia,hx711";
>          sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>          dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
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

