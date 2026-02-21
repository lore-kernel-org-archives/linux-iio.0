Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65D34EF14
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771692459; cv=none; b=R6Ce1KGcwqJaX7HBlORO8Mbbd0v+9ZNayPbZzMEkdpLk/BpbIFTuo2GGS1vcbwiUAMezSUQXYBOT4I+hiepQ1fcSNp3BAVyJ9g6bNm6R71wZmq71mh95HTNd8JMeH2mwF27bsyuBAFy4B588aj5Bjel1OJGOe+jUkSAlPf3yctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771692459; c=relaxed/simple;
	bh=NZkC0XrrAc6VJQltoZM0wC9Es2xPIesX2D4zRKy3KOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA05URJTa9ojvhK4tyjNPAMs6UaQcLMxCryHGHterlMp2IowQtLZbe7UrlqHQSbD5CMIjcJdDeojvKA4ZGRMjRRTimvlcSDMUciQj7ZVAK7/PnlWWc+4aOouhptrji3oxZGXC6Fdg/fwH8aA6TqJj1kgeXw/0B/F2u1RpzGCxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vztTjvRX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vztTjvRX"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so2787854a34.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771692455; x=1772297255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVSDVNsVU3WfS0jvVP+0eZ25UumXRJFiv0S9bwylHTs=;
        b=vztTjvRXbACJSagRHqdR30Yw7YRRK3YwDtfFX8jCMvgyPpxX2NZnvU4QhV5x3gIsFE
         CBHXdZa+4yesmSqwxyBllRVSGX0IwvSjZ7yPfQD64hFHB/YBjgGnCF9WngHUcSJJzAQd
         CI3j9lI8mbZLGSgdQI3BPftmwFDZTTzwDd9oXXSEX5768LhMsC+gRHPjEqAbtTHoflCZ
         eyl2VO35F3YmH1lk0RfRJCoGWeAPy1z5MqFZcp6xhpmO/BOVYuJeC2/ZcBHQKaV+BvMR
         GhmHU66z4fj5vPGn0ceK6raj7TqC0q56+9cncgwN903sXrbwDZu5fbX38s0QSrOdrMSr
         h+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771692455; x=1772297255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVSDVNsVU3WfS0jvVP+0eZ25UumXRJFiv0S9bwylHTs=;
        b=OmeZJDazn/Z0Mv+6Dn+uvtkL1s6iXGfV7K1hnsdG2gssOSwkmBQDLtyUs/8JZhwuKU
         tO8befj3lTdHKSiKSt7m9R62RKaZio1Yjbp5Np8Gj1ySsoOTkY70jsz22NpaSma6XrYh
         +Oil1iqV89H3E5IkWMlVcJe9kWxXc2urHcKJFOtSgLhqdTTtLAD/8iXU7wg8+WK1Qx3y
         hyDpk0m4JuDAPBVVgp64YJD2Zs6pZk9Lk+tVEbWG/GzcAqdIhhSf78DXF0iITIgvmBIK
         xg+hLTxzw1h3PICcTU6//mOxX/+Y+BtlPSUPfvX1hmT+luczAI3YUZ6IXjSAFDGT+XqG
         1csg==
X-Forwarded-Encrypted: i=1; AJvYcCVxrtKwF/m4TyPwK5HYdKuyAJ6un2iWkzCJUbK/0B5h8UWla6Y3EmYFzbeWQmaXs8H9xb8TPrzP3C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlEiSHscwj6g/iGPchmu4l8CdIMueNZhjABM1hvv5Nh0kJZFs
	GpGDSdX+GuxLC9tO7U2e2t/s5PJ82Kf0iEsG6qQTgIdgO4NmE7ZyrphU4tE3Z9tXGIyMP+jsWHK
	DyFmR
