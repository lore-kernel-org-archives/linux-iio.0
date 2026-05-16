Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2761405C47;
	Sat, 16 May 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930342; cv=none; b=d0zZ78/2r5oU3v3rgyk4WUqsQQDp6JYfbxowJ5XFTSGIVZgWLCnfJuRh7r1hBAtgkv8mwlyA1c7cn/UoV+Ax0Ufj5tIXolcOlZlW3VZtTRG3+sys1z5u8KOX9WzRDhogOUC0goFrkKDwPEolEodBE7gNgK4BdmDtnNfUrh6JUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930342; c=relaxed/simple;
	bh=CCyPS1sFsV3t/psx89EZtLnUeGZsTL1rAwJcubKYQHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwgHWRJemqhKbDJhpn0CH1hVSINxRA/x4sSD9UF7Ii0sRPjqW1+uDzpHJjvJ5YCDn/WY1IlgFeth+UQ32yHD9fMfdoImgN0yXlHG/YAidINVwRojorN9Rh4AM1Vw55VSDD0DtXu6YTlePieJaH6ERFrYLNSu3erKnwmYSVIj1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkGgTuOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkGgTuOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3135DC19425;
	Sat, 16 May 2026 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778930342;
	bh=CCyPS1sFsV3t/psx89EZtLnUeGZsTL1rAwJcubKYQHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkGgTuOu8e4UXKHOJjWMk1oF+czf85+DhTu5vfhZbwRyRiUOAhM4ubl+SoLpNA5aL
	 wbWssoGPPkMlfp7Wl11CK2AFiLB0o871gygaeIjrfQa7ek4z0aeHGde2KV7kl6iPW2
	 GHYoyeYv87FRHJa1+AOrw66FmqklqYmnDZhZQAu3P1DfZleY8bUhM+Ul1KnRgndQSp
	 SQIF588BtBaKnrT9QI75TC8G/ieFEOfAglxQ9vpybYDOfnIfwAckB6Q15/a6voeN19
	 PadtrDNoPIPlmzYFzl9sMpJbPjHcZJJfWtqbuFKychFFiijvvssAhZC2ukn+ij/vSr
	 nt+fptkr4QcdA==
Date: Sat, 16 May 2026 12:18:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pramod Maurya <pramod.nexgen@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Salih Erim <salih.erim@amd.com>,
 <michal.simek@amd.com>, <conall.ogriofa@amd.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: Convert xilinx-xadc
 bindings to YAML schema
Message-ID: <20260516121856.12b8880f@jic23-huawei>
In-Reply-To: <20260515075736.172172-2-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
	<20260515075736.172172-1-pramod.nexgen@gmail.com>
	<20260515075736.172172-2-pramod.nexgen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 03:57:34 -0400
Pramod Maurya <pramod.nexgen@gmail.com> wrote:

> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
> from the legacy plain-text format to a YAML schema, enabling automated
> validation with dt-schema.
> 
> The new binding covers the same hardware and compatible strings:
>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
> 
> The xlnx,channels subnode retains its legacy name (including the comma)
> for backwards compatibility with existing device trees.
> 
> Place xlnx,channels under properties: now that dt-schema PR#195 allows
> comma-containing nodenames for long-established bindings. Fix reg
> constraints inside channel subnodes to use maxItems and an items block
> rather than bare minimum/maximum keywords which are silently ignored on
> array types. Remove the redundant type: boolean from xlnx,bipolar since
> the $ref to /schemas/types.yaml#/definitions/flag already implies it.
> 
> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>

Various folk +CC, questions for them inline!

A few comments from me.  Whilst the original was 'example rich' I don't
see a need for more than one in the yaml.

> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> new file mode 100644
> index 000000000000..06a0ce498352
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> @@ -0,0 +1,210 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx XADC and UltraScale System Monitor
> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>

I'd like a confirmation tag from Lars that he is still happy maintaining this.
If not Pramod, would you be willing to step up?

Maybe one of the AMD/Xilinx folk?

Please +CC Salih, Michal and Conall on future versions..
(done on this reply).

AMD folk, given you currently have a series (including bindings) for the newer
similar IP, would someone mind reviewing this?


> +
> +description: |
> +  The Xilinx XADC is an ADC found in the Series 7 FPGAs. It has a DRP
> +  (Dynamic Reconfiguration Port) interface for communication. Two different
> +  frontends for the DRP interface are supported:
> +
> +    - ZYNQ hardmacro: available only on the ZYNQ family as a hardmacro in
> +      the SoC portion of the ZYNQ device.
> +    - AXI softmacro: available on all Series 7 platforms as a softmacro
> +      with an AXI interface (PG019).
> +
> +  The Xilinx System Monitor is an ADC found in UltraScale and UltraScale+
> +  FPGAs. It is accessed through the Xilinx System Management Wizard IP core
> +  via an AXI interface in the FPGA fabric.
> +
> +  The xlnx,channels subnode name contains a comma as part of the legacy
> +  device tree binding that has been in use for over a decade. This name is
> +  retained for backwards compatibility with existing device trees.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,zynq-xadc-1.00.a
> +      - xlnx,axi-xadc-1.00.a
> +      - xlnx,system-management-wiz-1.3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |

We don't need the formatting to be preserved for the following so you can
drop the | I think.

> +      When using the ZYNQ this must be the ZYNQ PCAP clock.
> +      When using the axi-xadc or system-management-wiz this must be
> +      the clock that provides the clock to the AXI bus interface.
> +    maxItems: 1
> +
> +  xlnx,external-mux:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |

Similar on dropping the |

Maybe worth adding default: for this. then you can drop the bit about
if omitted.

> +      Selects the external multiplexer mode. If omitted, no external
> +      multiplexer is used.
> +    enum:
> +      - none
> +      - single
> +      - dual
...

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* ZYNQ hardmacro example */

Not sure it helps much to know where it was cut and
paste from. We are interesting in showing how the binding works.
That doesn't necessarily need to correspond to a real combination.

> +    adc@f8007100 {
> +        compatible = "xlnx,zynq-xadc-1.00.a";
> +        reg = <0xf8007100 0x20>;
> +        interrupts = <0 7 4>;
> +        interrupt-parent = <&gic>;
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
> +    /* AXI softmacro example */
> +    adc@43200000 {
> +        compatible = "xlnx,axi-xadc-1.00.a";
> +        reg = <0x43200000 0x1000>;
> +        interrupts = <0 53 4>;
> +        interrupt-parent = <&gic>;
> +        clocks = <&fpga1_clk>;
> +
> +        xlnx,channels {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                xlnx,bipolar;

If this property were used for one of the channels in the previous
example, then I think this example could be dropped.

> +            };
> +        };
> +    };
> +
> +  - |
> +    /* UltraScale System Management Wizard example */
> +    adc@80000000 {

Nothing new in this one. I'd drop it.

> +        compatible = "xlnx,system-management-wiz-1.3";
> +        reg = <0x80000000 0x1000>;
> +        interrupts = <0 81 4>;
> +        interrupt-parent = <&gic>;
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2040011a386..58d35c17704d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29266,6 +29266,13 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
>  F:	drivers/watchdog/of_xilinx_wdt.c
>  F:	drivers/watchdog/xilinx_wwdt.c
>  
> +XILINX XADC DRIVER
> +M:	Lars-Peter Clausen <lars@metafoo.de>

Likewise, this needs an ack from Lars or another volunteer.

> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> +F:	drivers/iio/adc/xilinx-xadc*
> +
>  XILINX XDMA DRIVER
>  M:	Lizhi Hou <lizhi.hou@amd.com>
>  M:	Brian Xu <brian.xu@amd.com>

