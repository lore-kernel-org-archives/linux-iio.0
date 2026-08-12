Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC3279DB6;
	Wed, 12 Aug 2026 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503603; cv=none; b=aH1a7Xst0tbQ5INu2MLPJ5hgAq/5OR9Ri1jw3kDboODqkZe1CIDfobdzWu1m/TYfnT5WS4OGC138lY1lGTB8d9DsCLdvbPOrZruyIcMKMqixv6hXb1D4aOoqaxyz3ndCqsxEYBSV+46LQfEuTathpcJeh+Hw+N8qTXwc1j2bIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503603; c=relaxed/simple;
	bh=3pgO82nKlff7wJbElsukFnxnY7+pZvBl0Akfq+sm1qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7vJfhFrir0ae2hgEZUUAIMZksYc3oz2cjlKdYndV0v8B/9F3PRSkA4mcxi3FB5SmuAlt5tQ9DPor/xde1u2OpdGI/ZirrqZ/HmW1j8YH64bSFgT7QZYjYv/l1YTTQ8iHsy17ngfjilIiAN0J/vVcu45QeVPlwQA50ZOa0X9tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K97x6vA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K97x6vA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C161F00A3A;
	Wed, 12 Aug 2026 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786503599;
	bh=Bpxjg2oXsSCruLQdZKjR0sIz3mv2JlOLPQ5FjigQQko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K97x6vA84jO/2R4GeuqecGh6w2hkDZV3jiHp/cgbqSE27iD57m09ejT2GDI6OFPBu
	 h3xW37MT2mdXEAbix2t+sDrPabsU8pkLUbGfcQA2hENhcbCAMYk5l0Y0gZ2S/fyX1A
	 jpi96GJWk5+FzneUx8aIA3DaUTSytduXxGmMegu3vnydHTUjpLViKkdavcvh9ehL2+
	 LoDcCrMunu85Iozm09S5vViwxUWcTuosT6epu6WxIOS49w9RDgCavVBtFyGHE4c0uA
	 0LcT0/OqnjHj6KKLCEMGhcqqCn8oVI+uzQursZIP2KuukkmApvoE3uGXGBjMyyDXqR
	 BB0Yk/1zfFFZw==
Date: Tue, 11 Aug 2026 21:59:59 -0500
From: Rob Herring <robh@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Grimler <henrik.grimler@axis.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 1/3] dt-bindings: Add InvenSense ICM-42370-p accelerometer
Message-ID: <20260812025959.GA632086-robh@kernel.org>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
 <20260806-b4-inv_icm42370p-v1-1-670837f5842f@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-b4-inv_icm42370p-v1-1-670837f5842f@axis.com>

On Thu, Aug 06, 2026 at 02:46:27PM +0200, Kanak Shilledar wrote:
> ICM42370P is a 3-axis accelerometer. The device can support
> I2C, SPI and I3C. Add the supporting devicetree documentation for I2C as
> we have only tested using I2C protocol and leave the reset for future
> work.
> 
> The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  .../bindings/iio/accel/invensense,icm42370.yaml    | 65 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml
> new file mode 100644
> index 0000000000000..561e798b911ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/invensense,icm42370.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-42370 Accelerometer
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
> +  https://uat.invensense.com/en-us/products/3-axis/icm-42370-p
> +
> +properties:
> +  compatible:
> +    const: invensense,icm42370
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  drive-open-drain:
> +    type: boolean

Drive what open drain? Presumably the interrupt? Add a description.

> +
> +  vdd-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +  vddio-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm42370@69 {

accelerometer@69
 
> +            compatible = "invensense,icm42370";
> +            reg = <0x69>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +        };
> +    };
