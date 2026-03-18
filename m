Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EF25DB1A
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838076; cv=none; b=bRd7rFdNxcHNu0Fql6s2ZXYKZ3L+VZHm2RA3/r0pFfwgiUU0vWeAmISTZ9zB2bLKz+50tdL1arlBk8B8dKHsbvSwcoq/y9Dd3oLt8jMyyKhfSSG2IxCykjd5pX+LeGB2RYvFqQwBqnmOQSVjKwBDAZN6ssoBwfaDRtDFJnhRP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838076; c=relaxed/simple;
	bh=haKwnk7LAe5088Nk51Nv4mgC1HQ0jAtSjW0cfHLTAUo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oEw4qPyqe9BMjKBcAt3Rrll12v5I0xLufQ0JaEk0HW1TV4JuHYtep88qN6vLCW3OfAzwBNLfzm97mKcwnMmNad1zV+Vh77E2G7p2Cp+6mzq4lfl9MIfF+A+7BG+rx6s2fYbUaPe9HY0t3iAKYqmmeUh2qf/BTVO3qyxau9fMHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1m12cZ7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1m12cZ7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b97a9f4b4dcso459055266b.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773838074; x=1774442874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kPUTFEDRHwDnSlS2VHUl2pguJOQjDAxKt4qh2+1uSEo=;
        b=m1m12cZ70ooiaStxdugJP38CgunagyuOhZ6l2WB7RTD8EhQiBzTzv9gohjaEjC6L0v
         WaFATQSkko2vfgsYyHhHoQpeDubUO/sLEq2EFR9xEtgg3WFqhOYpCEMoRk1DZOJCA4AM
         vSbiXFxjyH+DzGaf7R8kI6SqzCHqyf/ihIxa6jkiM0orpIa2euKDSArwJw3xPt26HPWK
         JS+EgV+qd6bNCnWtZpeMPsFcouWwL39U1dDgiljUkeaFTqh+N1F/VKee6+31T+yh+JR+
         hMofokjPD8PXm4xTCpumXYRHV/ySZU5lzpOqgNmNhfqzlR4z/x1Cyu/UmLOQ0BP6wCDN
         p74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773838074; x=1774442874;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPUTFEDRHwDnSlS2VHUl2pguJOQjDAxKt4qh2+1uSEo=;
        b=rRa6EWZEA/P+CbI8c684zrYb1NkTrifgsimf1SezNDR7J+FjswPTit8W3M+uxMLMi8
         Jtq0p6K8x1G0Xg5O4VEiwxoUdwwi9d1WQNQybe1ushnP4kmPQsK5B61gH/HdWPEoVemq
         7ix/lw3aBclgHEZwS/PVYrLrmjbMwMRpEnDgB1emmpL6zimNmNYa0exBwdeBq6LZ1bPN
         17ap8HHmb0wiRkYkIHsrK7i8xv2KN7Jr5mmMkBK9hQpL+pApbfoXy6BuFYZOKC5zmkwL
         CERYitu5DLB4FIgYOHO9LG+hEwe6uCX5wur/RRr7nrX53djJlVFqoveP9kI3h9PBpep8
         3t5A==
X-Forwarded-Encrypted: i=1; AJvYcCVyjadBpNbffFk9+l49EyXSz3wjxbkaiAvFQGyrolIuF7TF0KTW6xSa9gPQXcYfYbNk1oPO3JpfrTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkoUHcxGmy9QZcVxWdwO/bEpveYQnPSh+XB6600qfeakm7ixw
	YeKPuY0maSAtQoPj5s2Hy2S6rlwgtJ1WDJoQXQYIH0R5d+0Lz6YhgR43
X-Gm-Gg: ATEYQzyAv9+WCKxnRt0Sp34krD/WvBXK8pV7UDWN3LWXcBLd/TdrPcEoSoFjqg4Aswd
	TcXrzWrSH2CrioH1+p4bjwPJBaTXTOaIziEP/Ju8jQgMgEiRCgBJyAnanETl42ZKwvECVHHhaiU
	HAoxNAH9piRsaBlq1C+q9XYO/8HgSElIouUoAyaLQ4tFJHNXnjWkiLBibJxY0Kz9t74XKOr62Ff
	Atuqd6VnF9ClblB4YuJ9tpx1D3KqT01F5evJCdAfrp3yowY8uWBKVhfmrSI5ErqtqarNMQ+nUn2
	BMQorV+o/r32cI/l5lycpjVYdROq/NOBE949n2cLwPhdVeL7x2sS2EdZl5uIGJz7PQoepK+JAqo
	mogKxttAVq2yLXcsJybM1qjXxWWVvEfuWs8iC4CGCRcZda38Qeqwhs5H3EcOZB2boJEUsY/iREd
	8loU72ntO0hxB4VL7mcPanKTFV6g==
X-Received: by 2002:a17:907:e115:b0:b97:94b8:f450 with SMTP id a640c23a62f3a-b97f47979aamr155736566b.5.1773838073330;
        Wed, 18 Mar 2026 05:47:53 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1689be2sm192663466b.34.2026.03.18.05.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 05:47:53 -0700 (PDT)
Message-ID: <f740d1e0-551d-43c0-9681-6011d9cb702f@gmail.com>
Date: Wed, 18 Mar 2026 14:47:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: light: vcnl4000: add regulators
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
 <20260316-vcnl4000-regulators-v4-1-854fc2eaf54b@gmail.com>
 <20260317-tricky-pony-of-assurance-7a8cac@quoll>
 <da9850da-af27-48d9-9e5e-2d187c35d262@gmail.com>
 <16b3eabc-ab88-418b-9eb3-367076a8bcce@kernel.org>
Content-Language: en-US
In-Reply-To: <16b3eabc-ab88-418b-9eb3-367076a8bcce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 5:42 PM, Krzysztof Kozlowski wrote:
> On 17/03/2026 09:07, Erikas Bitovtas wrote:
>>>> +  vdd-supply: true
>>>> +  vddio-supply: true
>>>> +  vled-supply: true
>>>
>>> Same comments as before, I do not see improvements.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> I explained why in v3. The message can be found here:
>> https://lore.kernel.org/linux-iio/cb92bb47-9078-475d-b242-71e3f9181a72@baylibre.com/T/#m6da277894cf5c2b473fbeebd4b7bafc7519ebc26
> 
> Apologies, I missed that. VDD and VLED are fine, but I2C bus supply is a
> property of the I2C controller, not the device, therefore please drop VDDIO.
> 
> Best regards,
> Krzysztof

VDDIO supply is needed for the pull-up resistors for the open drain I2C
and interrupt lines. Without them, the device will send spurious
interrupts. Such cases are already present in mainline, for example
Awinic AW2013 led driver [1]:
> there is usually more than just the I2C I/O lines. For AW2013 there is
> at least also the open-drain interrupt line. On other ICs there could
> also be arbitrary GPIO lines that are used in open-drain mode. Those
> are completely unrelated to the I2C controller.
>
> Do you have any suggestions how to handle the power supply for those?

From the looks of it, it was agreed upon to rename the supply from VDDIO
to VIO. Has anything changed since then and now there is a better way to
represent this relationship?

[1]: https://lore.kernel.org/all/ZBoR0DPQ+AufzKHk@gerhold.net/#t
