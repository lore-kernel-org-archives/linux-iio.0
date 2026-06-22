Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA46349CFE
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157213; cv=none; b=WXBCLSp42xD6t3S/D84lqEajHUM+3NLqf6YtnMoEgPUImGkrf1fqUIe5rfJsXSPyKNhZeUukwfgTXOI5Q6Dtim/92Qktz4K1dZPvbBYWj3z4x+c2nccv8mpF3EFcLcIro8SFrA3dzL/pTw83iQC1g9FaKe8+sY5NtfDQ03X3wI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157213; c=relaxed/simple;
	bh=lCkdrhm38AlWxxdieCJkxVeyiOyAVhbQ510MuHlfVr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFU7U/6q/TlIs4mj5RR6Cd9Mr5DS8jVoRfL5XKLTALRLGPisRnmNwcAAIbr4+m6vb6+tm2v0NvbMAh+klYzJmWF7h5lEiYLhjS8pjYbvL2ccP4oswpq7XED6Q8rrcG1v6jGq5YIZ3lQbq8FCFLcKdK+mUwxnyT7vGcVxJNbXOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=j706uKmQ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="j706uKmQ"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-489f3611e0cso2234833b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782157211; x=1782762011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8IT7I/yGTO1KOxNCxG0G9O3RLwfq9sFvBwNPgZ+U5Y=;
        b=j706uKmQjNTUZso9DcLWu85403YxD3TYTTKchESqsr/Fht8LNcf1pgoum47hNa36Xn
         soerpQFeJGtPC+maqgUJ9B6PSb9s8ALDob2bVPTTJD9fqLfp1ZHKQrDGVq6PGBQMQmZw
         AFZrPbvt2mQt+N0bkcuozWRO1MHpsDA8DQTfGcfh9X0+Q34dhE2aYQ9TkH1zTYf49Xt0
         yU8oakRMz9wbG4LHpQIJw3i7JZFesBKszCwQu8IKfksd23R9AOf1NPnPLx8k91x0nFln
         rOvBq3ok/czk6/54O1agcm/BxnXewSvtBhe8+yVrvNto4/X4hvxjKGZYu3lYCakyeCai
         cfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157211; x=1782762011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8IT7I/yGTO1KOxNCxG0G9O3RLwfq9sFvBwNPgZ+U5Y=;
        b=g6E9TXynrh30xhFo4R3+oR7jR+Wr6iwUsvWw4CbJWNK4r5E35QCj6AmHUZc/L2EJx7
         O2LWr1PTZ9t1NvtQ6PAdQEeGs2ohbbDf5gBBBv3ojQhph80AcszM61niHGIvDaDhLpvw
         c78k345bmCmiJHnogYhn54om4Udb0bUOrnhPprdg0qYhNnh2tHZYkvtjg771Ry6BXtgi
         Gzix0Shns68cp5hlz272sgqbbxBjUCpICaGoVNxzhDZvpoowR1OKTP24Zfx94f/NM4ve
         Dk9+eBc3uSRqQ0IhLCMBxiXRZ4EqJnuoo3vsyTJ1bY5mJs5p+iSuUr4lS/QuK8NNfuEE
         Q2CQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x3Fo1KbFtJFOJRnoZRnzN3IIp5C2WVikxpwbUXiOce2SOT7buIT/9J+8Ns9j1gAKVNzRCbM9WjaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypzJO3x2g41G97IAoMuILO137hn9gbVWP9xUbio4fL3W8tz4e+
	Pm+iSmnc40PHzBv6NuxX+evErtd7GiqqC7LOG/bjc42z7X2YB+37DePQow4IrPRg/2hJi2K8SSU
	k0Y/MmEU=
X-Gm-Gg: AfdE7cnPgF5zayEgLB16P8TTYUOQqe9SdtxVtuc1zy7xAj/khFDJ+wVRY9uRdxpG/TM
	t6NDLQ7Z9tVHFR9i9wVo4hZLBAE/PmnZG58cHlFWX3lJTDuaKpI023wxBgKCVn+zcusALk1V8CV
	LuRqkCjdsc+gZ1Aj2zoqk3lTcqzOsT4rQsbsajRv18dNV+hBkAGvBrYzbNC+tw2NFtaM79/nVVi
	6NyeGbGf38sxR0fpCoOh0q4ecXYxI79tdE7n2LwMIDPloKFr6gdGCsja1X4zWqpuJbIti6Jx6Qa
	3NRKoFiNAu3q73lZt4sNIzpfADc6oMQAOgTPTJjGkBMzCqxSr0rYYVzTHk8xqpsDMyXIEk9I329
	Sc9vZ2L5mQH0TNWC7NP9A7mGna/F2DgTVM6i4LywJqSMtHb7vRHUNNZe8JgVlOTxIBcUhgResSn
	C536EvHsN88uozvv4jIBO7ZwfRFo07Oadn+96rTELUD9HiShuH3QWh/Bd9EoBb5rI=
X-Received: by 2002:a05:6808:4f2a:b0:48a:a85b:ba53 with SMTP id 5614622812f47-48aa85bc13fmr13627807b6e.35.1782157211349;
        Mon, 22 Jun 2026 12:40:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0ddd7bsm5103906b6e.7.2026.06.22.12.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 12:40:11 -0700 (PDT)
Message-ID: <baeb24dd-214f-4dc8-a300-22b932c4b4ae@baylibre.com>
Date: Mon, 22 Jun 2026 14:40:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/3] dt-bindings: iio: adc: Add reference-source
 property
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
 <20260622-new-channel-props-v2-1-aafd5369f253@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622-new-channel-props-v2-1-aafd5369f253@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 2:30 PM, Kurt Borja wrote:
> Some ADCs have configurable voltage reference sources for each channel.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index b9bc02b5b07a4c7..fdad6b8276c934c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -73,6 +73,19 @@ properties:
>        device design and can interact with other characteristics such as
>        settling time.
>  
> +  reference-source:

Since this is an array, the name should be `reference-sources`.

> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    maxItems: 2
> +    minItems: 1

Maybe minItems here is OK, but I don't think we should put maxItems here.
This way, it stays more flexible for other use cases.

> +    description:
> +      Indicates the voltage reference source or sources for this channel. Some
> +      ADCs usually allow choosing between internal reference sources or a pair
> +      of external pins.
> +
> +      If a single value is provided, it represents a single voltage reference
> +      source. If two values are provided, the first one corresponds to the
> +      positive source and the second to the negative source.
> +
>  anyOf:
>    - oneOf:
>        - required:
> 

