Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4230214B
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013032; cv=none; b=b76lVUzUNtZlvjzCWrUQCvtncTkSo8ncbcdzW2aqVkljEtD+0mxR2R+iD0e/YknYQK73JupGSFU709QBckgnV9e/PyWyFVA3zXytK0HoFeqD3URBJkbMs8qjMkMS0gnDAHTOz5q5xL9C+46Iv/If8OKRIu5QlM+0u0emXXr0SB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013032; c=relaxed/simple;
	bh=Sywa6/Ye08B6vTkrcTaHJZX5fieJQ2q2ifsiIriTUl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GliATQ4zh8zPUvChuJHat8wUTbLLC0jBCA4REeMvEs4z8sWQOko3MKCshISf0sVuWoIF8Ax0TL1EVdEPlROxqAUTiebsT7BWlVcJiqmBz18Va/aV8ZHbENPQ4eXifbCKAvSjLc+7guKauiLlYNRuN6BPacIgGGR1NZSmDN3ZzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XgXGecnW; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XgXGecnW"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso487464a34.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785013029; x=1785617829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7BJq+VUPT3xZNhGxvs3I7o0afQFSkLHmMhg0Yb2V7f4=;
        b=XgXGecnWc2nEmXeTMJu4aE+7fYlkAajlinZaSfzJqoYWHspr36w66qq6lE9JiL1rO/
         YGJj13SiwXIjqC/4fp5RVpVhP+onvxpmqUXUGOO6Sp9UMx0vhZqVCKcMRe3rQpmFBwKP
         8Crb3Gk/URnYS6g5TZzGm2cg3gXqzNmSTsUfThmm+zgXR8DkG8GDZkIvNeGq6QlM/kab
         7ho5dDQ3jzpmKLdh7Bp+FGYNTWBeLcEQ1AJ/eW+0ns9/RvHv+BCjcZEcJtrG9FOtuS0w
         r0cnJdzeGZ979yUmbd4DmcrNg89ZdbNvpAxuQH0N0t2JeghqlXP6zblvP6+ZvRnS0OS5
         MaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785013029; x=1785617829;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7BJq+VUPT3xZNhGxvs3I7o0afQFSkLHmMhg0Yb2V7f4=;
        b=egsOIGeRQQdoVKXJp8nxgRcKY+fR/wop0V4J9U+epOCpcU/2R5EHuq93NrgxyJqGxd
         s3tcq+f6IvBlZmCOcwa4yyf0Dd/fTn9+RD6MrWrSXnOSW3wZlpi3yLUHOvothSmKHgCL
         8teuGw3QlEI4SNa5RZjciP1la1EMx3zn3XvhLIZcUWu56NwNZKb1JgIceWJ7eTT2v2ze
         Lb/i2+q3WKki7BZZbqoc0A1kT7cD/j0osWmrEqWpKV1Z35i5spTfDG+aiKlVlPgJXRUL
         Qd8u2vEZ3qEUj8E9/siWwm/GcaPTVLrFRl9xt4oj8raTu1hvDD7kVurViWGc9T3SY67b
         W6zA==
X-Gm-Message-State: AOJu0YwLExN3PoyKqYhhUGlwABozwlx1f8QjoBvK8KOiJd2dMj7W2w2y
	5tE+9CvIx5Gqp4F3dUArLxKDu/tlAtNZXJCtz0YDGDOmDxuveNmcrYIbjlMH62m8J7k=
X-Gm-Gg: AR+sD11geV5BcTZ8NwFNgbP6OaTUs1gYMQIOqFwk6/9SkBAyK97LDS84lNQtl1HgLTP
	G1w0l7sbd3LdxdoSaoXEePyVvrtpXdR9Lza9GglvA+gP1nn7EH4ScSwnvGZBWNrQ5nH2Km7APu+
	UUtR8YK55oDEqQFmwmcR6gw0mPYIeLe45aLooAny3R/YaiycYjIObvoLNbbb/WMGI5v5ASp6UNR
	laZxxre5YjJ3Qc8Seet7UxDuyIJmovIM/TLOdyTjJ4MRFaXaMwXjbcbFEzKlxNfBXThBpXWMZhC
	qlN+Ju2e33AvnDLFAAUgPX+orz6CM7pjqWu5WuU/rFIJwBzZqLyk19c7HNCNLlYXg89kK562L69
	GgkzRiOEufieNdi3zFmPVRHAgb8g7IsZUgH2nV+6yao1FNZbeBmu9vF/Ig5rbaDYv/DYs7lK9Gt
	Or7kVefavJakbmyUPiWFFKgVqw7KE5Xf2UXYpj+8ANiV/VWBUHkuZc
X-Received: by 2002:a05:6830:2906:b0:7ed:ceed:95b9 with SMTP id 46e09a7af769-7ee78d2ae71mr2872531a34.32.1785013029154;
        Sat, 25 Jul 2026 13:57:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:677a:56dd:37eb:cf53? ([2600:8803:e7e4:500:677a:56dd:37eb:cf53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a0ad02fsm9782435a34.19.2026.07.25.13.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 13:57:08 -0700 (PDT)
Message-ID: <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
Date: Sat, 25 Jul 2026 15:57:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
To: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
 Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 2:54 AM, Janani Sunil wrote:
> Add the generic spi-device-addr property to the binding and deprecate
> the existing vendor specific microchip,hw-device-address property.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> index 675319276197..de1ea289e7f5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> @@ -80,6 +80,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 3
> +    deprecated: true
>      description:
>        The address is set on a per-device basis by fuses in the factory,
>        configured on request. If not requested, the fuses are set for 0x1.
> @@ -91,6 +92,12 @@ properties:
>        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
>        which is first one on the wire).
>  
> +  spi-device-addr:
> +    maxItems: 1

Does it not make sense to all for more than once device connected
to the same CS here? I would expect maxItems to be 4 to match the
number of possible addresses.

> +    items:
> +      enum: [0, 1, 2, 3]
> +    default: [1]
> +
>    "#io-channel-cells":
>      const: 1
>  
> @@ -123,7 +130,6 @@ dependencies:
>  required:
>    - compatible
>    - reg
> -  - microchip,hw-device-address
>    - spi-max-frequency
>  
>  allOf:
> @@ -159,7 +165,7 @@ examples:
>              spi-cpha;
>              spi-cpol;
>              spi-max-frequency = <10000000>;
> -            microchip,hw-device-address = <1>;
> +            spi-device-addr = <1>;
>  
>              #address-cells = <1>;
>              #size-cells = <0>;
> 

