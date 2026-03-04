Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45837B02B
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663745; cv=none; b=eXddE25mY+OZKl/OYCQQFHIVhrGNsp6Awr7l1nU4UxOgT8gg8HZlsd7MDZcu7f/bXBwkVBC1Y7jrgU8iQMb5b679TKwWsowVWkTKMDU1MP4wWI9uQLMJMovp8hLJiSNiyl7KZpAH3hyqIzTaBzwRihdRUWbds3U5OiKlI597cMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663745; c=relaxed/simple;
	bh=LtFbwkFqbWej+/nawGcwCzJpOaKMDT5WUBWwLjVKOC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d09+9WrMYV4k7A/27iiRMdTUSc8y5BsRn6zm9KjEnx8QQ23XabtVmcQQEcUPWaycpZ3te2+c2YAP//bW3NUIqjyfUS1FabHrHXVbLCdmPP/tYjUXDCiP4s2fYl3PiM5hqZQM2dHbj/eXZ7ACzi9IyZKvQCpXEpsI1iFmqz2PJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cypNBbTv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cypNBbTv"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c68f0e47so4901625a34.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772663741; x=1773268541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chUUqpjwU5gcn5V4zr9PFO6M56aJiouyBS5dYvYBzj0=;
        b=cypNBbTvqrtigPOky/G3MgwIHaoXmQs83EIS45koxX0hFqlGziCdgKkCfapEf8hBlC
         X9Td9uSzv3OwNqG5orhc8UXih3o3XGGykRI6WSP+tJLBZNevbk1Vrs0BeGhI1N/VNyJt
         ZOdRM+6l9qZJuuGM5SbsbPUULRahoUsDbUXYvBHropyX9MntUAB/rjQ321qX9i7VILql
         NJcKpxEgGtKj6yIrvG4hRcWf38d36YDeIYl65aqL/IolFZoEXEBGsGyeleUWyrY8Z7En
         h5UxGuU32MbCz4hmaV2Vx1qAAYIND0dpnfAAv8VBBhVkiVQ4Co3RE6kEc/46vjTmW5v7
         zeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772663741; x=1773268541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chUUqpjwU5gcn5V4zr9PFO6M56aJiouyBS5dYvYBzj0=;
        b=d5PMQkXkmnFYmMFi7hF4Nrk7gX/PrQAdwIRV//s00EU44jSEmhdkUz8KJrlkdm6kR6
         Ojxa6yad9KX9ZUyKMWAYahQd3fIvAFhFnSShis98/FAA+ZIg99Mis4Q+tfI6jk5g18le
         i+YBLyk0Icl7kiekAZ0a4iTV6u85kEthGUwi9Pn0oZ6KSC1LARL9FkaXqHRGBqNND4Qy
         iGCTQ7ZrmFiRdoE3i2aZofBed0x2L6XBRnWQR7XP4F2yjgH48H18UisAA3kW229tZGXz
         8XIo/AVxhUbeoFKcTUjmjrTfqfWkMlO38pMl7Y4xM2Np/j2Yn1VS85fSGpzU+/FPfi8U
         LN/w==
X-Forwarded-Encrypted: i=1; AJvYcCXQZ8+RBxwdkt56SUe62u9DO41l3w6NEggta3aJN/FRtbx1ZdxV4KAPKAJaTN8Tjnv1H4p1GaWtC7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBF6dmdNwr+wgCCdC07dgiePmwV2f8wEEdZ8ELJCsk2wWzzRP
	FmUVywpEqK4ujiN/17L+EARLH5DHG4S+6u7RrONhj4jMewN2PRDprvu86TCv1sEOF5V7++SaUvy
	fM7U3
