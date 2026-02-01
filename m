Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170F23D7FC
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769971514; cv=none; b=cbzmBc4WowL7SEA8sqyPJSIYScCtmE2YTNox7uOki9qQ5ZAIx5FAGQyaP5lVdFDzV6waDdADuMDDBekx4x4jKYygBnQeWcda8NV9o5fkLNei4s9dlx6Il8NRrzEZ26dAPSISCSb1qVgNe7iXnm9m6THTSk65DDL2VQjs0j90WbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769971514; c=relaxed/simple;
	bh=LQgQQD9AmuPzorHnhKvFOzsRBup414VCck4EdvcVNLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7l6jpDLmXPD/RrTalJV/8ORJzSsG3WVVvWKNAJPu9ZN0kXV5+E2PEMQFp6GZ/JK3A63x6vizdM3szFshNJdrV1/gUgHIZnjdEw9hRh52cpbX9YgtA8U6fGYKVo6hP8oLf8eyWzp0+mGFyUbHgNKTZVXTe4RPPBilNChM1ynbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2AL3TAQ3; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2AL3TAQ3"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d122733808so1494227a34.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 10:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769971509; x=1770576309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Akl38qoflsvYXDrfSQS4UdKQ+8WjmfeZhRt65gKmSWg=;
        b=2AL3TAQ36k8/kME8b7gM6J0TI3/G9vFX5oPb6PJBT9JRSyY/Q8tplyzhCchG2AcCGX
         UiuRIameoV5ChfR4wMML1uF/xrr20bTweofEmoh6vXOurUsqyzQXOfHDhMO8dzFTAqE6
         d9XlFg2ySdpiiCEJnyQGrch2rBGIej32os8hwVbmdc+EdWsU9gUMrb/qB9fcOwoqTgTn
         lbJYGrCmB/bhY8/4aBSEA5ByRb0fY+OVXAD6AgEtxIp68zddTsbzTHHqm7kCHWsS+sH6
         A3wtfU+L0AhMjYQoo7kFdi2gt6C7oMJey9xJkEFAUnO6121QlbRQ5i26S3Lc526gO6y0
         sALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769971509; x=1770576309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Akl38qoflsvYXDrfSQS4UdKQ+8WjmfeZhRt65gKmSWg=;
        b=QRz9r6CGyDx8U/bUvAXbOegR3sn0YoUbDgqMtk4IKGeNgXveUJpvb3Q7r6KwZXvFVo
         hDLowTcOqANzdIn/ArFh67ETm7l+YhmA2v0Tu7uPU/gdWDofLbKHsVsj9i2iI648lnlc
         z5eVr9M+oQnScdrTN/NGC8InWA+OoAovaXMaRxCLeTF2r+sopZeqSW6k/76r2TRw+Zgy
         uurn6Af5gSV+fDzpNyW4mAmVlkWFIVcXt9qwuyNbI4/fFMdJuMen0e2lSosuVFM4GXvT
         RZG+MrElUZ9sCbeHbQdyiivRvpcNAzVFbw0kvOB5yCWWLrhFCYiwaZDPa2zNa0SI+kNu
         yXrQ==
X-Gm-Message-State: AOJu0Yy1hZuCfJh6oZvAMCBVPQO7jQEmPzdJm6FIOgxl+Ew8XpiTl0cm
	imt7bLdECiakEOBnfCDjOziBiJ/gkVYTyc0Js7kfy+74BbzUASYqShPR0qjVpj/QcMY=
