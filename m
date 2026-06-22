Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252B349CFE
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157379; cv=none; b=e6M1eAXpU0KnJZeItTi4d8+wxmlJ3BtrGwW2ndjj38U8+xSlyAYVPowD5P8sLmwX2BsXhto7RYQLvbVG88HZyYWuXJ/tNbGAw0OUQ2CEWHJ2iFmPSr2sQtzIwqzyj7d9ULN8yCGKblvFVWw9ZzXb+qjQUxPT2KSM8c3asn51nQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157379; c=relaxed/simple;
	bh=pMjY9983Xlc88h8R5u18Pz/l2ARVqbS7uUVOa5DBBgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGJnegH5ShB1WnZJ48VNeIXg6cCw3cOSUZY8UUBWoa/ildLntWELyGq5n+KCY/hCEVI+6RKzU43t1mlKtinw1JvRm9obZTNWPlXDfodiQ9AElWXeh9sopDTfYmDPTAddVqxlA9UOInOvcYGdG5RRnHB+724gwj3gymDrt624U9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=R+J0Eoop; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="R+J0Eoop"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6da33a561so3942018a34.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782157377; x=1782762177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBmXnwn03oc3U/w10vJ5c+8dVUv/tPsH8H+LzNeyaKM=;
        b=R+J0Eoop4uXjDgfdpwTtIsCBWKnF9/23LzxhlNaxMTeP1VmOwVqRoRtoc3Qu+Cz2/N
         N1hlhFCEpt/2IM7eqRw4UuWkMFnRYgWgdLLdNtJC/PeFxixsfOlPg0kSIlc1NE+KohoI
         FmnBd2JEzLSWY181qfk0ZLQivWhl6jOAFaU2speCsoxpPVVdU2sPMMEeVLwHoP9CFxIy
         M9hM4FUEpFFYVT4cUndXhkqQ9PHb9aSJU6qIKnzDTheWRlMkKV6hvSxO9Ahw10gLXOU3
         aptjhkkR6FyNQ+6tfWcu1asct2DsFftCHrXU+p+zuos0xaPQNIw4TvCg32JU0oGCBQZp
         MAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157377; x=1782762177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBmXnwn03oc3U/w10vJ5c+8dVUv/tPsH8H+LzNeyaKM=;
        b=oFyFo7Sm0tRCtAlgBrxwQ5PZgRXkDCtceyU0rdq1HQKLH5Y7hzcx4QUmqoRsAmjTbC
         NCcRQjZuoBXV2gqDsDfG+5JeieN84cHvB4T2m86PzD3qR9PcRldjfcMCWnwBk3KgVqyT
         wSA8OYYBglfD+nk2SwG9ZhfbLudGJeUULS7H3ef5f2FEKAV3+I2fANpwFJ1mCDOXQeWL
         Hk9IJpNLK3DXI/M04zxauoZMhUQfzWbRsacBGR2ZSJZNL0509Czgj8tnuq29/CYAbDq8
         pAFhTERODKIpwM/fSCDI2tOiruua00eIPI+oAbHsU1/PVyP4kbf0BtL/tdzz2RUacQMm
         weGA==
X-Forwarded-Encrypted: i=1; AFNElJ/AKKcNzoE3yaqBAhFDojPOsaWP/4i5gkBSQHwe6n3AQydTk+NtGEvTwRT5BfhtHhCjfB+CEmLu9iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0g5X9/By8urPmyQ9e/XhxNim2WBBy7g5EwfCy4nqySI4jiuay
	BDFhoG/VorSu7zukM5yINC0Rn5PY4pttkOb4vol+gZeItTXuPLuK3BdleInUI/kfPCA=
X-Gm-Gg: AfdE7cmvgGyzEQhkatyQc6FUZCtIc3aalMW3/ZBqI0arrP9I2ftJYeeaAmrIV3Br1sg
	A3BPbNcZ8lrhK2wBHvZmPqnuZX+gVPaD8Cv3RjQtS65VsLeWxTdKX5wy0uT7rB6c6J5XDNH6LL7
	VRe8T8SpGbaLwGWS2Y1MfjGf6Go57kSgXcdiVpVd2WBYsriHZCrGaWearEvOzbucVy90jFqDIOo
	eFKQdDR7ahMOgB7T5ynwdZwcKDWzrtouw3hbstH2HMuKtP9FwXSLDDnMKpymuiEvkCVBm6VOEC9
	x8nEe5F5g+ZwDa+Fd0t60d9+Ozxkt4J1N6XYpy93xe6ZmJhY1MBztGrXaD9Dz7hOzzm0zR7iq6h
	pu8Mi0cdPpM/n0EZKM5DKrVXKzA+rDPIduHF3I4gUWQHQ7ERxu+PiSwupcpBekKA5XzdPSmQ+fT
	cj5A+YTecqcYJMN7WpZ6cyYbkyFLE8SlEReotlvnGhl6QOD/FMvODEBzzXNHN6ND+9xL7KeiF1s
	Q==
X-Received: by 2002:a05:6830:6ad8:b0:7dc:4a43:fb5c with SMTP id 46e09a7af769-7e92d8466b2mr14360330a34.11.1782157377418;
        Mon, 22 Jun 2026 12:42:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944007d7fsm7005358a34.2.2026.06.22.12.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 12:42:57 -0700 (PDT)
Message-ID: <d02bc959-ea69-429e-a526-04067f5f70b2@baylibre.com>
Date: Mon, 22 Jun 2026 14:42:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/3] dt-bindings: iio: adc: Add excitation current
 sources properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
 <20260622-new-channel-props-v2-2-aafd5369f253@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622-new-channel-props-v2-2-aafd5369f253@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 2:30 PM, Kurt Borja wrote:
> Some ADCs incorporate current sources that provide excitation current to
> resistive temperature devices (RTDs), thermistors, diodes and other
> resistive sensors that require constant current biasing.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index fdad6b8276c934c..160a8cfa9842a86 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -86,6 +86,25 @@ properties:
>        source. If two values are provided, the first one corresponds to the
>        positive source and the second to the negative source.
>  
> +  excitation-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Excitation current sources provide current to resistive temperature
> +      devices (RTDs), thermistors, diodes and other resistive sensors that
> +      require constant current biasing.
> +
> +      This array describes the mux configuration of the excitation current
> +      sources.
> +
> +  excitation-current-microamp:

As seen in adi,ltc2983.yaml, this actually needs to be nanoamp to be able
to be flexible for all parts.

> +    description:
> +      Excitation current sources provide current to resistive temperature
> +      devices (RTDs), thermistors, diodes and other resistive sensors that
> +      require constant current biasing.
> +
> +      This array describes the current configuration of the excitation current
> +      sources or the single matched current for all sources.
> +
>  anyOf:
>    - oneOf:
>        - required:
> 

