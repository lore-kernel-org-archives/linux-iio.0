Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658236FC5;
	Mon, 11 May 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512817; cv=none; b=RZkgWNk+c4D+4CTcDlVOxz/bPXvZ3e5JPfcD0GUPOaZKii8H1fQjTYFx0bXE/d3iAHB3AJH/NiGLEY8Ek6uWbA4myitqQm1C/etThhIeD0Hiq5/CN53I+4a5NteEDi9dJf7wWjQOSuH3B/BjyTeCQLQ7l7H0OpAV6eS+FOuIri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512817; c=relaxed/simple;
	bh=n0v4ZUXO1q2PGmyAWHxuJFTgbefFc2h+g1Ad9zR4gIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6D5qSLlRGQmLO5GZZk6uZLR1VKZIJZjRB66PBnFvyz3SdyOuuPFPh4mhS12buafBl9EeTdfavS03ykwWIgTKSTqWU3eiLeRA7rKFynKX0pf3pe1PGXW2gfIG4GZYjsgIYSsfmf+8rmQWoOxFMMYMp2yl4FApFWFGu97fbiCdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0+lcfWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0+lcfWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DE0C2BCB0;
	Mon, 11 May 2026 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778512817;
	bh=n0v4ZUXO1q2PGmyAWHxuJFTgbefFc2h+g1Ad9zR4gIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P0+lcfWjktnylSX6xU3XHFwTpGDCkc+PAuZc0oGxBC9V50d4KL1GvbnjMbMBi4Ihc
	 6t1HozRquDYecgiFk3ZdeoXJfEzgxtLF2wY9zG6N9b0xgS5ouV3w7T0tVuTFYmCFpm
	 DHqKsKKITrI5V89FGCaQQODxCZWpAKSkwgbVQ9xEADQNnZ4Yysgd0cij4zVKrRteRW
	 vKjbVp+eaeRftl076wIp1CCunlNyRdUraXI9L/6nq2kNONALMTzQQY+wkH409jnx+1
	 6j/QHWYL20+f2j4PvvX8W6bSNno9a7NyVR/6r2JVxCX9V0oG9neyNoJThKQjWy6hyL
	 2GSDBDvX/cDrA==
Date: Mon, 11 May 2026 16:20:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandre Hamamdjian via B4 Relay
 <devnull+azkali.limited.gmail.com@kernel.org>
Cc: azkali.limited@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add ROHM BH1730FVC binding
Message-ID: <20260511162007.081b7e24@jic23-huawei>
In-Reply-To: <20260511-bh1730-v1-1-e0df1f499135@gmail.com>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
	<20260511-bh1730-v1-1-e0df1f499135@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 01:09:49 +0700
Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org> wrote:

> From: CTCaer <ctcaer@gmail.com>
> 
> Add a YAML binding for the ROHM BH1730FVC ambient light sensor.
> Documents the required compatible string, the als-vdd/als-vid
> regulators, and the rohm,integration-cycle, rohm,lux-multiplier,
> rohm,opt-win-coeff and rohm,gain-coeff calibration properties
> consumed by the driver.
> 
> Signed-off-by: CTCaer <ctcaer@gmail.com>
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
> ---
>  .../bindings/iio/light/rohm,bh1730fvc.yaml         | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml
> new file mode 100644
> index 000000000000..6273b69e82ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/rohm,bh1730fvc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BH1730FVC ambient light sensor
> +
> +maintainers:
> +  - CTCaer <ctcaer@gmail.com>
> +
> +description:
> +  Digital 16-bit ambient light sensor with an I2C interface. The device has
> +  two photodiodes (visible and infrared) and supports four gain settings and
> +  programmable integration time.
> +
> +properties:
> +  compatible:
> +    const: rohm,bh1730fvc
> +
> +  reg:
> +    maxItems: 1
> +
> +  als-vdd-supply:
> +    description: Regulator for the analog/digital supply (VDD).
> +
> +  als-vid-supply:
> +    description: Regulator for the LED indicator supply (VID).

What's this? I'm not seeing it on the datasheet I found:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1730fvc-e.pdf


> +
> +  rohm,integration-cycle:
> +    description:
> +      Number of internal clock cycles used for the ADC integration time.
> +      Used together with rohm,lux-multiplier to calibrate the lux output.
Why is this a DT thing? 
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  rohm,lux-multiplier:
> +    description:
> +      Lux scaling multiplier applied after integration. Used together with
> +      rohm,integration-cycle to calibrate the lux output.

Likewise - this sounds like a driver choice, why is it in firmware?

I'll guess this an integration cycles are linear (more or less) so can we just
define an calibration values (maybe the win-coeff. gain_coeff?) as being defined
a fixed ratio of these?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  rohm,opt-win-coeff:
> +    description:
> +      Optical-window calibration coefficients. Specified as a flat list of
> +      triplets <rc cv ci>, one triplet per window region, where rc is the
> +      visible/IR ratio cutoff and cv/ci are the visible and IR weighting
> +      factors used in that region.

This one is fine - though maybe we can generalize as Matti suggested.

> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      minItems: 3
> +      maxItems: 3
> +
> +  rohm,gain-coeff:
> +    description:
> +      Per-gain sensitivity coefficients. Eight u32 values arranged as four
> +      <cl fl> pairs, one pair for each supported gain (1x, 2x, 64x, 128x).

I have no idea what this is and why it would be in the dt-binding as opposed
to being a driver thing.  What is it about how the sensor is wired up or
physically mounted that changes this?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 8
> +    maxItems: 8
> +
> +required:
> +  - compatible
> +  - reg
> +
> +dependencies:
> +  rohm,integration-cycle: ['rohm,lux-multiplier']
> +  rohm,lux-multiplier: ['rohm,integration-cycle']
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@29 {
> +            compatible = "rohm,bh1730fvc";
> +            reg = <0x29>;
> +            als-vdd-supply = <&vdd_als>;
> +            als-vid-supply = <&vid_als>;
> +            rohm,integration-cycle = <38>;
> +            rohm,lux-multiplier = <1000>;
> +            rohm,opt-win-coeff = <260 1290 2733>,
> +                                 <550 795 859>,
> +                                 <1090 510 345>,
> +                                 <2130 276 130>;
> +            rohm,gain-coeff = <3000 0xffffffff
> +                               2000 9800
> +                               15 60000
> +                               0 1300>;
> +        };
> +    };
> +
> +...
> 

