Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FB30D418
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787116547; cv=none; b=gWR3mpi6Cpu2MEBg9UdpjziaYCcfOj0c+iKWumuVZPCxJs0QjbXGBCCkqOu4myLNJirGHLsvXGeC1M9qhMukBJ+o3VR2zw30ETMO/P6o+REgUY/Y0hUTm19PNftIGzC+neAlu6SHWp4XlUmjML2ALaBI+zw+mVAklbJn9/EksCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787116547; c=relaxed/simple;
	bh=UnkQv4kM8XuF78pBN3xPMkNYBRkSeUVmasVSJMrCfG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWODlzv1RA7Y0RoTio9S5Xz/VEPUzWy9/bzoONx7Lf4QNafRwUF2L1C0TQ7RZl552P/27V6Dpl/9bkslyCjl4+jjNZlW1frBzlagFcHjKTcbULlRamuoj17/4fRZpQJDBgA+OAgabb2nXVT0wgL/ndFHX98sH4cPvvwXa8DK894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIc0Nxig; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIc0Nxig"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b01146b205so522100e87.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787116542; x=1787721342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynNMYlH2iVBR0QbDnzi1NN26jmaCTIwuPqyidD2cakg=;
        b=EIc0NxigAM02ibD75En1iIiNf/FzO+ek9XWYQrLu3J/MVi7fyJUos1jAcJ5yTqnTT8
         dZjE3K3io4L+dqjNa/GqJOpCA/1ILme3Z1GUEBoikfEXCPFZz/4skKR8wPITSqb8QqoL
         qS7fmvjrl98pQczmY0mMdn9SonU+WRvEhQQZ7RB8V7NCEwDqk0Fbc3FOAq2ONsVMEv6p
         HhPHiMGvTTl//vRttrlTf1xVlsv6N/c1rNFO0Xy5Gt349HvwElGOIlUFsmSMG0WKYF80
         gh/GbjGpzrqnFCHTf0eqWG4nMYRbxmbKSQNNR76J1YeK2TmUoUkXwUvK8faYvh/hG/rL
         MxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787116542; x=1787721342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynNMYlH2iVBR0QbDnzi1NN26jmaCTIwuPqyidD2cakg=;
        b=SeMb8Q9TZOWRzbkLvbY+jGY3V8dm+7MeKqynuHdox4i0QQiWP8EeRJZb8YBDva/lp+
         Id9iUqEGDMy75KWcqfH49yzagC1SBSDLMU3jaJpg16E2e1NeIcGvZouPlVB0EDWAS22U
         /dBUkA/AnYMC/dvTjnN7dTCCDH5eNpnkNPrKKF6XG1q+vClqwnjSdPo2qMMEH+2IfoYQ
         ko1T+nxIX4ysGuLI0JD8vGe4IZXoUVayq2xAK+NQIG9kLLBM/kgFwDFuIf5tNGCM4K92
         oxAelOyDB40cSjXvH3rkSmmn+Fvpti4Igofthq4xcuOwg69o2p5KI000LFRwNGNT5kD5
         4C8g==
X-Forwarded-Encrypted: i=1; AHgh+RpHTUlwoDyFpcIzgmhbTqC4SBrLj7JoycJyjCV4zhV4uQzTBfvbXvcJVTAK4/iKRR/eY8IZ1P6xojA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcmHHdIywi8k8XeCx9dZP/3PAHqMgNi3ZVyRbsJYvek/Ufpd1
	IYTrlD0e744hknwDTwhs9DUGP07dlLXQn5aARcy5aI/BW5mytv+uFGan
X-Gm-Gg: AR+sD10Mpuq7zT4GgW+TltcsuJpYfznENrbwIiZcKu+scDVITNf0gFG5RpuwpZc1pcK
	RFfzAmwvZYJhJXZUsvVIPaM8Qbsrd5iG6AkZ/yrTMANnLu2BmzYqi4AVS5uBH9+Bxc2Tlrug7WI
	10Ee00/LTpfR1WKC9Q/0ilKg0Q9tPfHDtrGwZ6rGUypegJOKmXRMD0ukGnZGcmBGFglo9aovj8/
	GZXq/9FpMZG1iLGzBjiRcgYbxUxPYCLq18hxG1JoVBl5PWMZWUI7zmBWEP9uCfqFA7mtmeQzZN2
	bDiAgFLisvKnC3ENADeqB7Jold2r1aTg162RiOONNTaHKd68SHFCw+FoHy7OBzpLBTtR9NH4VfL
	nO6vNRejcTL1TCaM6ZRWKMPfCfKORA0HkHmqZob0+d8IZcSEOoIzFs95bpwbLhKCfF3dOeEZD3T
	j5WQGw7zj3IP3mE/3JKJ5pvZKpcp2N+mFk0aYffGUBo8yicAiYWdTpAuvLqKt/SNYWubzEvXLeu
	qKdWLw+SYgGmooXqMJ+g6jXLafu5Dfj/mhPWYQO2zoAlnRtzeksdDg=
X-Received: by 2002:a05:6512:3b1f:b0:5b2:f426:9c67 with SMTP id 2adb3069b0e04-5b478bd8b93mr488499e87.19.1787116541862;
        Tue, 18 Aug 2026 22:15:41 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a18a8e8579sm1510551fa.0.2026.08.18.22.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 22:15:40 -0700 (PDT)
Message-ID: <a23c2959-5c05-4018-9ac8-7c87e563d1c8@gmail.com>
Date: Wed, 19 Aug 2026 08:15:40 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: accel: kionix-kx022a: unify staging buffer
 and convert to iio_push_to_buffers_with_ts()
To: Jonathan Cameron <jic23@kernel.org>, Gabriel Rondon <grondon@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818215122.52715-1-grondon@gmail.com>
 <20260819010900.7728cff8@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260819010900.7728cff8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 03:09, Jonathan Cameron wrote:
> On Tue, 18 Aug 2026 22:51:20 +0100
> Gabriel Rondon <grondon@gmail.com> wrote:
> 
>> v1 was a single patch converting the two push sites to
>> iio_push_to_buffers_with_ts(). Reviewing it, Jonathan pointed out that
>> the driver carries two separate staging areas holding the same thing
>> (buffer[8] and the scan struct), and asked to fold the cleanup into this
>> set.
>>
>> So v2 is a two-patch series: patch 1 drops the redundant buffer and
>> routes the one-shot read and the triggered handler through scan, and
>> patch 2 does the deprecated-API conversion, now with a single buffer to
>> push at both sites.
>>
>> Changes in v2:
>> - New patch 1: drop buffer[8], use scan for the one-shot read and the
>>    triggered handler, move IIO_DMA_MINALIGN onto scan (Jonathan)
>> - Patch 2 now pushes data->scan at both sites instead of data->buffer
>>
> Nice.  All looks good to me, so I'll queue it up.
> 
> Applied to the testing branch of iio.git which will be rebased on rc1 once
> available.
> 
> Note that there is plenty of time for additional feedback, tags or indeed
> me to drop it again if someone spots something I missed.

Ah, Jonathan was quick and efficient :)
I'll drop my comments to 'nits' in order to not generate more work for 
Jonathan. Hence, acting on my comments is not required.

-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
