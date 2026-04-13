Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1031F9AF
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090325; cv=none; b=DGWrC2B9oJa874Vomp2mAzxAR+IJCfYm4rE/HcyNHUsHhzR3bJkMZNTu5WSJ9kICrJUE6QZYm7DyeWsvM7wtp0sFwsXy2JUWB7yDVhvdIBa56cPw35PxHwUq/3ocgqgGCC2kQWoNiQIBz8eL5LkSFVY8JuFJ6K+MFODHOqDVbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090325; c=relaxed/simple;
	bh=IS7eAxUAiq/UtfmsyS46FTl8Kti+FFgzIWd+y25jhy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/WhlppM6LHFFVHxzNyZeV6Z+y7YRCL4gJWfJAOY+G12XyxiPaFnxVAp3Os05KR27sFBdirwSlg3UBqOBZpNY7zeTQa7oIV35olywzMZBW4LKwGMQwa5yomF2nEcjUEczF8wmAvcYZ2Oot7PgnQ+H1jK6nEMfI4NCKJRLppgSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=rmFrP5or; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rmFrP5or"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbe437b072so2418641a34.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776090321; x=1776695121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaIyOX/UoqXzoUGcxU/8JMZsGGW5yIfdt3Yc4i68OH8=;
        b=rmFrP5orkAyrXO3G23HGoWQgv6fFipvQ5OApcZ1yde6m9JFqOaMEXHoMDYMpLe7Csa
         r3OFNfq4mt2IRlP5OffNX1nBOSheD7zsSTICrJpn7XB5Jgd/doII0M9NniurVrCal/qH
         lmKR0oGqbkOtNC2YvYrAKpeCaT2PtiIiWX49J0BpZ0MnFBPQpJWXFlxC7av9jhqoXofp
         Zkyywvom8TLvLZJ4aOfwGT5FX+U4XBQAXoNUO5v41oW8F9Nnk11f8sZb7HqIFnvNRE4q
         PTNqbdxtoKOJCdxk9z2VNwU2XGmBxhFJqkgY4wbO9ilt9Qrjlec7WyobNiKfgVYFiaFK
         2H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090321; x=1776695121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaIyOX/UoqXzoUGcxU/8JMZsGGW5yIfdt3Yc4i68OH8=;
        b=mL4KDxtFknY+yzuJ4CuIzZnhEflQ/+wP6Xj6ZJ8+e9tTHPRNgImBSIJXPiBD9+wxhH
         esWYMFGEhkCqypRH2YRGBLfy7q1yEBH5fLEErx8jzIYIdJ9MR/J+G6SzyXtxLYYHPQlE
         VMyGmioziZ86mWTghqH9jhXA3sC1+LfyB4KgI4IzCVkuwDpMGvN0GvknNgBEmQIEulie
         E24iPcAiqixL/5jJv4U5PDVsn2XWpeisQO3Puz+szQIdgy7CAQZyChpkkEWiXKs5RUkN
         cbt0Hr9ncLC5S5lCXHRhOrWt6k/Dstlys6RtQvMhR5cF8Koj0wxFG+1xn1yfRn9o70Bm
         2wpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yGyVcBZjK2f3WMwnCviGu1gZlgzOYVIFqh8ezXueX60QShFjMEodvlwr7WIFl7dWBqmOX8Q9FMw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFPL28Fgn5Zool3GftSZQqFZCpbdvTOB6H+k05pLjzhFLiYPK
	Aq5Iwf6YQ8f9yQVzcaTPrlgZZCfFuwg4qujilff3auD9EQbWfxILR9jJGPXG1vgLK1k=
