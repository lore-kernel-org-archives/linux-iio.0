Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EF3128A2
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487751; cv=none; b=FS7dFdwNibhdCRgxhAB9/+z4ZhlX8jL2s5j9HiUhrl1RVrRhkFhOzTd04NhcCHbJT/dVxj+AJSoOxT0TCc3rLWALF457N49rhuZS4kQAjUoMuME+nDAtgbJYwp9wFkAQg+Qeba8jxXUAGiEekX9o43BcPhCe+mLAljLPelIHVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487751; c=relaxed/simple;
	bh=xDPwfIZXTeW3yq3e+uusrA8W/Zw3xwvvavaC7B7WOb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HW9RRqL8N8dZ54VWMvoS/qLWo/XT4Abpos8I+G1tdiVFX3YcZ39PgLCRAnxWXwZeK4TZsDvoJyzhwGN5pM5o8TnI3fmnYNXEwyYFyS7O1n17OL6ca9Bq4CHYzC7GbJXRYrYHTEk7i+G5KF62SAnTNWD/TDSpDAwAvUnJAK7GH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEOQbUu2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEOQbUu2"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a860667fabso3612249e87.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778487740; x=1779092540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6S8mBYkFiwNSV2sm1TejB3CD4/6gNBSvCKYv8dIJSuw=;
        b=pEOQbUu2H+zOx9ZBV4oO3C4BiW3h2lBp6NjAe49h69GtJmkq+PE1F4pDxqxlDixxqE
         e7qMxfZwfIk7bw3xzDGvqRY8XV1muUAtAh+m7Z74eldJyg6f/0ITQ6lRfBDXNf7nFYAu
         GhKwXy8NeyrGDZc5PsfixtlyvMvCPVGmi5NWzxOVeckYvIf2fWd6VAnvPna0Pp5PQC9n
         a5TW2A+yPTkcFFTNoXS0lO89BTxTLqK6+m4/4LU4TIUUHukWqG8LHNuEJUkZv0d3WjOX
         YUs/rNcAwx33ZT4DFCh1od8wGXLpMxz5WwRMJDdHyPNp+erhhtDylda03AA/5K5FGevh
         m8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778487740; x=1779092540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S8mBYkFiwNSV2sm1TejB3CD4/6gNBSvCKYv8dIJSuw=;
        b=P5vaheBuXSTWsJf1DMGCYBEnVqQ0xWXcgP+cGpl2EDB5H9FOArQgM2tkCMHUyWKZAt
         IiXm9kGgPNLm1WeXpPLmwWzUEYuO9dJSEYJeVxm9WUbeNQYL+nXI2j3JDEQkXt3XGq9Y
         kKzk3hodVw6c+mF5oi2q5gDvq9180l42PHpqpT32H/GwOJNtYWw/vW6jWrnXBcTVI9S4
         LREDMG8xNsR7f6hdIU7a0gciHAZa3VAdwRLcRJCnGfVaBk4UYejUM+tz9ijPV3psim3Q
         k3eAz8aezpc7mzIlocCMCI3edSk+kWmP0I5ftayGqKZ9gY0OVNLsipGJcV3iD9XbP74T
         cqdg==
X-Gm-Message-State: AOJu0YwKuxCGa3zeVSR9OnwFwGM0Mom6+hc7NK/7ROe7l5LjrVaQvwGt
	QWB8RSME25bv/27KgBIZSghBtpJeRDBcot00yfsvBESq5EqmsiCTz8GS
X-Gm-Gg: Acq92OFDOy/YgGsCrFdTYqL9wsncCnj9wFYyNYp5xc9akhRLrMzeaYgfyAUhWcowE2/
	01l2jbwvurBBCrS4Ge5sD2NIVdeNdu6dsn+Mw99xOInWvfcHNwsJx6BY5pMVDsGehu9twCJ8F0J
	CNwuw5NF2vLgI0BydHXdqA6TyT3iM6m6PBE2EZ2iLnHbb5n7ULohVBYZo0Rylvmnr5k18/L5iqu
	B8FK4vgIh2LaqpO6s6o/ZOev9AymCjxdCzGKMHmEY0rQCzxTzXFE9/PmB6H/X0ndtORP1IGMA9L
	shd3mVU7kMm0gTazabl4vI5H0RVAm0awUXjmIdaCytMnxPDotazzjD41wKEQQdZjCDHJifYPpoF
	lM0R0b9ZssEYZqY4n+5pcxrsEyNJHza72+P2zi0OhNGEoROcypWzXpR+UUValf+J6RPABq+KcHu
	K8LLxZzOL+DwiQs/YNXTPf6pqPyl6ZvERu/mbXiNCewzltsdyInMJXkws/c0qQIdtkuRoHrATu0
	XxXlyc9
