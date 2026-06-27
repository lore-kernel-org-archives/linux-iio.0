Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08A272816
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782590740; cv=none; b=nkAjlNft3PG1R1M0jLdoXMOP7TRfzyMSLKHmYLO0Vr7GyrxbxPfRnsxXIxA5aN3VkgL8wF/OyVX59WdY+3aGH9gHoJyfwzNvWU1zpO58YT6uEC2lbCAklbhX5ZK8FU6bXev+hBPPp+X9jgcgoJH6Hsppy1QpmCMnJqhxtUHjWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782590740; c=relaxed/simple;
	bh=Fti5RitrHgLtVut0VLG1wOwpVmHHhems5mNTGTJkbvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM4BjJTDLeY1Uc3Nj3hfymOjNa29gYd0nNCfVErhZrlCpAVsZElYT4HdBkJr5XMqEHCPzjmD/uwo4Uyr2Hp6K8Jrmaqfhtao6J0Os8AOCHWHeGKxl1qAwAr2sCjgcVdCrwA8drjuK2kq4dHM3/ntdSC+mk+ZrUSIzZH4JNE8n/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dqJ5Vgei; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dqJ5Vgei"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9ca789c3bso137427a34.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782590736; x=1783195536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zw1XUzdKzMRddxWO66mJGTZ0Kc7t/mjGgrDQTnuQhzo=;
        b=dqJ5VgeiVW+VNgepryL07DXiYEdZKcw69DH+6Wr/Y1CuL5TtRqO8BvryhyJbjM41OG
         DT0OIlSfp/7VkBx5KvpIDfVxX8L+D8wFL2J+PrRPJaSOLiMUp0dpQGQGFKWcplb0KfKy
         Da06ToWdMp3sXAkj2IYRCwXKQPj0QeBN+ycdZHCd/3KFPNjZQNwRruajhD9L2BTT41pZ
         L+Xo9rk1hI5rm0+2scA2n1hs2RoQsEwwxYhwhogtb9YyiCFtq0nV7pebJAN3KDUMZub5
         qbC/CiuKacOo3lXadNVlsqbMJgLTgvzOxWQkMwcqhuCWOSEr1F0Jw4bciG8VXLxP4D6a
         VQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782590736; x=1783195536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw1XUzdKzMRddxWO66mJGTZ0Kc7t/mjGgrDQTnuQhzo=;
        b=UuP6pDvHJWo+PNA1IPt+8woTA+ZnPaQ31w65XPus5SmhmpqjjrrxP38a051Rkrgxrg
         M77NA+BIVXjSxjgLwAkr4LzzC0XUoO3QZzhoHPZ7MC2ARl1vR3bIybJ9oxs3P20HumLJ
         5rvJSxKtTJtdjB8KW1OChE38RtHSerhaab3v8tzQNwESXhsMsMvV9wC8lq4ajzImLwso
         wMA4nk5vORwb7YOew3rakZfexyIKbAZy9IMHbAnzfHjJaDW/+9u2QLEs72i8Nbn7E8lz
         kOlIKo8YyPEHxVoUHiu1LyjPDMs4i9bUxbvB3qn+wr29NQUKAS3K4bqATUzFwvURH7Yf
         VSIg==
X-Forwarded-Encrypted: i=1; AFNElJ/wfHBhpzbjFuB9Jva7w3aayyn3ea9yyDhl7tnuBV5/wTZmORG7isJc0kOPC3zWjywA2BWp6OgarIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNl4a2os01dr80hnvETAf+x5Iwl8qjS4bAkGcMLidrXgdcTiN2
	PFPlV+aaq2S9125VIUAMC30/orLZCyzC34fmG7BxT3jujpkQM7cy8Gd1IekVfyYaUtw=
X-Gm-Gg: AfdE7cminDf+m3Xoevn8NvYzYXAW91hzVwtQ+Tz9GZdyOoZMOTKd0U4iLDvy8sHzowF
	fLu//H42RTo1LeQlJAzFZ0BKkqCLd5OJJIAwlrDxjGEqupdqZGwBeyauMkQxcLxlrvWhSZsjIRZ
	PY1ispejR42B3VMo0xQVn7fBoe8661jYYPPHeRQeGLds+XFPMqdnVtoz3kuObCLJ/XDTlA9ilse
	PLf3bu9wtlLdEmYdL1KjgWMq/I6Ds8sPRo3iHUrkNQI2D7xqV0ZYOiCc02UCdBKmy8YqR6UK40n
	Qz9AyvjAqITltUXoHZPEa3BeV2Hcs3rS8HGKhke7XvBKbt2AUlBGO99e5lBVQ98bwIumtFe8RvH
	SeVBQ0VMDM/SQuyOUmQvF3NJhByrntydAkLyU/q5whlquyVvuY0SDriMYXbSVifygcNkyPfriCY
	K2U1fsmr+yGM7OVEI0ikp9FGPVtCbPpLI54oat2OFpjvBdcU8v63I5I10nW/bZA8g=
X-Received: by 2002:a05:6830:a0ca:10b0:7e9:b34c:ce3d with SMTP id 46e09a7af769-7e9b34cd128mr2742074a34.18.1782590736281;
        Sat, 27 Jun 2026 13:05:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa57a229sm4889712a34.4.2026.06.27.13.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 13:05:35 -0700 (PDT)
Message-ID: <40485b4e-6585-42a1-9b84-3019328574c5@baylibre.com>
Date: Sat, 27 Jun 2026 15:05:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Chi-Wen Weng <cwweng.linux@gmail.com>, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-2-cwweng.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260625110638.38438-2-cwweng.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 6:06 AM, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add devicetree binding for the Enhanced ADC controller found on
> Nuvoton MA35D1 SoCs.
> 
> The controller has one register region, one interrupt and one functional
> clock. ADC inputs are described using standard channel child nodes,
> including optional differential channel pairs.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> new file mode 100644
> index 000000000000..ae7ad0f7689a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Enhanced Analog to Digital Converter
> +
> +maintainers:
> +  - Chi-Wen Weng <cwweng@nuvoton.com>
> +
> +description: |
> +  The Nuvoton MA35D1 Enhanced Analog to Digital Converter (EADC) is a
> +  12-bit ADC controller integrated in the MA35D1 SoC. Each enabled ADC
> +  input is described by a child channel node.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-eadc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

Datasheet says there are 4 interrupts.

> +
> +  clocks:
> +    maxItems: 1

Should there be an optional vref-supply for the V_REF pin?

Should there be a dmas property? Datasheet says it supports
PDMA transfer.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^channel@[0-8]$':
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 8

I assume 8 is for the internal batter voltage channel? Often, we don't
include fixed internal channels like this in the devicetree since they
are always the same and don't depend on external wiring.

> +
> +      diff-channels:
> +        minItems: 2
> +        maxItems: 2

adc.yaml already specifies minItems and maxItems, so we don't need to repeat it.

> +        items:
> +          minimum: 0
> +          maximum: 8

This (and reg) are uint32, so don't really need minimum: 0.

Also, I assume that 8 is for the internal battery voltage channel, which
wouldn't make sense as part of a differential input.

> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        adc@40430000 {
> +            compatible = "nuvoton,ma35d1-eadc";
> +            reg = <0x0 0x40430000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk EADC_GATE>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                diff-channels = <2 3>;
> +            };
> +        };
> +    };
> +...