X-Gm-Gg: AZuq6aLxaB6dsbdwxtGVjhBD5Yzc5gfuL7KdvPzYU3LIBWg0D+cf1QJ9+zOnOSmR6hd
	mLR3IWJ7Rv+dm0Rz7M0Bd2E0xbgh2yL7Mcr/k13NJKbF5KQ7ww93FoK4qW5Iv/WzVlnkMig6vok
	O1oEFeyLTr0MwsDOTUHEro/1706GiwEH2HJzhZPWGMNe43No93JMWQJI8XBRNxU7oXEpHn4cjtN
	o00nxwyK3l/X2uG0VVz/e7GT5xdIapLFFysLpNnC27Oq8MyCRJtB8y7qiM1uavgMkx7r57f7iJK
	rvjWlKvo336rk2+tgHobZWJjTl1oihjmf+ZDjA8RFYaGkKi6blV3VNzzzTcOPlntB3LcML12ikM
	JLfaeJOD8a7Wf5sf+HBk7mpEbrbm56+aKv3FZUmC8qHgDIz+1s6jgzw3rhnvsZwGthwbl/2c5D5
	clMdJSp5fPftoO7IigjxTqwosOzycBEKZgE3up18mk+bOqyMCmaVJjZ+wMbx0775mYVS1pbw==
X-Received: by 2002:a05:6830:6af3:b0:7d4:bc46:e35e with SMTP id 46e09a7af769-7d52bc7368dmr2008264a34.0.1771692455398;
        Sat, 21 Feb 2026 08:47:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d038804sm2728289a34.18.2026.02.21.08.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 08:47:35 -0800 (PST)
Message-ID: <e2c74e7f-d851-457f-88f8-d80a8d17c51f@baylibre.com>
Date: Sat, 21 Feb 2026 10:47:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] iio: accel: adxl345: Implement event scaling for
 ABI compliance
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org
Cc: rdunlap@infradead.org, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260221141251.34855-1-0rayn.dev@gmail.com>
 <20260221141251.34855-4-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260221141251.34855-4-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/26 8:12 AM, Taha Ed-Dafili wrote:
> The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
> event-related registers. Previously, the driver reported raw
> values without a scale factor.
> 
> Implement IIO_EV_INFO_SCALE for all event types to provide the
> conversion factor (0.612915 m/s^2) as required by the IIO ABI.
> 
> Consequently, remove the obsolete comment in adxl345_read_event_value()
> which stated that the scale factor is not applied.
> 
> Add explicit write rejection for IIO_EV_INFO_SCALE in
> adxl345_write_event_value() returning -EINVAL.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 37 ++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 78e3f799ecc1..eac4ab052fa2 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -213,7 +213,8 @@ static const struct iio_event_spec adxl345_events[] = {
>  		.dir = IIO_EV_DIR_RISING,
>  		.mask_shared_by_type =
>  			BIT(IIO_EV_INFO_ENABLE) |
> -			BIT(IIO_EV_INFO_VALUE),
> +			BIT(IIO_EV_INFO_VALUE)	|
> +			BIT(IIO_EV_INFO_SCALE),
>  	},
>  	{
>  		/* activity, ac bit set */
> @@ -221,22 +222,27 @@ static const struct iio_event_spec adxl345_events[] = {
>  		.dir = IIO_EV_DIR_RISING,
>  		.mask_shared_by_type =
>  			BIT(IIO_EV_INFO_ENABLE) |
> -			BIT(IIO_EV_INFO_VALUE),
> +			BIT(IIO_EV_INFO_VALUE)	|
> +			BIT(IIO_EV_INFO_SCALE),
>  	},
>  	{
>  		/* single tap */
>  		.type = IIO_EV_TYPE_GESTURE,
>  		.dir = IIO_EV_DIR_SINGLETAP,
>  		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> -		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +		.mask_shared_by_type =
> +			BIT(IIO_EV_INFO_VALUE)	|
> +			BIT(IIO_EV_INFO_SCALE)	|
>  			BIT(IIO_EV_INFO_TIMEOUT),
>  	},
>  	{
>  		/* double tap */
>  		.type = IIO_EV_TYPE_GESTURE,
>  		.dir = IIO_EV_DIR_DOUBLETAP,
> -		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> -			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> +		.mask_shared_by_type =
> +			BIT(IIO_EV_INFO_ENABLE)		|
> +			BIT(IIO_EV_INFO_SCALE)		|

I still question this one. Why do we have a IIO_EV_INFO_SCALE with no
IIO_EV_INFO_VALUE?

The docs say:

| in_accel_gesture_doubletap_scale | Double tap gesture threshold scale. |

But there is no attribute labeled "Double tap gesture threshold" that it
could be referring to.


> +			BIT(IIO_EV_INFO_RESET_TIMEOUT)  |
>  			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
>  	},
>  };ret = adxl345_write_mag_value(st, dir, info,

