Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF535FF5B
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785597852; cv=none; b=pIT3k1vIX+x2sJu2fYNiFOvnTnFXkbtoADUyMgpKI3/1YAy8Qj5ZsvGXvjgx5E+IvMwILkBm0n0HML5tsSj88YWYG7Y1qO0fN+PKldMpSJIsMt1viFz9L0AD95v3VW6YqfGSm77jRtQ6q5TjAx3qNOsdu1D3LelN/Wi1Gy16QEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785597852; c=relaxed/simple;
	bh=KfKGQnx1eCD25q0FBuJY7nWkwiXRpHJE83d8nZd4uLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRAPlpj4kkrEzOfwsArt8NQLLfLlkmEhzv655U/mFibAnIlJ53C7GW1n1YBhBcJqJVrpzljcVmPzTgBkrgX2hRdWDXN/ySS7FrtQPI4iLj+N1BFJgNVnGAmdntmNvLpItrGDV1X0JguMGqIbVamUrGZGlEBWZdsiVp3xjZPV2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J7jQXFXl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J7jQXFXl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-497d3e4460aso2542256b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785597849; x=1786202649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o74EayfySMbsZ5CiJdiforyPbffJBYMP1tskxGjtvew=;
        b=J7jQXFXlTATXERfFI+VEXpOWNN4bvyfjRPKxHd+1vn2l4mBMXZMhBjkZ64GExFj0eA
         U7gX8ISc1McI3nx5yIq3+y84GzRBl/8823Iqz8DZh9uSe2tATqPiKzqDHz2U0IuJcvyB
         9NRN32gCr/Vf4yzvuinQMgLScqtqnnIIjyao3dhfZNNx4RyNeiOCjD+Zk7T+vfgeg9b1
         uinUsamivgsGtQqoWw4ZfN3iE18RUAeKwwKWSAcY9SfMWurj31ZLoT1F6CpWUKe4u+Wl
         YaUlGIICeBdwH8A8QWZsK8vstONj0y/Mh0jdvqqOVJjFE5CNKW9lq8bEM32nPZsFGj7i
         dkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785597849; x=1786202649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o74EayfySMbsZ5CiJdiforyPbffJBYMP1tskxGjtvew=;
        b=kCliwITayJYt5FI9c9EEnrZFuvaqB+HfbFb73FI5DyOdm3YqalYYkHi8wFxpTd0QUY
         jZkqx6zVu0XZH3+zGyU+nAqyPgpsTvDY8jt4/Z4JzrjOtGNBdpGWuiOs4c3XuaXRwk4A
         zvGaejDQkhrRqJ8PBfjg7dNHpT/Q867vWHnuWF9lx32ksw9cj2+8pg6n/hypeWkVtlSs
         uoevt2boeB+ARdNncwZ8RCz8JbSs6PUR3cLpdmAhOCzETK3EDfXCJwWpxKzYARi6aQai
         PBQEvp901xrR9G208vzP/Eqkun64L1ligsCVag/MNn7fK/b0hfeQaF6im7U1hEure9+l
         XmQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTGUuNFZ9/Z/y+c4uCwoZbqG2C3MV+/vuqWRwyf1cGlgKxbr1oaBQb5QoqgIcyFY9RFuTTfZQ8+UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0/KweCrOxqEXX2Dz5Kxytwpsc601dDTtOVjrrmvKV/xxhayp
	sBvjFzv4vqWl/tiniAh2+eVCZ8+DAFNZlWuR97zJtK8PPNleuMVkbnzScnxPuroMmdQ=
X-Gm-Gg: AR+sD12wK64zWgbi2ciJHkVhRMx45Sylcvhps/1ARq/SL/3A6wRdUAWhiEbSbZB5lcL
	H0hGkmeuWeodLKLtIfF6x7xJujAuG7DPARj7o2idRPUQl7suK6P72QG1CPJs8w00O+1qRDjTQjx
	a8cekDTSspXyZnJf8Px80afvMwWqJEBpJ9etsuuaz8ou6lUzaA6te+dpmDnjF0tP0eWuF/33kP2
	JtAO1CbMhKQMEGc4U0DwDJbUDb6G23mXv5kr8TY+9s16tFeWsOS2F5wy8HFPyGTebHNLroDbGN8
	JeHnbDlmCUYQyQI7ZKwCuNizn0aNvUufXzwI3a2Un/d1qGE+YZdFnupqS2+aLFpg1bz3TUON3Jd
	gj/OusmZD4l2hN2Y9H5i0C9onprONSIqRlME585Q0b+6KkoUvnt0aIWYY8GxH5VmTMz3ubtcqfv
	sUM7xC4HymJls2fEGZKPGLgKXuu9cj0ewVBQP3JFV68MK87PSuvi86fcT+XvdSj2V1hD1/PnkKD
	Ri5NcMyJo4EcafQMPV1ZEUGmouBDK8r4GGcY2o=
X-Received: by 2002:a05:6808:384a:b0:485:7c46:b866 with SMTP id 5614622812f47-4ae31a43a61mr9405371b6e.16.1785597849331;
        Sat, 01 Aug 2026 08:24:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f664d812sm4486608fac.9.2026.08.01.08.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 08:24:08 -0700 (PDT)
Message-ID: <973f6508-f702-4f3c-a051-931035bcc302@baylibre.com>
Date: Sat, 1 Aug 2026 10:24:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: cm32181: return zero after writing calibscale
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
References: <20260731132048.199946-2-giorgitchankvetadze1997@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260731132048.199946-2-giorgitchankvetadze1997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 8:20 AM, Giorgi Tchankvetadze wrote:
> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> 
> The write_raw callback is documented to return 0 on success or a
> negative error code.  However, the IIO_CHAN_INFO_CALIBSCALE case
> returns 'val' (the user-supplied value) instead of 0.
> 
> Fix it by returning 0 on success, matching the behavior of other
> calibscale implementations in the subsystem.
> 
> Fixes: 971672c0b3cc ("iio: add Capella CM32181 ambient light sensor driver.")
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> ---
>  drivers/iio/light/cm32181.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 2590fc8fd154..b32a94028f09 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -368,7 +368,7 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		cm32181->calibscale = val;
> -		return val;
> +		return 0;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		ret = cm32181_write_als_it(cm32181, val2);
>  		return ret;

While we are looking at this, it looks like we can follow this up
with another patch to return cm32181_write_als_it() directly and
drop the ret local variable.

There are also a couple of switch statements where we could move
the return -EINVAL into a default: case as we usually do in IIO.
(A separate patch for this as well.)
