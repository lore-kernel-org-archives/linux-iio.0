Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EF32A3C8
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284192; cv=none; b=qNcybMgaUq2DQT3nGbDmbgYyZGx/E7NVOtJCdCTDzvp9TuL8+cXJekq8Auf3ziLZr465q2v0whMqM1OiLSz4y8mg1gCSPAYjxSE0vJkMMF2YVKfPZAgY9Fe9Kwcno9HtJRuPf+KMMhDggMhhkxp8CfzROO/YQFiCbGsCaa3p9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284192; c=relaxed/simple;
	bh=OxXbfE9PCobZzGaLgGmy8nF5e5TXeuhPaqqFd7wMX+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvYtSvEKGvENhLTmZdxs2wpBkRK6f0y2e/HHnpQkBnkOxyr7Oy3IduYRfcIDhC7UsA/ZKx/FadF99PRVy/ismIXL1S99I6l1yMYtIVJKXrrWlt/K+l8ug+2Te+5WmqWWyeJGMX4A5v8bbkAUxCruAHA0QCkdsiMkwxmM27zUEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyQuID7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyQuID7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F52E1F000E9;
	Fri, 12 Jun 2026 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781284190;
	bh=c0JFziYa3koMduWH7bD78fl3Sp3fdD8uNHumZ7UVyes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PyQuID7fJL6i8pvD1u5gbmdjeYSlByn5zJL2qPk5jh4cFpav9L4sipcavKaFmySik
	 N7MlCZj33SAbZJ2vgjD3HmbqulB+vr/QT3SOkjK8LJtFJUy+xjKTIY/Q35ROU9PL7V
	 tcG01eef/0PMEdD5wUpHrCjkfpVPRNmwy/ceJ2dQp8MLy4lm0AnYILh+/ZH3u2xSYH
	 V4p0BrdynIe3lJso8xHMnMMFWimT+ettS5yrI1w8/bmFWR060o/dTbtj6Vyzq0JBwz
	 5a4bEsDhtlBXlEIQIpI6W9cRgLujeYqjuu5BcGZa1EYAQg2jpPWBaX9PlhgLtFocZI
	 19zPfQM+RFmfQ==
Date: Fri, 12 Jun 2026 18:09:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcin Bis <marcin@bis-linux.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: adi,ad5337: add dt-bindings
Message-ID: <20260612180944.2cd1e5f4@jic23-huawei>
In-Reply-To: <20260612133125.196208-2-marcin@bis-linux.com>
References: <20260612133125.196208-1-marcin@bis-linux.com>
	<20260612133125.196208-2-marcin@bis-linux.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 15:31:22 +0200
Marcin Bis <marcin@bis-linux.com> wrote:

> Add dt-bindings for the AD5337 dual 8-bit I2C voltage-output DAC driver.
> 
What is the relationship between this part and the ad5337r which is supported
by the ad5696-i2c.c driver and adi,ad5696.yaml?

I'm wondering if there actually is an ad5337r or whether it was always meant to
be this device. I can't find a datasheet for it.

Jonathan


> Signed-off-by: Marcin Bis <marcin@bis-linux.com>
> ---
>  .../bindings/iio/dac/adi,ad5337.yaml          | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
> new file mode 100644
> index 000000000000..327a45ccfe4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5337.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5337 I2C DAC
> +
> +maintainers:
> +  - Marcin Bis <marcin@bis-linux.com>
> +
> +description:
> +  Binding for the AD5337 dual 8-bit I2C voltage-output DAC.
> +  This part uses the pointer-byte protocol and is not compatible with
> +  the AD5337R nanoDAC+ driver (adi,ad5337r).
> +
> +properties:
> +  compatible:
> +    const: adi,ad5337
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      7-bit I2C address. 0x0c when A0 is low, 0x0d when A0 is high.
> +
> +  vcc-supply:
> +    description: DAC reference voltage supply.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dac@0c {
> +        compatible = "adi,ad5337";
> +        reg = <0x0c>;
> +        vcc-supply = <&dac_3v3>;
> +      };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 614589b6efa4..f967c18fe730 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -441,6 +441,7 @@ F:	drivers/regulator/ad5398.c
>  AD5337  ANALOG DEVICES INC AD5337 DAC DRIVER
>  M:	Marcin Bis <marcin@bis-linux.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
>  F:	drivers/iio/dac/ad5337.c
>  
>  AD5446	ANALOG DEVICES INC AD5446 DAC DRIVER

