Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DDA21E097
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823886; cv=none; b=bcor1YVKNWBLAhQBMLNMVtgn3NRyUZzDaQ9mVeD1C5ZHsc95w9oEuKJzCRBXp5cXHSbhBi1tyWE8AEXMAJfWxjilm7lXHNv9M9ugLGyxqIfNFyaNchL6L4lnMzX0Hkjw/dsnSrd4i8ZZMWvjwtVkpwruAgAf7ItnAIq47DBL1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823886; c=relaxed/simple;
	bh=mB6gjqFVNYugWLU6vwXbHJZfq1pD9ilhYpAc/8L5b3s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pGIKno3x3OoNzPe0Hj/S21iI+TVjpMqWfQaoXBBhi0SiOfdBOTN6fyZJ+pbAvOMYLcIkHJWLLxphS7aIkXJpNujh4zDEMCF5zkE7hAJTRTn4cbgcaSmK9+uV97kw2iFqyt29ajZgilApXid+cwxN09iBxr2vqYb+Q7dtaKRy+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dsERdrM8; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dsERdrM8"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so22163885e9.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789823884; x=1790428684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynO7gNGl3+DgbWqmrpV3fne3h6bOndWTZo/kOSRwgfY=;
        b=dsERdrM8wrzDZbd9rXNU3oCESGOofGLcz6iOubTex+qe39SL58qh49bFfR1DZ7eIX9
         Ng9lpFI7U54dH+tPW93s1HVi/OZtiSGUR6t9+xhv5tccEiQTTOFMST/x3Hgv8vr9vT/Q
         C546bYIXv7o0hRsmnRuPosOs/9pWFfkiZE0mj0PWQlkoqGxKw/c2C8dWL8CbGLG/ZLPe
         Vrf4pGCZCKWqfN4b0OGdZZzBLK0eQe8Oiux5h/I18I+Y8yePLLrKmHgwu/P0TPbIzIS5
         /IlptPZyJzwkCDs+ihKKcw7TBID7gXwwNlJCVCY924uDpjhgEp+u/FuUfzz0GQhveycm
         GXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789823884; x=1790428684;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynO7gNGl3+DgbWqmrpV3fne3h6bOndWTZo/kOSRwgfY=;
        b=FWiMgpr79aoZTjZDnMapZzaVk1drzcyS9KBNv0gHHvNOBWvUiEgCtqY07Eq+qPp8bD
         qaPSSX6cfaPbHtTrfC5AkNuO1vDT+RxEpGDF3hJruvdmROF9GH6Jrev6MJIj48VFQIzR
         wQG+Tks4wY1yNvv3/wIpz7N5o3erb+pqalhSgtM/DIT8G4XgTPdt9Dy0P/H4NlWMTEVE
         6lHvsrUCDfEhhxEhyfLiC1KqRwTdDFJ6UJY7L/EawjPCMLQ3Q1XAtypCKgTE/aiCjhSU
         Oq4xG+g6YmgiENeLRemlH0FyBQaEugKA+PI9mCyXC+U22bnyQCrKN976I+La3MDmoIV3
         E0NQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6ks5BCUGua/X+fLSVk/ceKgt7GD1VNz4bG8pJpstWfCooX9LHdZU9vAQ1I74TlTqXtHP6ab7+Ly0=@vger.kernel.org
X-Gm-Message-State: AFuF++nHiWx9bn8179NQROuJQuPz0yTXXxHFWl5VzHcgG7R4Jf8XGTD2
	SsY5HnisJ51Vlz3A5ebQ8Pp7ZuP/9uJDLltlRF+vNwfMB3qhFpHRvfeb3likhl32vMo=
X-Gm-Gg: AYBFou1XviAyAoIFBdBVYXXdbpEiyCMstRMF46iHX5Bjnv6sfTYe1LSKZtuI91oaWuU
	FCP4cHPYR0qeEyFR2qb6I+1WYyGiZ4+HJLW9awi9vQo0q2/eRP6365B48H6fK39moJqkVhn1vwu
	4Q9D0mgF6VafRx/tSALD3qgvBz/xICtt4POQDWBPVPlnW3ll9Q3pAxzRwodtWA14Mpyclacfjl+
	K/nM60FmzQxZKWPO7OmR2jX2wFOUCr25zUjkh29jJdw7i27Q0PrrIotUPGmbc6jhDhNo3/QBv/t
	TQoGhEMvRUMJwYGuV1GwNUYGsup32kws4RhUvvWo+2N41DFiCuTgY7lTzfNDfrYZblnuBc2MIKc
	D6qfYAEZsx4FFKEIc0Tsg9LexHr/+wL1LV4BhZJ/1PEMFSDURH1vtyHBa/JyjvLQ62iXJTWTmtV
	2eBO6TAa/TfFTOBC4Yo7/VoCKBs6MaFQ3M4u6tBwEp7jAxxelRTjJS33gXcVTp2KjqmYdEnG9Rh
	4sHA+bkWSP0DcNb5aXAm5yhtPwv7A+bDZ/aq7AKTLn8IyL0LFxr8Nbp1zx43ji2EA==
X-Received: by 2002:a05:600c:474e:b0:49e:7cff:f8ca with SMTP id 5b1f17b1804b1-49fc5743c69mr71850835e9.29.1789823883840;
        Sat, 19 Sep 2026 06:18:03 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd2f7ef3sm70658255e9.0.2026.09.19.06.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 06:18:02 -0700 (PDT)
Message-ID: <275bb967-21f9-429d-89fb-efb8a498f388@tuxon.dev>
Date: Sat, 19 Sep 2026 16:17:59 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v6 08/17] dt-bindings: nvmem: microchip,sama7g5-otpc: add
 sama7d65 and dt node example
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 radu.sabau@analog.com, joshua.crofts1@gmail.com, jorge.marques@analog.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-9-varshini.rajendran@microchip.com>
Content-Language: en-US
In-Reply-To: <20260806074024.531259-9-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/26 10:40, Varshini Rajendran wrote:
> Add support for sama7d65 and a dt node example that shows tag can be used
> to reference a packet stored in the OTP memory.
> 
> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
