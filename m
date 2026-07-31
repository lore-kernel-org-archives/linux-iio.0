Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAC438472
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510571; cv=none; b=n4OPfqwf9uWIUdCmNg3Ut4AtfohV7VmckFrmf1ECI5eRMt7OI+ZbAuOo9bEvVAz4IcwuSVuX0eCNkKobJg3xRaDbW84laRrlkA9e6kAKs/91sVl6HHuiabiaWaevGXhx7antrScZTYqLnrfrSg32rGFv16sVEUxsQ0bVKyZ/RvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510571; c=relaxed/simple;
	bh=H0PtDtMH7fhKXYVLHdaggAQU9rhUC69jlh+BkXkBf9g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cy7UpvisaRGb65OlTPYmF+zDmhdXUM/w8NMclt/KA6bhadL2A/MOC2GLxZBr66idEm1nD8qJimpw5Bo0j5RNzGd1L7TqVNcLM5Uggf6e1dmxzhb+raPaP8HYR3Iwy5x6vwsU9/ELCnAxFpubuRZLw9wMh+Q8f6clY9XCch6NfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bUvjqg6T; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bUvjqg6T"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1172035a34.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785510559; x=1786115359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q7B/qtQQs7zBLF1wHpifwjnC8NO3TVJxvfEFMj9bRfo=;
        b=bUvjqg6TJ19WEzFCXJsl+kt5Zb3Ppxgv/JgEzHlfLWB8jlT60ChmpBGNE/s542p32T
         XT5vkPKx5LRCyuBYxqbV85xvb0kBM1IAqiDw3qQgwCTddCJjnyXRLL6xuviMkJvESvPR
         sZwBUn8I2vV1m42PCbzGg2vtwv0Rqbx4WbXyR9qf8fH+7kRch0WJFlVq8IoSFUb2i+nE
         GC8o4tWzQs+YQ08+n0Gz4tI3thbK812bAy8Fa9mcvIJbmHjYfRHYWVTyrSrdCp9trdYh
         UB0vunTMOdsz77oOXBY2jz6Lc0T5a9ReuKAV0j0JIqbnGwl5cc+5t8wD+DvzNZqPlol0
         4l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510559; x=1786115359;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7B/qtQQs7zBLF1wHpifwjnC8NO3TVJxvfEFMj9bRfo=;
        b=kWND8yt+iJe8sbLvySL8tM+G7rPeygSSJVKcMEKfMWztyY0mllylh3enpumL/HOoD2
         izPcVSdtN3EuijwVFslix9bD/Re4g92jPUg5sjMvBd1gEF82zZAhknYRXQbx8S/W4mHh
         w0KqgxuuT3SBdfQFQhgBZTrOGn2CFDCba1QpgrPM/ZYh6bemynKop9ruW1cAtgQhrQI2
         rIkkx+VZP2eoHEPb1RAeQc9mYdalh28X+u43enN5Gsct+NeAqp7Rxgitqfbm9/o/kPI+
         iFDFZox2TVixHYSh/8fFzifSCJeR2lOV/nhhwf0Gv0rY2oENu/FFaSb3x+Up78VvRHUU
         Q2rg==
X-Gm-Message-State: AOJu0YwAxGJVywBEJNMfzg2fAc6+8Cg2bSe7UIjG4g/Jmt2U4z+4iQOy
	CYwAFUwcMRMcdtCfFYmfMHEZgimocOBHONmPouCJcoBacSsX2dtT7wMbij+VSbnbQb8=
X-Gm-Gg: AR+sD12K7Wnpx343bfDHkrpzWtG5s8KSgO+eieoNHNWrMJPqyUbApXw4KYz2T+4l7Md
	UnXiFCrCgWjlrHkhZtnUh5RuwLEZ4AQIygBs6SbdQC4avQ+y4g1ap64WZ3kdzXeF68Msp4MRSz0
	6XPdwgYPDsXqzR2E0G8ImYtvDp07zDVbho9/ejtL96SV1sdpbwTy3z8+AiB9P1hVe9zLQN77tzZ
	o9AqT1vqBsStUPiAMwGBbgeX0WNjyvWhj7JqbzOgeBKPE9rMI9CiewUGy+sEga2xRtfVrCaS+aH
	E73asF77dxBSdhEXjBIKKbILg0RvkSDx9ol/v/AvoftKKetUQi3nJzxZpOv0igfe1I3xDcr4r0I
	xqVLuRuUcmvFD5e9sDYpaAYTUnKJ5Q+n9cBvvnOCcuDqmVqYflRqEx1uaB4HIgM8hquQ5v4ldSx
	P65Vsz2S9x3r0QL5neI/vx/4kzAASI+UM4pYIYzzxMQjakpsICvtRDbDU7ALNXpkIKTMj5jZXkA
	weMppCD3r/W6EFr5Ar6Mq5Bn3MEdR1yLr75nNHEEUR8VxEdYJw=
X-Received: by 2002:a05:6808:198d:b0:485:48da:133d with SMTP id 5614622812f47-4af5e29c73bmr445224b6e.10.1785510559180;
        Fri, 31 Jul 2026 08:09:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fa40:746f:401a:3b75? ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58f2a635sm795191b6e.16.2026.07.31.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:09:18 -0700 (PDT)
Message-ID: <feb422c5-a1c2-427b-9585-1f796d61fb3d@baylibre.com>
Date: Fri, 31 Jul 2026 10:09:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
From: David Lechner <dlechner@baylibre.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com>
 <0f092382-416e-43ac-b58f-b915165e29ba@baylibre.com>
Content-Language: en-US
In-Reply-To: <0f092382-416e-43ac-b58f-b915165e29ba@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 9:54 AM, David Lechner wrote:
> On 7/30/26 9:58 PM, Kyle Hsieh wrote:
>> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
>> delta-sigma ADCs.
>>

...

>> +	st->config0 = 0x01;
> 
> Needs a macro and FIELD_PREP().

Correction: This one is a bit, so FIELD_PREP() is not needed.

> 
> Also, since we are parsing channels now, can/should we leave PGA enabled
> for diff-channels? Otherwise add a comment explaining current choice.
> 
