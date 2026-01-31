Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81636EAAB
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889781; cv=none; b=lDpleAbr4UYgyNrH61JFMDt0YQxvz9WDbwD7/yIaVvKU81RVLi1QovH8Y4SWgRYE7A+pg4gnlvZM0akTrWvgHgcq8H5EK2tnHARN++8QVoLpFlhQDbLDxbS9xf/6YVvaQLP3KXSdFmTwvINIXQWM/lpIWKTfcDJDW2YnqDw+wcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889781; c=relaxed/simple;
	bh=u1yuFWr3eI3cUhJQh3ws4Rrs2CjchEuu5iwWD3RXNzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJwkaXxHjzKrXyjyD0oJuHYHDtOVXA7sLHaCjuoogS+MEFJ1nusM4zGNHWHwKi+5xuMel/40fY1/O1THPu8fcJZio/yO9oSl5dCDKP95Lvej9KcuW+oceCt8/4k1L1xGiGGMGNV+OB5LWBhoL+rVHPTRtcBWmpLGXXgT5bL4d8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QpNA5llk; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QpNA5llk"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d148dd3421so1240038a34.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889778; x=1770494578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZjM9shHX4YFsvwKhFAe/sG0x6/ZZidUkV5AzO3KYmk=;
        b=QpNA5llkqAKdONL1eN3bd44/voICoGhTF7xLpjtkeaVlNru5AnslVcS8/AwXpiytTf
         I2UeNTRtpPlIq/+3FgpsFnQrRXvHBdE3Rx2CnjopYmqWSOoLOki6RFJAyf1hZ8bd8c/T
         Olsi+9QlG3fd+jZDGDJ19qV4pkVb2L4YirnGEmS52FpZnBDuzG285N4XheaCK2LqQriv
         y6D3/q7DKt+3I1clNCZZAAwZAsuhikMDruktXp0KPq/NkBgDWl3Kr1hZVS4uHeC+P5ry
         rFTpLReo9FvJ1SHJTpWsZxUsbfs6FcFvpZRQfVsIqIcZbCL0laSA8nzuAKjgFW517Qzy
         dBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889778; x=1770494578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZjM9shHX4YFsvwKhFAe/sG0x6/ZZidUkV5AzO3KYmk=;
        b=J5uoZ+79r1VlWOt3gNzOKwAVo8WmXz3fjmDoowrDFrp2Y6x4s7ln06yMvrwnfmvb0F
         W/lA3eVtwmsXAYKaLP0DXQ7V7h5yvXoXJblNhOI+m6bMwe3bVAF4OrZjKU3GjzmYYnfi
         vOriz8yVODUk8XLPCWIv206BKBdt/P5UT2hszlm1l+DaCt1rIIH389DdeLjRJfEHaCJc
         JGHnTLH3NCxI9g7LRCQLz+FQ+5v12TvIL3jJR8kqztx1LHacOpAmwQ+q1L9Vqe9ULfjT
         n21qKKQ+Nth06aluBhp8fuM6UhUW0rS9hc1j52Vw8qwolOmFLgWUd2u7tYY28mpCWF4T
         CXgA==
X-Gm-Message-State: AOJu0YyO8gm4swnzEJDQqchLQCC8zIrPPdYm0mvH+URJrDkfRjXbVLMB
	FejxkQ9a+wuIjTCNzxoZgZw6cCCgUIwnPUjvSTnnKtzLG3rfr+z8dqSZguuvPXhjLqM=
X-Gm-Gg: AZuq6aJPvgTRn+vdUEhibMTQV/zi8uaswAUoeexu1aHIMC4DaNonY9Z0Fyjz7XnzDM1
	lgwzeqy4EcNjGoXM5c0B98NDpU12PqbIniUdHicOv6wJxCw6RDBVHZYnIQnjRaXZzVjgRG/KsBl
	hE+379C7sACoUSqCv9aXpAxuPKAXGhqr4OxMWRhT2+nhLrnIlnFTQ1/APLYJkBIhyOHs5IxkleG
	ltOUATQGUxbZN3msD3g6fHFJ3+Fb5UF/Bx9OIUqMrF7jgiXTUb9bW/G3VVIQ4tTIRhmdptvPIIz
	3ggMqiAZPFSjxyh+VQbw/7U6cAK6AovbbE58PPhIU+paGIhNlCveF90WHbH+BnbGchziE2Kwnqw
	71UKRzhympHTgu4mP63gGnHRPOE4+od71uiEoXSQcMmWHwGgtuad7cK9H+jZZvaUBKo/K6dBuk9
	N4lf5uX16yUAWZWfCmIvt4aqvF3DmLaGM+ACn8UwqSWqArLZusNM2kDB3DhfD48Jx4HHpX6nA=
X-Received: by 2002:a05:6830:2b09:b0:7cf:d14f:a4aa with SMTP id 46e09a7af769-7d1a531026bmr4075358a34.20.1769889778127;
        Sat, 31 Jan 2026 12:02:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm7795242a34.6.2026.01.31.12.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 12:02:57 -0800 (PST)
Message-ID: <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com>
Date: Sat, 31 Jan 2026 14:02:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to
 schema
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-8-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-8-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
>  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> deleted file mode 100644
> index 0dd0076daf71..000000000000
> --- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Motorola CPCAP on key
> -
> -This module is part of the CPCAP. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> -
> -This module provides a simple power button event via an Interrupt.
> -
> -Required properties:
> -- compatible: should be one of the following
> -   - "motorola,cpcap-pwrbutton"
> -- interrupts: irq specifier for CPCAP's ON IRQ
> -
> -Example:
> -
> -&cpcap {
> -	cpcap_pwrbutton: pwrbutton {
> -		compatible = "motorola,cpcap-pwrbutton";
> -		interrupts = <23 IRQ_TYPE_NONE>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> new file mode 100644
> index 000000000000..643f6b2b1f13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC power key
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> +  power key is represented as a sub-node of the PMIC node on the device
> +  tree.
> +
> +properties:
> +  compatible:
> +    const: motorola,cpcap-pwrbutton
> +
> +  interrupts:
> +    minItems: 1

Should this be maxItems: 1?

> +    description: CPCAP's ON interrupt

Or I suppose:

  items:
    - description: ...


> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +additionalProperties: false
> +

example: ...

> +...