X-Gm-Gg: AZuq6aLVPJ9DoOlWusDZlBS+CgEJTKszSb5w2jKFyWgHziQsIwZBFrnDnXu5Q6F22rV
	0xpWgPeqJhUqg+YJh8+3xgADkgYN3nnsL5OqWiNa02W6cmyMIDpz7Zxfk+kBUIVLLKK+MqM7wBr
	xQFQWsqMppZWSqSRN6G7MhN/J1NPSFGAmlM+UQNZQF6Q80pwPveU4KRNIwVHufzgs0bhOPM44JK
	SGyKrKbGok8aeJdtps/sDPjzTAaIZBpM6wSsNq7QjaBnBte+IygyqFgqTYt9gywU0yM7SMS0LEJ
	+7/s8jv44a2+j3J7rXPsjVrm0Fp1HwTTp5ErCApkJkOsSpx7Xbe+EGuWq4GZ9ySKzwOSPvdB7QA
	JgvTEDfYn55kvgk1HuiwMDm1mxCv5gRQkAORg7hXWEYcEEUNOZlyGp3vpxS/Xc3Q7k5xzFrOZ0M
	wnTkYtdFh5WrSfzuUpmavvEJ5IaabR7RsSIo/JFWtNtMCqomXCYIDwaVoPp/wl
X-Received: by 2002:a05:6830:650b:b0:7c7:5458:75f8 with SMTP id 46e09a7af769-7d1a53284e5mr4480816a34.29.1769971509098;
        Sun, 01 Feb 2026 10:45:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:66ee:10f7:4858:7df6? ([2600:8803:e7e4:500:66ee:10f7:4858:7df6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm9327775a34.6.2026.02.01.10.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 10:45:08 -0800 (PST)
Message-ID: <fe99b154-dd88-4fd0-86dd-a61db84d6bfd@baylibre.com>
Date: Sun, 1 Feb 2026 12:45:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: Add binding document for cm36686
To: Erikas Bitovtas <xerikasxx@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
 <20260201-cm36686-v1-1-4949a2a9ba63@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260201-cm36686-v1-1-4949a2a9ba63@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/26 11:03 AM, Erikas Bitovtas wrote:
> Document the Capella cm36686 ambient light and proximity sensor devicetree
> bindings.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  .../bindings/iio/light/capella,cm36686.yaml        | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
> new file mode 100644
> index 000000000000..5f0a585e3d87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/capella,cm36686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Capella cm36686 I2C Ambient Light and Proximity sensor
> +
> +maintainers:
> +  - Erikas Bitovtas <xerikasxx@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - capella,cm36686
> +      - capella,cm36672p

The cover letter mentioned that one is fully compatible with the other,
so we should have a fallback here.

  compatible:
    oneOf:
      - const: capella,cm36672p
      - items:
          -const: capella,cm36686
         - const: capella,cm36672p

> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C slave address of the device. Must be 0x60 for both cm36686
> +      and cm36672p sensors.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Regulator that provides power to the sensor.
> +
> +  vddio-supply:
> +    description:
> +      Regulator used to power IO and I2C bus.
> +
> +  vled-supply:
> +    description:
> +      Regulator used to power proximity LED
> +
> +  proximity-near-level: true
> +
> +  capella,proximity-led-current:

Should use the standard -microamp suffix [1].

[1]: https://github.com/devicetree-org/dt-schema/blob/d16dc68b093e59ec4ae6a32a2e1179cb9cc0fada/dtschema/schemas/property-units.yaml#L86C4-L86C13

> +    description:
> +      Current for proximity IR LED (in uA)
> +    $ref: /schemas/types.yaml#/definitions/uint32

Then we don't need the $ref.

> +    enum: [50, 75, 100, 120, 140, 160, 180, 200]

Should have a default: value since this isn't a required property.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg

Power supplies should be required.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      light-sensor@60 {
> +        compatible = "capella,cm36686";
> +        reg = <0x60>;
> +
> +        vdd-supply = <&pm8916_l8>;
> +        vddio-supply = <&pm8916_l6>;
> +        vled-supply = <&reg_prox_vled>;
> +
> +        interrupts-extended = <&tlmm 113 IRQ_TYPE_EDGE_FALLING>;
> +
> +        proximity-near-level = <30>;
> +        capella,proximity-led-current = <100>;
> +      };
> +    };
> 