X-Gm-Gg: ATEYQzxBePTOHekwVmUdYXGbEK0l2dwdlkUf9Hn0nTjZjcZI39rLtyZRRyXyCReKE95
	jkuMoSXxrKtw7ANN3ECAIZYGtwZdQ2m1cKwT6Cn1BtY2Djnjf/V9ryaZC7kiIR6Wo73x7K7uMFo
	hrfdndlJ8kOwrt2kaMV3SWDG7lJhH1pZ6Nj9dP7JiqE9SDA1sjVjfv6gXvrm91hGq2MXDnhao0H
	GEHTgh2XnLPxcPZNACkNb17sUeSYZxm+RTxu4UHbqJkH76HOYMUaZwhqCDPBSplUJkmjQ5yFQ6L
	hH27uTc+wudkAXRPXzBYo+FPBmZjW3obedLUjOlrNMjcMZIVUdeietPdplP9C5zTl/XmfOZZH4h
	7+i/Rvg9uSiW4iQBkNufon5Tcvi0KGe13a8Xi5c2hopxYIC3OwHA8hUM0o6MrvnUmqTv2x7fGBF
	XBzJXI9I20uzNvHzJA03wO/uM4x3Zkm2B2lqAe3ic5rm1xVolJnuu4d7J4VGj5fFhkFb8FObU9G
	Q==
X-Received: by 2002:a05:6830:3901:b0:7d4:96c3:3f8b with SMTP id 46e09a7af769-7d6c7f5d9c6mr2386873a34.8.1772663741327;
        Wed, 04 Mar 2026 14:35:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm16397148a34.16.2026.03.04.14.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 14:35:40 -0800 (PST)
Message-ID: <77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
Date: Wed, 4 Mar 2026 16:35:39 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080706.2844472-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260304080706.2844472-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 2:07 AM, Francesco Lavra wrote:
> This modifier applies to the IIO_ROT channel type, and indicates a data
> representation that specifies the {x, y, z} components of the normalized
> quaternion vector.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  1 +
>  4 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index bd6c3305dd2b..54e38ebb044d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1755,6 +1755,19 @@ Description:
>  		measurement from channel Y. Units after application of scale and
>  		offset are milliamps.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_partial_quaternion_raw
> +KernelVersion:	7.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw value of {x, y, z} components of the quaternion vector. These
> +		components represent the axis about which a rotation occurs, and are
> +		subject to the following costraints:

s/costraints/constraints/

> +		- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1

Isn't this usually written with w first?

> +		- the rotation angle is within the [-180, 180] range, i.e. the w

Best to say the angle units. IIO standard unit for angle is radians.

> +		  component (which represents the amount of rotation) is non-negative
> +		These constraints allow the w value to be calculated from the other
> +		components: w = sqrt(1 - (x^2 + y^2 + z^2)).
> +
>  What:		/sys/.../iio:deviceX/in_energy_en
>  What:		/sys/.../iio:deviceX/in_distance_en
>  What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 22eefd048ba9..792fbeb0dfa8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -125,6 +125,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_UVB] = "uvb",
>  	[IIO_MOD_LIGHT_DUV] = "duv",
>  	[IIO_MOD_QUATERNION] = "quaternion",
> +	[IIO_MOD_PARTIAL_QUATERNION] = "partial_quaternion",

We've found that using `_` in components of the attribute name makes it
difficult to parse since you have to know all component names to know
where the break between components is. Each time we add something with
an `_` means all parsers need to be updated to handle the new name.

In other components, we've just squashed the two words together without
any space or punctuation to get around this problem. I find that rather hard
to read though.

I wonder if we could propose something different going forward to do a better
job being consistent and readable. For example, use a `-` at the word break
in components that have more than one word in the name.

>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>  	[IIO_MOD_TEMP_OBJECT] = "object",
>  	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 6d269b844271..c80ef7c1ed12 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -77,6 +77,7 @@ enum iio_modifier {
>  	IIO_MOD_LIGHT_GREEN,
>  	IIO_MOD_LIGHT_BLUE,
>  	IIO_MOD_QUATERNION,
> +	IIO_MOD_PARTIAL_QUATERNION,

This is userspace API. We can't change the values of the enum
members after this, so new members have to be added at the end.

>  	IIO_MOD_TEMP_AMBIENT,
>  	IIO_MOD_TEMP_OBJECT,
>  	IIO_MOD_NORTH_MAGN,
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 03ca33869ce8..db0fb75806ab 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -113,6 +113,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_UVB] = "uvb",
>  	[IIO_MOD_LIGHT_DUV] = "duv",
>  	[IIO_MOD_QUATERNION] = "quaternion",
> +	[IIO_MOD_PARTIAL_QUATERNION] = "partial_quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>  	[IIO_MOD_TEMP_OBJECT] = "object",
>  	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",

