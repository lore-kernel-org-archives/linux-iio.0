Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0A425CF2;
	Wed, 10 Jun 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107011; cv=none; b=n2zBVOMMWzcVirVw1EIpOVYaXQP2IxRxPmlLsGf2J/wnS4lAzs2WRRy5ac3y892h0zWGXmZuJ88pTeHjH2k+7Av22pWYukqQFrz0hC7BLuu3OL07+0uHn5JJF68N76+JNtPuBS3Ci6sUa8CrATxFAB/EOgVJmlvR/7ONpw3dUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107011; c=relaxed/simple;
	bh=ecYYcI7OGaxfESYz1T2yQys5OqEzE5OKWKiNJ/3bAPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rG46HTwJTHk3FdmxdcbUPv2I71nEeo9+ILGZhnPH0Q9uXmdipDzQX15CIv2Jl5s7uwViZ9jB3Kci1tEZAO2CmptO9dgPPT4x8b67EYpl7FdrT7IbdMY26tD6koOj7g4jkx6agGFkHdDpR11DOag4/k75uTzBJe+Wm+CPo1ZucJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0P4/f05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0P4/f05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F2F1F00893;
	Wed, 10 Jun 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781107010;
	bh=f+sYq0Yn5WJCXocg14S0rZGqlqPs0y/kVktvVs2h6e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h0P4/f05sAaF8GtI+LcKXPUTBtBc27SLV0aX/mrqaFNEtLi4zRyz0JJn76VEdONAC
	 mgoijmGE85Yfvd2/BbJCr6aBxj5+9S9slLhXJ2jznF+7HeLZxZs3XVGoEdG/JcJRLk
	 plSwsusOzJtcWNy8kUNe/OzQ42l6H+EnQIL7dTMZ/c27b7VCJUPOeYgjqo5Us+yOIH
	 lcdGZDt8VslFP9XwLjXizieklcF7IgMTYTInaheqXwLEC8dPzfLmoNA3+JTKfyXiw/
	 xQzyoi6MaOGaRoOntcoA47F8PfbOFd50nGesnHftRmlEFSso3TlFwEFMSJb3vgeyvj
	 cg42njMK7PrHA==
Date: Wed, 10 Jun 2026 16:56:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <20260610165640.411c1477@jic23-huawei>
In-Reply-To: <20260610110051.1228-1-shofiqtest@gmail.com>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 14:00:51 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Convert the STMicroelectronics LIS302DL/LIS3LV02D accelerometer device
> tree binding from plain text format to YAML schema format.
> 
> The binding covers two variants matched via their respective bus drivers:
> - SPI: st,lis302dl-spi (drivers/misc/lis3lv02d/lis3lv02d_spi.c)
> - I2C: st,lis3lv02d   (drivers/misc/lis3lv02d/lis3lv02d_i2c.c)
> 
> Document all vendor-specific properties read by the driver via
> of_property_read_*(), including click detection, IRQ routing, free-fall/
> wake-up engines, high-pass filtering, axis remapping, output data rate,
> and self-test limits.
> 
> Also correct the click threshold property names: the driver reads
> "st,click-threshold-{x,y,z}" but the old .txt documented them as
> "st,click-thresh-{x,y,z}".
> 
> Validated with: make dt_binding_check   DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

Hi.

So the conundrum here is whether we want to keep carrying this binding
as it dates to a previous era.

The driver never made it to IIO and is still in drivers/misc.
The majority of what is the text document should never have been
in DT in the first place. I'll guess this dates all the way back
to the wild west days before we had regular binding review.



> diff --git a/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> new file mode 100644
> index 000000000000..befc419f7f39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> @@ -0,0 +1,343 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/st,lis302dl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics LIS302DL/LIS3LV02D 3-Axis Accelerometer
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>

NACK for that.  I'll only maintain bindings that are both in a good
form and typically even then only ones I have written.


> +
> +description: |
> +  STMicroelectronics LIS302DL (SPI) and LIS3LV02D (I2C) 3-axis MEMS
> +  accelerometers. Supports click detection, free-fall/wake-up interrupts,
> +  high-pass filtering, axis remapping, and self-test functions.
> +
> +  Driver located at drivers/misc/lis3lv02d/.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,lis302dl-spi

That wants deprecating. We don't include the bus in a compatible
as it can be trivially derived from where the device is declared.

> +      - st,lis3lv02d
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  Vdd-supply:
> +    description: Main power supply regulator (I2C variant).

That is very odd. Power supply that is only there when using one bus?
If there was an alternative for SPI and some weird naming thing
maybe but it seems that if not on I2C the device works fine without
power :)

