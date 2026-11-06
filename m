Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932581;
	b=V0Lzt/Y+05KDRiLgOi2RLFZvpMBW2SOKjD8RqBtO0A7oHZno+pjtAt28doo7LomPaxQi
	 2uoE6Siy5tZE2tqGgHST/aXjv59C4K1/X2xerGHd0YGhwuPq3bgPd2HR9R7YwvA6ZaNfZ
	 NJKFVsPvAso1BiUCv1oEqaRJGiHOGbNGTu3woG0LWX5QdU3hOmTD4a/D7Tx861NoYapCh
	 Ml2PM3U51I1y9w89NzlQNWLlmTOytBRoUJL6NVNzqydIkibKfEcppFjlJkLviOeyek6Vu
	 hnhby64Wa+VBu0qo2tPB3gtV/+SRCVp6LruFZRWXwOkjYc8l2RhyPUcXpqoovHHQdsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932581;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fRBwZI5AAmJVvhkGhNHrJYHOCVFskpUHRt5+nUFd1+E=;
	b=n4x4GHG14DoyTtmxL83zQ0L2D0LE6hF7pq2zn9XJctp0/lPbR7eheV/Mn3FdLpl7+Kno
	 YaEVTX/BrcLc7xykUpAIX9jEQD5Zy/RaBHsTTPKl/t8CHhqyyphkvQbLB81TtoOltMz9a
	 BQ+xbCukosMgFvKtr/H1Gq0Jy66PfJRyIqrWqYCJRZFppzgftSeoisz+9kLNc7Jo/cM3i
	 7YxGxQ63NictPxumJlR2mM9wvA6GXmMFPLP5IAgQcHWCWQheFGZW03cmeGE+q3D5bMdGh
	 Lo0PxXIJrecP6AkyxtvXWSHRHKevIyIz5+r26zkbiAx2FrRQXnJRv/xL2Vc9TPnYe3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDfg5sKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADF606A32E;
	Fri,  6 Nov 2026 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDfg5sKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E31F008A1;
	Fri,  6 Nov 2026 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932580;
	bh=fRBwZI5AAmJVvhkGhNHrJYHOCVFskpUHRt5+nUFd1+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aDfg5sKSXMsUodp9jTIUWWSyt4aqd9MEGmLgibN5T715f42L2g86k+m7MDTbDq7cE
	 DT46BEUux1mbXWBO0rgY+nczhCH/0Ri+tEx0gL5WGjgbqB6qnzI5aroAeaXKGMiO+B
	 Us7XwlSXsMzV29H9ZEUwdTP5sisB+0KUezLlHbg6MA6GGRAAfhvCfojozhBv3nE3g5
	 ysVEUpSCVhKJqHe/u1Nkor35q96XwkXXbYlAJVPotv1T6r9I9qDIE9kVwGZkhgNIeZ
	 bEPWmGj/Il4ynJN07CU1TGWwE4ENsL1uei39KvZhmsJZw8lYRWOD1jE6y6hc1wPggb
	 wkHrwQQPg9YKA==
Date: Fri, 6 Nov 2026 02:36:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Viral Patel <viral8854@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add Infineon
 TLE493D-W2B6
Message-ID: <20261106023612.344f3b86@jic23-hlaptop>
In-Reply-To: <20261105-tle493d-v1-1-3246e91e6394@gmail.com>
References: <20261105-tle493d-v1-0-3246e91e6394@gmail.com>
	<20261105-tle493d-v1-1-3246e91e6394@gmail.com>
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

On Thu, 05 Nov 2026 21:23:47 +0530
Viral Patel <viral8854@gmail.com> wrote:

> Add a binding for the Infineon TLE493D-W2B6, a 3D Hall effect magnetic
> sensor with 12-bit resolution per axis and an integrated temperature
> sensor, accessed over I2C. The A0 to A3 variants of the part only differ
> in their default I2C address, so a single compatible covers all of them.
> 
> The sensor's /INT output shares a pin with SCL and cannot be wired to an
> interrupt controller as a separate line, so there is no interrupts
> property.

I haven't looked at the driver yet, but your explanation in the cover letter
of why it is a separate driver seems fine.

That doesn't exclude using a shared device tree binding (as it is a many
to many relationship between bindings and drivers) and it seems like
nothing stops you combining this with the tle493d-a1b6 binding.

Thanks,

Jonathan


> 
> Signed-off-by: Viral Patel <viral8854@gmail.com>
> ---
>  .../iio/magnetometer/infineon,tle493d-w2b6.yaml    | 48 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml
> new file mode 100644
> index 000000000000..46f9c0e77e24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tle493d-w2b6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon TLE493D-W2B6 3D Magnetic Sensor
> +
> +maintainers:
> +  - Viral Patel <viral8854@gmail.com>
> +
> +description: |
> +  Infineon TLE493D-W2B6 3D Hall effect magnetic sensor with an I2C interface
> +  and an integrated temperature sensor. The A0, A1, A2 and A3 variants only
> +  differ in their default I2C address (0x35, 0x22, 0x78 and 0x44).
> +
> +  The sensor's /INT output shares a pin with SCL, so it cannot be routed to
> +  an interrupt controller as a separate line. The binding therefore has no
> +  interrupts property.
> +
> +properties:
> +  compatible:
> +    const: infineon,tle493d-w2b6
> +
> +  reg:
> +    maxItems: 1
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
> +        magnetometer@35 {
> +            compatible = "infineon,tle493d-w2b6";
> +            reg = <0x35>;
> +            vdd-supply = <&vdd_3v3>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0017755f593b..c8916e1286d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13110,6 +13110,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
>  F:	sound/soc/codecs/peb2466.c
>  
> +INFINEON TLE493D-W2B6 DRIVER
> +M:	Viral Patel <viral8854@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml
> +
>  INFINEON TLV493D Driver
>  M:	Dixit Parmar <dixitparmar19@gmail.com>
>  L:	linux-iio@vger.kernel.org
> 

