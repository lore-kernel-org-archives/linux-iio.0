Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825907;
	b=xBpY2TZjk/rM+Q7zOeW0mmJg+PiUsNywpyRZ/GX9Ku1q1wacnJcYSxTNDgGP4U6dfOhv
	 RUVyaVtF7bojDBuCmpxlBql0bgikkdQARVqvfVpG6qhV/9wz/MR4W0Xsr5m/FpC67ETmw
	 wCcGtSLnGm+1xPpb1QPo2Z74kTYjlU7j61rwY+Y2sYACpB19u8+b9bwdJ1uImyrfxUYDi
	 CuFRwqpR3ESicypspX3hZE24d7EChp4bRJWDxt8i4ukqmLIUQ0GOf3FIk2HPuX/Lw9aVM
	 6kGcsjj26JjcKN1MZMouHdeghL/BjTiKrr/3/cGZ7hW033FB7rIWgjWPJZTl8/HNt5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825907;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JlVRTxL+BcSjflaSgLcOcjIGWl+CetICaQlh8dZNIJw=;
	b=FZjxL19r5wh10Ali3sK/daNjoLnLXwqIb4lBhtSgoSeyvK4V4oBFjbNlYjz5S0cNM2+k
	 Zq5bnC8VTs0AoGP6n7dgmhIfVx7lgcMXMearmUGE39xNTAoWGXSVvl56x+R8vufK5hzHi
	 /Km7GrnyvQ6h/uJe2gmU/a5X0i3SrTBR4Fsikd+TWGyW2q0iYZLK7R8NHVgt9CFn/dEn8
	 tnx1talOW+O8plHSnE4BaBIkAYF3ZA+pA4tvCaUXAohGbgQvcjQy4SwfxvQLAmEJKdfhN
	 g0Peh7GiJ7jObERU2HIErGnsuBwe8xTsQIqo3aDiOsmLpc9pJUkZNymYh7UxUVvEMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MirkBkv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC5606A31C;
	Sat, 28 Nov 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MirkBkv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A054A1F000C1;
	Sat, 28 Nov 2026 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795825907;
	bh=JlVRTxL+BcSjflaSgLcOcjIGWl+CetICaQlh8dZNIJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MirkBkv/IldmNlYYjVbjFiV1LePvCtliEMxLM2/GZDoiaacmxl60jRrw5KPSEpA9c
	 lIdiYa6vP2v9XwiEyOh72znWsie2YUd+KVzxsoBbuM3vOZyJgfECXNWROw572uALMf
	 DhkTDMB1yf2yu0HTqTCwPEdMlZ9k8fZuuWUEn7r1bau/KvNW9bfrChuxCzxvB3mDvw
	 y+ZJvWIBtn2V2Q6QWKYAReJhdv7cbFmq1LEb+w0moW3nFw9GUNjSy9fgfw6DQ5OQb3
	 MrSKv7wDNiyzKU4OP/2U+owZcBHkHFv3UIIYzJzQAMuBnFQzBNQ+1LIz7o+BBfKpry
	 55qy3IJk/Uw1w==
Date: Sat, 28 Nov 2026 00:31:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Cc: admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: Add Capella CM3217
Message-ID: <20261128003139.0d8a011c@jic23-hlaptop>
In-Reply-To: <20261128-upstream-iio-cm3217-v4-1-fdab04f40bbc@tsv-stahl-riesa.de>
References: <20261128-upstream-iio-cm3217-v4-0-fdab04f40bbc@tsv-stahl-riesa.de>
	<20261128-upstream-iio-cm3217-v4-1-fdab04f40bbc@tsv-stahl-riesa.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Nov 2026 00:38:56 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The Capella CM3217 is an ambient light sensor with an I2C interface but
> without registers and without an interrupt line. It always answers on
> the two fixed addresses 0x10 and 0x11, which are both listed in reg.
> 
> The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
> Tablet.
> 
> Tool use: Claude Code wrote this binding.

Comments on that belong below the ---

If nothing else comes up, I'll drop it whilst applying.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  .../bindings/iio/light/capella,cm3217.yaml         | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> new file mode 100644
> index 000000000000..a03cdf2bd375
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/capella,cm3217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Capella CM3217 ambient light sensor
> +
> +maintainers:
> +  - Patrick Fischer <admin@tsv-stahl-riesa.de>
> +
> +description:
> +  The CM3217 is an I2C ambient light sensor.
> +
> +properties:
> +  compatible:
> +    const: capella,cm3217
> +
> +  reg:
> +    items:
> +      - description:
> +          Command byte 1 (shutdown and IT_T) on write, high byte of the light
> +          count on read. Fixed at 0x10.
> +      - description:
> +          Command byte 2 (FD_IT) on write, low byte of the light count on
> +          read. Fixed at 0x11.
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@10 {
> +            compatible = "capella,cm3217";
> +            reg = <0x10>, <0x11>;
> +            vdd-supply = <&vdd_2v85_sen>;
> +        };
> +    };
> +...
> 

