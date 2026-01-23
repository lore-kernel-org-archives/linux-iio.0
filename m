Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6C1E5B68
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198452; cv=none; b=oDSbwcsR7pMJFAzdgf5h4u1MO0YHBGjK2490w6Qq3zqe3tDRj5GIgn/4T8NM6Q+2Sm53InyN7QXN5M5HasT2sz8O3Trk00qRhYEX5GgxsCTUgOmIvwWRBhmT0btFd8zSRojJxLkC6BeehQIVxycnqxTY66z/rp2rJrmmL5m8N0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198452; c=relaxed/simple;
	bh=jaSV0XV90NJZ5DW0iVOUm7jPWN0ayo+Rhu16Xwg752M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbl8SVZ8e4/gTvuLmiDuMxcfMZHvbtihh7c5B9MpZKDmyIwIuZLnTA3+6ZxngTiUJwmPfbExyIucP2mI23+LeSpd5pPOVId9uDb40rCHhaEnnnMHWKvnoC8E2hVizYjzzmj/57Zyvil7AkQFvi3DyaYutyt1DsTgMw1bMISWRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=biWEAE2y; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="biWEAE2y"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d15b8feca3so545378a34.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769198449; x=1769803249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZGE4YuUh5bkNr/jB1KpY4pup5iAiGZtQZh24ZY4RJU=;
        b=biWEAE2y8hhYAb4xSRpXVOIpHhumtSmteiMO6egnPDCrEGxi4ADUG42blWUPpYsBo3
         rKniLaE60XfvkaEq877XyjQAjA4dSTWtBxVyF30SR67AtTNCkZM9MvMyFYov1CIGFYi3
         SjdZnVf/gSYwgmE0La9b+esHUa4Z/qISzBqDhhBsFfpWDJuwW/4BkZcGsU7CznDx5CZe
         +hiwe0Qz06ceMXSlzrrMmVYxcwHT2Z3wYhM37qpQJ3qsDSCsl4zSS+x9GxNpS6UHvIIk
         kLzlfV4cSqYHGKtCxOAFnpZNVP6pnF49ah3x1a5MPLY0Q+uC3v8ZE2dI+KizRtbkczrR
         8qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198449; x=1769803249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZGE4YuUh5bkNr/jB1KpY4pup5iAiGZtQZh24ZY4RJU=;
        b=MXVXiEzReW5KJVlucBftR20WFa4KMfkFvl7Hg0IUAHVNG0JCHo51uKDX7CGnMTCPIB
         h7s6cP2YxeLCCm4ptEV6e04JRPnxP7AP7GTnMVu9x7sdTfcCe5dAS2xdm5UHq4ciiiE8
         B8Uugchq2D3w3GdXH95EbsmxbzouNG56KNYWmO3XOWGmwRHhhAs6Cq7sHdYWYm/5a4jV
         uUHVG0ocByp5EEVXVYF5lXamUErikTnQCTEcVe+idNYQlvMdum8vehyNrcYyOigXtkCa
         Banro1TvWa1ws1TE6s95d8McbpolPQcW7cBJAwon0S2eLK7HPz2VStqAMkt8GkzejTIG
         DpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlAgVAKABPZJJorsKJPTCgoKAXXNZaFRhh/IAcVPmuknaeqi6hWoQlY+pUcVEFg25vRT9OZzZXRjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFLM87x6sQFb0JUdTflhI+9jXiEvJMDguWZhgElyKXyE3xNGK
	yjYVAe4RyVamoapuTRkdo2YPAU8V8MSN9saY9LguMiesk8fYWNwwJFjcRk8/l0zMSPo=
X-Gm-Gg: AZuq6aJgioUeDruFUzsTrx+QdeLEFp30nUw0VsRAoI5q6lUMslw1jyalr44hQ9ogl6Q
	GrcuZicIGgCxqdxZN7WjyQkymWcT+VOyDEurTomR21qjZvLR6vg8ByyKIOX+nkoBcYoCJ6rCT1w
	htvflhQgMUFgOFgRU1pMsGI+wKq/4TDB7eDcF3evM52shu0lhkPF2zlLYl0GPhiKsVZG421o1x7
	FejHwC/ON92p/c5W5VRiv6H6ZPZQ0n/ql+8D3rsYkxXWrd8legS+1TszosWKTAkEOrTq51dULnB
	uIkDK63a4ZmIu//wHD+4XZVyMdwDvUvTopgUasVicfRmCMoLS4UD1xjVIJV0GUQBz+x9axcREI6
	Jn1cieHZWZVQlasNemGWqpdNK575ocnbaUKkcBc4ZuAP2KCdoRH1FJJzkt+pEWD4ejHtSXERobq
	gLnDzODJ+D5LG98Cxv/xjsfiTsBXnyXyotBDZ+UtlOUK4ZDMZhZHXsboj2Ww==
X-Received: by 2002:a05:6830:6aec:b0:7cf:d1b7:c076 with SMTP id 46e09a7af769-7d15a6391c1mr2303288a34.23.1769198449058;
        Fri, 23 Jan 2026 12:00:49 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b3d31d4sm2411128a34.21.2026.01.23.12.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:00:48 -0800 (PST)
Message-ID: <af4e092b-1b80-42c1-824d-16554d91e792@baylibre.com>
Date: Fri, 23 Jan 2026 14:00:46 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] spi: Documentation: add page on multi-lane support
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-5-295f4f09f6ba@baylibre.com>
 <20260114091024.390432c0@jic23-huawei>
 <ad688ba9-7771-4b64-a9d7-ec5100345460@baylibre.com>
 <20260119101116.00002664@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260119101116.00002664@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 4:11 AM, Jonathan Cameron wrote:
> On Fri, 16 Jan 2026 16:35:13 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 1/14/26 3:10 AM, Jonathan Cameron wrote:
>>> On Mon, 12 Jan 2026 11:45:23 -0600
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   

...

>>> Whilst simple I'd kind of expect a multi lane case as the example, or this and
>>> the multilane one? For me the comment that follows is sufficient for the 1 lane
>>> offset case you have here.  
>>
>> I thought that is what I did. I have one example that shows multiple lanes (ADC)
>> and one example that shows the map (Thing 1/2).
>>
>> But I guess you mean that you want a 3rd example that show both the map and
>> multiple lanes at the same time?
> Oops. No. I was arguing....
>>
>> I chose these two examples because they came from real-world use cases that
>> drove adding this feature. We didn't have a real-world case yet that used
>> both the map and multiple lanes at the same time so I didn't include that.
>>
>>>   
>>>> +            ...
>>>> +        };
>>>> +    };
>>>> +
>>>> +
>>>> +The default values of ``spi-rx-bus-width`` and ``spi-tx-bus-width`` are ``<1>``,
>>>> +so these properties can still be omitted even when ``spi-rx-lane-map`` and
>>>> +``spi-tx-lane-map`` are used.  
> 
> This comment is enough to allow you to drop the first example entirely and
> just have the 2nd.
> 
> Jonathan
> 

I still like having two examples of real-world uses cases since they are solving
two very different problems. It think combining these into one contrived example
would make it more difficult to see that.


