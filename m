Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E336F430
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829438; cv=none; b=Fsl0bijFpKmEJ84/MAb+ocf0MG3+TWbbufiGM216h45AWLtM6o+kI4LNsu3MuO2/G01JwARn93rR6xe0CNuCwYEU3wYSVeUWoBI3HAg92lRwEo5/HFU3+6XbR88sZysUJtosFZ49+qQPgmF31D5WZA31D2o+3jZgP3X6pgu/R+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829438; c=relaxed/simple;
	bh=9XAxqGdoYnPypi9pDiH5n/sLMDogOMDYiBwl2GgCMww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiH8ExA/ZpulIQ1tKtZvj8tYnk2o5osFmkIq3S5kf1eJtmrkbi0BF+Sj5aaOBmWDpPj5Sb2DxEGWyrBc1+EYlRtrdeA37ZIJaPr8XWdNWRkegxnIjxbdkGvEY3UpKTtaDrIEn3yrVe4KptO/Y2yELFaz4JqN7MBMCcgWLGJ3i24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KGbMuTL/; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KGbMuTL/"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46391e91e16so6660046b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772829435; x=1773434235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guJ8HhzXT4BfiL89v2VHGYnRZxssARS5UTcNEFrucSY=;
        b=KGbMuTL/x6WW3ddfzOc4PovFDr0kb9HlZ67+6nlOpjwNLK3NNMVQOc6r347NmQdYXB
         IKMDev9AanMOBrBG1ysfYWaXpmDO6FwWb1aTwaBu5j2k8gHsrrbGCH7OrL3A3jtcdd8Q
         QvH9DCTVe6fhCp9nVIQZk3tqbABzo1Q2wz+LZAX/Iqee0ZDEVkw0PPOIwJ7lbrhKrhe8
         8+k5nJwKExMW2gTJhMGsXyiiQ3BatbzDDiWiY2KveatW2eQIP7I/lAX9XOmSAF0HuH0y
         EuiPt/Rfo2S0hWFRwNtHWzS/j2jC5lRNz4A0koCYTPl48FkJgbxdDiUdtBzzVbgnUVC+
         AtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772829435; x=1773434235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guJ8HhzXT4BfiL89v2VHGYnRZxssARS5UTcNEFrucSY=;
        b=t4DMcrSlKvKw9P5t/qloE7q0EE/Xxx92Vv33MP0JxkIMEf3YJM3MQQhyL92oNY7QiD
         TIOiroC5cy7HBty8Nnnrw8y41JoUYc2KwVQdsT9ZCtHgPT2HsVjlzLxeulsiitkubvux
         LHrB+wpBvwFCMa0UJEu6zk5jGw6i0nELL2ZvblR/97Bs6Ic+tfj+2QyNNWYz1yLyawjK
         yeIMKJtZwZyHtj7hVGgZL85SGIONqnIM99Os0b99zfvSwXVxxHAMTyZB0gny2kDoedkM
         bFZeXS39emjpWuSgPvqXhiA71SN6zikeU7xGrqh5QhDl3PepqeJhneaBibVOZ1A/Og8j
         Tuig==
X-Gm-Message-State: AOJu0YwTeSV74tfbfhgeLd2ZGGAF2sw3gqFDKvr0xOD0z7FDZrjosVPg
	g+dHgoqTLzbTnWjuaYOq4vS0gKJgZ+Ig7n3MbSmIX8I3N1TLofZQg36ZX/oaNwv88F4=
X-Gm-Gg: ATEYQzzXLlThFf+Ti60KxE/fMfbBRdnFnQgsw/FaJ7toNiIXB1/W9FaI0/zZ+Qi7jTm
	K9StsBQUv4OQi9NACzRvMfV+ncGLfDLsY3+keu7Cy3TNkD5TKCkor1oRfs00xFgwG8S0TBFIq/a
	cEZm2JW6uWsx2LYvCB5fHCx0ARks32aPUqAXhvISSdt5SPDpGNhrbba9wG3F0KdKsk85yI6yCoD
	fI/V2O7ytivcopLQehmBamR28iSh3ry25Q8XNIMGtoWvtbCJ+6KJ/Vj0DOClFIlBCZved5Xkn7f
	zurWZr/JmEsumnhQ+HBMIw/iedvW7vwfzjSReR3QOLac61kgwcZD7uMkXubprbpGVI3O8h3/+75
	plWbiS+VoJwTt1lOko5pfzZ5iXy8dHWBx+2enzJ+rj/i8vWDDOksJod+NBgv/v1q2DHxm5eAF/U
	4/URWWOJVrQm+Mp/dtFkup0yPx3DIXxf5wS9FMhNw1XIs9DWytXpY3XkPvJNOL+tstKAzY9hzUw
	EshGP6Vt2QH
X-Received: by 2002:a05:6808:c3d5:b0:463:93a5:a5bf with SMTP id 5614622812f47-466dc9ec17emr1937365b6e.8.1772829434794;
        Fri, 06 Mar 2026 12:37:14 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6d78:b98b:fc05:ddbe? ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466df96c1a8sm1263028b6e.8.2026.03.06.12.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:37:14 -0800 (PST)
Message-ID: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
Date: Fri, 6 Mar 2026 14:37:13 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: convert to guard(mutex)
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, puranjay@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306202650.61865-1-rajveer.chaudhari.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260306202650.61865-1-rajveer.chaudhari.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 2:26 PM, Rajveer Chaudhari wrote:
> Replace manual mutex_lock/mutex_unlock pairs with guard(mutex)
> in several IIO drivers. This ensures the mutex is released on
> every return path, preventing missed unlocks on error paths.

If there are any actual bugs this is fixing, they need to be split
out and have a clear explanation of the bug and have a Fixes: tag.

> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---
>  drivers/iio/accel/adxl313_core.c      |  7 +++----
>  drivers/iio/accel/adxl355_core.c      | 27 ++++++++-------------------
>  drivers/iio/accel/adxl372.c           |  8 +++-----
>  drivers/iio/industrialio-sw-device.c  |  4 ++--
>  drivers/iio/industrialio-sw-trigger.c |  4 ++--

Please split these up as one patch per driver. It makes it easier to
review and backport if needed.

>  5 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 9f5d4d2cb325..94c6023af487 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
> @@ -356,18 +357,16 @@ static int adxl313_read_axis(struct adxl313_data *data,
>  {
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = regmap_bulk_read(data->regmap,
>  			       ADXL313_REG_DATA_AXIS(chan->address),
>  			       &data->transf_buf, sizeof(data->transf_buf));
>  	if (ret)
> -		goto unlock_ret;
> +		return ret;
>  
>  	ret = le16_to_cpu(data->transf_buf);
>  
> -unlock_ret:
> -	mutex_unlock(&data->lock);
>  	return ret;

Watch out for places like this where we can return directly now.
If we aren't doing additional improvements like that or fixing
actual bugs, there isn't much point in spending the time to convert
to guard().

The same applies to all of the other changes in this patch.

>  }
>  
