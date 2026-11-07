Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079586;
	b=1ZWsKjv7EsQ4yKlDJ1T+am3x+amml3cGdd4yvEN22N/Pyt/KxEci0LI/CSmRG9gHgTGI
	 hYWaHt0e1Y4m9nir15invz1UJilvNVYR6K7JrGZlioVdaKnmVsLOyF5iqLQ+R7ZvyoXi0
	 uYT4jUAFoo+uc0DAnvXOjZ/ucmTanhqfpMrBRqPbJQ+Laa6w1iqfTAmfMYQHCB+tTpBnH
	 aLVK933w9BpYNC6fq3M+/O4E1zd1z8sekG+nfe5QtJF2rybiWyn91vYZ/xd6s0atI8sn+
	 0yIbyTHaucNUeCuK79sUHNLAvWJgLxn4UgHc5uJPbxTWSDfd4yIrNUUfD8J412/8pvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3HNu1KANaG+U8kTSPLyfgpYzK/AYsfGQ9PW6Idr9ttQ=;
	b=3J5u+jACJV/kAn0M+Cd4HuPbEezyiRa76hZzc3B+fJ9ZEyROGKiQinHe+epleIUidksK
	 zIreXzKs19pv5C5uJJodyK7O7A/Tv6bydb4SidMhnF8syuF63zYccPsY7hJc+G9SxSzNO
	 b1e87mRIvKWYJpDd3xxgAvoBL67DPj6PKQSSUGbqjvs1DdJs/JIBzyUuX4Vkiqd9LZc6O
	 6oG8XQit7pFd57R9r4eFeSunXQruR2HzXeIcdi6yKIYgRlXg7YfWxu63v84AIeoca2LN3
	 VXGuL5TKtGrV+OVteEZ1obpDVWcP02unr/dDES3a5wv0SMs2oVKrWDD3WEUAC+kLisw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgXkTM7u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB391606A326;
	Sat,  7 Nov 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgXkTM7u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E341F0089F;
	Sat,  7 Nov 2026 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079585;
	bh=3HNu1KANaG+U8kTSPLyfgpYzK/AYsfGQ9PW6Idr9ttQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WgXkTM7u6dTBcGz/vnQ4v/VhNxTWi7yJ9hWG0RAm0INiQZwNTFNany0uZXGs0Kndu
	 6DPX2ffdGvnfXLDp7mymglHw+BrHwmvUMDF3XX74iQbkwc+0UdsrbfDkQ3zuRfw32J
	 wB1/pQGCieiqQ2aLuxW65W2vKHKuYyWH1j1CTbjOOnuQt8adaT69dQSfjr8fCVE8J6
	 Sejzo7rt5p1U+XwsDl/l93oh+SHpSyEDvSmJMpb3jfGLfVDCH/TwOAcTnW58rhCR/l
	 CnPrrJ00PV3G7U1n00/e/4bIb3xzq7REIMl+aA9eayN0KWmtjm8yDHZu1UPOoumlGl
	 eY6v3z6VDSzNQ==
Date: Sat, 7 Nov 2026 19:26:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: <lars@metafoo.de>, <sai.krishna.potthuri@amd.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <michal.simek@amd.com>, <pramod.nexgen@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH v5] dt-bindings: iio: adc: Convert xilinx-xadc bindings
 to YAML schema
Message-ID: <20261107192618.6814da6a@jic23-hlaptop>
In-Reply-To: <20261107134955.1423727-1-dileepkumar.nagavarapu@amd.com>
References: <20261107134955.1423727-1-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 19:19:55 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> From: Pramod Maurya <pramod.nexgen@gmail.com>
> 
> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
> from the legacy plain-text format to a YAML.
> 
> The new binding covers the same hardware and compatible strings:
>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardblock)
>   - xlnx,axi-xadc-1.00.a  (AXI softblock)
>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
> 
> The xlnx,channels subnode retains its legacy name (including the comma)
> for backwards compatibility with existing device trees.
> 
> Move xlnx,channels under properties, as dt-schema now allows node names
> containing a comma for long-established bindings.Constrain the reg

Space after .

> property of the channel subnodes to the valid channel range of 0 to
> 16 with minimum and maximum.
> 
> Drop the redundant "type: boolean" from xlnx,bipolar, since its $ref to
> the flag type already implies it.
> 
> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> Co-developed-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>

