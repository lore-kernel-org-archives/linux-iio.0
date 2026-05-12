Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BB39B949
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601252; cv=none; b=MO/+P9S2Ew8C26YN6RqnN+Z5aXaPExKTxumPCt6CXuixYZdt4qPLF2jLCsp+su0uS1O0O/HDaT7DzqiRG8QhjDrOx0kQtE+5U/umB39wnbzpivq55bN6XXrARKGvwwjAaHNz4xOd68aTdLBXWnhQD+MFi5XsPKx1odFcaK+m65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601252; c=relaxed/simple;
	bh=ar7r0CplPhOBjT9O7jDUVxLUCoUGYulfCXSofIIVZxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzLGqILBFUjQdgxdhnYz5PyH57/5mCsuPOz9IRWp5t0IE3W8LIuZ/KOkDNYloS0dhhpL07MDLPFmPxS3r7OsI5ccMRQLEY2Shgneu+MM0lve0LOTZh0nd0KNJtof8HOcCJ+G8gS6TOVVgH6JLwHSkemNWu+XwV5eX6+/qx4Oy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=x53TWIKz; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="x53TWIKz"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6966d0665baso3455546eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778601248; x=1779206048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mu9LntJbCssD7Nm2DFnHOLJ9ocvl6E8VHMXK5m9CjY8=;
        b=x53TWIKzeyMKFVktKRdzanktnalpKFgdRGZbKkQFiPb3Q0OsUaqqiujnGzSeMiqkvL
         TV6boZgKVgU9baz3Vsb2TANUgjgM1ttGdjTG+c0JckHhABdDHdffq/TenH7FJzdIqryV
         3/7su7QAlyDwg7Tw+uMpvagNjnt3g6xqTtRP0eO9f6aoEiukqnjdeNiOMDlWS2oXJhGB
         EkgKZMS15PL5xF0nOBXXI3oWryXRIZWHP+MbXTbU7P6IMMlu+8ShDjKqtoZ06WlHSwf1
         CN2M47cffSbS6BCbmAHDFqVljbuNJhOxnZFqhCDcU9QUrprqjpWQS016aQhJ7Hh3oU2Y
         X38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601248; x=1779206048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mu9LntJbCssD7Nm2DFnHOLJ9ocvl6E8VHMXK5m9CjY8=;
        b=flTryXK0fkXG9uYQXDPlE9WaFhXUco+pZ4SkzExoqPRWRZCfI9WLmIoWYFcvkO5V6r
         ODW5GakOeEVDx7M7b31HCoW21qCK1V6dNVHZ1faGH8wwTfspu8C9s3VZQWBR6D8tZ+yy
         KgAL5Br+77jfdTPlDzRbx4F5AvbRMOPlBlYZIJtROfox+I2DtT165ldPxfm3nKNoleZZ
         OnnxxXAznRURZetoedgLFso+U5UCSKZ9CIgpijvbz+Lqo1tbVYkrcbt0vWPYGU1beleU
         zXfzXSkdOyF/viCJZKPLGZbUjATc5WsVZ/3ox760qLNxUmNuFwfLtYv0ACrRfEVea6ax
         e19Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9X+33htB4AX/0+1EPLYPvoNg7B0/oQ7P4it4oTvbTpXe08ZJe4FubQ7zfgcTUwRl5VfMqFtc5Cvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDRqhDIDKfUB//TfFvAwjK0HDQvRlfzjRkOsXgDcFIVhQXTYI
	Aee0w7uIh9BYqj6w7CvYRJ88iIp00znvHZBSLgguFkXJsdtVY3YlAZ0rHZbOC6qlmbo=
X-Gm-Gg: Acq92OEdLhdwQOGN5rEj97TQwPzptyyxLpsA9gJF7WzlAJHsfJ4fOTsQbmoWMUIlDlU
	Oq2tgRVJB54W4sM1Jh3fI7msZ432+xKFycZqwSkYohRTShcowFjrvaAlgmfsuWmHO/kCMtgOWSz
	xKf3XvT9R/faZ4ODD3eTBnv29bp8tcoyyjk91j648X8GXoBMxMglCyXDcmLyOqGToIN86D/suoD
	yhrB0Vrc8KaBRR4gdTVRSuhapVkRMTEOrTRgdf1GQKs/HTUoZshf17/owYuVkY3sXVICZHVbd1F
	eTmRGDB0TN7SppI0eYubSv0QvGbGMTxy+8geSwv6yJOGKltj0tgHrHv6EZTSfALzd+LiBIMlc6v
	jXp8Du+lp3JIpwyCZ25ea/YIdb/lF55pvEgzrf2G52wnbbOnt88XU9KEFMlC0t54Pc4d+bviupm
	YDhQv/8UqhF0FMELJOLGSUFGc06Uylc1FqoYHeiK/4riUGInLjr75FxnAWtUbfiR+DB1/rN7BSB
	g==
X-Received: by 2002:a05:6820:1610:b0:696:1a85:586b with SMTP id 006d021491bc7-69998d103cemr16189557eaf.35.1778601248273;
        Tue, 12 May 2026 08:54:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm13105588fac.12.2026.05.12.08.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:54:07 -0700 (PDT)
Message-ID: <051ee23d-cc9d-4eff-bd2f-3ad2085f2162@baylibre.com>
Date: Tue, 12 May 2026 10:54:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260512120356.40839-1-m32285159@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260512120356.40839-1-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 7:03 AM, Maxwell Doose wrote:
> A Time-of-check to Time-of-use race condition is present in
> kmx61_write_event_config(). Move the mutex_lock() call above it to fix
> it.
> 
> Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger")
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/imu/kmx61.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..9aa00acc7f14 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -942,11 +942,13 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
>  	int ret = 0;
>  
> -	if (state && data->ev_enable_state)
> -		return 0;
> -
>  	mutex_lock(&data->lock);
>  
> +	if (state && data->ev_enable_state) {
> +		ret = 0;
> +		goto err_unlock;
> +	}
> +
>  	if (!state && data->motion_trig_on) {
>  		data->ev_enable_state = false;
>  		goto err_unlock;

There are actually 3 other drivers that have identical code
which likely need the same fix.

And in all of these, there is an write_event() callback that
reads ev_enable_state without holding the mutex that looks
suspicious too.

