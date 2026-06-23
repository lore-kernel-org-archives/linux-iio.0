Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E11361DBA
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242227; cv=none; b=IqosD8mWxhpyk4fQ66zulJZzCNYY46QcgnKtocak4Zg7GP4sR2UUSvh278Q1XRqkK9T5PSwVFB7thqbxsRU6eLw1wo1TQHebP4srZAMwv9V3Z3CwFdw8jL8MOcDLLwyVKWKA4JiajEtIOKco+6Ag9v8OXVtxTTQO+oNjvq0irDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242227; c=relaxed/simple;
	bh=GZmwz/eq3EH0776LVBkc/Awev7J2/zhL0s8H3paK49U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/d63k5OBaBQhXAWdYtaJSXrr+CTlyNIByIRIkumhwSGPfSlli642GJxRKWy98CJV1hbfK+JEymEnU8RJ3G3hRu5XEmqReTwPj4xDtDEnenKWmkA4CA42Zf7K+di1tGcJMwZnzpoNHBb88ITpzo2hi8G22iC2qXXuQkbxKpKr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PY8EWM+Q; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PY8EWM+Q"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d8f70cb0cso193212eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782242225; x=1782847025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlgARPWBHtV3qLgQWXpXHi/OrSl0JXhyJKYyRqQxSsc=;
        b=PY8EWM+QlzKiF4U1MHeZcI6SlAQgwwkIYoMyrhJ3BEyQZcriPpHHmQC0TcGgyYtv3A
         B7yCE2xyjkXUBD7KbnHu502hRMHogfJNNtMMotMX+FocSN6u0vsXTz7+y2gbXFoC7Vx9
         R/qp2f832WcIGxBYBgBf1EOuPF9huZS6icB95pluA8s/GIzH48wCyCY10oSNiMavENKI
         kInPWxbjJnO/b53lYe+36sEo3ywNki2SCPSAyEF79WtVFy4H7JBkOXplxkgfTVcdewVx
         h13F+QzxgxO9hW1ICJJ3XmJIQ0McOH663KILLBWmdD0fQetBdQT8TIUhFhlgMaG7/oEB
         25Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242225; x=1782847025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlgARPWBHtV3qLgQWXpXHi/OrSl0JXhyJKYyRqQxSsc=;
        b=VBnu09CD+lRSF1c6QPkmwQVSLP02shCFNqtYyxF5rERjzWBzAsdtUc5vuhNtoXOjPr
         rfC2QGKJh6ApTeMOqQIPzl2f/0Gv1njyahJMpCDnh7Kwl/nvJfaFWqwXykIxqxZAGovT
         +MD4iq5Ep6HYgD1S3VrUZzRaRoQ2SoMVC+JBxPe7p7jFTC3oYeRUN+VCf1XgtUrbHmRY
         hCRyXC1f8gNepL7m7KCyK9RiD1UxC3eqDBpFfhveYVkVP6K2fFEw2Qq/RY6nSekVf5Me
         3gbixtQ1jTbiQhuIyOkZbI/gzgYEbCJ1WG7cV8iMDB0pR28USliBNcqiCbvRhr5C/XkL
         Twvg==
X-Forwarded-Encrypted: i=1; AFNElJ+fbkVVQswY7AnyoU7TLItNBQ1cZtNLyAv6qIsWlib933C/DTeavOJmeXUm95jWU7UYcXnT+ixNIfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/2DgyjiwKb3y1vkMFPu6y4TCMikOHvDVHTcM1N9xbx46b2Eg
	BAU0OqP7aneL9+gWGOJiK1e7UfSzZIgpWAn4nHypreczDSLGaZAxeddKGBI6y+xqh/s=
