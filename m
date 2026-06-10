Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E31374E5C;
	Wed, 10 Jun 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119237; cv=none; b=rmaOt8YLTkOhKrVOa6XpMxAr8r+bPBVFaxlw6Gacv4stiofOaveO+s2yR1qQUoVgCOMPkeoE2K+aKw5q0AR2og18dcCKC+88hqPApRAotAsCbEdKC+onwMOKur/b4qgCljVN/5qCG0KhQdV3XVC6fE6aMuLkDi/7mm+wGua9qDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119237; c=relaxed/simple;
	bh=V/rVHqyHj59fjbu3pAvvcbKAI6fqgkcTeqSzpFGmSwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfqUalqMZsBAbtlc5sYxJuC1vCHsx9Tbg08AV6S5z5Wx0nHFPmL9Ue1rMwQvn++SoA9qtSqj1rnFrwwJJnReKt/1LZBl6IRL818Qbpcjhi6fPNBinI7L1wfAt+V4EBjpWV7tlf9baXZGCSgXxcMPQn60pakymxQ9+kzf6pIV8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHIhkl6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHIhkl6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281BA1F00898;
	Wed, 10 Jun 2026 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781119235;
	bh=8iYGIBnTbxARX77e4J1Cy61Z+zY2So7vubTjTfnYQ8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SHIhkl6TIxAsQju2tkz4DtMHTRySxTuK+LbKTvcae/X8Xr7nY4PtuBA5heZKN79V/
	 2NeNkyrdqhxbU8LBnhUf/ZUqC3kItb9t7zfCZ3jaRJ69bSUkbJVz0Por6IIZssJAtW
	 G2yTjPny2KRjRLQzy6YWAk7q8AEpYpQbz5mG51dHFl+QaXHXC3CMczNayYR+Vlp7zr
	 /8KsEevb5suk8OpcL+huEuHsp+dZPd6uoHDESuwfUQ8htzNYuamFgp3cmb5xYBYgmc
	 N63PJGjqEnG+7887NIFgO4MDatWaeudfurIzdVaAF/TXyZQqcjBxVWgXnFjY2LhZOf
	 xDsYXn8F2+Rcw==
Date: Wed, 10 Jun 2026 14:20:34 -0500
From: Rob Herring <robh@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <20260610192034.GA626285-robh@kernel.org>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610110051.1228-1-shofiqtest@gmail.com>

