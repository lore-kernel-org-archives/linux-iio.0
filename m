Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D80336EE1
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879101; cv=none; b=pNG+Ztzyjo3n+p0aq7lYO1GPmifh0a6My3qXUzXtr2gi7GkUMHZou/FqkJTMirZfI2AyiBPMSZVuvhStdMV6rOkFRgW0wSKNTP5hhFpvLu+ORfsDH55Yi+QlRb7vegDxoe0lYgQewnRkOEAysCyNfot0ecQm9qD6HLxScyRndM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879101; c=relaxed/simple;
	bh=pGCla/vvf3lJsUCV9oSk/dYHXQS9yOlxHQdvLssuW40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcdDJRpWUTw026aQpjYgxC8xUSO5gYvQ7mIATEFg/m6aylMrioj+tkdrQB6XZ2YBoy6yMFdlMRQyOS9HK1Wq0UD+Y0ZqYGOOJ3PYa0nUuMCQfE2KXJ/M5xMmBm7sfNkbpifM42x18hDlLokO2jLSxZm2NF0VYDWjAnpVSX0kByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=meW2LVjF; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="meW2LVjF"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43d133d9a28so832921fac.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781879097; x=1782483897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26PmlAB+sYAYcUZ9jY2wJzqTIoNsm0ptg9G8UNT6ht8=;
        b=meW2LVjFmK3RVTIRdoU/KQlI369U2S8gd42Lrw5PZV6M0sL52OtjzYjNHN+DVN3Fsx
         3pFTJJKAi+UQvZs2FEDJdpIIv7UKCWS5k6EVBbWZQX/K8F+j84xvs/k8zaqlUKuMOl5B
         P4Rjk1WTl7d57UgYYEJPUQmvqbYLa+7RJ6SG5TmxxrnOG9yA6qpbbvZGtfjpxOnjAXPB
         MjjyTShfVsHYqIuhLKd9p164sz6ilCrUU1BGBOZ3whlBpJYQ92iKo7FfBWx/Jkxl6eEl
         40dfuWr8FJ5nxqOAqKT8ET9JYbSjz3T4++DP776xFj9OvTw6fW3+L21fHNx6JkYdtSkU
         v6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879097; x=1782483897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26PmlAB+sYAYcUZ9jY2wJzqTIoNsm0ptg9G8UNT6ht8=;
        b=jjM0/KagsgQ6vQ9abyHRB/zqH98+x3E6Q3yq30QxzzPbHECg9w7C6M3SW4hLm6OoYN
         cgNrJ3ItpaXR3MaUEwT3MCOAFBFoWe4Jv+MXfey5+OQp0Z5LUuvEMdiVbamcDprf92Dl
         65DqDiZyJvKQMF2W/4IjRyeHRHxFl05Zml2fIf7uUTKrmH0gnYfDVGmOH49Gix9n3xWr
         cGa36DzN9X9qEITFmzG2ppn49wZqC+h6vJ/SdY64ZWTsyHQZYEDrkqHMcdBxQ3O+hghG
         6ZbWBNF+pMgGfwCmVwJ0ZvmfEVJ6mj5qjy7jPZzMck9WOQwym572qZqh8iwilFQPM+ew
         Gi4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9K91z/MGjBUxDyR4bE/y9JmbcTSLwL3Wku1ABMH+6cWvj7+nJdmBWhRxM5vZN5LvokXNnnffKXilQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AV8qNMg5QqLaN8li6JcEsEVKsGchBgoKvcm/n6g1m8LWPcEF
	GMZWFjxreSITECMWnlEAgkZv34OpWs4ZkHAEO6iPYc90a3XVn/I9gw0lEk0u3xGJujk=
X-Gm-Gg: AfdE7cnkI4gp21ZrKfusfPLPi8QSum/9n8CkQV8s08KxSGAhV51k3N1upUHHpJNCbMX
	J+SLtZcZdGeD/vlHe8RNv4cc0H2sblB7z8noA/T0QXfFy0hZUfNw1pHuBQ7tcHyMIshHv8L3Bho
	jxsephBcc3Llu0T0DnBUPLLWYUjHURdi4reUCHmtNkkyG9POiw98+SQyAWBGdDRFkNmbxngE0UQ
	7h7gFtlReLzbMyms6KjPJfA6B/MMq9UuTed7GdM39MrIrf21mn/Cs/Ig/GEtglsgsMEjt6JM0A/
	zOeQZ4dZLJAw/eDSxWC6x19FuCJHs8l361XKoZsX3rdcd0yPr0sNtZCgNK74/5pqKtqPx8rxnM7
	Kmlx4/+iOxS66wt+1/TkcaQWxakgh0qcJ6s7YGWBVGcxJYahxsQr7q+6GThO4mY4A635t4U+rNp
	76S4VhYpPXrYaWi0aE22De2LdDqihUxWfi4biCLqlWJPuC7T+pg0TRtYzqAg==
X-Received: by 2002:a05:6870:21d4:b0:42f:d844:7d0b with SMTP id 586e51a60fabf-44706ef4944mr3031655fac.6.1781879097453;
        Fri, 19 Jun 2026 07:24:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4470a3091e5sm2351865fac.11.2026.06.19.07.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:24:56 -0700 (PDT)
Message-ID: <736962f9-50b9-4884-88b1-94bfd7cd8abf@baylibre.com>
Date: Fri, 19 Jun 2026 09:24:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: Add reference-source
 property
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-1-963c1b5cf40a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260618-new-channel-props-v1-1-963c1b5cf40a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 7:33 PM, Kurt Borja wrote:
> Some ADCs have configurable voltage reference sources for each channel.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index b9bc02b5b07a4c..c74c2084fdb68c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -73,6 +73,16 @@ properties:
>        device design and can interact with other characteristics such as
>        settling time.
>  
> +  reference-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 2
> +    minItems: 1
> +    description:
> +      Indicates the voltage reference source or sources for this channel.
> +
> +      This array describes either a single reference source or a positive and
> +      negative reference sources.

Do you actually know of any devices that allow independently selecting
the positive and negative sources? I don't think I've ever seen anything
like that.

Also, this should be string, not uint32.

> +
>  anyOf:
>    - oneOf:
>        - required:
> 