X-Gm-Gg: AeBDiesLWlx8FaFAkGRSe634TtfUbegc6ONuMv7AvFYo3j1yS151SZbLrQhZAd1lqzd
	ztqYs+sPCOT4yvcvCou1krMV1zkVKhx6WbWw0EUXvMuJNVgppZFspWyXlO9eqlcz8RMONLyK8O1
	rc2sgX8SEZmNZnhQFPEvae38zh04y+x20UeSBvoz1F1uAqkIzQboAmpxiYxu8nY7X3dNSpnWlzc
	apvT6EZ1DnzGa1M/DlkGbRxr+I0BmorNUMgHYvVUl+t2Zy+Tp5TFGWGO9Pp35EoVPdDaoiTyLNc
	fFDkbEYaq+xyW29QzN4zcsxJxlSe8if29EXXqjvKSus1FnenSYw2s5i58UyM2W2bY1KdRankXsv
	0R/oftnXFPTQpzvWmBMairR3j2HeQDjOTwHZxxx40pUfeYPp/4l3MQJXrGR/Rj1u3bOLmsK4Gxl
	uql7u5Wj+YuYsmEDOM1FKwIm9YRZPL0uCak8Nj2j1fNlWwNdObZ7xjdk3TSIu6TYJqtEvC2bQ=
X-Received: by 2002:a05:6830:6af8:b0:7d7:ef60:e9c6 with SMTP id 46e09a7af769-7dc27cbb922mr7859500a34.9.1776090320944;
        Mon, 13 Apr 2026 07:25:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1963:d48d:f7b2:862? ([2600:8803:e7e4:500:1963:d48d:f7b2:862])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26573350sm8790073a34.2.2026.04.13.07.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:25:20 -0700 (PDT)
Message-ID: <028a5407-e0c1-438b-b124-55df8e5fda92@baylibre.com>
Date: Mon, 13 Apr 2026 09:25:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: light: Add PixArt PAJ7620 gesture
 sensor
To: Harpreet Saini <sainiharpreet29@yahoo.com>, jic23@kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Marek Vasut <marex@nabladev.com>, Kael D'Alcamo <dev@kael-k.io>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413000308.7618-1-sainiharpreet29.ref@yahoo.com>
 <20260413000308.7618-1-sainiharpreet29@yahoo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260413000308.7618-1-sainiharpreet29@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/26 7:02 PM, Harpreet Saini wrote:
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> ---
> This is part 1 of a 2-patch series proposing a driver for the PixArt
> PAJ7620 gesture sensor. This patch adds the Device Tree bindings and 

Gesture sensor sounds like input subsystem, not IIO.

> registers the "pixart" vendor prefix. The driver patch will follow in 
> a succeeding branch.
> 
>  .../bindings/iio/light/pixart,paj7620.yaml    | 48 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml b/Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml
> new file mode 100644
> index 000000000000..301816485fcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/pixart,paj7620.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PixArt PAJ7620 Gesture Sensor
> +
> +maintainers:
> +  - Harpreet Saini <sainiharpreet29@yahoo.com>
> +
> +description: |
> +  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
> +  infrared LED and CMOS array. It communicates over an I2C interface and
> +  provides gesture data via a dedicated interrupt pin.
> +
> +properties:
> +  compatible:
> +    const: pixart,paj7620
> +
> +  reg:
> +    maxItems: 1
> +    description: The I2C address of the sensor.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Interrupt mapping for the sensor's physical INT pin.
> +

missing power supplies:

vbus-supply: true 
vled-supply: true 
vdd-supply: true

Can also be GPIO controller (if not using SPI bus), so

gpio-controller: true

#gpio-cells:
  const: 2

There is also a SPI bus, but it looks like SPI and I2C would be connected
at the same time (SPI for image data, I2C for register access). Bindings
for that could be complicated, so could wait to add that until there is an
actual user.

In general though, bindings should be as complete as possible even if the
driver doesn't implement some of the features, like gpio controller.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts

power supplies should be required.


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        paj7620@73 {
> +            compatible = "pixart,paj7620";
> +            reg = <0x73>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ee7fd3cfe203..d73a0bf62b62 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1273,6 +1273,8 @@ patternProperties:
>      description: Pine64
>    "^pineriver,.*":
>      description: Shenzhen PineRiver Designs Co., Ltd.
> +  "^pixart,.*":
> +    description: PixArt Imaging Inc.
>    "^pixcir,.*":
>      description: PIXCIR MICROELECTRONICS Co., Ltd
>    "^plantower,.*":

