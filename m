Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E52F5492;
	Wed,  8 Apr 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654386; cv=none; b=Wvc5taWz3xhGmqj9O/w77lYHUDaECP5fDa+7/XDbgkdU+22Kzu96w/UVwF9zi8wdWJepuQJPWwh4Hs45M6DIZKRqWVJHl0zVJ8LFVfkWwuHeI/WL5EOWC6fD84uwI4z7BndsuHjRcN+/W8zZ/Sk7SfuMvgck+2Pv8XTY6dBxyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654386; c=relaxed/simple;
	bh=Fle2L3rP4peCU11Gpmi6PDE0LAZyu5oAbKg95o0Fecs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skg1UOLE57woZ+IujCXw1UaECALm/JMIqJhK7ZgyxF8nZlz7vmX4ZbQaNmQDJUDJ6JOEpo1xKmr6nx7p5WXviS/o5TGgL7p8UvNl3hJcjeInzd1U1JmIA5Eq8OVgknWeuD/HQG0AdUagx64zQ1P6aRomc0RXM43yaQqd7rtZT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpVHV3Cm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpVHV3Cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28508C19421;
	Wed,  8 Apr 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775654386;
	bh=Fle2L3rP4peCU11Gpmi6PDE0LAZyu5oAbKg95o0Fecs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpVHV3CmDuVp7UWNZaiBV/BW1BwcG6fy1qmMuvrzu8fa3JXdcfzMqfX8eh27+GlSI
	 ozrPhlL4IEPow4YnlM/Fi2ukjUJf6kk9umhYjBxM6Awll7vZbrC7FGOYq68Kfu8Qf5
	 /y5kmPKzgg+2bI6c3gZQTyuHBFR/CNTf/Srccp17aaN+mJoNbqW2U8o8d8BQAh/VcZ
	 F3LoYxhSa7+4fek50DIAdsyG8S0HucpD9BhkKKyCx155T7aG8AIXhI/8JPyrpqyGq7
	 brUz9AVuqTxJaVFUmM+w73WgmcJnKSYRL6VDKCGqYaXM2AHMTZm3emK9QguFEAGvCK
	 xS9gHvKYbeFuw==
Date: Wed, 8 Apr 2026 08:19:44 -0500
From: Rob Herring <robh@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 1/9] dt-bindings: iio: imu: icm42607: Add devicetree
 binding
Message-ID: <20260408131944.GA1901621-robh@kernel.org>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330195853.392877-2-macroalpha82@gmail.com>

On Mon, Mar 30, 2026 at 02:58:45PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
Subject space is limited, so don't say devicetree binding twice:

dt-bindings: iio: imu: Add Invensense ICM42607

> Add devicetree binding for the Invensense ICM42607 and Invensense
> ICM42607P inertial measurement unit. This unit is a combined
> accelerometer, gyroscope, and thermometer available via I2C or SPI.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout.

Similar enough to use the same binding schema?

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/imu/invensense,icm42607.yaml | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> new file mode 100644
> index 000000000000..bbacdee5b906
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/invensense,icm42607.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-42607 Inertial Measurement Unit
> +
> +maintainers:
> +  - Chris Morgan <macromorgan@hotmail.com>
> +
> +description: |

Don't need '|'.

> +  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
> +  accelerometer.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - invensense,icm42607
> +      - invensense,icm42607p

blank line

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    type: boolean
> +
> +  mount-matrix: true
> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm42607p@68 {
> +            compatible = "invensense,icm42607p";
> +            reg = <0x68>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT1";
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm42607p@0 {
> +            compatible = "invensense,icm42607p";
> +            reg = <0>;
> +            spi-max-frequency = <24000000>;
> +            spi-cpha;
> +            spi-cpol;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT1";
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +        };
> +    };
> -- 
> 2.43.0
> 
