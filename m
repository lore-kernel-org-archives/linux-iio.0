Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62251413220
	for <linux-iio@vger.kernel.org>; Thu,  9 Jul 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611812; cv=none; b=BB+j0hQ9Tv5P6jX+O1Hq7qfmlHFSdwfaDKvTepX/gq8czzBM0GO8pY9csLdrqlcf+1H1iYI5fBEg0PNBYQoM5iIH8KVjGq25aQPcYQK+hMI2nwjwwJCLTixvmUgE8Rx+ggXz09n+Kt8K9dVpCPABJQJ7QMH/TeI7uDbDEA6NMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611812; c=relaxed/simple;
	bh=46Vxt43agJazPbO88O2vqw7lt9h7u00qTiJXc2dgbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORl8HIep9bTdcR+53NjdHPmc3ipJHb9xk6ZY3Tkk/wxFawCBvSd0vW2qVIpnaCAL8FpAaGFEFnvIZsHNelRrdLGnFXizRCPdRfPgwT9ztVYl35xWN4FVnTFSiOVnrQUg5Fve/2blioAbjnkBbZ6m7GCwxdWIbwetXlgx4b5m2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gEYXdEq9; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gEYXdEq9"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso4010a34.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Jul 2026 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783611809; x=1784216609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K71vA2rRxJHnRmY4YuInHn+JTOnkMM3kjsWFyARkKU4=;
        b=gEYXdEq9nRZbXdd/wrFq1do5TqiYjXSW94459W5MmhV5Xeyaf/hcrvCvUVGE448PMK
         TQNNjHq9f7FqqO7N46i7+rAJmwaQmOoza3zqAz6hqFi5qWRpKW0LCGUCMHcrmFcr9Ihw
         7gIGBpwxuSlCQiffMs5I0nTRgqeKS0Z4ZR7I6Ip/RpA1/JdIznKiV2cUcHhkjAOFDOy7
         Vxzc7D8/gAlXaCfBsRtO1cI9Y2+3KcdmuMrD54Gj+I/x6H5W2FvLl5eVu+7RQHvVgy6Z
         ylQGXLubndBym826n7XPXDijePHj7mCAZP+HlKbLfMkKQUjFIjw2C6hgPz4saxTVPMi+
         up5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783611809; x=1784216609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K71vA2rRxJHnRmY4YuInHn+JTOnkMM3kjsWFyARkKU4=;
        b=ZRnisJRJCzf9MDqfIp2okpmJVrAMS1p6Mltowk1uih49jGwKwMPMiIe1/C454GDW4w
         06hzjMjxO1aJ1uhaM1BWGJHmwrejNV9hhKc6GEgQ0TuUVHHxrPfN0QTCAVkVXIe56FLK
         nCmY5oCIM/oAeIoz5QDddd6YHY0ObpKH+kfh/0zVSWOZA41ZcvGCmyAZ+dnrKDInMmyb
         XF2Z1Mlr0PKm5FcjWxzjl0knG04fo8kgqNYcv3UQwDZOsyfnLdArg0U8rGPjQvq7zbEp
         T3Obe6SxNEmHVbyMqezaoe9j6xClI3Ebjlp/QwhBRobaNwKZuhrgSpmYCvuiqWji5rmh
         49Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+lH0JWdvKxdNQhmHFsRdcg9MIVzhTVLWk4m3jHEPmRzV7K9tgXEnk8mDtPNjNBpRo6VGdaYcEOnlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bWjSXS41muMD3WZBYalQBUQszVN30Xld5GmXbkvt+2gRH6n2
	Ypho74owL/sz68lyj2LRzqzs+V7NvJRMZoyAwT2XhNmafR2TuWvSuC89xEdRHhN+GbU=
X-Gm-Gg: AfdE7clZdXOmJUwi9hYnfOTy9/gCD4ziFH1n3QP/FkWykRV8zI19R0WTY0qABHpAKka
	hF+Z8BIz7a6ZgncFYPTLXhuYsCOnE1dX4RAn44UxJ3jZQ9FvsE+KAe1ZLz9vXmaeowjS2SFpgJ+
	q2pk+l+an1MjV5dE5y7DrB9APAoMh6Di33xyr77cazSp/QnAMjen+PfAeXk6CH9eJ69OczOBl4M
	ZFeVg34k0a5n+qC4K33ezJoVacHiJDTFicitEDPnWJ21euKzGLWRelSMCGGYcYg07a4zhBSD/PM
	dXSVR7M542TrYR3UmHdQL1f1A34VIQRu0n9GB1kJIwdmXXrHjdlYlklWOHZeKs1PWc8rqvUfWbv
	uMrUs9vkmGNg6bNeO9rfeP6g0IJFSVJsB5+OVQ+vLr3gNcEAVVdXlS50KRtntkv4zkBk2WK7gmh
	VJVZtMGraPyXo/YbKk+ebBzr7nTEfGCD5de3sYQP2s+yNLkLl2lQg6VQwAEa+tdSM=
