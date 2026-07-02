Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C343AC0E4;
	Thu,  2 Jul 2026 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035377; cv=none; b=VBBPIddN436WeF3qIF2/VFgpWPiFIXJl0g9+f+5yl8RnTK3bR3eYc2cJc7LhtZ+Cm5mHbwK0zygIbxAvZRBWZ3bbDyjuBf7DrG1YnW0tG7P/OjNPMlDAFrNVauB/V9sqWoBQcWJIf74MrOo9VGgoGEh3qX8b48KnunnG5BmV7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035377; c=relaxed/simple;
	bh=2vIdANbPJn1iv8op/WJ3hcP5POUkPpa+80O1m+Ab0y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0ORToQFGJUUMIt1ftGuk4tL21V0pT3EaTZPa2lSicTXf2gDZgRxKaFP8Nfzpjki/yfFa9CtMont9HMVdDwR63awduNGEHMn/kjLGxoMucHCmWHBzzA0JMYfCnlhHM35QxK0YIqMdBNQKI2MK5i8Y8kfmvYSMih5NhLEJAtf4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfYvVP8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfYvVP8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50311F000E9;
	Thu,  2 Jul 2026 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783035376;
	bh=llU+UmL8Q/qchJOBszH9xyQc5tc/remZtLE7HXLq1EM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jfYvVP8MrpZ+teELaikkmt3pWj5vx/hLpHJVFZgQaalsjlc5I7YdO4VGwFhzKDzY6
	 Hkeqf3H5xbPU8IY4H3V9BfXi/+gS4hntvKIBMz/UgzUrb2DKNwpQhvG0NG6mVGpffv
	 /OSeEMIUdCzCywdWa/csMMSfkFfoQ4HurNyx/xK9iSqF/pES1s2DeGmFLM6kUGf8MT
	 navKfmV0LApnovadI4vO/jUud6GgihbfQzx7Fk/vOh/j5omFddjw1hfDEQCkoLVstt
	 KkJIPWRUtbBOPxnIa7MdwxguyTg8oxazPYmd3tW2x5DHYIe5oktgzaWMAgGrhgaVUF
	 NPNfK+3N2tUlA==
Date: Fri, 3 Jul 2026 00:36:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM
 AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add STS30
 devicetree bindings
Message-ID: <20260703003611.1b9acf2a@jic23-huawei>
In-Reply-To: <20260621004626.66629-2-m32285159@gmail.com>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-2-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 19:46:23 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Add the devicetree bindings for the STS30 family of temperature sensors.
> The STS30 family of sensors includes the STS30, STS31, and STS35.
> 
> All devices in the STS30 family share the same commands, timings, etc.
> The only difference between them is their measurement accuracy and
> tolerance.
Given we don't report accuracy (and reporting less accurate than they
actually are should always be safe if we do add such reporting in future),
I think a fallback compatible to the least accurate is appropriate for
the other two.

> 
> Additionally add MAINTAINERS entry for the driver.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
> Changes since v1:
> - Squashed parts of the MAINTAINERS commit into this commit.
> - Added ALERT pin as an interrupt and in the examples.
> 
>  .../iio/temperature/sensirion,sts30.yaml      | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml b/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
> new file mode 100644
> index 000000000000..9bb0f04795d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/sensirion,sts30.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STS30, STS31, and STS35 temperature iio sensors
> +
> +maintainers:
> +  - Maxwell Doose <m32285159@gmail.com>
> +
> +description: |
> +  Family of digital temperature sensors from Sensirion with I2C interface.
> +  All devices are compatible with each other, their only differences are
> +  their levels of accuracy.
> +
> +  Datasheet available at:
> +  https://sensirion.com/media/documents/1DA31AFD/65D613A8/Datasheet_STS3x_DIS.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sts30
> +      - sensirion,sts31
> +      - sensirion,sts35
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature@4a {
> +            compatible = "sensirion,sts30";
> +            reg = <0x4a>;
> +            vdd-supply = <&reg_3v3>;
> +            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d95d3ef77773..7f94b8cac3e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24487,6 +24487,11 @@ F:	drivers/iio/chemical/sps30.c
>  F:	drivers/iio/chemical/sps30_i2c.c
>  F:	drivers/iio/chemical/sps30_serial.c
>  
> +SENSIRION STS30 TEMPERATURE SENSOR DRIVER
> +M:	Maxwell Doose <m32285159@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
> +
>  SERIAL DEVICE BUS
>  M:	Rob Herring <robh@kernel.org>
>  L:	linux-serial@vger.kernel.org

