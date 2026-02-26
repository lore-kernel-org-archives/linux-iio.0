Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4D3D3D15
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130824; cv=none; b=B9VejOxQeKDiUrL7cJSv4Acb1Sj+Y9pZ5dbGV5QhpzMhMgPV+p+2ewSNYTH8h5lDBV+NNhYh4seyekzuckn/2hi5J5QFld1kV3K8Hlb+1jRbzK0ChbyiKW8ONBsVS0WXUjqtxDZ1jfgvoH0/Hkrco0C8JGEaEAl/6qdP+jBUf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130824; c=relaxed/simple;
	bh=1tGyrjrefZFBFYuiY5W3I580PT+gFhCEdxPhb7EAQk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1krHZpY1FnQGDk+VhtaOlL1ASFpM+9amL83EQmag34lN7LTRVcAi7aoqihseMNxBuCzIaF7hoAMPXMX00OIYYazjsy9jEz5nQg5OZgB7sF4vWmeUYyPcDNmKvXGAmEMO82iNfTBymKCQAGKp1YKm8A/PqqMlldZyRv4MeDfcpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MwBHuBlb; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MwBHuBlb"
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-662f2fa7e67so512255eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772130820; x=1772735620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/5cjoh5WVMRBP0Xk9oZ5/S0VwEnukyl5VAKVEVtxPQ=;
        b=MwBHuBlbF9+gKD3Swr0h9tKoz8F0AMLOvz9VM1eElSmLIETVX+sqAHoKTJixs2HusX
         5WlZsSd3neg22xMVY/ZwiG/7/cymosZa6Rz0AQJ+xCkdlmW7i72KrhfKpR6Vye/CoMSO
         aJvRLwarcrau2pOblxD4Dv5zqad41zNTq2GJOg9q0qrD/Eo/D/m+3iBhZxveygjbZtZV
         NkCpst40r2TXGQpD6bq4J65l+NUQVmdnvGOWqDDMppJYmxGkvB4pGUvF+rL7zKVpJ76/
         ff3oenNpzZjkNJu8mJCsZd3pU6UW8j8W8xts9qUNeTBZst1npnWmIjEw609Vr6zLNR3k
         aOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130820; x=1772735620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/5cjoh5WVMRBP0Xk9oZ5/S0VwEnukyl5VAKVEVtxPQ=;
        b=bL3eBDX6l35iGtRExJPgymlmLrTurG+PCh4lx6Kwo2CAA9zfOvRuZ7HIMlZgpjZXQX
         Qok31Id+3Bcz2F/c/6yPTMlNWCgkKoPrQ2ykTHoFTRh3RDPu+Rq0k/UrkrWgj6dfL2V/
         U4FPN9iqEj+3fe43oygxCKur8x2E4yF68/Ahcv0vuVLVrMDl7Uv+ukLjNRmShU/5Sapz
         mE/rxfyB6ugAs2bkLnnFarMVb83M7Q9dJ9uwjX/J1xMTANQee1g9xT78EyK8wnp8TbcV
         bjG73SPpUkncMesmuTUDR04HNiBF3dIdi728B7b6/nnjleT+lXDX7jdKKXTMIjEcBBO4
         2ktA==
X-Forwarded-Encrypted: i=1; AJvYcCWkVA2GgtzqRooeQY27afSAmRXGbhTXFpe0I3LLIBZzkOjSFRx1vgqgoX89At1OU+kJLjMmq31V2SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/fSv08Z54iL3ovS3EiBDsWRPQOOy2xagjqPEkt0c4/cs5cSb
	fmtpFF6yxdkXSNoAz8SqLyIhjzOkDIhlr3myhD5ObA8vz71zuslroBdgWOh3Jyd8lIc=
X-Gm-Gg: ATEYQzwvt+Oe+5dRrUkIiIm2i5gXNJWGddS6xsnrU9gflKnKZmaKBzVlRSZMEE8BZ7E
	IdobP7+Urr8SZcUASmimeb6vr3dFu1LtbRD1UK+9M+xIUFbrq1+8c3qnSoHWlAkuk98M+mN/qQz
	r+VD4GjfEqv1EJcsjmEzT/nKC+xxd7GfK0aGmEQTKqlB2U7jq4sRopHFP8QoD3nAteA0tzJ+ogp
	SAvc8XMmyqodcVZTQSphimNHVT0xjZE4ihLGTsJ2jtkvcoqDipuG9LZw5efTso2i3PHZPBbyYOx
	3eUOXDUTTH5oHhTlCj4qrcpEXIpgWYCE6T8bPrOjDaJYjyClJrV+5FQ3lW2wXmU38/KA+SGWIqP
	jMHNGlVEUppF7QaMsQhfhQjp3xfdyJlsicBfP46GfMrMPzHwQOf3OQNqdckJXvIyYitesj6cO7w
	BLP1zNsnDiauG9SECN997TnlPG1Rtsy/QQQjBpzI5hipAq+FHB5zrpQAys725gZCJ7rCdsna+Al
	w==
X-Received: by 2002:a05:6820:20e:b0:672:a49f:1291 with SMTP id 006d021491bc7-679fadbf66amr168019eaf.15.1772130819691;
        Thu, 26 Feb 2026 10:33:39 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:602c:a8f4:3667:524c? ([2600:8803:e7e4:500:602c:a8f4:3667:524c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf239e0sm2680245fac.1.2026.02.26.10.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:33:39 -0800 (PST)
Message-ID: <8ff054f9-c22a-4108-8a9b-6ddb49e18dcc@baylibre.com>
Date: Thu, 26 Feb 2026 12:33:38 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: add ADI MAX30210
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
 linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
 <20260226163041.169786-2-johnerasmusmari.geronimo@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260226163041.169786-2-johnerasmusmari.geronimo@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When there is more than one patch in a series, please include a cover letter.

On 2/26/26 10:30 AM, John Erasmus Mari Geronimo wrote:
> Add device tree binding documentation for the Analog Devices
> MAX30210 temperature sensor.
> 
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> ---
>  .../iio/temperature/adi,max30210.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> new file mode 100644
> index 000000000000..80aeae23e0a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2026 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/adi,max30210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX30210 Low-Power I2C Digital Temperature Sensor
> +
> +maintainers:
> +  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> +
> +description: |
> +  The MAX30210 operates from 1.7V to 2.0V supply voltage, and is a low-power,

This voltage range doesn't match the one below.

We don't really need all of the tech specs here anyway, we have the link
to the datasheet.

> +  high-accuracy digital temperature sensor with ±0.1°C accuracy from +20°C to
> +  +50°C and ±0.15°C accuracy from -20°C to +85°C.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max30210
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |

"|" is not needed here or below. It is only needed to preserve formatting or if
the text contains ":".

> +      Analog Supply Voltage Input. Must have values in the interval (1.7V; 5.5V)
> +      in order for the device to function correctly.
> +
> +  powerdown-gpios:
> +    description: |
> +      GPIO spec for CVT/PDB pin. Should be configured with GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Connected to INT pin. Should be configured with type IRQ_TYPE_EDGE_BOTH.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply

> +  - powerdown-gpios

Is this pin really required? Seems like it would still work with this pin
hard-wired by using autonomous mode.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/pwm/pwm.h>

pwm is unused.

> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";
> +
> +        temperature-sensor@40 {
> +            compatible = "adi,max30210";
> +            reg = <0x40>;
> +            vdd-supply = <&vdd>;
> +            powerdown-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...

