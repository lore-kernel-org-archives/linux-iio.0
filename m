Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011922C1595
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687569; cv=none; b=ah6ygGWdlDmkUWlfJ3pNF90BeUc4VGx21OTTltxwXIIcc4D9pN/4RUfEu32JiIhY1bpE0qiRSrsbEVzz+2ojZEYPPMXnTXXHsYn9iKdavokdnzuWjRD6cJmPjJkq1xGudv08F1vy95nzJ9g5y1I2xxjOvHqHKX8G4aFVEsy0GGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687569; c=relaxed/simple;
	bh=KxHPKoiDCurUCtsWQ6ggtOoQgw/61uc4/tX7qUf9nEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzj1LF6+zCmlvh7rBL9wdYI+pktdsKAZOExxT1VjCq2FgrRDD2QY2B95opXd32eTpdD/gk6s79dikdybWgyt59y+9Yy48CrXz97vtntLDPkNeLI5VhpetxoJijC8sytjRueOjDWGDbDbOx8Pw+fN9lO5ZAUbpDP/0uN2/z20D80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WUykbia9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WUykbia9"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6acabd2c8bdso1442126eaf.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785687566; x=1786292366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfhxQUwsFgYF3mH3fJ4GDJgiou41ziE3NPkuGjACN5Q=;
        b=WUykbia98RhxPYI9X2HerLBNqFPJdf1Zc8R/EfcrZZzg6KxEdQMC7R9N1xxMX4uGm7
         OHhmds1mdlqpbPfYWL0e7qzuaHk+BxDhFylOMy5ybEq/mHYw1WzAEfR3k29m+dRYvPU4
         mjUNTjh3s91lciiP/Mw2eo7rxRQaBmWPBrESOSGLh3Z1103NPP1lBOZH22C+yMaIRfOE
         YUobl9q0cgKEVzQRejTbyezag20G7EpHJboo0GsCVtT9/uRupsPk4wfZzznK2dse1BRF
         uTR/v/cJxKgmmzoJkDwXsa++uxXLcpd/UZ6qYzNnmoU88/97WsrVVX4ZKTp0RArD3ZHv
         1Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785687566; x=1786292366;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfhxQUwsFgYF3mH3fJ4GDJgiou41ziE3NPkuGjACN5Q=;
        b=lwpNyR0ZZr40Q3/1KM+YZaH0tGsfzZh+QJ2P9pPsX+ipHt+UMxseoqsCCioIvonqyD
         I6I1mTezgTSsnEnHAsTe6u1q7UL5/dHWD2pQCrIuj+YrKQJgLgRF8sunjs/bwa+MmpUe
         hIJ98/B8J4/ULdao5iubP7c8Hnuh5u3kMrHjoT1IB7V2xLyMMHJtcVx4FwruMyj3HOTB
         nUGTTlS7lc2s3R+xDTTcLb5oBvD+jnmG9ny+CYjSVhBcMYuNgqAWtPHnKlDPbfAJoX79
         pxDCzuTA5+TGARcjmUKLaScNaEOWy584j8jAjPZuRB0a7Z2Igtl9oX0IOX9Uo9mCZbzE
         s13g==
X-Forwarded-Encrypted: i=1; AHgh+RoBflfJYcQ/f6s68t3FJtMwN9sORVGoMVD8ccjWUOM3pWFVm77OmZexEaG8bE474CtPJj6IzlP12OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOr5sORCIRb+j1PeMiF6jZGOMVFoF1/SV8v2ov79j/Z8SOjrv
	znDajFKaodwn64HbQ9wdm7h1EAhYWPSB37uo6QzUHjAi0B5+Eg1AppiorQhbs3jgIUs=
