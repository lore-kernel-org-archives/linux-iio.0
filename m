Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD9397AED
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879233; cv=none; b=uOgwFAcyuCJIa2LD9wdlGh8H4BoiS8IZHhrOog/UuMm0J6osaGedkeu2DZChOlhcLIwrlqFqpmRQFs+VjHzS2neq5G0y+EP23Scw55vWsXXahNy0tZ6cDf/mQabMKAdhK13L0K5bQalGZ6grwEcYNoajVr6yeaxloRVQ5NG91zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879233; c=relaxed/simple;
	bh=tsZcS1Ql5O0PIy+kzQJ4rmy5aAwuUe8HeUYy8fIOpZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijI7WwDMcsaghl+GzdstfQL8qN1auZj0OcAj1Q1npk9nZW5HzR+RwzX4gZ7Z/6YuqFSWWX9kwQ2fGZfDaMmm7kW/Y6x6+/ZOEpiA1rB91cwteYlxIHhAdOTLH/O9D0fgVxHvCl2wePM0GYN2dck4AGno+tHhiIZ7fOgkG+vq9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eB9DqW22; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eB9DqW22"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6f586a0d5so1078553a34.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781879231; x=1782484031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1j0UgJOZIv8fQVrRLhrenC7+Pv2Rmi7dw33auXSxlrA=;
        b=eB9DqW22xMMl2M9atWWa5RyFMuy6xbhWHUr6EgUWCirWCvJYQuePVj4Q419qTEm5Bn
         fNVnL+DQ0K1vN6uN6YJtwibcaooSpDiFnSDeUpfEf2YEB/SWSysuiNMQqL8qw+QM3rPq
         hjOCr72T5prolSR7rDUSmq9KwqF4o0Fba+tTLZVYdBtARSUo5RyVF3dWugoqWuQJSADC
         rcAuTBxJRGuQ1XIJ8kZ5vE3t3DGY3zTdesgmPq1E5SDr2RWDIPWZTI/9xIenRd/YIjmr
         NsNED22QZgNAV8JybGTMu2YHBJJgG/bak7LtxRZcfA4BWfPxgmxRNVqJyb2p2miteZV1
         bwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879231; x=1782484031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1j0UgJOZIv8fQVrRLhrenC7+Pv2Rmi7dw33auXSxlrA=;
        b=hDcNTEpDcYtVoBiUbwjhb4qsszfMliEymKis8mNBybiOcQY/1RPyvsQxhnDOEIytCS
         j8Vzy2Nv+YL08nAFQldUD5P4OQFYK2PuASqhceT1CtSbzkyP1lMR4DBWw0yq/ZWUqYQt
         g69HZnKCamWir4z0rsOoolIb6OseV56drWFwCJz5GUI5cXcU6WCrgu7h9cJrbgtM/8Xl
         UWzEJh0/ecG7rMI9W8Hr7bTXvagw6BhcBxakhNf7jA/6pJNBus66wcM9EMskdYdOdjaN
         JhsqPqaqRKVf1xmUAMha858FehGWc7v1BWIo8bT5u2pGY4ERVVbigN91QG2aQT5HXvZi
         Fr5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ZKdfdya2A40m0Zcji5NfUpeDPicIKSMJMLdT86Lz70ZrCiaI6WaODRQ5wASnV09lNVFzAcbmh0Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsivUCLHG9wdzZ/HI4jAaakAFxgkiunmMXu7GQIMUp2z/K/7mK
	x0L2G9cv/ND1htYNZfTc71v87zhgm12UjkXsIvqQx+R/B/4znzvcOhsyR552N7h5//w=
X-Gm-Gg: AfdE7cnJQOY/pfgBlD5zsLB1/kJMINVlFMW15B5/gmz39oGRRgQqSfRw59cjuJixiM2
	qHsNJVW49BsIxtZXJvWrmARSZd9xbXNvys0pINoRGHKWIJ+4l0IzUHXvGFq6nm4Qqte3XRgxuBI
	fNBPQPXvy25icdFNX3m1M5vOLD+aEK9SmYsghRjDUXD3M+UqwFrxT3hs9dvarllz4B+ffAsrwWD
	uUd44rB6HEZ7X3yMeZbJB9UQKARG/ZmTaY0bz3zcRIQZWF3GRu35xJzwB21pZPw86R7zQjVshSO
	U3vrDtYzUpq5kbBoxlCra5ozFfY/0bfO/tg3lfe3zV9swlyZeNM/G/M/sCa5RexOs/xrKq0loXU
	X+8nds5vxBVK2S0VIN9/WEcadMZWZB6mEeXqGksWDlhFQCVIUJyPhMs2sVTOzFWUAbr2BLMKzwc
	Uc6pkXIpeItJ/PNq1T6GP7WKWuEfjJ05qqlkp8GuHip7UWbBmHPzkIiFqNSbpfXQLNocRj
X-Received: by 2002:a05:6830:6504:b0:7d7:4fc7:21a with SMTP id 46e09a7af769-7e92d85d7aemr2596343a34.13.1781879231361;
        Fri, 19 Jun 2026 07:27:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e92ecfcc9csm1932228a34.21.2026.06.19.07.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:27:11 -0700 (PDT)
Message-ID: <073b0a89-65af-4a21-837d-851d35e3e294@baylibre.com>
Date: Fri, 19 Jun 2026 09:27:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] dt-bindings: iio: adc: Add excitation current
 sources properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-2-963c1b5cf40a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260618-new-channel-props-v1-2-963c1b5cf40a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 7:33 PM, Kurt Borja wrote:
> Some ADCs incorporate current sources that provide excitation current to
> resistive temperature devices (RTDs), thermistors diodes and other
> resistive sensors that require constant current biasing.
> 
> The maxItems constraint of 16 is arbitrary but should be big enough for
> most devices.

I wouldn't put an arbitrary limit here. The bindings that include it
can extend it to add a limit that makes sense instead.

> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index c74c2084fdb68c..106b1e317411d5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -83,6 +83,29 @@ properties:
>        This array describes either a single reference source or a positive and
>        negative reference sources.
>  
> +  excitation-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 16
> +    minItems: 1
> +    description:
> +      Excitation current sources provide current to resistive temperature
> +      devices (RTDs), thermistors diodes and other resistive sensors that
> +      require constant current biasing.
> +
> +      This array describes the mux configuration of the excitation current
> +      sources.
> +
> +  excitation-current-microamp:
> +    maxItems: 16
> +    minItems: 1
> +    description:
> +      Excitation current sources provide current to resistive temperature
> +      devices (RTDs), thermistors diodes and other resistive sensors that
> +      require constant current biasing.
> +
> +      This array describes the current configuration of the excitation current
> +      sources or the single matched current for all sources.
> +
>  anyOf:
>    - oneOf:
>        - required:
> 

