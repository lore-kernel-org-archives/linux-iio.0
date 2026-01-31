Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879036C5A2
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889579; cv=none; b=TbXELo16Yzuh/lpcHHh832JF9UaJ6oXqpblo3lEc7UmAfvlu93rQdNG4afaBZfS9BKrfYne1wMyXZu+uqy7Z4EJr4OubnxOHg+EYIS2mE9TgaF41b9IN6yYddh6iMrEV1DhUa7tyhk5p+ER5DpFgonqfFRD6HijUtyRR2Iuynwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889579; c=relaxed/simple;
	bh=y501ybWHBgGRKwznvyi4r3Ot4gsoNEcrqXIf0H2+IFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T82vmqf/luW9IO8+zzKpUbIeT/HzAP7YdWE2eaa9svdgGu/g1jamSIoLMiOowWEjSIryGlur6Nm3TFi+ON1htVE9JG6AuabCIdN04mBXApu04yQhoO6vxq3ZsYWiXsIoaR/+7RZdbFLD4vejwbpWR2V14E7Yzo39q/6Db+AtXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yOaOumtW; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yOaOumtW"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-4044d3ff57bso1196279fac.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889576; x=1770494376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElQ4mZrKFvJjO3Pi3PK+S2VsoWxu8vErX54kiEsiHyM=;
        b=yOaOumtW2KbV4JjPlFFWE8iPUmm0x1fmK1VHg/d1znD2UzoVlBV2D8o67cGSBS6WkV
         T9azRTRRCU4OUe88g98GcBjFZtUxeHfeax9jOEbAYsS0cz2MMVJf6BmhS3NNUR7eMFbp
         hqqdzSgzqi4bF6hpw1Jnc0h9t2ga5U8QEzxgOFOauAjLWR1LDDFOLcSA7gsLe/mOgtAz
         SBdnqtaMDpjMQY2Vg+wkDrBCxhFx3dG1T36scs+wRTI8q2ePNv+eQnjOpHfDtN4vIsty
         R+GwQpSnDFsjHOe1gwoUceJ1phB4P53OxRWzhN6uwd6F+ndgqw09kWw8o3x2sZJcfa3c
         Azyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889576; x=1770494376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElQ4mZrKFvJjO3Pi3PK+S2VsoWxu8vErX54kiEsiHyM=;
        b=omv6xlNIfpRDx3n2AHX8hOUNs5kvEcrWqXVIOKWeq/oRyHCUOKy4hR0FKLA7mQe2Ut
         U5pHpAmgMmxpFKRljatxUA50+OjrgvZxvYjkI2RKGl2SHCik/2T4tRyyjIGDlb9LB4yQ
         Sk5e1XDKYhR7ScR7eYG2ReR2U4TLVTPeoq8o1IGL2rQt20S8BChXxVnfHSDQIVaY3DZa
         FcjHilOd3wRZLJWE7VlNufuwfLsQ5U2GY68yR7mp5M8S/3krcqLUkIGxkeRJP85NFOIa
         qwDloP7fTEYMOHTzmIacXux0EjZVF82f0eaK08bHxtRxlb/YL2xmowI1J0x2wuJd75wb
         TaQQ==
X-Gm-Message-State: AOJu0Yye4x8FwjahylIeNLFTJi25Cm3nzKuz/ZnVZCv3dv6pmcQ+RtoB
	/p0tDNEMpoRWWcPVVyQUFhKdv7rqF6y/NHBbLaBJbB5ay2qAkRhEsKjZfmMNVWS4pzU=