X-Gm-Gg: AfdE7cn2hpu6P5T7+KYjDmg4vRdJFcwG+nnad8lPncccVUmvo1pylm1Ny5rb0LK3P++
	M9pg2w0a/okxqN8lpFHUCXTEPgmvmERN/3XCFpy53pJGHlXGZNHbeA1gNq0inpp2X3pjHbAc6B0
	nn8+uM9y4pr0Et5UMz5YISkr8ULrFwUYcLfOfnszMHUcA5+01fCJdonmFHSANti0QsELeahGGwO
	ZGakok3OrVDr2Zl5/lJKWhLWzfDQfBruDKcsz369WRYkPUMdemsjRo7T6GlotpYvZUxyaF/62FX
	BFAeRVMcAyAUHxspHEk0+JGC6sL1aRgwtDMef/2JJVUMiSSp8nFE6YPkAyt9TWza7vIKhdOS4hO
	34ap/Eaq9ys1qOlBQT1l0TvRoWILpLdGkvNgn2vNJycbPUyZubrR24TMGcBrTPu6WwClcrVXR9b
	ivRfv4OifozGWXBckKX4XXLzQnLabKf0hOHaOFSgrk29666plbUI2/dYwTUC+IgYlXmAa4hJ3eC
	Q==
X-Received: by 2002:a05:6820:617:b0:69b:36d5:dd52 with SMTP id 006d021491bc7-6a122e2a1ffmr78642eaf.9.1782242224879;
        Tue, 23 Jun 2026 12:17:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f2a4e9sm7485652eaf.2.2026.06.23.12.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 12:17:04 -0700 (PDT)
Message-ID: <5a19c272-e8fc-4fa9-b137-842b6ed6649b@baylibre.com>
Date: Tue, 23 Jun 2026 14:17:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: Add DAC8163
To: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is more logical to put the dt-bindings patch first in the series
before the driver that makes use of it.

On 6/23/26 11:07 AM, Lukas Metz wrote:
> Add device tree binding for the Texas Instruments DAC8163 family
> including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.
> 
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
>  .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 75 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> new file mode 100644
> index 000000000000..bb4bad389323
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> @@ -0,0 +1,75 @@
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
> +  reg:
> +    maxItems: 1
> +

There are a couple of more SPI properties needed since this is not a "normal"
SPI device. We can only write and not read because there is no D_OUT pin. So

spi-rx-bus-width:
  items:
    - const: 0

will describe this.

There is also no chip select, but now that I am looking, there doesn't seem to
be anything to describe this.

> +  ti,loaddacs-gpios:

This should match the actual pin name. And we don't need vendor prefix on gpios.
So `ldac-gpios`.

We also want the binding to be complete even if the driver doesn't all of it, so
`clear-gpios` and `sync-gpios` probably make sense too.

Usually for SPI devices we also add:

spi-max-frequency:
  maximum: ...

> +    description:
> +      Pin needs to be asserted permanently when updating the DAC synchronously.
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Reference voltage for scaling if an external reference is used.

I prefer to use the actual pin name, i.e. vrefin-supply.

And for the description, it is the actual external reference voltage
supply, not just the voltage.

And we also need `avdd-supply: true`.

> +
> +  ti,internal-ref:
> +    type: boolean
> +    description:
> +      Flag if the internal reference is used (external otherwise).

Usually, we don't bother with a property like this since it is redundant.
If an external reference supply is given, then it gets used, otherwise
the internal reference is used.

> +
> +required:
> +  - compatible
> +  - reg

avdd-supply will be required too

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      not:
> +        required:
> +          - ti,internal-ref
> +    then:
> +      required:
> +        - vref-supply
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

These chips don't appear to have a chip select pin, so this comment
doesn't make sense to me. More logical would be to just use dac@0
and reg = <0>; since it should just be ignored.

> +            ti,loaddacs-gpios = <&gpiog 8 GPIO_ACTIVE_HIGH>;

The pin is marked active low in the datasheet, so I would expect
this to be GPIO_ACTIVE_LOW.

> +            ti,internal-ref; /* internal reference used*/
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e82cc28e1bc3..5512f5eaab44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26398,6 +26398,7 @@ TI DAC8163 DAC DRIVER
>  M:	Lukas Metz <lukas.metz@gmx.net>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
>  F:	drivers/iio/dac/ti-dac8163.c
>  
>  TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
> 