Hi Dileep,

Given the legacy nature of the binding this looks fine to me.
I noted a few things on how I think it would look today, but not
expecting any changes to this doc based on those.

I do want an Ack from Lars-Peter Clausen though if we are going
to more formally list him as maintainer.  No idea if he has time
to keep an eye on this one!

Jonathan

> ---
>  .../bindings/iio/adc/xilinx-xadc.txt          | 141 ---------------
>  .../bindings/iio/adc/xlnx,xadc.yaml           | 165 ++++++++++++++++++
>  MAINTAINERS                                   |   9 +
>  3 files changed, 174 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> deleted file mode 100644
> index f42e18078376..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> +++ /dev/null

> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> new file mode 100644
> index 000000000000..2cbc3b82a26f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> @@ -0,0 +1,165 @@
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

As below. Need an Ack from Lars-Peter.

> +  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +  - Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> +
> +description: |
> +  The Xilinx XADC is an ADC found in the Series 7 FPGAs. It has a DRP
> +  (Dynamic Reconfiguration Port) interface for communication. Two different
> +  frontends for the DRP interface are supported:
> +
> +    - ZYNQ hardblock: available only on the ZYNQ family as a hardblock in
> +      the SoC portion of the ZYNQ device.
> +    - AXI softblock: available on all Series 7 platforms as a softblock
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
> +    maxItems: 1
> +
> +  xlnx,external-mux:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Selects the external multiplexer mode. 
> +    enum:
> +      - none
> +      - single
> +      - dual
> +    default: none
> +
> +  xlnx,external-mux-channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configures which pair of pins is used to sample data in external
> +      multiplexer mode. Required when xlnx,external-mux is "single" or
> +      "dual".

I guess this is a legacy binding, but if we were doing this today we'd
put an explicit mux consumer in front of it that makes use of the
channel via the io-channels consumer mapping stuff.
My guess is that stuff all came in well after this driver!

This is also rather inflexible as why can't we have a 4 
channel mux that is therefore in front of 4 ADC channels?

> +
> +      Valid values for single external multiplexer mode:
> +        0: VP/VN
> +        1: VAUXP[0]/VAUXN[0]
> +        2: VAUXP[1]/VAUXN[1]
> +        ...
> +        16: VAUXP[15]/VAUXN[15]
> +
> +      Valid values for dual external multiplexer mode:
> +        1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
> +        2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
> +        ...
> +        8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
> +    minimum: 0
> +    maximum: 16
> +
> +  xlnx,channels:
> +    type: object
> +    description:
> +      List of external channels connected to the ADC. If this node is
> +      absent, no external channels are assumed to be connected.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@([0-9a-f]|10)$":
> +        type: object
> +        description:
> +          Represents an external channel connected to the ADC.
> +
> +        properties:
> +          reg:
> +            description: |
> +              Pair of pins the channel is connected to.
> +                0: VP/VN
> +                1: VAUXP[0]/VAUXN[0]
> +                2: VAUXP[1]/VAUXN[1]
> +                ...
> +                16: VAUXP[15]/VAUXN[15]

Another legacy one which is fine.  If we were doing this today
we'd use diff-channels rather than reg to specify this I think.

> +            minimum: 0
> +            maximum: 16
> +
> +          xlnx,bipolar:
> +            $ref: /schemas/types.yaml#/definitions/flag
> +            description:
> +              If set, the channel is used in bipolar mode.
> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        xlnx,external-mux:
> +          enum:
> +            - single
> +            - dual
> +      required:
> +        - xlnx,external-mux
> +    then:
> +      required:
> +        - xlnx,external-mux-channel
> +
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
> +    xadc@43200000 {
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
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 745d8d0169b2..2d7e9c9ca659 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29996,6 +29996,15 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
>  F:	drivers/watchdog/of_xilinx_wdt.c
>  F:	drivers/watchdog/xilinx_wwdt.c
>  
> +XILINX XADC DRIVER
> +M:	Lars-Peter Clausen <lars@metafoo.de>

I'll need an Ack from Lars-Peter for that.   Whilst sometimes about
Lars isn't anywhere near as active as he once was.

> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +M:	Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
> +F:	drivers/iio/adc/xilinx-xadc*


