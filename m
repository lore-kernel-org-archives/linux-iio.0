Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420341;
	b=ZPzuN89SicDbWZNNxGfn1gb1AQIFhpW8yfz6vvmqzDDMktqiAy1vg9XlZxc69VV8GfFB
	 1UDzNshHvc2OAvneVgks90kWxRKOGAq3RWMuaSXvmBHHvFcHn/BpXCnY8A34RVOWkhhGE
	 R6XTVfdeEKnSIeEEyV/ORiXrhqcyQNtdTzDmLeqyEyCF6X4uQLHR5An+0xEYH0wek9D5N
	 ev1MJeQQOJy0fx5jMbnLnW4wCTjED7h3Ga8PYGs8hRpPefhjak89TpNv7t3noql+tEp6C
	 /p9lLqGYMP47gHnM9ov+EBgAkrTU7B/ValrNyYvK7ofvhi3i9J1N0kkhGK6glMBidQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420341;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=t2W2owkpBCVo5YvfxGBxlpKmBfU+hvS/9sxrZ7gmr0E=;
	b=vNmtu1/bg1U90NehNdEu70Ac6B+f899Qij9yc5oYgJGa85KSv8oOaRYAeTkBmTXO7H8t
	 rTFymomyZ8R2rgvJAhWQ5sFANypAl1lggDOrBwrDv2l07kYi+HfNEJlJLZnYhDuePR3yn
	 T3xl3R11wzKwT/Uz6AUHqIKOo5WREhCSBEwMvj0AliCJiyQnNmsNP7WpGiFl8sypjl9t3
	 UPxKPsoWkPKOVkBuWvOmqLbw8hadKAOrv8qC9jXF+IirJVR3USKTEC/oNyvTYqBs3pUld
	 FGchCyMnzUlEznR78kNaMeNlhm+twv4bRFrczOwpkflivveEVAcP0LqPZbYW9VmBZ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYK7nhDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72681606A68D;
	Mon, 23 Nov 2026 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYK7nhDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3E81F000D0;
	Mon, 23 Nov 2026 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420341;
	bh=t2W2owkpBCVo5YvfxGBxlpKmBfU+hvS/9sxrZ7gmr0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OYK7nhDJyR2sfniYIuNJQEdZ8tFw2Iw1+xfuBPM2fon4u7rjzNkpgesrKA2varJbK
	 m2ZHcO34jiQ0Y5X1GH3TwFggKcd3MQS7Eovrz/NT4aB/yRwwsOGm9TuGHV9zE9dPeY
	 uedCkwI6rSQhvu9CWJ+19Ma3OIP6B41UE1TYFWMgbS4NVfFTGtcgplVkcfCQR9Fi2Y
	 W9041bG0H8soB+DLBqDDW/7iKYuZ0WdGxsN62Q0lHSHmv35c/EPSotPp2XTq+YWwRk
	 qvIeC8TfXBqWlnOpD8BUBRJmo1Ke25tRJOyPMl6YXGQoesG0lwKxxP7oz3PhFJS9DT
	 QtspXWfunuo/g==
Message-ID: <2b4e18ec-a403-4f96-bdda-8165bdc917c5@kernel.org>
Date: Mon, 23 Nov 2026 08:52:19 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/8] iio: adc: at91_adc: switch to
 device_get_match_data()
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-4-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-4-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:00, Abdelnasser Hussein wrote:
> Use the firmware-agnostic device_get_match_data() instead of the
> OF-specific of_device_get_match_data() to retrieve the device
> capabilities.
> 
> Check the returned pointer so that probing a device without matching
> capabilities fails cleanly instead of dereferencing NULL later on.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/iio/adc/at91_adc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 76000486b17a..2a378540837d 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
> @@ -1002,7 +1003,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	st = iio_priv(idev);
>  
> -	st->caps = of_device_get_match_data(&pdev->dev);
> +	st->caps = device_get_match_data(&pdev->dev);
> +	if (!st->caps)
> +		return -ENODEV;
-ENODATA is better.

-- 
Kind regards,
Joshua Crofts