X-Received: by 2002:a05:6830:82bb:b0:7dc:cdea:7d9 with SMTP id 46e09a7af769-7ebcff82b2dmr5550730a34.22.1783611808795;
        Thu, 09 Jul 2026 08:43:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:2a8b:8d9e:f359:9a35? ([2600:8803:e7e4:500:2a8b:8d9e:f359:9a35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f27besm4343356a34.25.2026.07.09.08.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 08:43:28 -0700 (PDT)
Message-ID: <36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
Date: Thu, 9 Jul 2026 10:43:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
To: Janani Sunil <janani.sunil@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 3:50 AM, Janani Sunil wrote:
> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
> simultaneous sampling ADC
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 285 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 292 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> new file mode 100644
> index 000000000000..b74fe6aef01c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> @@ -0,0 +1,285 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7768.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7768 and AD7768-4 ADC
> +
> +maintainers:
> +  - Janani Sunil <janani.sunil@analog.com>
> +
> +description: |
> +  The AD7768 is a 8-channel, 24-bit simultaneous sampling ADC with configurable
> +  power and performance modes. The AD7768-4 is a 4-channel version.

Probably worth mentioning that this binding is for SPI mode, not for pin control
mode.

And that the io-backend is for the data output interface, so consumes the DOUTx,
DCLK, DRDY. Maybe also START? And SYNC_{IN,OUT}?

> +
> +  Datasheet at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768.pdf

A link to the example HDL project for the io-backend would be helpful too.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7768
> +      - adi,ad7768-4
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Master clock (MCLK)

Could also be XTAL{1,2}.

> +
> +  avdd-supply:
> +    description: Analog power supply AVDD1 (4.5V to 5.5V)
> +
> +  avss-supply:
> +    description: Analog ground/negative supply AVSS (0V to -2.75V)
> +

What about AV{DD,SS}{1,2}{A,B} supplies?

> +  dvdd-supply:
> +    description: Analog power supply AVDD2 (2.0V to 5.5V)
> +
> +  iovdd-supply:
> +    description: Digital I/O power supply (1.8V or 2.25V to 3.6V)
> +
> +  vref-supply:
> +    description: ADC reference voltage supply

There is more that one reference voltage input. so ref1-supply, ref2-supply.

vref is the name of an internal signal, so doesn't make sense here.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the active-low RESET pin
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  adi,data-lines-number:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +    description:
> +      Number of data output lines used for serial interface.

This could be made a bit more clear that this is a secondary data
output interface, not the SPI lines.

> +      AD7768 supports 1, 2, or 8 lines. AD7768-4 supports 1 or 4 lines.
> +
> +  adi,common-mode-output:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - avdd-avss-half
> +      - 1.65V
> +      - 2.5V
> +      - 2.14V
> +    description:
> +      Common mode voltage output selection.

Why not using standard regulator provider bindings for this?

> +
> +  adi,vcm-power-down:
> +    type: boolean
> +    description: Power down the common mode output buffer

Is the buffer separate from the output? In that case I would expect
buffer to be in the property name, otherwise this should just be
part of the enum options above (and the default one at that).

> +
> +  adi,power-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - low
> +      - median
> +      - fast
> +    description:
> +      Power mode selection.

Unless there are pins that control this, it seems like it should be
left up to the driver to decide how to set this.

In this case, it looks like the power mode also influences sample rate
which is normally something controlled at runtime.

> +
> +  io-backends:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the device.
> +      AD7768 supports channels 0-7, AD7768-4 supports channels 0-3.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +        description: The channel number
> +
> +      adi,ch-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 1
> +        description: |
> +          Channel mode selection. The AD7768 supports two independent
> +          configuration profiles (Mode A and Mode B) for filter and
> +          decimation settings. Each channel can be assigned to either mode:
> +            0 - Channel uses Mode A filter and decimation settings
> +            1 - Channel uses Mode B filter and decimation settings

This could probably be handled in the driver. E.g. allow per-channel settings
that just get stored in a data structure. Then when starting a buffered read
check that all enabled channels have at most 2 different groups of settings.
Then do all of the required register config at that time.

> +
> +      adi,prebuf-pos-en:
> +        type: boolean
> +        description: Enable positive input precharge buffer
> +
> +      adi,prebuf-neg-en:
> +        type: boolean
> +        description: Enable negative input precharge buffer
> +
> +      adi,refbuf-pos-en:
> +        type: boolean
> +        description: Enable positive reference buffer
> +
> +      adi,refbuf-neg-en:
> +        type: boolean
> +        description: Enable negative reference buffer
> +
> +    required:
> +      - reg
> +      - adi,ch-mode
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - avdd-supply
> +  - avss-supply
> +  - dvdd-supply
> +  - iovdd-supply
> +  - vref-supply

> +  - adi,data-lines-number

Suggest making the highest number of lines the default instead
of making this property required.


> +  - adi,common-mode-output

Should probably default to disabled, unless it is always used?
Changing it to a regulator provider makes this not relevant.

> +  - io-backends
> +