On Wed, Jun 10, 2026 at 02:00:51PM +0300, Md Shofiqul Islam wrote:
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
> ---
>  .../devicetree/bindings/iio/accel/lis302.txt  | 119 ------
>  .../bindings/iio/accel/st,lis302dl.yaml       | 343 ++++++++++++++++++
>  2 files changed, 343 insertions(+), 119 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/lis302.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/lis302.txt b/Documentation/devicetree/bindings/iio/accel/lis302.txt
> deleted file mode 100644
> index 457539647f36..000000000000
> --- a/Documentation/devicetree/bindings/iio/accel/lis302.txt
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -LIS302 accelerometer devicetree bindings
> -
> -This device is matched via its bus drivers, and has a number of properties
> -that apply in on the generic device (independent from the bus).
> -
> -
> -Required properties for the SPI bindings:
> - - compatible: 		should be set to "st,lis3lv02d-spi"
> - - reg:			the chipselect index
> - - spi-max-frequency:	maximal bus speed, should be set to 1000000 unless
> -			constrained by external circuitry
> - - interrupts:		the interrupt generated by the device
> -
> -Required properties for the I2C bindings:
> - - compatible:		should be set to "st,lis3lv02d"
> - - reg:			i2c slave address
> - - Vdd-supply:		The input supply for Vdd
> - - Vdd_IO-supply:	The input supply for Vdd_IO
> -
> -
> -Optional properties for all bus drivers:
> -
> - - st,click-single-{x,y,z}:	if present, tells the device to issue an
> -				interrupt on single click events on the
> -				x/y/z axis.
> - - st,click-double-{x,y,z}:	if present, tells the device to issue an
> -				interrupt on double click events on the
> -				x/y/z axis.
> - - st,click-thresh-{x,y,z}:	set the x/y/z axis threshold
> - - st,click-click-time-limit:	click time limit, from 0 to 127.5msec
> -				with step of 0.5 msec
> - - st,click-latency:		click latency, from 0 to 255 msec with
> -				step of 1 msec.
> - - st,click-window:		click window, from 0 to 255 msec with
> -				step of 1 msec.
> - - st,irq{1,2}-disable:		disable IRQ 1/2
> - - st,irq{1,2}-ff-wu-1:		raise IRQ 1/2 on FF_WU_1 condition
> - - st,irq{1,2}-ff-wu-2:		raise IRQ 1/2 on FF_WU_2 condition
> - - st,irq{1,2}-data-ready:	raise IRQ 1/2 on data ready condition
> - - st,irq{1,2}-click:		raise IRQ 1/2 on click condition
> - - st,irq-open-drain:		consider IRQ lines open-drain
> - - st,irq-active-low:		make IRQ lines active low
> - - st,wu-duration-1:		duration register for Free-Fall/Wake-Up
> -				interrupt 1
> - - st,wu-duration-2:		duration register for Free-Fall/Wake-Up
> -				interrupt 2
> - - st,wakeup-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
> -				upper/lower limit
> - - st,wakeup-threshold:		set wakeup threshold
> - - st,wakeup2-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
> -				upper/lower limit for second wakeup
> -				engine.
> - - st,wakeup2-threshold:	set wakeup threshold for second wakeup
> -				engine.
> - - st,highpass-cutoff-hz=:	1, 2, 4 or 8 for 1Hz, 2Hz, 4Hz or 8Hz of
> -				highpass cut-off frequency
> - - st,hipass{1,2}-disable:	disable highpass 1/2.
> - - st,default-rate=:		set the default rate
> - - st,axis-{x,y,z}=:		set the axis to map to the three coordinates.
> -				Negative values can be used for inverted axis.
> - - st,{min,max}-limit-{x,y,z}	set the min/max limits for x/y/z axis
> -				(used by self-test)
> -
> -
> -Example for a SPI device node:
> -
> -	accelerometer@0 {
> -		compatible = "st,lis302dl-spi";
> -		reg = <0>;
> -		spi-max-frequency = <1000000>;
> -		interrupt-parent = <&gpio>;
> -		interrupts = <104 0>;
> -
> -		st,click-single-x;
> -		st,click-single-y;
> -		st,click-single-z;
> -		st,click-thresh-x = <10>;
> -		st,click-thresh-y = <10>;
> -		st,click-thresh-z = <10>;
> -		st,irq1-click;
> -		st,irq2-click;
> -		st,wakeup-x-lo;
> -		st,wakeup-x-hi;
> -		st,wakeup-y-lo;
> -		st,wakeup-y-hi;
> -		st,wakeup-z-lo;
> -		st,wakeup-z-hi;
> -	};
> -
> -Example for a I2C device node:
> -
> -	lis331dlh: accelerometer@18 {
> -		compatible = "st,lis331dlh", "st,lis3lv02d";
> -		reg = <0x18>;
> -		Vdd-supply = <&lis3_reg>;
> -		Vdd_IO-supply = <&lis3_reg>;
> -
> -		st,click-single-x;
> -		st,click-single-y;
> -		st,click-single-z;
> -		st,click-thresh-x = <10>;
> -		st,click-thresh-y = <10>;
> -		st,click-thresh-z = <10>;
> -		st,irq1-click;
> -		st,irq2-click;
> -		st,wakeup-x-lo;
> -		st,wakeup-x-hi;
> -		st,wakeup-y-lo;
> -		st,wakeup-y-hi;
> -		st,wakeup-z-lo;
> -		st,wakeup-z-hi;
> -		st,min-limit-x = <120>;
> -		st,min-limit-y = <120>;
> -		st,min-limit-z = <140>;
> -		st,max-limit-x = <550>;
> -		st,max-limit-y = <550>;
> -		st,max-limit-z = <750>;
> -	};
> -
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
> +
> +description: |
> +  STMicroelectronics LIS302DL (SPI) and LIS3LV02D (I2C) 3-axis MEMS
> +  accelerometers. Supports click detection, free-fall/wake-up interrupts,
> +  high-pass filtering, axis remapping, and self-test functions.
> +
> +  Driver located at drivers/misc/lis3lv02d/.

Bindings are independent from a driver, so drop this.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,lis302dl-spi
> +      - st,lis3lv02d

These compatibles are already present in st,st-sensors.yaml. The long 
list of properties are not. Probably need to drop them from 
st,st-sensors.yaml.

I would suggest you remove anything here (compatibles and 
properties) that is not used on the 1 platform using this binding. If 
there's no platform using I2C interface, then that could be removed from 
the driver too.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  Vdd-supply:
> +    description: Main power supply regulator (I2C variant).
> +
> +  Vdd_IO-supply:
> +    description: I/O power supply regulator (I2C variant).
> +
> +  st,click-single-x:
> +    type: boolean
> +    description: Enable single-click detection on X axis.
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
> +
> +  st,irq1-disable:
> +    type: boolean
> +    description: Disable IRQ1 pin.
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
> +  st,irq-open-drain:
> +    type: boolean
> +    description: Configure IRQ lines as open-drain.
> +
> +  st,irq-active-low:
> +    type: boolean
> +    description: Configure IRQ lines as active-low.
> +
> +  st,wu-duration-1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Duration register for free-fall/wake-up interrupt 1.
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
> +
> +  st,axis-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: |

Don't need '|'.

> +      Map physical X axis. Negative values invert the direction.
> +      Valid range -3 to 3, excluding 0.

Define the range with schema, not free form text.

Rob