X-Gm-Gg: AR+sD13OYduEJb4MVWwEAuetp2Gqb+4wsQAKcuxwWDQnDxon8lsj3iFqtZSiceVS8VZ
	WlnrS0CrUXuxJR8FSyT5PxTaoFN5IC1/8RZnotbWsqxWAEB5Q1w5/A8Mr25JC2XM2y1rhmz4Mnh
	6T5KnQOCnq4ubVevrbSEDu+cNXvd0Dx7OH8E1q+mDdDmZ4EZEMRRCbb49jRAdhAasDKDfbmiohe
	yPSGWrEPeMwggWBv6tmjzykqDST5Szys2Tv0SxIGk8kPHPIRllrDt+KMlbn6rq4dzLglIXc0deG
	kWcFETTJG2PjsuW1ELwmIb/+nd/EZsH2IhCXvYW4eZzdjt7XiUDYB0BSXmEUG8O9mUMBMloT5Sb
	+TWFPBVuODrUyGAXhUZASouhSrV6AnyVQ9G5jEbr4IAwJCj8VDepzTViqxgPeM3oG3aeDn1t9iE
	L+nO3tdECC66zc4d9gOvcGSWWv01bDSiibtYFLxtFLIaE6j1IybtfjPVckih7V4d/8jWJWuIaXV
	AVmwoAj1ESj4R7+eCO2ovb8KPG6QwdjHAvtrAQW
X-Received: by 2002:a05:6820:88f:b0:6a3:8b32:3ecf with SMTP id 006d021491bc7-6ae43217e3dmr12146792eaf.12.1785687565710;
        Sun, 02 Aug 2026 09:19:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a0c724fsm4864613eaf.9.2026.08.02.09.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 09:19:24 -0700 (PDT)
Message-ID: <fde82f14-c0da-489a-81e9-cd047f8e5862@baylibre.com>
Date: Sun, 2 Aug 2026 11:19:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add DAC8163
To: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
 Siratul Islam <siratul.islam@linux.dev>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
 <20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/26 11:07 AM, Lukas Metz wrote:
> Add device tree binding for the Texas Instruments DAC8163 family
> including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.
> 
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
>  .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 87 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> new file mode 100644
> index 000000000000..ba4099c78e06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac8163.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC8163 family of DACs
> +
> +description:
> +  The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> +  dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> +  respectively. These devices include a 2.5-V, 4-ppm/°C internal
> +  reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> +  None of these devices are fallback compatible because they differ in either
> +  resolution or output register values after reset. The sync pin on the device
> +  acts as chip-select pin.
> +
> +maintainers:
> +  - Lukas Metz <lukas.metz@gmx.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dac7562
> +      - ti,dac7563
> +      - ti,dac8162
> +      - ti,dac8163
> +      - ti,dac8562
> +      - ti,dac8563
> +
> +  spi-rx-bus-width:
> +    items:
> +      - const: 0
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  spi-cpha: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  clear-gpios:
> +    description:
> +      When asserted, the device output registers are reset to their default
> +      values (zero for dacxxx2 and mid-scale for dacxxx3 devices).
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      Pin needs to be asserted permanently when updating the DAC synchronously.
> +    maxItems: 1
> +
> +  vrefin-supply:
> +    description:
> +      External reference voltage supply for scaling. When no vrefin-supply
> +      is present the internal voltage reference is used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - avdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@1 {
> +            compatible = "ti,dac8163";
> +            reg = <0x1>; /* CS1 */

Comment isn't really needed. The bindings already define that this
is the chip select. And I would just use 1 instead of 0x1. This isn't
a memory address.

> +            spi-cpha;

Missing spi-max-frequency and spi-rx-bus-width.

> +            ldac-gpios = <&gpiog 8 GPIO_ACTIVE_LOW>;
> +            avdd-supply = <&avdd_3v3>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d238590a31f2..314f235332f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26394,6 +26394,12 @@ S:	Odd Fixes
>  F:	drivers/clk/ti/
>  F:	include/linux/clk/ti.h
>  
> +TI DAC8163 DAC DRIVER
> +M:	Lukas Metz <lukas.metz@gmx.net>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> +
>  TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
>  M:	T Pratham <t-pratham@ti.com>
>  L:	linux-crypto@vger.kernel.org
> 