X-Gm-Gg: AZuq6aLVr6jPhCdOb5sWwlSG+Ob2PPhm/B4mr39pa7j/tdAloWYSx806vEjXaJ0WGfZ
	4z6qgBqEMrEPcQFBD3/uUbGxaEhskoAvpR9wKBHmh5Zdcnl1C2/xosfm/Wf8655uSs5BxSK9ipI
	891ordPxygYepRXgWVLmm2a3aDHhqMgfhtf7sRQ/RVrfEKyG9EbNyyWW+uKE1FMB3T8swlhDvCt
	vJ/re3+pd4MvzzcwP4ps8RQ3D7WloaXbO1cwZiVXe+RrBfGkknky08gPPtiJvtZgo2UepZKiJbJ
	VUAW2Y1i7JZ3QfrbtxSxN1bX0Vr/EIbvDsEQ6j+C6LWfjSPSswnVkyL+MonvxbCpTzr7pbMSl/u
	1pkoSvfeFKg3t93O4XwJEIKdcCNz5rdxEPRUc+G7Tyh+O6Gt8M6GA3qaLN0si+omrxFAbB6gzZD
	fJMW1Uxrw2/xqz66qGLX5PJ1cn5583Hjpmo41ClDLmC1RlwGB1BJgBzD6YwNaH
X-Received: by 2002:a05:6871:c968:b0:3f1:664f:e8db with SMTP id 586e51a60fabf-409a6ba324emr4043538fac.23.1769889576024;
        Sat, 31 Jan 2026 11:59:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409570f1413sm8612306fac.2.2026.01.31.11.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:59:25 -0800 (PST)
Message-ID: <51d07338-6ddd-4893-986f-7fab96ff6802@baylibre.com>
Date: Sat, 31 Jan 2026 13:59:24 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/10] dt-bindings: leds: leds-cpcap: convert to schema
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
 <20260125134302.45958-6-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-6-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Convert leds devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
>  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-cpcap.txt b/Documentation/devicetree/bindings/leds/leds-cpcap.txt
> deleted file mode 100644
> index ebf7cdc7f70c..000000000000
> --- a/Documentation/devicetree/bindings/leds/leds-cpcap.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Motorola CPCAP PMIC LEDs
> -------------------------
> -
> -This module is part of the CPCAP. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> -
> -Requires node properties:
> -- compatible: should be one of
> -   * "motorola,cpcap-led-mdl"		(Main Display Lighting)
> -   * "motorola,cpcap-led-kl"		(Keyboard Lighting)
> -   * "motorola,cpcap-led-adl"		(Aux Display Lighting)
> -   * "motorola,cpcap-led-red"		(Red Triode)
> -   * "motorola,cpcap-led-green"		(Green Triode)
> -   * "motorola,cpcap-led-blue"		(Blue Triode)
> -   * "motorola,cpcap-led-cf"		(Camera Flash)
> -   * "motorola,cpcap-led-bt"		(Bluetooth)
> -   * "motorola,cpcap-led-cp"		(Camera Privacy LED)
> -- label: see Documentation/devicetree/bindings/leds/common.txt
> -- vdd-supply: A phandle to the regulator powering the LED
> -
> -Example:
> -
> -&cpcap {
> -	cpcap_led_red: red-led {
> -		compatible = "motorola,cpcap-led-red";
> -		label = "cpcap:red";
> -		vdd-supply = <&sw5>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> new file mode 100644
> index 000000000000..8dfc98a1ef99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/motorola,cpcap-leds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC leds
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. Leds are

s/Leds/LEDs/

> +  represented as sub-nodes of the PMIC node on the device tree.
> +
> +allOf:
> +  - $ref: /schemas/leds/common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorola,cpcap-led-adl # Display Lighting
> +      - motorola,cpcap-led-blue # Blue Triode
> +      - motorola,cpcap-led-bt # Bluetooth
> +      - motorola,cpcap-led-cf # Camera Flash
> +      - motorola,cpcap-led-cp # Camera Privacy LED
> +      - motorola,cpcap-led-green # Green Triode
> +      - motorola,cpcap-led-kl # Keyboard Lighting
> +      - motorola,cpcap-led-mdl # Main Display Lighting
> +      - motorola,cpcap-led-red # Red Triode
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - label
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +

Should keep the example here.

> +...

