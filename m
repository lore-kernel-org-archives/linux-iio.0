Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4052194C98;
	Sat, 21 Feb 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771670309; cv=none; b=RxkrSnX6oyEdlAm+7t0JKL6jVc+lwrPfJxX7+gx4oKDLwMMchlnCThx9djCbrtjyr67jzxaqNyi5yV+eqtVF+5zOcExYWkPu3oE+AP0ou42qkIKGn5dXijq2qC7OZwsToHdzgh0WJ8s54cPvQ/7FrbjCejkwsGImDwI7yrJJyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771670309; c=relaxed/simple;
	bh=A5ionjHqidefDy1oL659rS2XvqIkj0eqhGeMx0KIfjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfP3YNtjRq3i6nTCS2B8t/jU9FTyyOGmrOuWUxSr6KrHRdj95wMhqVmYhFZx2zJvFW/LC6oQzgecibR6MILt7eNwP7im5DOEFdTb3lSYkM5t67nXs9I4IncxlUC0FyhXAtXm/jptysJNnTLace2u8fd7LY0pBQbmXz3/CT9n60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbdyH0Lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbdyH0Lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8848C4CEF7;
	Sat, 21 Feb 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771670309;
	bh=A5ionjHqidefDy1oL659rS2XvqIkj0eqhGeMx0KIfjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbdyH0LmIt9E3TiAbP35Nm28E87g8vlsF/Qbyr/av8HTBT8Y3MZM6vMYcR0DdGyfz
	 Ap1ba2TTwwgjLQdS5IaAqPKZVTLN9OvdPTwm4/g2X1vVyRHXh9iK9wojvV/qWYkFRn
	 ara4swNMdIbP8srPWyyg0KK2/lj2X4yUmGrAZiTA3gNzI95u36DiPOQDI8xFSFAHXy
	 gj/UZmfuUR6HmWMHIuEiCLaEoLxgbnxRJVP6DAAAeAVTxeVjT/nIn2/ajvfxCFDN3y
	 3GqcDOFKocTa2ewafjlC5Yd8N7AA/8/EpD/Nup0g/lBnydrvFv730SeWPudMToA0ZA
	 DDUKxNBYGF4JA==
Date: Sat, 21 Feb 2026 11:38:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
Message-ID: <20260221-dancing-papaya-wolverine-db8afd@quoll>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220053941.611415-6-sai.krishna.potthuri@amd.com>

