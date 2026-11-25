Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593746;
	b=YigSo2bqvtsAthnMgLR9cSgYGpuRwOBTNZg36oMBFEmML3mNm5LiO5Tg5DKNpGP76jZY
	 J7Rh7Aa5zIdv1moZJSga+x7Zh5p4JEw+hrMxznZniofBIzlHVGYsURAn4kNORUazjk/OF
	 HOaHJUvhZ9hRaNkr1RtDt0Vbzyg+okpSwrZCLPNzeW8q5VGPXNrfDm4LN3JyvQENsCMcj
	 QGNMHoKEL4h5qDx1EAmJHDRhhogwFfoShHaIKqEZg7LAH4KWd+PRVL5QCIzgiBhjMMTLw
	 lv3kj2wQZDJfM1CzxDsuWocuVdQqfUxOrHj7jgCiPAVRxVm4mWpiS5P4xOIWuGGkChA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593746;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bq8niCuBVcSSdG4c8yZws7x2JHKXNJ0u15en+T+Uozg=;
	b=nc0JXQ4c+l9jrlvvb2astw3BlnCybiVpoXekyuKKytvUJ2HlBJlH7+UWMPujHP4q/BUn
	 bBqHuqlE/JQJRppYwz8EQ492JtNzRGCfRtiYj4ch62tiw9jftNfr7bM7PQONfutJVVgDi
	 LaTNfcZeyCYfL7itUv4PLLbbSqaH+Y3ZkEWuVAGikVYHxzEtCZDsCTd7nrOw++t4clajy
	 XqqpqARndl7qPN5w52Osp2ePV+/juDyA2D6YfUColQl6xphr6mrS8y6n+XMqgbvpijoSk
	 AXo8gvKezYGQJlYpETxJmcWj/DOr/RnukAQ1VEEgxQ8gqql8q/QE+F6ciq0YMk+u35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iE4zM36J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C55606A31E;
	Wed, 25 Nov 2026 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iE4zM36J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C961F000C6;
	Wed, 25 Nov 2026 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593745;
	bh=Bq8niCuBVcSSdG4c8yZws7x2JHKXNJ0u15en+T+Uozg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iE4zM36JQypIAGEuu169VauXvnf+w7iq6UJ+DGsRlW5DU9vUfqAIjBm6VM8bKQ3P4
	 aG3bWo6Plmj0O292Y0Jh37K5IG2tLjCsXklkSAGAw6lwCD4rLSStDDiu1bU4JKSIna
	 PjSE/8H5sekQtkrJrtjlExewSlSsT5QAZMLOVS5JVB9zMn05hPwhJslh4fwOUKbZ7e
	 9SC2Wm2IsmVrPatGzjXVWms4GzLOIRpq4uWE2QKZVCTwivyua1/k8PT9UkcSoKJPGM
	 MDYp19G37AxqI3KlslHPkTWkHjwtHMkKnUoZa1u0odY51QQTLKNXLESXGq1ZOpmw1d
	 8NhXb2kkk44qg==
Message-ID: <812cd6dc-b18d-4381-8aa6-e4b248070150@kernel.org>
Date: Wed, 25 Nov 2026 09:02:23 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: add ams OSRAM TCS3430
To: robertijtsma@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
 <20261124-iio-tcs3430-v1-1-0f2a38a6a4c1@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261124-iio-tcs3430-v1-1-0f2a38a6a4c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-Nov-26 23:46, Robert Ijtsma via B4 Relay wrote:
> From: Robert Ijtsma <robertijtsma@gmail.com>
> 
> Add Devicetree binding schema for the ams OSRAM TCS3430 ambient light
> and CIE 1931 XYZ tristimulus color sensor.
> 
> Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/ams,tcs3430.yaml | 52 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
> new file mode 100644
> index 0000000..085a70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ams,tcs3430.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ams OSRAM TCS3430 XYZ Tristimulus Color and Ambient Light Sensor
> +
> +maintainers:
> +  - Robert Ijtsma <robertijtsma@gmail.com>
> +
> +description: |
> +  The ams OSRAM TCS3430 is an I2C ambient light and CIE 1931 XYZ tristimulus
> +  color sensor with photopic Y, Z, X, and IR channels.
> +
> +  Datasheet: https://look.ams-osram.com/m/43d518b4cd81e3f2/original/TCS3430-DS000539.pdf
> +
> +properties:
> +  compatible:
> +    const: ams,tcs3430
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
> +  - vdd-supply
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
> +        light-sensor@39 {
> +            compatible = "ams,tcs3430";
> +            reg = <0x39>;
> +            vdd-supply = <&vdd_reg>;
> +            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44540a1..b1cebc2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1489,6 +1489,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
>  F:	drivers/iio/light/as73211.c
>  
> +AMS TCS3430 DRIVER
> +M:	Robert Ijtsma <robertijtsma@gmail.com>
> +L:	linux-iio@vger.kernel.org
Drop the list entry, get_maintainer.pl will get this using the path.

-- 
Kind regards,
Joshua Crofts

