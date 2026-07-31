Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07B301493
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505957; cv=none; b=AaDth3nDJtW7wTmubW4Oc9HbKpFoz5jGS7pmpYlwatZDs8itF287+VFqR3c+tP09w9UYMwXx2EQlEbmI8UvlLkvoYbPensD8006mwOg+bQ3b52f/C36+lcOCJ9f7niRdoMH0z+a4+NfYgScaxeTG1EFjQTuxTcNj1Tm5pQoh4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505957; c=relaxed/simple;
	bh=lSZ+/tv9wX7w51bK6R7N7Sqsdlr7yLBGjQShbkEuqZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iC1kIUloEhrJjOahhKQJBYS37HagCYwrw7WkfJLkffq6g+x7rcfL1rV5mIKvNTJPU8aZpLTjJdyD1T2iSRQVshg83TjLjfbRcz/Wz0j5RWH8TMI37TiDOdkNxjRrlWkFgZgijLMYmAHwkBWq2WamKH+hZyoD4qYx2+YNV9CvvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lmmWoqP1; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lmmWoqP1"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb34c17b96so732867a34.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785505954; x=1786110754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JsZfkDKXnNJmRKluxq/2lt4f+eKCbGLQWu+itVq10m8=;
        b=lmmWoqP1KgsDx3pYF+Keo8N13MBpcUFNNbKDJq74TJkzPQrqizqy9c/w+PLZi+h2qm
         We0bz/bT2+m2IS8g2crmvQvf0swQ149nUMfEbM1sJZd3Dq5mxYvk13mZjz5ZW71wgGPA
         hune1U8ZiAq3i76z4bmeGxFIA4OYMS/3M12LwiRBjWOKkZyAYCUf14e9plwTrvZTo0zU
         RYgprHlckkRhvXMjqRJ6dtWvmi/2FVd9xZDqw+J0d1tP9wEtLPzd6RHvZSdJRqf4kPld
         4UuLP6/26572oRaMCjV1pHBy3hZdhchqJWhANaZVUC/qwqZgZG2HWbySN0QEnz9HE5gS
         C6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505954; x=1786110754;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JsZfkDKXnNJmRKluxq/2lt4f+eKCbGLQWu+itVq10m8=;
        b=ktqkqOLVBHePcK22HqL8jZevIJcgaGrcDAR8Bzu3hD4rAX+K3tIZNufVmT2Jz7QYAA
         1PqaWaje/Nz8JhHAbZhSEmY7IWaE+E4/jcE7ZfapUxMFxUQH6xiVRJH1gOM/Z+9IhIdq
         sZC3DE12pdeAJSMbfMrbraqMQS1hjU1j2sMkcnCIWXzmV9RLsPVgJp/hkmyYiK6B+q3c
         96zehySOJlClhyJ6gmc+P9BDRhvxcItviZVhzH3aRicpnzici7EGxntDKiN7zdIGJzAg
         9stfL3P1ugCByc0FU3vvcX+DE+LwXa3a6ATPRhe2AJuGurGHy4oAvCxKtdz2aJlHO9Ne
         Am1g==
X-Gm-Message-State: AOJu0YzsqPhjHl5UKocnCZNiOG5ZkpD1YmiFFz4gtOHbwA6founpwj1B
	oTmcqe+YoVDeTNCjnLB+mMIagJXd+L4p2c90/4zEgxSixSu4hk5zY9/L24WdUh9h7Rk=
X-Gm-Gg: AR+sD11Dy1kngolV2FiQhUIqrek3pVB1DcfL1lqfsRpGGNMgfZeUt/Eg3fT+joCkCoa
	EzkbkQdAZ823MIpspg/BhnEfNwj8F4AQWXRZqDU5Rsp29fX2TbOdDId6SOHTOf4WPfVdU6x5r3I
	7AHkHA98OoXTFGkP3Exb/7wf0hkZLkawBHQpXIg/J/neK78pXV8qq4eoZo1ux5VtaH+tuIAV2fP
	ds79/Gi8bCb4+CtrCZ/we5CgyC09iP6Eaek34POo3tbtIT4XNVR3b0/FOy1TLYG56403hNFl+6V
	Of98v9fIl7BoSP/opdi38P3gSzA4fYJhsSBRZGR39qbxOhwluQgnZB4J75LDX7vQjlJHncWMHMP
	bGioU9jx07ppCGV5+GkPteGvnh3KBEe+Qli8qrDXSlpZwAzfHk9yfviwJKLUvpcNqxfmsRKM46b
	jSclK/ZRDnExwJSKFeqzSpF3gilugDOgGNrPsubiB5yxTan81C74sLG/CBuzecrqa0VMmaBOnOP
	z/2zlQ1vNrCNv1wQLyltN61/6cfrQFNvSP8OgM=
X-Received: by 2002:a05:6830:4983:b0:7dc:df37:844b with SMTP id 46e09a7af769-7f189afca30mr3300344a34.4.1785505954129;
        Fri, 31 Jul 2026 06:52:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fa40:746f:401a:3b75? ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed9af83sm653269a34.10.2026.07.31.06.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:52:32 -0700 (PDT)
Message-ID: <b2297241-e0ae-4058-a406-348440798e38@baylibre.com>
Date: Fri, 31 Jul 2026 08:52:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 9:58 PM, Kyle Hsieh wrote:
> Add device tree binding documentation for Texas Instruments ADS112C04
> I2C Analog-to-Digital Converters.
> 
> These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> interrupt output.
> 
> The binding uses child nodes to dynamically define the connected
> single-ended or differential channels.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> new file mode 100644
> index 000000000000..6a5ffda84b80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c04.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS112C04 ADC
> +
> +maintainers:
> +  - Kyle Hsieh <kylehsieh1995@gmail.com>
> +
> +description: |

The | isn't needed in this case. (It is only needed if we needed
to preserve formatting, or if there is a : in the text that would
be interpreted as a dict key.)

> +  The ADS112C04 (16-bit) are precision analog-to-digital converters (ADCs)
> +  with an I2C interface. They feature a flexible input multiplexer, a
> +  low-noise programmable gain amplifier (PGA), two programmable excitation
> +  current sources, a voltage reference, and a precision temperature sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads112c04
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Data ready (DRDY) interrupt output.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the RESET pin. Active low.
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +
> +  refp-supply: true
> +  refn-supply: true
> +
> +  ti,refp-refn-resistor-ohms:
> +    $ref: /schemas/types.yaml#/definitions/uint32

As the bot said, don't need $ref here because it is a standard unit.
(So don't forget to run `make dt_binding_check DT_SCHEMA_FILES=ads112c04`
before sending.)

> +    description: Resistance of the external resistor between REFP and REFN.
> +
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        items:
> +          - maximum: 15

This chip doesn't allow arbitrary combinations, so there
are actually only 12 possible single-channel + diff-channels
values. So maximum: 11 and channel@[0-9a-b] would make sense.

> +
> +      single-channel:
> +        maximum: 3
> +
> +      diff-channels:
> +        items:
> +          maximum: 3

For this chip, we should also have excitation-channels, excitation-current-nanoamp,
and reference-sources.

> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]
> +
