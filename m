Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C74F5E12
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895007; cv=none; b=Xn/85/1ZKWU2tFDOY/spDyLjyvW5+Gzt8jLjWULsjAl61F/qcU3pJmey/F0aZAatUAEC14NdjZ161026hTXVMRkKk0HVGw133Q8RPBi/4Jh1qAOBsInVkIacxZBiJfW39W5NiN2HGaPMMee1vCn2YKRsWTfLU7GQQkim0+ZEX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895007; c=relaxed/simple;
	bh=iTqegItL46VZzOOmaKOWbD4dw0HLPDGa1sgVVAbiO/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL5p5Cwh4HBvRKGzMfCh0+Z1GFJ3Uir2T+aSzqvcwiXGfPIILkXeSy4SbrXwwzkm+szx5NCVHGxa0CZLmQoY3z+gwvzFGoZ1BwuonrDuLD/qJwSFFl8bYlYkgUf7Cmqjke3AEra3jzCQNe/lygPCKkzpY8AXO4bUkOUnyhtqtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0828nRS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0828nRS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso3166314f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791895002; x=1792499802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uTSmNl5owwJ6C1JNsqWpAVpytnSmw48VMmiRayPCI+k=;
        b=G0828nRSEeUlnOyc4KHeUotlZjd8svAZhfESRR7oZREuxfvP3crvhTlfdzXopE9Si0
         AURyO+ReoLFDJ0kLsCSVQfxn+Uar3eQcSmRz0FbRrB2BLa7ahyQJlLMwULYDn5ckhPZ5
         MLzNh6+HwPfXj7dAhYUeVRJTAWR2C2MnTmJyMs1Q9vhjpSIfalHCtfjPW7X+udZlY4tr
         4awrG9gSK2MCC93pXYb5ZFvHrFa/FDLbxsNHdYe1ppBvACpORqtBA81eHgRjGOZaeM9M
         OZhhmx/DLxC20rqz/02ywAoRNbSPGSdBbS/x69OX6QSOQJZBB6bdIu9bE34Ml5vmr087
         hBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895002; x=1792499802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTSmNl5owwJ6C1JNsqWpAVpytnSmw48VMmiRayPCI+k=;
        b=mpiq/HLytGcXL1ODK/xb90YL1IyIRUyJxX2W9swWgM9lm3Lah3mkEHvOJODl1qX1Vy
         uiE++/Z8J5hGk+iSlbzztbahrHkDCwN2uxSROWOwp1OmOk7B894KAfEBpdxB13Is6NLi
         sRq3Yw6SZpj5TqmZZuLuxeO7OQ1RgjNvk0fH+AyO8XkW5ifN4KiQxP82ZIN84nN4+GO3
         j3S5hqU5TNTczUUTbIlY2lwnlHqzlRZWJnFHOZYXzzjR5YJb2WlbutQyQCWLtNtzysJu
         buKfDq6z3xlD4aeQF8bl/c8sKqWBerhajEWuR2KpkovtsPdetFDmdK5bJ3SJp1Rk4LV+
         H84A==
X-Forwarded-Encrypted: i=1; AKwUvBzBhdQ/0JqYrMlCsxVmIVAvNt5rRN+obdX+DgQ/Akib/Is7sGgMJ3HoA4t3BJHzzpoGTutb8J/+Mw8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYfAQllaxdyxXphpe/w6tOFtuqg6vVPNCs3rpGfCoMJ96rX13Y
	I1uw2NKSNdkoOhKxLjcHRyI0N/tPxWz1g+h2fapLE81Z4BXqv5QuMi/S
X-Gm-Gg: AYBFou3XSNz/8GoCZmyTDHha/f2kMcBwmc2PRQHPuapPmKQxcsqHX5nR5R9WS5IJ6/r
	eYxKT4F5CXjL0WXmH3NRVtZHOePGqt3CYzYLDFcgtGlZpDI/JUgIVC0edf1yjnSmhrUaadPKfKb
	gTVHcKnDe0pveMwypxQwtxugeBpzaJAnupXAHPytFaidAR1rSW0jRYLuMypJTYoMa8Sm7eOHgqo
	euFEQ5X80HFHeg1PBuW25ECrIn/xE2YOC+B8kUqxXCuAS9BPLW1+hX2M0MNYC0nXOTZ2bZdvM++
	oy08frlcy+9Xt7G+gKriRSXgq2Z+f2IiEBzXFO70D+8wrO3aQzGjSBCxZG10g0qqAt0BiFfWc5m
	8LH32eCgKZjlsQUdZCuEFNcNBQJGi2ZzlNIP/SZI70I/y8MSPT0tmPpHrDNoNH0nLtdmzCQoeYN
	3Pb1zbjeXEnGGo7tf2zLCz414icGxFrfGyVlijdZ8gtTfLzjmkWEKgoE6lbawgPcw0DLlpsG8Wg
	IRsQPpqISsFa4N9hE7MYg95paz7UO/qs0vsIxb4uWlSoXEcI07rOIpFTdHGjpZ6I3SEWokk+lA1
	SAr4LiEABu6V3jAs08ilWVBCMGXABwQPJpS/TbsQNAY/zXI/WCeZnH7XlOSAhEnE8dT6035Chur
	0XaAKNNe9+MCNtYOyI3eERuUs9ho/gy1l/MjY8Cf3s5pznS319zgu3s3tGod/bnw9lUDHIievoH
	EPfSUj
X-Received: by 2002:a05:6000:186d:b0:488:8913:e64c with SMTP id ffacd0b85a97d-48dca34320amr17714316f8f.18.1791895000936;
        Tue, 13 Oct 2026 05:36:40 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7003982sm31222f8f.8.2026.10.13.05.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:36:40 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:36:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shi Hao
 <i.shihao.999@gmail.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20261013143639.000017b9@gmail.com>
In-Reply-To: <20261013115639.167433-2-marcus.yu.56@gmail.com>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
	<20261013115639.167433-2-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 19:56:38 +0800
Chang Yu <marcus.yu.56@gmail.com> wrote:

> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
> 
> The GPIO pin is not described because the datasheet does not document
> how to use it for hardware synchronization at all. The GPIO register
> also has no mode-select bit to isolate the pin from the chip's
> internal control logic. Exposing it as a generic GPIO could result
> in kernel writes being overwritten by internal logic.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v6:
>  - Add a ref to leds/common.yaml for the LDR pin.
> 
> Changes in v5:
>  - Remove the GPIO pin.
> 
> Changes in v4:
>  - Fix led-max-microamp property name.
> 
> Changes in v3:
>  - Add missing include for gpio.
>  - Expand GPIO descrption to include hardware synchronization.
>  - Use led-max-microamp instead of led-current-microamp for the LDR pin.
> 
> Changes in v2:
>  - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
>  - Fix node name and unit address mismatch.
>  - Include MAINTAINERS changes.
> 
>  .../bindings/iio/light/ams,as7343.yaml        | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> new file mode 100644
> index 000000000000..7fb10b0d4843
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> +
> +maintainers:
> +  - Chang Yu <marcus.yu.56@gmail.com>
> +
> +description: |
> +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
> +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,as7343
> +
> +  reg:
> +    description:
> +      I2C address of the device (0x39).
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Open drain output active low interrupt pin.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  led-max-microamp:
> +    description:
> +      The driver current for the external LED connected to the LDR pin.
> +    minimum: 4000
> +    maximum: 258000
> +    multipleOf: 2000
> +    default: 12000
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false

Should be unevaluatedProperties as you're using $refs in the binding,
but Jonathan could tweak that when applying.

-- 
Kind regards,
Joshua Crofts
