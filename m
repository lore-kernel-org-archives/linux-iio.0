Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A3231A21
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519737; cv=none; b=k5Hh2ChOm+qHHdb5xnKMuU1aRv9DEoq7LheQAXb++gt61ZfUtiZXxOSf8iMv24sXaYfP8Zexq0uZtrGsLxhpTSrWtHpycJRX5g/lMQ/OxHdaLIGLtZAS7iS9b41bTs9TvsrX5AYNJX8uX9lka1GeNTnhhZA7APuNIGV82FxRAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519737; c=relaxed/simple;
	bh=gv5UVXcM+GM9/Tz4ymtqz4cpxzaHKReheF2p9kWkpIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0ykRvuFAn42q4go6tbtuP1AxLZyp0TO4wjo9nzGftJwi0Yj8mgH3yq2To5lyOnVEutBau7TSMsopzCkGkaomzELZhhxoHBF7Lj9v+cXYP1Fulp6SMUWBXuZW8AZmfiqCzj5mXp+ncxQIJMf/CFxc0aWBM/IKdd7UTBBOOi1w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W3aAHvOe; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W3aAHvOe"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d75ed779bfso3461032a34.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773519734; x=1774124534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJo3ixYn506JdxY20NI00e42tBgHOxbKoRjS/yR4UCY=;
        b=W3aAHvOeVbq8M/LNpdiF/NGrZPqtNcazwQFirxNhYD8NZFSiumlShqzqWFHx45nbmI
         BNkUrShC4Y5dMNQKZqaBFWYdBnIpZuZAB7tw3q31DjvwNToDblMfpqBFQG7ubLn1mgs8
         uKtjFGn5aOWQsNxKbDhhr1UdtlkmIzNlt00aJs8G+4JM44RugUJ+8OhjU/4Sas5vZMRx
         DM3lU9QZShxXDGAdNIEbCOHIAIqWA3YcD2Cy8cWkOC4CrorCm/mVDXWkaO1eU4p7svyC
         Xlet6v3mgFL1ZZjf+kxWyuTLUohGVKEEYPMupZ6yOMZ9tbo5dsVJ2kpRVYv9E9xxO6Zc
         d1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519734; x=1774124534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJo3ixYn506JdxY20NI00e42tBgHOxbKoRjS/yR4UCY=;
        b=b+rOWMHxMXVB+9CzIHFzCT6r+0/X9Ayy0+xetuJX1Er43XKtCTaSSGTGTBYV+OFI4B
         xQNMC9UNlqMT4u7KBJXZTV1RmGsIzlEykZJB1+cCRZJ8zU1WQa61NdRlvnSszreEHOtX
         JyiZLKcz/edIvbOf5tsSKPO9pOzxJ9PCH7doEEq7uYMZZWWReT0Ifx64b8/wgKQIV3I4
         p1QG0e/U5kl6jL4D+tVUcSsXftSzWix5TDAovOfvFiRd7n1cp2X6TILxcn0qZO2SD7+Y
         9+afc6guOfllg5gfa3Iir6gt8p0ABKIWLjl9S77Mj19VqJkjaRgZDMeYz1n88DtdIlLG
         ZLpw==
X-Forwarded-Encrypted: i=1; AJvYcCUYRrTDqYLA9xwFD2XwN3aQ30h+Kpt5kWXOstfva8h/hlT9+DY/hLGeB55rLKjKnv5m8P59hS2igOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPnZEnn9IBo10vYdAWgBvO2zDSUgctnK1GYv1CEQanAIU7WjR
	aY0GgDvXDySBmHwo5AsYxKPnprQgsk9sTdYOiGoBmOXskUtUPFUfhn5AcWsnzsv8rzaBpv6Z3VD
	nLSwl
X-Gm-Gg: ATEYQzydyib18TcYJvlKlFpwLV0TbmKhEkvq4vRKDpZchAzO2e+7SCASc49CDh2gi4y
	h7m9JPDSiyQ6ccEVt2V9cKMMaG9H2eLt0ZVd0fdp8K7W7ek0OjkRy75U5oYbb2qUF1fIavOnVBL
	PSyXvc6PjzNmMPMgUw4sMZuYyPCQBtPQ7r25d1OA0utxIiUceCTsSIL4o4XffF28ZTTsd/vtT+y
	Nlg6t6MUXm7tqdDph1ALC5TERt2NFP7EPgfvaiZLllYTA7xap4VHU47oSwV4KtD/FXaGpWvKDM6
	KCJY5aMwA8LykTTXQjoADJh/mTxIIci8dFdznf45cwYFeXZWVlfDwCFj0kSwxSAwEkdB3rPYbhO
	tqbMSIX/M2x/6SypCr94HqOsd30K6+rs+3d1ev71CPUXnUJWSEabxnix7rV6IsBcpHUM9bs0Bv1
	TdflQdqzc9TXtxgmzrzVZail2Vvg/luWSmgI87WxePtGJaeSIXp0dE1y6Z94M6gl5EZqnMPFnl/
	PWNYhya9bdK
X-Received: by 2002:a05:6830:6d12:b0:7d7:4aec:7ae1 with SMTP id 46e09a7af769-7d78259d059mr5215603a34.31.1773519734048;
        Sat, 14 Mar 2026 13:22:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac328b9sm8838001a34.1.2026.03.14.13.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 13:22:13 -0700 (PDT)
Message-ID: <a2e56b5c-ef76-4a6a-9ffc-e8fe259a7153@baylibre.com>
Date: Sat, 14 Mar 2026 15:22:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: fix ADXL355 temperature signature value
To: Andrej Valek <andy@skyrain.eu>, linux-iio@vger.kernel.org
Cc: Valek Andrej <andrej.v@skyrain.eu>, lars@metafoo.de,
 Michael.Hennerich@analog.com, puranjay@kernel.org,
 jonathan.cameron@huawei.com
References: <20260313092413.35912-1-andy@skyrain.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260313092413.35912-1-andy@skyrain.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 4:24 AM, Andrej Valek wrote:
> From: "Valek Andrej <andrej.v@skyrain.eu>"
> 
> Temperature was wrongly represented as 12-bit signature, confirmed by DS.

signature == signed integer?

DS == datasheet?

> Even if the temperature is negative, the value in the register stays
> unsigned.

And IIO_CHAN_INFO_OFFSET will be negative.

> 
> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> ---
>  drivers/iio/accel/adxl355_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 1c1d64d5cbcb2..8f90c58f41008 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -745,7 +745,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
>  				      BIT(IIO_CHAN_INFO_OFFSET),
>  		.scan_index = 3,
>  		.scan_type = {
> -			.sign = 's',
> +			.sign = 'u',
>  			.realbits = 12,
>  			.storagebits = 16,
>  			.endianness = IIO_BE,