X-Received: by 2002:a05:6512:684:b0:5a8:638f:cc9c with SMTP id 2adb3069b0e04-5a8a94aa770mr4687218e87.17.1778487739469;
        Mon, 11 May 2026 01:22:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8cbfc4dcbsm672723e87.16.2026.05.11.01.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 01:22:17 -0700 (PDT)
Message-ID: <92e2d1ab-c973-45a2-b0c4-d7c672c610e0@gmail.com>
Date: Mon, 11 May 2026 11:22:16 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add ROHM BH1730FVC binding
To: Alexandre Hamamdjian <azkali.limited@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-1-e0df1f499135@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260511-bh1730-v1-1-e0df1f499135@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for patches Alexandre!

It's nice to see these upstreamed :)

On 10/05/2026 21:09, Alexandre Hamamdjian wrote:
> From: CTCaer <ctcaer@gmail.com>
> 
> Add a YAML binding for the ROHM BH1730FVC ambient light sensor.
> Documents the required compatible string, the als-vdd/als-vid
> regulators, and the rohm,integration-cycle, rohm,lux-multiplier,
> rohm,opt-win-coeff and rohm,gain-coeff calibration properties
> consumed by the driver.
> 
> Signed-off-by: CTCaer <ctcaer@gmail.com>
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
> ---
>   .../bindings/iio/light/rohm,bh1730fvc.yaml         | 95 ++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml
> new file mode 100644
> index 000000000000..6273b69e82ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/rohm,bh1730fvc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BH1730FVC ambient light sensor
> +
> +maintainers:
> +  - CTCaer <ctcaer@gmail.com>
> +
> +description:
> +  Digital 16-bit ambient light sensor with an I2C interface. The device has
> +  two photodiodes (visible and infrared) and supports four gain settings and
> +  programmable integration time.
> +
> +properties:
> +  compatible:
> +    const: rohm,bh1730fvc
> +
> +  reg:
> +    maxItems: 1
> +
> +  als-vdd-supply:
> +    description: Regulator for the analog/digital supply (VDD).
> +
> +  als-vid-supply:
> +    description: Regulator for the LED indicator supply (VID).
> +
> +  rohm,integration-cycle:
> +    description:
> +      Number of internal clock cycles used for the ADC integration time.
> +      Used together with rohm,lux-multiplier to calibrate the lux output.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  rohm,lux-multiplier:
> +    description:
> +      Lux scaling multiplier applied after integration. Used together with
> +      rohm,integration-cycle to calibrate the lux output.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  rohm,opt-win-coeff:
> +    description:
> +      Optical-window calibration coefficients. Specified as a flat list of
> +      triplets <rc cv ci>, one triplet per window region, where rc is the
> +      visible/IR ratio cutoff and cv/ci are the visible and IR weighting
> +      factors used in that region.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      minItems: 3
> +      maxItems: 3

I am not sure if I read the driver patch (2/2) correctly, but if I did, 
then these coefficients are used to compute Luxes out of the raw sensor 
data. I believe it would help anyone integrating (or investigating) this 
sensor, if you added the actual formula here as a comment. If I read 
this right, the formula is _somehting_ like:


Lx = (cv[win] * ch0_data - ci[win] * ch1_data) / gain / int_time

Here the cv[win] and ci[win] are selected from the opt-win-coeff -table, 
depending on the measured ch1_data/ch0_data ratio, right?

> +  rohm,gain-coeff:
> +    description:
> +      Per-gain sensitivity coefficients. Eight u32 values arranged as four
> +      <cl fl> pairs, one pair for each supported gain (1x, 2x, 64x, 128x).
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 8
> +    maxItems: 8

Is the gain-coeff only used as a saturation limit for increasing or 
decreasing the gain? Are they just raw channel values?

> +
> +required:
> +  - compatible
> +  - reg

I will leave this to other reviewers, but I would guess the sensor does 
always require vdd?

> +dependencies:
> +  rohm,integration-cycle: ['rohm,lux-multiplier']
> +  rohm,lux-multiplier: ['rohm,integration-cycle']
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@29 {
> +            compatible = "rohm,bh1730fvc";
> +            reg = <0x29>;
> +            als-vdd-supply = <&vdd_als>;
> +            als-vid-supply = <&vid_als>;
> +            rohm,integration-cycle = <38>;
> +            rohm,lux-multiplier = <1000>;
> +            rohm,opt-win-coeff = <260 1290 2733>,
> +                                 <550 795 859>,
> +                                 <1090 510 345>,
> +                                 <2130 276 130>;
> +            rohm,gain-coeff = <3000 0xffffffff
> +                               2000 9800
> +                               15 60000
> +                               0 1300>;
> +        };
> +    };
> +
> +...
> 


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