> +
> +  Vdd_IO-supply:
> +    description: I/O power supply regulator (I2C variant).
> +
> +  st,click-single-x:
> +    type: boolean
> +    description: Enable single-click detection on X axis.
Everything from this one down to...

> +
> +  st,click-double-x:
> +    type: boolean
> +    description: Enable double-click detection on X axis.
> +
> +  st,click-single-y:
> +    type: boolean
> +    description: Enable single-click detection on Y axis.
> +
> +  st,click-double-y:
> +    type: boolean
> +    description: Enable double-click detection on Y axis.
> +
> +  st,click-single-z:
> +    type: boolean
> +    description: Enable single-click detection on Z axis.
> +
> +  st,click-double-z:
> +    type: boolean
> +    description: Enable double-click detection on Z axis.
> +
> +  st,click-threshold-x:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Click detection threshold for X axis.
> +
> +  st,click-threshold-y:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Click detection threshold for Y axis.
> +
> +  st,click-threshold-z:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Click detection threshold for Z axis.
> +
> +  st,click-time-limit:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Click time limit, 0 to 127.5 ms in 0.5 ms steps.
> +
> +  st,click-latency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Click latency, 0 to 255 ms in 1 ms steps.
> +
> +  st,click-window:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Click window, 0 to 255 ms in 1 ms steps.

This one are userspace decisions.

> +
> +  st,irq1-disable:
> +    type: boolean
> +    description: Disable IRQ1 pin.
This one and the next lot 
> +
> +  st,irq1-ff-wu-1:
> +    type: boolean
> +    description: Route free-fall/wake-up 1 event to IRQ1 pin.
> +
> +  st,irq1-ff-wu-2:
> +    type: boolean
> +    description: Route free-fall/wake-up 2 event to IRQ1 pin.
> +
> +  st,irq1-data-ready:
> +    type: boolean
> +    description: Route data-ready event to IRQ1 pin.
> +
> +  st,irq1-click:
> +    type: boolean
> +    description: Route click event to IRQ1 pin.
> +
> +  st,irq2-disable:
> +    type: boolean
> +    description: Disable IRQ2 pin.
> +
> +  st,irq2-ff-wu-1:
> +    type: boolean
> +    description: Route free-fall/wake-up 1 event to IRQ2 pin.
> +
> +  st,irq2-ff-wu-2:
> +    type: boolean
> +    description: Route free-fall/wake-up 2 event to IRQ2 pin.
> +
> +  st,irq2-data-ready:
> +    type: boolean
> +    description: Route data-ready event to IRQ2 pin.
> +
> +  st,irq2-click:
> +    type: boolean
> +    description: Route click event to IRQ2 pin.
> +

are driver internal decisions. The dt-binding should tell
us which pins are wired, not make decisions on how the driver
uses them.

> +  st,irq-open-drain:
> +    type: boolean
> +    description: Configure IRQ lines as open-drain.
This one is fine but there is a generic binding for it IIRC.
> +
> +  st,irq-active-low:
> +    type: boolean
> +    description: Configure IRQ lines as active-low.
This one we normally do via the admittedly slightly dubious approach
of assuming the IRQ flags tell us this one.
> +
> +  st,wu-duration-1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Duration register for free-fall/wake-up interrupt 1.
Back to stuff that should be userspace controlled.
> +
> +  st,wu-duration-2:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Duration register for free-fall/wake-up interrupt 2.
> +
> +  st,wakeup-x-lo:
> +    type: boolean
> +    description: Enable wake-up on X axis lower threshold crossing.
> +
> +  st,wakeup-x-hi:
> +    type: boolean
> +    description: Enable wake-up on X axis upper threshold crossing.
> +
> +  st,wakeup-y-lo:
> +    type: boolean
> +    description: Enable wake-up on Y axis lower threshold crossing.
> +
> +  st,wakeup-y-hi:
> +    type: boolean
> +    description: Enable wake-up on Y axis upper threshold crossing.
> +
> +  st,wakeup-z-lo:
> +    type: boolean
> +    description: Enable wake-up on Z axis lower threshold crossing.
> +
> +  st,wakeup-z-hi:
> +    type: boolean
> +    description: Enable wake-up on Z axis upper threshold crossing.
> +
> +  st,wakeup-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Threshold for wake-up engine 1.
> +
> +  st,wakeup2-x-lo:
> +    type: boolean
> +    description: Enable wake-up engine 2 on X axis lower threshold.
> +
> +  st,wakeup2-x-hi:
> +    type: boolean
> +    description: Enable wake-up engine 2 on X axis upper threshold.
> +
> +  st,wakeup2-y-lo:
> +    type: boolean
> +    description: Enable wake-up engine 2 on Y axis lower threshold.
> +
> +  st,wakeup2-y-hi:
> +    type: boolean
> +    description: Enable wake-up engine 2 on Y axis upper threshold.
> +
> +  st,wakeup2-z-lo:
> +    type: boolean
> +    description: Enable wake-up engine 2 on Z axis lower threshold.
> +
> +  st,wakeup2-z-hi:
> +    type: boolean
> +    description: Enable wake-up engine 2 on Z axis upper threshold.
> +
> +  st,wakeup2-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Threshold for wake-up engine 2.
> +
> +  st,highpass-cutoff-hz:
> +    enum: [1, 2, 4, 8]
> +    description: High-pass filter cut-off frequency in Hz.
> +
> +  st,hipass1-disable:
> +    type: boolean
> +    description: Disable high-pass filter 1.
> +
> +  st,hipass2-disable:
> +    type: boolean
> +    description: Disable high-pass filter 2.

