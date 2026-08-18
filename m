Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1D411F8B;
	Tue, 18 Aug 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039790; cv=none; b=pDvp0xLjMvndQcJGzz3R014hC8pdgBxHbjzuQa0AzNiTqfCRZLgjM14BI86h1Wz8KaIrsrhktLiQ5uW1A6Ihw09x2AFX6ciep9kLZNUq/LE8UkCQAljBmZbLjLuai7ezn3OH2WMvR3YskIDeFM6XByvAhbM5r4tgx/qsggnTBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039790; c=relaxed/simple;
	bh=h9VB4aoWmXw2KVvGQ1cECS0bXRPbAl5jIwHGLVu3qr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCT0sYrNcx5GDMWclOUCQUuedhMnZcCPZyYLfosAafZqlwXTIVoqQoElo0+07pESMK3z+niSYiKbF4gr9KFu6n9KE6dunEn/LfdHubJwmfh93vVM266eYUxogYIjElg+FzVHGnHKXGjeJTnVVSh4yzYtFMiLEIzKiPShX/KhXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKxsxYJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKxsxYJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E331F000E9;
	Tue, 18 Aug 2026 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787039789;
	bh=Ias99HrwAjLEfCmql+XAIh9FEXTSz0g1HLDm3Xd7Vzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QKxsxYJLni4wbPnfxA4d7/9JPPwUJhMnt26cfJCj0c1DfQ/E3nqt+b61s0TiKZ9Kc
	 XVbs1dwoKl5Im4efQHvvbW7sjDLphuiZ3Kt1WnhLa0pMWyrC1/ex8qiwcwdJJPlX+L
	 ONHgVhxu4TKxLRtYIEI16nOAU/TEn+8Qw33sBwVLX/ZR+tLFYaLs5rX8jLkrbTnMXq
	 Q3eVbLt3VLGlwXJer7caC2tzYVFxP7LtotNIUJcywTj/jF7ahbIzAaSaviWB/KGhsT
	 NsAo0zV8iMnvJ+fKjfla4dNd67ds02JkYV2cPiH/jiBHEn7XRAv8QNNjMdfGDAdS2F
	 B8D9fm5C/b4rA==
Date: Tue, 18 Aug 2026 09:56:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Grimler <henrik.grimler@axis.com>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@axis.com
Subject: Re: [PATCH v2 1/3] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Message-ID: <20260818-adorable-bonobo-of-honeydew-3ef84f@quoll>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
 <20260813-b4-inv_icm42370p-v2-1-11aedfdf76d3@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813-b4-inv_icm42370p-v2-1-11aedfdf76d3@axis.com>

On Thu, Aug 13, 2026 at 02:26:10PM +0200, Kanak Shilledar wrote:
> ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
> and I3C. Add the supporting devicetree documentation for I2C as we
> have only tested using I2C protocol and leave the reset for future

"rest"?

> work.
> 
> The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  .../bindings/iio/accel/invensense,icm42370p.yaml   | 84 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
> new file mode 100644
> index 0000000000000..df23406921a51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/invensense,icm42370p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-42370-P Accelerometer
> +
> +maintainers:
> +  - Kanak Shilledar <kanak.shilledar@axis.com>
> +  - Henrik Grimler <henrik.grimler@axis.com>
> +
> +description: |
> +  3-axis accelerometer MotionTracking device.
> +
> +  It supports I3C, I2C and SPI serial communication, has a 2.25kB FIFO
> +  and 2 programmable interrupts with low-power wake-on-motion support.
> +
> +  It also has programmable filters and an embedded temperature sensor.
> +
> +  https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> +
> +properties:
> +  compatible:
> +    const: invensense,icm42370p
> +
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
> +    description:
> +      Whether irq is in open-drain mode. False means push-pull mode.
> +
> +  mount-matrix: true
> +
> +  vdd-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +  vddio-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +dependencies:
> +  interrupt-names: [ interrupts ]

Drop, core schema has it. Unless you wanted the interrupts to require
names, so opposite dependency? See other bindings how this is done.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +  - vddio-supply
> +
> +unevaluatedProperties: false

additionalProps, see other bindings.

But OTOH, if this is SPI device then where is spi-peripheral-props
reference (and then unevaluatedProps woyld be correct), regardless if
you tested drivers or not.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        accelerometer@69 {
> +            compatible = "invensense,icm42370p";
> +            reg = <0x69>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT1";
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fa5322d9f74..e4764489ea971 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13561,6 +13561,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
>  F:	drivers/media/i2c/isl7998x.c
>  
> +INVENSENSE ICM-42370-P ACCELEROMETER
> +M:	Kanak Shilledar <kanak.shilledar@axis.com>
> +M:	Henrik Grimler <henrik.grimler@axis.com>
> +L:	kernel@axis.com
> +S:	Maintained
> +W:	https://invensense.tdk.com/

Let's drop the website? No need to repeat it for every driver.


> +F:	Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
> +
>  INVENSENSE ICM-426xx IMU DRIVER
>  M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>  L:	linux-iio@vger.kernel.org
> 
> -- 
> 2.43.0
> 
