Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F22262BD;
	Sun,  3 May 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818052; cv=none; b=ni5QWbtE+E2s4nrq3V33xTpE5duS7fkkjYwgMW3ChxrypujTxE5o/l5rL6AVak1/UDTPVbvoIPFxUL5bSGpBGU7y8BVzRoNxRAcgZWEvz2YEftY6V/8s1xWhA+VhB+q1ZxHeqqVZ6fW8jFeZJkvg95sJZUkoOy0gcnL0EyIeJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818052; c=relaxed/simple;
	bh=+mXebF8l6fKv1MGAwtZ8JdrzhXYlLttE8YFT+3jZtoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhpuHTkvp5NS2uKobR829Y/dSnPP/93D5IjH0NZCqaTRnafsXwFzitfcTPvCK4KKDqC3nQEuoEpQ6gqOTURHzWX+X/Jaesb32/6UgiNGm9ksOeZZJHKd4BN5O7bjkES0uGnoDROR4aLAgaA89vAc589bZ26Xkt/rwwMTZOlM1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dado4+/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dado4+/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DDDC2BCB4;
	Sun,  3 May 2026 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777818051;
	bh=+mXebF8l6fKv1MGAwtZ8JdrzhXYlLttE8YFT+3jZtoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dado4+/jcatP/JdZDaWbSUggpSfgZtbLuOallLiYxavQ4vV6JeesR7kFirJ8XogPv
	 bQKqOCTzGsr4+mLJBQXJVMsza71t12zEaUrVh2/b07Gh4245BhVPx1cXrSynludnI9
	 1mAXwmxbe31283qmQjOStXbyro/hD1+ItYewZPcG50Ao1J0Jzq4XWwLjgh+ln2vVG5
	 BvNwiwul/sYaWD5X/fZ+SMD8fCC3Lft3EwX7q7G+LB9wu2zzZJtybXevNoSQBL/cRI
	 e/yJOmxB+UZpO9ZpAJCAhu+CUn0yt99vQAaOqu/oWbZ2IoRQqElbEVVJ9Gkn+A0Xmc
	 sVNaCltCiv5fA==
Date: Sun, 3 May 2026 16:20:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org, 
	dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com, 
	erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon
 binding
Message-ID: <20260503-rebel-sassy-weasel-ed26ee@quoll>
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-2-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502111951.538488-2-salih.erim@amd.com>

On Sat, May 02, 2026 at 12:19:47PM +0100, Salih Erim wrote:
> Add devicetree binding for the AMD/Xilinx Versal System Monitor (SysMon).
> 
> The Versal SysMon is the successor to the Zynq UltraScale+ AMS block,
> providing on-chip voltage and temperature monitoring. The hardware
> supports up to 160 supply voltage measurement points and up to 64
> temperature satellites distributed across the SoC, with configurable
> threshold alarms and oversampling. The device can be accessed via
> memory-mapped I/O or via an I2C interface.
> 
> Supply and temperature channels are described as child nodes under
> container nodes, referencing the standard adc.yaml binding for
> channel properties.
> 
> Co-developed-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> ---
> Changes in v2:
>   - Restructured to container nodes (supply-channels, temperature-channels)
>     with channel@N children referencing adc.yaml
>   - Added xlnx,versal-sysmon-i2c compatible
>   - Descriptions rewritten to describe hardware only
>   - Example simplified to #address-cells = <1>
>   - Interrupt example uses GIC_SPI/IRQ_TYPE_LEVEL_HIGH constants
>   - Commit description explains hardware context instead of schema layout
>   - reg required for both MMIO and I2C, interrupts optional
>   - Hex unit-addresses (channel@a not channel@10) per DTSpec
>   - patternProperties regex updated to accept hex digits [0-9a-f]
>   - Example trimmed to minimal variants (one basic + one bipolar supply,
>     one AIE temperature channel)
>  .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
> new file mode 100644
> index 00000000000..cdd8706fc02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
> @@ -0,0 +1,172 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/xlnx,versal-sysmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD/Xilinx Versal System Monitor
> +
> +maintainers:
> +  - Salih Erim <salih.erim@amd.com>
> +
> +description:
> +  The AMD/Xilinx Versal System Monitor (SysMon) is the successor to the
> +  Zynq UltraScale+ AMS block. It provides on-chip voltage and temperature
> +  monitoring with up to 160 supply voltage measurement points and up to
> +  64 temperature satellites distributed across the SoC. The hardware
> +  supports configurable threshold alarms and oversampling. The device
> +  can be accessed via memory-mapped I/O or via an I2C interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,versal-sysmon
> +      - xlnx,versal-sysmon-i2c

This is explicitly mentioned in writing bindings. One device, one
compatible (not two, not three, not four compatibles).

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  supply-channels:
> +    type: object
> +    description:
> +      Container for supply voltage measurement channels.

voltage, not supply. Supply is the source of energy coming to this
device. But are you measuring that source?

> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@([0-9a-f]|[1-9][0-9a-f])$":

Keep consistent quotes, either ' or "

> +        $ref: adc.yaml
> +
> +        description:
> +          Measures a supply rail voltage. The register index and rail
> +          name are assigned by the hardware design tool (Vivado).
> +
> +        properties:
> +          reg:
> +            minimum: 0
> +            maximum: 159
> +            description:
> +              Supply measurement register index assigned by the hardware
> +              design tool.
> +
> +          label:
> +            description:
> +              Name of the supply rail being monitored.

Drop property, it's already in adc.yaml.

> +
> +          bipolar: true

Drop

> +
> +        required:
> +          - reg
> +          - label
> +
> +        unevaluatedProperties: false
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +    additionalProperties: false
> +
> +  temperature-channels:
> +    type: object
> +    description:
> +      Container for temperature satellite measurement channels.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@([1-9a-f]|[1-3][0-9a-f]|40)$":
> +        $ref: adc.yaml
> +
> +        description:
> +          Reads a temperature satellite sensor. Each satellite monitors
> +          a specific region of the SoC die.
> +
> +        properties:
> +          reg:
> +            minimum: 1
> +            maximum: 64
> +            description:
> +              Temperature satellite number (1-based hardware index).
> +
> +          label:
> +            description:
> +              Name identifying this temperature satellite.

Drop property

> +
> +          xlnx,aie-temp:
> +            type: boolean
> +            description:
> +              Indicates this satellite monitors an AI Engine tile.

What for? What is on the other side of the channel is not really
relevant to this device, but rather to that other side (consumer).

> +
> +        required:
> +          - reg
> +          - label
> +
> +        unevaluatedProperties: false
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg

Best regards,
Krzysztof

