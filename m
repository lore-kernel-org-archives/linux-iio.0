Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A969282F20
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782585687; cv=none; b=umjE5hQlb/evHbONH8mohaxqq/nx/Sp7xk4jrr4HhN9MWP7h0xNwV5AImWIhBHMZQpnL+HGp+WnJwEaNQwKBC71sh65xf74zTVsDc5XNfxC0K6Z41Odumtep+QgkmmO5VadwSBAIyR4Hi8AcZdE6QPZEfptE7TVJhuACEOWj5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782585687; c=relaxed/simple;
	bh=8fNyIkfw/0xYqHeJkX6O72fskcyAw69K6eCvgFE0iuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRbg8aC/SkpBjZ7q7ufJad7NMRSrLOfyjPQepUJ/XN+zq5DSnd+bjlmYcs2GAed1xUKtYlxD+QY9Oqh2PR1zN6LsnvBAKAwGx79Ujutca+gNz5Sh2c9AX43/JB6FuaWu9G++o55u1N0iAGKJGgMZBwQdF5Yj5VhHgAD35An6yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MmYm2D8T; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MmYm2D8T"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-491bc1d4e6bso1554077b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782585684; x=1783190484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SD3aaAda6IdwUA5LxoT3zVkkP/l61F3rjfDVOmdi7Lc=;
        b=MmYm2D8TUsEQJUpEcDCXHfcCKfj+taX/N6aFJbmJxt6cBEDvcC1X2FmCYHSA0i0Qgh
         7l4P3CUWSs84xTzwWVtxjcjQvB3UG34o3GYV7B2klXclP8UXyxexuCJPM4pYLyLRQTpc
         Z+8FGFhGEEXgxReWLvc+PXW88WN1I9WXptGxWfYZizu86TRVce7JBi39MbxElq+XD/CK
         OcsK4W1s5P7VJ7G1G8kNCk5nnXYRIHAtXjJx/iFqeRjDrNvLsmlLMuREG7ezs6r8P6+L
         EEkDUF2HDc93Bl1kE5fLV980SPxzG7fG5VKI4V+68q6xI/Z00kf+9BmUJqdkSm1x8duF
         QMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782585684; x=1783190484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD3aaAda6IdwUA5LxoT3zVkkP/l61F3rjfDVOmdi7Lc=;
        b=U7IoIg56tWfcYvcr1UtQPf4W8oT6GcYROxi2y94nZ+ouVXNBXiwRFbp3Rn4Rez4+X8
         xUrSDL+5jNBXInLv7+ll2Gqe2SvkNhqp4asVrUop9O7hbdddEKI21JkJR3WpxjpomHvW
         ohX0fKwVA4e+dzHXEbDh8/h6OSzVv8czRxxEJAYR98vkFjsbIJqmFHK7QBGG7OhNAFcR
         1jrPGv92j4IEv1jb9ujEWFdclyEn3WyYDlLQyrW37kwcG0hb9MIj/phihF6rUwyoZLY8
         w63zUecgEub0wyl8Up9AVCJih5ttAw1xt8tFNWCTLLGTQixn6XhVKDBAum4fXEZKFGN9
         7dzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/h0RykiRQnnlb3i4T/0PBQoaFgy4Cm179jbMfnNJNGBKZOkH6Y+Q+Lfa5aDejx+jZNFHch65lFVYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMs0AynPYyr6Nr/JuZjjk7pPX7dyXcuhDe71lg0InpCg4Qwsf
	r4k9LB/nPD5u4V0y+Jtfkq3pz2eD+Lvf92Ux11en/wP73UVQCXgi+2wf+ypjwB5b7rM=
X-Gm-Gg: AfdE7cmqmtroiFXNX+jyx1B3oWKuTKHtl09CeTsC14r4zSzdJxQnrC8Tg2+iAFy4+IR
	qIL1DaHEJsXZ4t7PllRimKgwEasjQkMd0bg/3b7ONrPwM6fQ0JpQYW/n5jExeBzS9wscgRNNu6E
	BBz0CD0egj2ChPodkq8NdbEB2+Cg4V5qJOOxx+Fydn8yuYbUKQGdNcNCuJ5TJcfn+KMGX4d5PAs
	J0EOMOY5JYZU8ZOXp32FKJOSk19TuPxz2iQ75JJ5uu6ODBNME6UbpdhEHa9NdnibSR81GPEdD58
	zcG8kZOc8OFahqOaN5mThkzTD8/hxH9k2q3kMKjzup0dm+AykmFr6gedleXVo6zDl14eo98sYxz
	z09YVkPZ0hbaPcp7vocmS5zc2FOKJGIKRb4F3ImPSP30W55U2J52yaLc4XSQ4OIpBPliE29lwz3
	rfn9Pf5mHCiiOpRaaM7e4lHRbBo8Ec1ujoyxpK7sm6pdx4NMZ5JiKoG31KGARN20k=
X-Received: by 2002:a05:6808:6411:b0:489:97a6:a72a with SMTP id 5614622812f47-49217238baamr9016207b6e.4.1782585683662;
        Sat, 27 Jun 2026 11:41:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49352b05f2esm3723287b6e.7.2026.06.27.11.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 11:41:22 -0700 (PDT)
Message-ID: <aacfec88-da09-45e2-9e33-67e0c7af8e87@baylibre.com>
Date: Sat, 27 Jun 2026 13:41:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: magnetometer: add Melexis
 MLX90393
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260627005843.7786-1-nikhilgtr@gmail.com>
 <20260627005843.7786-2-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260627005843.7786-2-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 7:58 PM, Nikhil Gautam wrote:
> Add devicetree bindings for the Melexis MLX90393
> 3-axis magnetometer and temperature sensor.
> 
> The device supports magnetic field and temperature
> measurements over I2C and SPI interfaces.
> 
> This initial binding documents the I2C interface.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---
>  .../iio/magnetometer/melexis,mlx90393.yaml    | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> new file mode 100644
> index 000000000000..33ab0be66345
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/melexis,mlx90393.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Melexis MLX90393 magnetometer sensor
> +
> +maintainers:
> +  - Nikhil Gautam <nikhilgtr@gmail.com>
> +
> +description:
> +  Melexis MLX90393 3-axis magnetometer and temperature sensor.
> +
> +properties:
> +  compatible:
> +    const: melexis,mlx90393
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  trigger-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddio-supply

The supplies are required but are missing from the properties and the
example. Running `make dt_binding_check` before sending would have caught
this.

See: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@c {
> +            compatible = "melexis,mlx90393";
> +            reg = <0x0c>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <17 IRQ_TYPE_EDGE_RISING>;
> +
> +            trigger-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..469ae3f9aa0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15501,6 +15501,12 @@ F:	Documentation/scsi/megaraid.rst
>  F:	drivers/scsi/megaraid.*
>  F:	drivers/scsi/megaraid/
>  
> +MELEXIS MLX90393 MAGNETOMETER DRIVER
> +M:	Nikhil Gautam <nikhilgtr@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> +
>  MELEXIS MLX90614 DRIVER
>  M:	Crt Mori <cmo@melexis.com>
>  L:	linux-iio@vger.kernel.org

