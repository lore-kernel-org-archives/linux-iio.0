Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0658368D4C;
	Sat, 17 Oct 2026 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199509; cv=none; b=eJA8iuHfpI2a622ZUCycJMOhsAHKbofUijLa1PVY37L9pBTHlCjjC1ztyAunPbCcLHxB9HXK1XeYWZCjWE7q4MTjowBeVPLr1/yP472gyz1NOOTIsfIxJQvYa70JxQ8ApDsy0ETdAzccMeJ+eUZU0bdkKce/19wicQXi7SXlQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199509; c=relaxed/simple;
	bh=Tc+qWaLLbSD9D9Lls7lHXEoytPmpl4+LJ09JrbY00Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rf9r38QALxs4+1Z/KYaa12OtkyQaWcS7cVeNG6g66D3Z5mTmguP1AHA6wKgoOn0voyRhRirYsldJBY1lEsqBB2ALDe9w27YRCxdpeqLKtC4ucQVdEZcXChCNsGZGiAziASjxEvlI/XYiEqnm0M+XeWlhatWBJ39NGM+hZcrIEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzv3ALTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzv3ALTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CAA1F000C4;
	Sat, 17 Oct 2026 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792199507;
	bh=kIMCpe5Yt1Y2+5Y/j1kd4e8zqh9gHeuCZZIS+MOh7e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xzv3ALTKXcTtXWX5ADEpdHW/oD+O4r09sPDcfLW3T06wnrjngnCnRkd0Uj5aq6978
	 nW6wPSDXdxomiCkFn/yB5v1hNP51LB9qO9KjlwMsE7E0tGF/e/zfqpsAx3iIF8DLEM
	 jTEAcbcTm+10HjpgWOvktDvq/7AhUEUY8eZAKAIGSDwEIEdYed7HrUbjkv7rDxGlx3
	 zLvU1TUu3nvq+wcBAvVfePraS53AqBLbGDZ6bhjKD4jIO6/gvSMWzD1Lzxfph23qSL
	 DToCW+AXkrgwUy/qbUUVLZxmG4PnjvGB93NaDqqq7pfOx0gMTaofSfPqHqlf1u4beh
	 xqLRVP3HHOC6g==
Date: Sat, 17 Oct 2026 02:11:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261017021141.5b023e60@jic23-hlaptop>
In-Reply-To: <20261015-adis16607-v3-2-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-2-f972d4efee85@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 12:32:59 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
> 
> Two variants are supported: adis16607-2 and adis16607-3.

Say briefly how they are different and hence require their
own compatibles.

The hardware rest being a configurable pin is an unusual
bit of hardware design given how do we reset the reset pin
to issue a reset if the device is hung?  

> 
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> new file mode 100644
> index 000000000000..1cf969154885
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16607.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16607 IMU
> +
> +maintainers:
> +  - Radu Sabau <radu.sabau@analog.com>
> +
> +description: |
> +  Analog Devices ADIS16607 Precision MEMS Inertial Measurement Unit (IMU)
> +  with a triaxial gyroscope, triaxial accelerometer, and temperature sensor.
> +  Uses SPI Half-Duplex communication protocol.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16607-2
> +      - adi,adis16607-3
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Optional external clock for sync mode. If not provided, the internal
> +      8 kHz clock is used.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Optional GPIO for hardware reset. The line is active low.
> +    maxItems: 1

The datasheet I looked at has 4 gpio pins. You are calling out one
as reset.  What happens if we don't have controllable supplies
and someone else (firmware for instance) configured GPIO0 to not
be reset?

Anyhow, feels like this isn't a full description.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imu@0 {
> +            compatible = "adi,adis16607-2";
> +            reg = <0>;
> +            spi-cpha;
> +            spi-cpol;
> +            spi-max-frequency = <10000000>;
> +            vdd-supply = <&vdd>;
> +            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent = <&gpio>;
> +            clocks = <&sync_clk>;
> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7fd31320b38..f6ad73be5260 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1717,6 +1717,13 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
>  
> +ANALOG DEVICES INC ADIS16607 DRIVER
> +M:	Radu Sabau <radu.sabau@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> +
>  ANALOG DEVICES INC ADL8113 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
> 

