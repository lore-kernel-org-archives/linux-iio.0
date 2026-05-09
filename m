Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94363A0B38
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363524; cv=none; b=LRmA/4y9vjUwUAsBDJjg4PW2eDBtkuLgQgKbC5aQlSwkVT37+XqoHfA3nFp8FUBi5gSD2Z42155LFSm1XjiBgwyud642cFeqEW9tzgpXC25uT3OX/v0LeiYWmInj2cX7Inqq6VVHFgKRK3uHdJJHO+IoEpezL5NWwYWEhCGhmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363524; c=relaxed/simple;
	bh=++Y08TYZ4mbhtieNPTpgMorN8mO9UiFRW5j/djVaGtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKTs9M+hOr3OolgutVLyz/lIZyFNkQVzUE0k2ALwq858keK0Fgs24rj199DkydBstuOua4RPp8H5LP8Cq+ZDuCWMhpG/+8+qcF4NwDeaRPRXDLLBVHtwYRQYPxmdx7AMKlHxsvqQYpzbvziyTZYmEc/wSPZAn0I7+PkMflyOiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Yk/C9j4P; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Yk/C9j4P"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1257278fac.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778363518; x=1778968318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l45ZS9ar0zxFC87RTiw4MPu5Vj+1FLT8m648OrrG9Ns=;
        b=Yk/C9j4PnDpnfReQvD80tk86iZZievZpwYP/2IjquWtHI6gjqaCOORBIcEm1vXgfoU
         9NPinW2WPBR8V5PaoMHeIM2Y8I+H4GUOGeRStVhFGA/4cRIP9v9CI6tP38uE1tTMfJO0
         Ldj09lNv+up2OXf/5oLmyFf68GQh3UqV5yta3Ryaq4fUf5zZvQKMzQW/YVxfxeaQci12
         nEKH8DvcA0BpYiTnKjK0mR3qnLPOJH5iCTbT4RzcSgS8ad0ukDBfd0CAxC0UuNTVkmtm
         zNLizlMQX3lCPBgEbWuFb/q3B9FKJ7hpHk3MVjfNlHtqRdRvyLeRUflRwrMbzqVUwS1p
         vDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363518; x=1778968318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l45ZS9ar0zxFC87RTiw4MPu5Vj+1FLT8m648OrrG9Ns=;
        b=pAAHLSlWngyahzJNXr4bm7d7aZD4AWPvxtkXoGBzdsfKK9c1UjJ0Ljdkh6m0LxbWNW
         xyIeC7pvrRI3PUliGtUA0QYpQl5hYfCAVR9+egrO+KX+qxbzo4zv5K5LdpBNBZ+fqNsT
         Dib3Klnms6uu86kPk7ZAPfU+/SyT+Whaw9hTPLDx9p+L/xQtpU+A54raqbW4TQk+zXZ0
         WMcx8fIt1gvz3C+mmz+SwtquLvHgHpjAIMJdn3HaZ2DGG5WzOz0k5+qtMfl0W5cRun61
         etUG0D41LYQeNxLAK69FulnryEO32yHdiIq1BzUfD5ACZ5PTB72sjkEBQzsTx8fSBSmI
         AxOg==
X-Gm-Message-State: AOJu0Yz7RczQsYMtlMQDYu/ieq7rSdtU3fqX1wZI1/4Hd2P3HN5DizD/
	NMRNB5QZQNhKh8zK2IZWXa5HzRkuAtCDVFWIdeC3XcfOEWPLxiKFR6dLlkuXbMuC83U=
X-Gm-Gg: Acq92OEkOgRurBK2YSSShrvspQhEtZF9B1hVoThZqsD/+1yD0R0yc/tetPn8Yfw2I6S
	NTxqbJ0EcbAojtlg/BMt+wm4pv72S1eq2+qf6e2Ud6XeELZHWvM3dK9QgmIopvfE/5vim7CodPq
	jSoDBPIbyO3HqzXMkrfi5aDxCks45upC/av0KowMbuVa2NayIFXTOGyo/PkLbh5/CjPm2fT/751
	Og1Oa4WRs15/1CRzpfkEl6KVSHyM1LmkTGUosx7rigj4X19yRT6+9v/O4jtlduu836dcddwSmNf
	Qr3b0TVSJIuG2RAbQMLmmHIcl41Z+KKpIQhLV/da/ly9PITNK0Csihr3Ex9SA7x/wSculMXcrwF
	2WJfiAwOzmbI33fpbLyVtiuiR0xb44knjQwkhxJS8P0rIkc21PqDZM7OknYjrcmYYxHTwe5yOrc
	14kY1Zo6Iv0AZqrrD52MAEOueHAil+KEVsXnM5jm26H1D4EQHqHg7boCHl9tylQF7vEMv1fo6YK
	A==
X-Received: by 2002:a05:6820:4c02:b0:692:a19b:af6b with SMTP id 006d021491bc7-69998cc00e4mr9762752eaf.13.1778363518550;
        Sat, 09 May 2026 14:51:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e3917csm3283036eaf.15.2026.05.09.14.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:51:57 -0700 (PDT)
Message-ID: <24652fd6-c2c7-43cf-ab82-a2ad240b56a6@baylibre.com>
Date: Sat, 9 May 2026 16:51:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add MEMSIC
 MMC5983MA
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
 <20260507205033.951990-2-vlad.kulikov.c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260507205033.951990-2-vlad.kulikov.c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 3:50 PM, Vladislav Kulikov wrote:
> Add a Devicetree binding for the MEMSIC MMC5983MA 3-axis
> magnetometer.
> 
> MMC5983MA is not register-compatible with the existing MEMSIC
> magnetometer drivers. It has a different register map, 18-bit output
> data format, and I2C/SPI transport support.
> 
> Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
> ---
>  .../iio/magnetometer/memsic,mmc5983.yaml      | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
> new file mode 100644
> index 000000000000..e144b4d9b0ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5983.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MEMSIC MMC5983MA 3-axis magnetic sensor
> +
> +maintainers:
> +  - Vladislav Kulikov <vlad.kulikov.c@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: memsic,mmc5983
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the digital interface and INT pin
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example for I2C

If we do another revision, we could drop these comments.
They are redundant since the yaml already says both
"examples" and "i2c".

> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@30 {
> +            compatible = "memsic,mmc5983";
> +            reg = <0x30>;
> +            vdd-supply = <&vdd_3v3_reg>;
> +            vddio-supply = <&vdd_3v3_reg>;
> +        };
> +    };
> +  - |
> +    // Example for SPI

same

> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@0 {
> +            compatible = "memsic,mmc5983";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            vdd-supply = <&vdd_3v3_reg>;
> +            vddio-supply = <&vdd_3v3_reg>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..952fbf3020a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17170,6 +17170,12 @@ F:	drivers/mtd/
>  F:	include/linux/mtd/
>  F:	include/uapi/mtd/
>  
> +MEMSIC MMC5983 MAGNETOMETER DRIVER
> +M:	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
> +
>  MEN A21 WATCHDOG DRIVER
>  M:	Johannes Thumshirn <morbidrsa@gmail.com>
>  L:	linux-watchdog@vger.kernel.org

