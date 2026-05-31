Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372D378D86;
	Sun, 31 May 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780238526; cv=none; b=omG5qmFovYINVK3SncDJpkWoor52u/zz8GSQXN1eT1dAVaasNar11xfbQTQjOkVrPqj4pD9Jhu7WKWzHTIQIrRChHI5kHhufD400yIXVb8AIqTilRJVgloTYnBktIGOGr/PU4mSQNIYO82NmZnZB2iZIb/GEdB7VrSR9/WvBU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780238526; c=relaxed/simple;
	bh=vYwmsB3solrgAjZFagRs/PFfFmR0JiokI2uYFfCrH9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISMkpNS4JkZE+PL0tgcZwoINdXq8G8GP1VM1n9ErvkKOP+BJUc+CMEn6YnUTkskHbu8Yvq38RKDx8OT8WjkDQlw1YRgAlCZWJoadydp7ql8C6utitflfBMyVY4+m8UadN0Ky6x0OyfuU1TwFw9wxHNTfoCAEhYWGanWpfML6RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZELJ+Nd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZELJ+Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E21F00893;
	Sun, 31 May 2026 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780238523;
	bh=AtTAM2HAUmCXOqjbQKB8kwAqCACUpxFRMewqyJMnhM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cZELJ+Nd5L64hQc1kZ47+NYMJL9CpMxN5mdWfEJkjiFVq/K8xoYQQBKxVyv5oQPic
	 lDFE8ba90Z8GqDV8grKzQntycNLrs36h2YYnqSdlBpgPYzensBU4BlOlELPIuUSTbM
	 Do43M3MSEoSDeiiJCjzab7aR6SX6Ykr5SxgObvc1Y7aop+VrelJ0Lh92kurB4Ai5Fl
	 UULDjpOe++rCR7eNhp4n8ZCDuo+e0tNqZGFe93Kj0/tdlq0liglIuJdnqPIXNE2mmq
	 na4DnOikyr7luD1X/9GtrMscRZsPl4sp2fCDxpFvPXWsG4u6U9B+5ggVZ8GtY9UZjk
	 MRn1icaJgx+Vw==
Date: Sun, 31 May 2026 15:41:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Narimani <tahanarimani3443@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org (open
 list:IIO SUBSYSTEM AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH v3 RFC v3] dt-bindings: iio: adc: add ad7816/7/8 digital
 temperature sensor / ADC
Message-ID: <20260531154153.2b77a407@jic23-huawei>
In-Reply-To: <20260530165917.55767-1-tahanarimani3443@gmail.com>
References: <20260530165917.55767-1-tahanarimani3443@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 16:59:15 +0000
Taha Narimani <tahanarimani3443@gmail.com> wrote:

> Document the Analog Devices AD7816, AD7817, and AD7818 digital
> temperature sensor and ADC bindings in YAML format.
> 
> Please note that the driver for this device is currently in drivers/staging.
> This patch is sent as an RFC to clean up and standardize the device tree
> bindings prior to any major driver refactoring.
> 
> While reviewing the AD7816/7/8 datasheet to correctly document the properties,
> it was noted that the current staging driver attempts to request a 'busy' GPIO
> for both AD7816 and AD7817. However, the AD7816 is an 8-pin device and does
> not possess a BUSY pin (only the 16-pin AD7817 has it). Therefore, in this
> binding, busy-gpios is strictly limited to adi,ad7817.
> 
> This resolves the checkpatch.pl warnings regarding undocumented DT
> compatible strings.
> 
> Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
> ---
Hi Taha,

There should be a change log here. Please reply to this thread with that for
this version.

Also, slow down.  For any patch allow at least 24 hours unless a maintainer
specifically requests it faster. For most stuff a week. That way any ongoing
discussion can finish and additional reviewers have time to take a look.


>  .../bindings/iio/adc/adi,ad7816.yaml          | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> new file mode 100644
> index 0000000..48563e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7816/7/8 digital temperature sensor / ADC
> +
> +maintainers:
> +  - Taha Narimani <tahanarimani3443@gmail.com>
> +
> +description: |
> +  Analog Devices AD7816, AD7817, and AD7818 10-Bit general purpose ADC and
> +  temperature sensor. The device communicates via an SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7816
> +      - adi,ad7817
> +      - adi,ad7818
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 12500000
> +
> +  vdd-supply:
> +    description: Main power supply.
> +
> +  vref-supply:
> +    description: |
> +      Optional external reference voltage supply. If not provided, the
> +      internal reference is used. Applicable for AD7816 and AD7817.
> +
> +  rdwr-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the RD/WR pin.
> +
> +  convert-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the CONVST (Convert Start) pin.
> +
> +  busy-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the BUSY pin. Only applicable for AD7817.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: OTI (Over Temperature Indicator) interrupt. Active low.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - rdwr-gpios
> +  - convert-gpios
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad7817
> +    then:
> +      required:
> +        - busy-gpios
> +    else:
> +      properties:
> +        busy-gpios: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad7818
> +    then:
> +      properties:
> +        vref-supply: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad7817";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            vdd-supply = <&vcc>;
> +            vref-supply = <&vref>;
> +            rdwr-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +            convert-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
> +            busy-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
> +            interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-parent = <&gpio>;
> +        };
> +    };