End of userspace stuff.

> +
> +  st,axis-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: |
> +      Map physical X axis. Negative values invert the direction.
> +      Valid range -3 to 3, excluding 0.
> +
> +  st,axis-y:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: |
> +      Map physical Y axis. Negative values invert the direction.
> +      Valid range -3 to 3, excluding 0.
> +
> +  st,axis-z:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: |
> +      Map physical Z axis. Negative values invert the direction.
> +      Valid range -3 to 3, excluding 0.

The 3 are fine but should be deprecated and replaced with mount-matrix
which makes it a userspace problem on the whole.  There is little
reason to ever have this stuff down in the driver.

> +

> +  st,default-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Default output data rate in Hz.
Nope. Driver should pick a value, then control from userspace.
No reason to have a default in DT.

> +
> +  st,min-limit-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Minimum self-test limit for X axis.
> +
> +  st,min-limit-y:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Minimum self-test limit for Y axis.
> +
> +  st,min-limit-z:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Minimum self-test limit for Z axis.
> +
> +  st,max-limit-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Maximum self-test limit for X axis.
> +
> +  st,max-limit-y:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Maximum self-test limit for Y axis.
> +
> +  st,max-limit-z:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Maximum self-test limit for Z axis.
Those are actually plausible things to have in DT. Maybe...
Depends a bit on what governs how they are set and whether
there are always 'good enough' numbers we can hard code in
the driver.


> +
> +required:
> +  - compatible
> +  - reg
Supplies etc.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - st,lis302dl-spi
> +    then:
> +      required:
> +        - spi-max-frequency
> +        - interrupts
Seems unlikely the other part doesn't have an interrupt or
that the device is useless with out one.  Note we don't care if the
driver requires it - that has nothing to do with the binding.

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - st,lis3lv02d
> +    then:
> +      required:
> +        - Vdd-supply
> +        - Vdd_IO-supply
as above. This smells like documenting the driver, not what the wiring is.
I would be very surprised if the other part doesn't have power.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        accelerometer@0 {
> +            compatible = "st,lis302dl-spi";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <104 IRQ_TYPE_EDGE_RISING>;
> +            st,click-single-x;
> +            st,click-single-y;
> +            st,click-single-z;
> +            st,click-threshold-x = <10>;
> +            st,click-threshold-y = <10>;
> +            st,click-threshold-z = <10>;
> +            st,irq1-click;
> +            st,irq2-click;
> +            st,wakeup-x-lo;
> +            st,wakeup-x-hi;
> +            st,wakeup-y-lo;
> +            st,wakeup-y-hi;
> +            st,wakeup-z-lo;
> +            st,wakeup-z-hi;
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        accelerometer@18 {
> +            compatible = "st,lis3lv02d";
> +            reg = <0x18>;
> +            Vdd-supply = <&lis3_reg>;
> +            Vdd_IO-supply = <&lis3_reg>;
> +            st,click-single-x;
> +            st,click-single-y;
> +            st,click-single-z;
> +            st,click-threshold-x = <10>;
> +            st,click-threshold-y = <10>;
> +            st,click-threshold-z = <10>;
> +            st,irq1-click;
> +            st,irq2-click;
> +            st,wakeup-x-lo;
> +            st,wakeup-x-hi;
> +            st,wakeup-y-lo;
> +            st,wakeup-y-hi;
> +            st,wakeup-z-lo;
> +            st,wakeup-z-hi;
> +            st,min-limit-x = <120>;
> +            st,min-limit-y = <120>;
> +            st,min-limit-z = <140>;
> +            st,max-limit-x = <550>;
> +            st,max-limit-y = <550>;
> +            st,max-limit-z = <750>;
> +        };
> +    };
> +...

