Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B85313277;
	Sat, 30 May 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153108; cv=none; b=lWA28d7kqgMsIOSM1oP3ujhw1gRPxijSCDdM2jVyOdF0bDdsrinlpM1sFdmAJyyRnCgjoG4O1SkfpMYW4ImsxacGr2PHSzGa+ErJELgalyovvEZk3zApsJmRAZWJLnl5FvAB7Mu4o7jxNSM9fEAi813uLgL/05jQRMqJf8fRcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153108; c=relaxed/simple;
	bh=a4+KQja6htIDXYLfA2BgFq5/aaJC/Cnpvk0kRZkR6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+1GbmYo4rPBT3xuSv51tOcRCm0tVuG/cu2vJ4w6PacbuJZfLrLe3ZerMiqRFVcQvAkXBP3+/0sKtbvEGfhJkuxJcfV5AdRpVT0Dv26gS0Kvw9kcDDXjEcLbg1tgtIStQ+LjyTROiHyIZhzAKBHa5+57Qkr0WYfZfzIWwlrQR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPstMd+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPstMd+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD531F0089C;
	Sat, 30 May 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780153106;
	bh=4MPClRdjPOFGm5/B0RDHvccClpe5HdvjZSPy5CO5YY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cPstMd+QN3T3NqDIDKz4qq/8nNMF8POI5XSwclZsXKknZM/R1CuoK+1QH3G0ZlNIk
	 zIgbVSH0P5OKtpr4OqMdyFfGtarW1m7aQ/5UV3Oi+v6qPEB1yk2nQeK3raHIO3GjU2
	 ZEVKZOYkwgIyy3W9PjrDkXp0a+xQj5a6XnqvF9lfCBRGLMrGMwSthcJJP4bAQ7/RYC
	 vGSREHmWVrvXEb3cG8LzRlQH4bZP/qBy7XnNSOcAr4PCtgyynIieEGjOhfdgwjBjo0
	 0O103n+ZHid+paNzUn5l24v4Qygc9wvMk1eq6fd5S+nsIkysI2Us5IXNCJXrDEP24f
	 GIkfVKjTlB5Wg==
Date: Sat, 30 May 2026 15:58:17 +0100
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
Subject: Re: [PATCH] dt-bindings: iio: adc: Add schema for AD7816/7/8
 digital temperature sensor
Message-ID: <20260530155817.6169e5e2@jic23-huawei>
In-Reply-To: <20260530135302.54688-1-tahanarimani3443@gmail.com>
References: <20260530133126.54460-1-tahanarimani3443@gmail.com>
	<20260530135302.54688-1-tahanarimani3443@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 13:53:00 +0000
Taha Narimani <tahanarimani3443@gmail.com> wrote:

> Document the Analog Devices AD7816, AD7817, and AD7818 digital
> temperature sensor and ADC bindings in YAML format.
> 
> This resolves the checkpatch.pl warnings regarding undocumented DT
> compatible strings for 'adi,ad7816', 'adi,ad7817', and 'adi,ad7818'.
> 
> Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
Hi Taha,

Please read the documentation for submitting patches. Also look at similar
dt-binding patches for title style

[PATCH v2] dt-bindings: iio: adc: add ad7816/7/8 digital temperature sensor / ADC.

The ADC bit is to make the point this is a general purpose ADC rather than simply
temp monitoring.

Also, never send a new version in with reply-to set to the previous version.
That just makes for very confusing emails. Even more so when they both have
the same email title!  New thread for every version.

The driver is in staging currently.  Normally we only submit a dt-binding as part
of the patch series that includes the patch moving the driver out of staging.

I don't mind reviewing it anyway, but for now I'm not considering this for
merging.  Various comments inline.  If you do send a new version make sure
the patch description calls out that the driver is in staging and not yet
ready to move out.  Maybe better to keep this as an RFC given that constraint.
The only exception we might make is if another project (i.e. not the kernel)
needs the dt-binding.

Jonathan

> 
> ---
> v2: Added conditional schema constraints for busy-gpios as suggested by Sashiko AI.
> ---
>  .../bindings/iio/adc/adi,ad7816.yaml          | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> new file mode 100644
> index 0000000..74008c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7816/7/8 digital temperature sensor and ADC
> +
> +maintainers:
> +  - Taha Narimani <tahanarimani3443@gmail.com>
> +
> +description: |
> +  Analog Devices AD7816, AD7817, and AD7818 10-Bit temperature sensor and ADC.
> +  The device communicates via an SPI interface.
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
> +  spi-max-frequency: true
We normally provide a maximum for this based on what this chip supports.
Obviously the board or the spi controller might have lower limits but
we can at least ensure we don't set it too high for the device.

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
> +    description: GPIO connected to the BUSY pin.

Interestingly the datasheet for the ad7817 suggests using this as an interrupt.
The driver seems to currently be busy looping on this which is a rather ugly
solution and likely something we would want to look at before moving the
driver out of staging.  This is an example of why we don't tend to do bindings
ahead of that move!

> +
> +  interrupts:
> +    maxItems: 1
> +    description: OTI (Over Temperature Indicator) interrupt.
> +

Power supplies are missing.  They should be required if they need to be
there for the device to function. It doesn't matter if the driver actually
uses them or not as the binding should still be complete.  Note that some
of the parts definitely have an internal reference option, so vref-supply
will be optional.  The lack of it being provided means use the internal
reference instead.

Also looks like at least some parts have an !OTI pin which should be an
interrupt.


> +required:
> +  - compatible
> +  - reg
> +  - rdwr-gpios
> +  - convert-gpios
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7816
> +              - adi,ad7817
> +    then:
> +      required:
> +        - busy-gpios
> +    else:
> +      properties:
> +        busy-gpios: false

Looks like you'll need to handle vref-supply in a similar fashion.

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
> +            compatible = "adi,ad7816";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            rdwr-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +            convert-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
> +            busy-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
> +            interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-parent = <&gpio>;

You don't have any interrupts in the binding. So this shouldn't
pass testing.

> +        };
> +    };