On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
> and remove the old text binding.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  .../bindings/iio/adc/xilinx-xadc.txt          | 141 -------------
>  .../bindings/iio/adc/xilinx-xadc.yaml         | 194 ++++++++++++++++++
>  2 files changed, 194 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> deleted file mode 100644
> index f42e18078376..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> +++ /dev/null
> @@ -1,141 +0,0 @@
> -Xilinx XADC device driver
> -
> -This binding document describes the bindings for the Xilinx 7 Series XADC as well
> -as the UltraScale/UltraScale+ System Monitor.
> -
> -The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
> -The XADC has a DRP interface for communication. Currently two different
> -frontends for the DRP interface exist. One that is only available on the ZYNQ
> -family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
> -on all series 7 platforms and is a softmacro with a AXI interface. This binding
> -document describes the bindings for both of them since the bindings are very
> -similar.
> -
> -The Xilinx System Monitor is an ADC that is found in the UltraScale and
> -UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
> -communication. Xilinx provides a standard IP core that can be used to access the
> -System Monitor through an AXI interface in the FPGA fabric. This IP core is
> -called the Xilinx System Management Wizard. This document describes the bindings
> -for this IP.
> -
> -Required properties:
> -	- compatible: Should be one of
> -		* "xlnx,zynq-xadc-1.00.a": When using the ZYNQ device
> -		  configuration interface to interface to the XADC hardmacro.
> -		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
> -		  interface to the XADC hardmacro.
> -		* "xlnx,system-management-wiz-1.3": When using the
> -		  Xilinx System Management Wizard fabric IP core to access the
> -		  UltraScale and UltraScale+ System Monitor.
> -	- reg: Address and length of the register set for the device
> -	- interrupts: Interrupt for the XADC control interface.
> -	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
> -	  when using the axi-xadc or the axi-system-management-wizard this must be
> -	  the clock that provides the clock to the AXI bus interface of the core.
> -
> -Optional properties:
> -	- xlnx,external-mux:
> -		* "none": No external multiplexer is used, this is the default
> -		  if the property is omitted.
> -		* "single": External multiplexer mode is used with one
> -		   multiplexer.
> -		* "dual": External multiplexer mode is used with two
> -		  multiplexers for simultaneous sampling.
> -	- xlnx,external-mux-channel: Configures which pair of pins is used to
> -	  sample data in external mux mode.
> -	  Valid values for single external multiplexer mode are:
> -		0: VP/VN
> -		1: VAUXP[0]/VAUXN[0]
> -		2: VAUXP[1]/VAUXN[1]
> -		...
> -		16: VAUXP[15]/VAUXN[15]
> -	  Valid values for dual external multiplexer mode are:
> -		1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
> -		2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
> -		...
> -		8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
> -
> -	  This property needs to be present if the device is configured for
> -	  external multiplexer mode (either single or dual). If the device is
> -	  not using external multiplexer mode the property is ignored.
> -	- xnlx,channels: List of external channels that are connected to the ADC
> -	  Required properties:
> -		* #address-cells: Should be 1.
> -		* #size-cells: Should be 0.
> -
> -	  The child nodes of this node represent the external channels which are
> -	  connected to the ADC. If the property is no present no external
> -	  channels will be assumed to be connected.
> -
> -	  Each child node represents one channel and has the following
> -	  properties:
> -		Required properties:
> -			* reg: Pair of pins the channel is connected to.
> -				0: VP/VN
> -				1: VAUXP[0]/VAUXN[0]
> -				2: VAUXP[1]/VAUXN[1]
> -				...
> -				16: VAUXP[15]/VAUXN[15]
> -			  Note each channel number should only be used at most
> -			  once.
> -		Optional properties:
> -			* xlnx,bipolar: If set the channel is used in bipolar
> -			  mode.
> -
> -
> -Examples:
> -	xadc@f8007100 {
> -		compatible = "xlnx,zynq-xadc-1.00.a";
> -		reg = <0xf8007100 0x20>;
> -		interrupts = <0 7 4>;
> -		interrupt-parent = <&gic>;
> -		clocks = <&pcap_clk>;
> -
> -		xlnx,channels {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			channel@0 {
> -				reg = <0>;
> -			};
> -			channel@1 {
> -				reg = <1>;
> -			};
> -			channel@8 {
> -				reg = <8>;
> -			};
> -		};
> -	};
> -
> -	xadc@43200000 {
> -		compatible = "xlnx,axi-xadc-1.00.a";
> -		reg = <0x43200000 0x1000>;
> -		interrupts = <0 53 4>;
> -		interrupt-parent = <&gic>;
> -		clocks = <&fpga1_clk>;
> -
> -		xlnx,channels {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			channel@0 {
> -				reg = <0>;
> -				xlnx,bipolar;
> -			};
> -		};
> -	};
> -
> -	adc@80000000 {
> -		compatible = "xlnx,system-management-wiz-1.3";
> -		reg = <0x80000000 0x1000>;
> -		interrupts = <0 81 4>;
> -		interrupt-parent = <&gic>;
> -		clocks = <&fpga1_clk>;
> -
> -		xlnx,channels {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			channel@0 {
> -				reg = <0>;
> -				xlnx,bipolar;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
> new file mode 100644
> index 000000000000..17508fef1f43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml

Filename matching compatible, e.g. xlnx,axi-xadc.yaml


> @@ -0,0 +1,194 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/xilinx-xadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx XADC and System Monitor ADC
> +
> +description:
> +  The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
> +  The XADC has a DRP interface for communication. Currently two different
> +  frontends for the DRP interface exist. One that is only available on the ZYNQ
> +  family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
> +  on all series 7 platforms and is a softmacro with an AXI interface.
> +
> +  The Xilinx System Monitor is an ADC that is found in the UltraScale and
> +  UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
> +  communication. Xilinx provides a standard IP core that can be used to access the
> +  System Monitor through an AXI interface in the FPGA fabric. This IP core is
> +  called the Xilinx System Management Wizard.
> +
> +  The System Management Wizard can also be accessed via I2C interface for remote
> +  monitoring scenarios where the system Management Wizard is located on a different chip.

Not wrapped correctly. Please read coding style.

> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,zynq-xadc-1.00.a
> +      - xlnx,axi-xadc-1.00.a
> +      - xlnx,system-management-wiz-1.3
> +      - xlnx,system-management-wiz-1.3-remote

There was no such compatible and nothing explains why it appeared. You
cannot just add new ABI and claim it is just a conversion.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      When using the ZYNQ this must be the ZYNQ PCAP clock,
> +      when using the axi-xadc or the axi-system-management-wizard this must be
> +      the clock that provides the clock to the AXI bus interface of the core.
> +
> +  xlnx,external-mux:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - none
> +      - single
> +      - dual
> +    default: none
> +    description: |
> +      External multiplexer configuration:
> +      - "none": No external multiplexer is used (default)

Drop "default", don't repeat constraints in free form text.

> +      - "single": External multiplexer mode is used with one multiplexer
> +      - "dual": External multiplexer mode is used with two multiplexers
> +        for simultaneous sampling
> +
> +  xlnx,external-mux-channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 16
> +    description: |
> +      Configures which pair of pins is used to sample data in external mux mode.
> +      Valid values for single external multiplexer mode are 0-16:
> +      0: VP/VN
> +      1-16: VAUXP[0-15]/VAUXN[0-15]
> +      Valid values for dual external multiplexer mode are 1-8:
> +      1-8: VAUXP[0-7]/VAUXN[0-7] - VAUXP[8-15]/VAUXN[8-15]
> +      This property needs to be present if the device is configured for
> +      external multiplexer mode (either single or dual).
> +
> +  xlnx,channels:
> +    $ref: '#/$defs/channels'
> +
> +allOf:

Missing ref since you use unevaluatedProperties...

> +  - if:
> +      required:
> +        - xlnx,external-mux
> +      properties:
> +        xlnx,external-mux:
> +          enum:
> +            - single
> +            - dual
> +    then:
> +      required:
> +        - xlnx,external-mux-channel
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

or you meant additionalProperties?

> +
> +$defs:

Why this is a def, not used directly? I see only one usage of this def.

> +  channels:
> +    type: object
> +    description: List of external channels that are connected to the ADC
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@([0-9]|1[0-6])$":
> +        type: object
> +        properties:
> +          reg:
> +            minimum: 0
> +            maximum: 16
> +            description: |
> +              Pair of pins the channel is connected to:
> +                0: VP/VN
> +                1-16: VAUXP[0-15]/VAUXN[0-15]
> +              Note each channel number should only be used at most once.
> +
> +          xlnx,bipolar:
> +            type: boolean
> +            description: If set, the channel is used in bipolar mode
> +
> +        required:
> +          - reg
> +
> +        unevaluatedProperties: false

Again, where is any $ref?

> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +    unevaluatedProperties: false

And here, please read writing schema and writing bindings docs.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    xadc@f8007100 {

adc

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

> +        compatible = "xlnx,zynq-xadc-1.00.a";
> +        reg = <0xf8007100 0x20>;
> +        interrupts = <0 7 4>;

Use proper defines.

> +        clocks = <&pcap_clk>;
> +
> +        xlnx,channels {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +            };
> +            channel@1 {
> +                reg = <1>;
> +            };
> +            channel@8 {
> +                reg = <8>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    xadc@43200000 {

One example is enough, I don't see differences here.

> +        compatible = "xlnx,axi-xadc-1.00.a";
> +        reg = <0x43200000 0x1000>;
> +        interrupts = <0 53 4>;
> +        clocks = <&fpga1_clk>;
> +
> +        xlnx,channels {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                xlnx,bipolar;
> +            };
> +        };
> +    };
> +
> +  - |
> +    adc@80000000 {

Again, one example is enough, unless you have multiple differences in
properties.

Best regards,
Krzysztof

