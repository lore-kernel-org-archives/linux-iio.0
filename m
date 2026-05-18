Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA063EFD04
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109954; cv=none; b=Q+f9MqgcgYRXbmgj8G0V/QN1v8LCoYaWddSwbNHH9IwXdv3mw7CDTqIck3NYWcaIlrwXepS4L3cz9V6k8VTuBD5HuhF0cJg87iQ8s0sEhbXGGo9siPqiwgi7/ymU3s+6B9R9NY3WIQ2q1dowfzi+33esi/ICrPiSHCi0f6MAClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109954; c=relaxed/simple;
	bh=9XbefT6LP7uaOrTBgP0TqlmDNJsKAeQiH+5pUEFQLTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz25Dbs20foXeqN6LUtQ8Ml8gMr0086MMgKUq0z1bOyJxTWtoy26uFl7pfIGLj/lZ49ObRwDrcEk3CRF9bkt2S6cFWlLoa1IxkH4eArKi6c+1XntX74A421iqN+eqIiF4o/hozDrQ3xUPu4e/3KeoaPp2NO1vJ7dGfJJW1diWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prJ1GwI3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prJ1GwI3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8891febd2so3157164e87.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109951; x=1779714751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Pdi0+dpac8Unk8S1tGuiXeeWqIL92VAm9G04zoVwsc=;
        b=prJ1GwI3OblKnvBUh7jRwdhvhs83oLlSiQfMl9QOhv/U+IS8zuBmbqdYvdybav4B2a
         5wHbZFJlYs26WBLND+66w1tywZ/wEsrfsEI+jZWQ4lvza8013GRB24oY5GSvc6/G9Pz5
         oO+Tw3wsXk9lYwPxcEitGy5kDjMFIEAdKpLquCnYJY/kCht5/FTzOuBiiRUhsfS+TKng
         P97HRqWN0ykV52oFFZR9e2nBcQhV9Ybfeh7e6pszm6SXMPrTz64bItZyiGu33Jc2vBMi
         icT65WG3u6ITgK+6F3zx09TdUaM5r6RqwR/onhDiGXJ7NQVQdvxn6zIeUlV7t3C1X7Eh
         2HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109951; x=1779714751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pdi0+dpac8Unk8S1tGuiXeeWqIL92VAm9G04zoVwsc=;
        b=BiERpdGl2PdaVI7PHTxAY2WgEpptYx7F7OzSXUmAmcbHtd1RSF4sUDiUaxFXNlHh3B
         0xPCdcTsuBMAihaH7EieBrwHdEM+mm07Sh3r4KsIAPL4g34/MoZxipxe/xVi2Ueg4O83
         6+Q4Onp2gRjf+gnsNKf8KV9bG6eBV7zhXS8joqtKnHW0p0knE83fgQSkvNlMAYjxZFhr
         bOw6P6gQEOeJuISlwGbZ+z2CppBvB+dsmLAhK4bXmFo5fNC1u+aR3nsDuBYIej1eyY0B
         zi9pCeZqRL847ZDLt5vpJ5+MV9ExFeMOoSHzxDcm28t3LUTI1YIT9SvOkc70H36n6QYH
         zosQ==
X-Gm-Message-State: AOJu0Yz0Zf4FimMTAzsvVWHlVcaVkfiZsagtpnV7yFBIY88p0NC87SdB
	bhL01/YErNQnXdZ5MA0ot4xIKRFOHN/7PXvm/sgO3kS3JEKhk2PiT+Wd
X-Gm-Gg: Acq92OEY3+HVewfk6IkC8P4hIEKYWayubD0VbFrjkGhwFSSg6uC0h3kWB2NiZmgw6HD
	4EH3mcP1PzRzAKI/RNDcAYfP//Q0cW/VG0k0CN0SFLaGnD7gktlZ8oQIPeQJGWnnpZI4n3oV6XG
	VN4VKcKfuZRTKBtgr5XuH8FYVWRkQYEGdn3sDquxuYujcLBDdhvO1vshzOeuJ7ebUh8AtvBzhr9
	7r1EJnQp8/Ibv2ccF8A0V2G4Vz5Xvu4NzBeQ9NFmlH2ySlLnn31Kzm1ajPzgrHn5W56u5rPMqDa
	YIzd1ovKkUjj7Sk8t84Od0EdTjsr7aleiNwL7N6WmlgFetQODllQVi3T55QvXyvyvxW3OKhO3no
	9uNlVX4WzxS8oZat7QENHi+6vbS3XLmZeh+GrUlkEdD6VQAIYDCm1nneVUVxEs939xcTi243DZF
	9kWCEFmik9fPXy6n/2yt47zwtdAOzDMoJc
X-Received: by 2002:a05:6512:1285:b0:5a4:d44:99f0 with SMTP id 2adb3069b0e04-5aa0e733f63mr5400870e87.6.1779109951164;
        Mon, 18 May 2026 06:12:31 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11a5d5sm3319135e87.28.2026.05.18.06.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:12:30 -0700 (PDT)
Message-ID: <9bb6db05-43c7-4bdf-88b0-b92525ad5cc9@gmail.com>
Date: Mon, 18 May 2026 16:12:29 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2026 07:49, Javier Carrasco wrote:
> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
> Use the correct channel type.
> This bug was introduced in the first version of the driver.
> 
> When at it, fix minor checkpatch code style warning (alignment).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/iio/light/veml6030.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 745cf3ad7092..855f052b60c2 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -871,9 +871,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
>   	else
>   		evtdir = IIO_EV_DIR_FALLING;
>   
> -	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> -					0, IIO_EV_TYPE_THRESH, evtdir),
> -					iio_get_time_ns(indio_dev));
> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +						       0,
> +						       IIO_EV_TYPE_THRESH,
> +						       evtdir),
> +			iio_get_time_ns(indio_dev));
>   
>   	return IRQ_HANDLED;
>   }
> 

Is this change reflected to the user-space? If so, is it safe? We 
shouldn't break the ABI, right?


Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
