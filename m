Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FC30C63A
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771695826; cv=none; b=ezJe3Q+rVe+A2aWhjCYtY6mE4BEX1Ig8qvWMdVkXRsilEME1FTODgwWng0dTHSrHwsCkqIturFD/q6Z74dF//74HuVwtgitT4UKud3kOIV4fGVPwvSbjB8EiihK5GZkNPF45gnxYlSbNXM0TqJyj1QAs/Tpxh5axir9iZAsLcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771695826; c=relaxed/simple;
	bh=nJumRRbqfdNmn2IGqF/Uly0EsPFk2xrL0YCTdj2iRqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxKG6Qo/uOSCl8M7LazqGcIOZGp+VHsr1buKXwik5hrHCLKBcrzCQKrDMQQzDMYQQeraWK2TCLeCtcJzUQcoLsAx69wNk9F2b3oqYFN6iEJzL4EhGOZhUjRMT3FAqJEX9k6p2agNTf0IhZsumJ15jwwD2ljYUwtZstBKrKlLGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BlDw8brg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BlDw8brg"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4d8712b40so1111291a34.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771695823; x=1772300623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRCibtW3MIRfvX6LQTp5cSh9t1XPZOYyYIJvnHLTP3Q=;
        b=BlDw8brgA/MjL/hXyXQVFhFkE1qmzpcfsdzIy7gjfhED4VIgU5Dq+2RdGPO99F4EN1
         eK5HIePFQpHagF2txYZpdfEZAn8X0vJWA/TnqFuhP+PRC8P91SHvix67gTkoTDi4pwGa
         6ojwBsL/FhyUHNAK8C5zcr/L5iHAWcYueNR9I9IzFGjh505EGpI8//SVAVBxU9ZWbekY
         m0DxWaMm5KXIThPjkuA9vWfmn56WLB0LwbKcrj5e+zCLGxOA/MEZLoK13YTmI/EWaAFE
         O939ixrEUAwUx5U9Np68SCK8o/Cs1e7IL/9/oCnbZDLohBhKNcJX4Nv1y885kFuuuP12
         pIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771695823; x=1772300623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRCibtW3MIRfvX6LQTp5cSh9t1XPZOYyYIJvnHLTP3Q=;
        b=pYvkWxrGTaIPJ78ZFcaLBpXh7L4e7uiXLZVrBSbev1zHh5Aaak/MQ69cIpUmy3h8iZ
         MuCdpRQwMqy1Kx+JIenLbgC6ZsGqAUstMry/OP8JHnxuc/xYb7BacM848HhqU3iBhMkI
         oySUkbpS0HBGhtQjspGbJXNI6b3Jc5SfthlA067yKEMBUwTbsPP8PB2GfL02tyQcMKkW
         xJTHdkn93LYHMX+dPb3yDXOvGqH+Mho8fnwCBZ+z/ijT3uyXyIRJeT+YxRu6hSqF3EO7
         MrO14zMFY0MVGUCk/vuT0CrQz8abiHEYJ2IJJiRNweIf2Hw7FWAUo1CbRHLue3gOAQp8
         9UaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQQQPhHj/H6eIhgCVty+vRoUbwKsrB9mffu8G3DygfMCnVLeQPyeCr741jkcIBYjJoG88XQNmidp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rTBD6yJNnOZRUQk0oG/7hcO+pi5MDzPJqllEuS7qNcGfQxo8
	C4n/4UBriHGfpnXk7qiVcBbmZkcAosBUC4uYO/c40XXwRBLbJibMIfwCe9TRUbK+QUc=
X-Gm-Gg: AZuq6aIdV0JCFYw4rlgDprl0u359gJXbGG+4Hrlp3VPtwMKnKhCiSralikWGHaspQ5K
	DGqdAKFrXNeSLO5X+tuF0PYthI2vNWtzBHVg+9J7sVCNQMsPRNh/H9pu32eRCk+3YRs9lFib97L
	I8GQPVL57HRtWmSB4I6AIHP32cJTTqBSnemVQ4VImHtnPuFbohFb/9t/DjedeaLl7wAL21FEXmU
	dotWLjYDxhRHPJUT10hxdZ8TrZf56+rfzuX4ixI1vKChojRJJ6KdYPbQCZPOPE6+blOXtPwBkqr
	NkG5l6ur+Q2XvxkW5L8TegAM9WGEJFHO/iY5PYkDiAxCWBjZjyMixQgY0qRh4gVF/JusNnTKVmX
	SVXgMG1iAsXP+Vx4/ayA5/Lj6HxL6ujNKPytVJ60wog8mpCJBhjAiRmabz7c/ESpoMmPKhPAC30
	3oVzF5rnyu+EY9K2Hn6rAINn9LZhxUbvv39iuSMR23AHM6YxWKJj2GVy4fVyFLuZ3CDQ4NIA==
X-Received: by 2002:a05:6830:660e:b0:7cf:c613:d301 with SMTP id 46e09a7af769-7d52bf530fdmr2120582a34.23.1771695823282;
        Sat, 21 Feb 2026 09:43:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d2d7922sm3143078fac.12.2026.02.21.09.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 09:43:41 -0800 (PST)
Message-ID: <a8267ee4-783a-4f04-a94c-d05d4c689658@baylibre.com>
Date: Sat, 21 Feb 2026 11:43:40 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ti-ads7950: complete conversion to using
 managed resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-5-dmitry.torokhov@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260219022929.3558081-5-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 8:29 PM, Dmitry Torokhov wrote:
> All resources that the driver needs have managed API now. Switch to
> using them to make code clearer and drop ti_ads7950_remove().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 98 +++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index d31397f37ec4..1c53e000bdcc 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -528,19 +528,26 @@ static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
>  	return 0;
>  }
>  
> +static void ti_ads7950_power_off(void *data)
> +{
> +	struct ti_ads7950_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +

For the regulator part, we can simplify this even more.

The part where we call regulator_get_voltage(st->reg); in
ti_ads7950_get_range() doesn't actually need to be done there.
It was something that I just naively copied from another driver.
(This was my first IIO driver after all!)

Instead, we can use devm_regulator_get_enable_read_voltage()
in the probe function and just store the voltage in
struct ti_ads7950_state.

I would do this in a separate patch first, then the rest of of
the devm stuff after that.


>  static int ti_ads7950_probe(struct spi_device *spi)
>  {
>  	struct ti_ads7950_state *st;
>  	struct iio_dev *indio_dev;
>  	const struct ti_ads7950_chip_info *info;
> -	int ret;
> +	int error;

As in the other patches, please do not rename ret. It is adding noise
in the diff. (And I like ret better anyway.)

