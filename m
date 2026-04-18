Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9E1EB5C2
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529289; cv=none; b=YlsQYx0LM9pQ0QadH1soGPLB2Rq+fC8YGlD1nOXYYZFI1SdiIHZovMKEmZlWegXrkslwjE70GJtlyAA+Sdllc6OQ+8nHevD8HRsK0ZwyYC1HGKbIGfBaB+fhZ1yB3aPCrSWfeDZjgFVPArpRxcf9gMWarVPm7/LNgnFFbUlPq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529289; c=relaxed/simple;
	bh=N8aE5S8C2XmXzUuK5yOAau0uPRfzG6M/6pQXuMRM8YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rmqd9Aafu9L17wUQD6UW9Zf/3mMIeyPBBaKz1OR15uXZDnQhw8vt++Zz6h4jySPzJY5xSLrG9ZFEioc9cKb6g/81mBA6S35r+LEntErXdbwUfCPESY9yTSK1yD/UJ16AFPKieqEpuFImg1/gLkCaCnmLYGC1iGHrrFdZMJAB1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SRLLVMwR; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SRLLVMwR"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbdcb85067so1562401a34.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776529286; x=1777134086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvxAbaRE6PouL3PbK5UfOT21ooVvOkJtFC5yvChF5Jo=;
        b=SRLLVMwRTwT5WRBzsgKKivYpSM4Ca4yHU2knC888x58Ezrdfe4uZuwOGHHZDZhURYs
         o8AeQSzZj8sYZoDBusUHttb3MeViJU1j8Q0nlBeUjlmLFUOcX4PygHo9bpKCf2FX0Nhq
         tW/JFzhbypmYcPdZcmY3OZ0QuvVHMnzZPHZ/tNU9wVRP/5IZlSQeHWryq6kZMiRHNct3
         OIFanTj5wAsZnp/EogvuSNNakkcCoGgfpUB1WF4qRaaXMeZ/M39aZpKCKoh3UbzQ0ar4
         rD7TfSlAvMWBzF3nR+Ek5EwvumTZTViBgILlInnfEo5E/ITcVT+MBMSnThGUe54CUUDi
         X7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529286; x=1777134086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvxAbaRE6PouL3PbK5UfOT21ooVvOkJtFC5yvChF5Jo=;
        b=Lg9ti0IrLEGBjTEoMfFz3k5dHFDLCNgNQ6Dlu7yRKSNaWXfEhMp0cMuYrRO9Ke0OXu
         IVHl8B+oTZRYJ8IINT85NWMPgn5R3gsAQ04PebzkN1rpHWZ2GNI1a3BJz7qKwszR488W
         HsFD60oK6zfwEsAhTXdkUxjulcc+C84YLYo1qTPbkHqR4JquSeUGkom2Fhh0IpWdYfCP
         3VD9G/GGX0plh1fqhcjG/38bVvJkWOrX9Au9woJObEhoq2ds/6pmecJUT5Xy73+btV4o
         qtJJvDtRtQM8xp7m/Nh8q1V8JKkG6J4zTqZxU5l2g3JwTyZGJqVF8akglaxkePMUH9ZY
         a5DA==
X-Gm-Message-State: AOJu0YxLU0CPBT4tj5XAj9a/BV1ONUUvonR6XuxjYVRH2J5jBveLEcd4
	99YE8pBpQMYdO1B8AedKBP7eNtscalpHGSKp2Sx2rWfKM6amCda5KZcatKnSaWP5HXAvmkT3q15
	7jQ+u
X-Gm-Gg: AeBDieu+qiL0CdoDZjgOV4yaI2IR+i83F7w00KaBXHLyGBTvZs4qO4xNzGb5IBGEq2k
	1JZxND2W7Uf2mktfu9siQMesbAhbH+hHthzkrq/TV4R6O43MmWBHTp/bg+8lAuBbhrK7qjLJwhP
	GtnRYhrrgjaUdH0oSMRGoVHY3Xw9bOdURS2LhMUvdmQZ4KR8RU8aW0grYzFTaT8rbzyZeQdn3Ev
	pg3IHzfl6Upgj9UCte39VjfQtxyh8S1mhKcrVy5NnXl1kr/3Km+CqYzdXSVIvuw2v6Sztdtaj7t
	Gw3qJLeuCm7UBrOAJFC2X4hf///zntPm0BH0N80ZkuSdzHGYix9A+bwo6oH6h/EYFtflOJMZZv2
	gMdg5bdeLCwoD9Vt1WUJNbDPYk13pD/lW6dlVmeJHjtQ5EHrq4Thb/+YKWepaquTMAXOeQd4sFI
	ZDVowP/jPULDVeRtTPwy9XVhBoujdyXkzrjDaiAg+LJbeTa8kq485X1Du5G8n84vXmgoJ03JzEk
	t/Tni8Apqcu
X-Received: by 2002:a05:6820:2914:b0:681:94fe:aaef with SMTP id 006d021491bc7-69462ee5de0mr4058662eaf.29.1776529285612;
        Sat, 18 Apr 2026 09:21:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9304b7f6sm4347048fac.1.2026.04.18.09.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 09:21:24 -0700 (PDT)
Message-ID: <9c61d07a-fc94-4ef1-b57a-a42d917a6518@baylibre.com>
Date: Sat, 18 Apr 2026 11:21:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: iio: light: Document Avago
 APDS9900/9901 ALS/Proximity sensor
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418144716.132936-1-clamor95@gmail.com>
 <20260418144716.132936-2-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260418144716.132936-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/26 9:47 AM, Svyatoslav Ryhel wrote:
> Document Avago APDS-9900/9901 combined ALS/IR-LED/Proximity sensor.

I think we can just add this to iio/light/tsl2772.yaml. It already has
avago,apds9930 which looks similar.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/iio/light/avago,apds9900.yaml    | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
> new file mode 100644
> index 000000000000..f5fb79439e56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/avago,apds9900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Avago APDS-9900/9901 combined ALS/IR-LED/Proximity sensor
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description: |
> +  The APDS-9900/9901 provides digital ambient light sensing (ALS),
> +  IR LED and a complete proximity detection system in a single
> +  8 pin package over I2C interface.
> +  Datasheet at https://docs.broadcom.com/doc/AV02-2867EN
> +
> +properties:
> +  compatible:
> +    enum:
> +      - avago,apds9900
> +      - avago,apds9901
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  avago,pdrive-microamp:

In tsl2772, this is called led-max-microamp.

> +    description:
> +      The LED drive current is controlled by a regulated current
> +      sink on the LDR pin. This feature eliminates the need to use
> +      a current limiting resistor to control LED current. The LED
> +      drive current can be configured for 12.5 mA, 25 mA, 50 mA
> +      or 100 mA. For higher LED drive requirements, an external
> +      P type transistor can be used to control the LED current.
> +    enum: [12500, 25000, 50000, 100000]
> +    default: 100000
> +
> +  avago,ppcount:

This sounds like something that should be programmed at runtime, not
fixed to a single value in the devicetree. One can easily imaging an
application where the sensitivity needs to be changed as the environment
changes.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The number of LED pulses can be programmed to a value of 1 to
> +      255 pulses as needed. Increasing the number of LED pulses at a
> +      given current will increase the sensor sensitivity. Sensitivity
> +      grows by the square root of the number of pulses. Each pulse
> +      has a 16 mS period.
> +    minimum: 1
> +    maximum: 255
> +    default: 1
> +
