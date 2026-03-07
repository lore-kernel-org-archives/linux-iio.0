Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7C303A26
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920062; cv=none; b=YWmfSCzi8CTrmp3m8iE3E5IehwTtnHS5e5CcmVixQJf/51kNAZ2sM4ZWA4swTtE7czwMYWrHFY2GakqwwfjmI8kdbKbc1uZXO98KYvTRYpEa6gHVnafo6oiChVf/HbBw1sgUA+S968Q36ARqhAiUHNEkueOoTnMQz27rukHcbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920062; c=relaxed/simple;
	bh=gTc+rU5U7u1LSuR+IKx+LpKeYrIe9j1L7M/z9tGx1ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONdsM9YvsfV4kinK45XIep3E9PTCapm6gIMt7JsrDv2ufwhH7TlIikMPV7OrRrkz4wv6b386USXTGBr9HueAqSaO/RTUdl1iGMXdmsB9+p9tP5hfqclBy7WSPNjLYjMfzB28MP0OODbQHlTEfLLvJ+4uoImS1953gIyTXBrt0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DZdu02Rm; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DZdu02Rm"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d741f61ee5so200948a34.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772920058; x=1773524858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTCotYBdAN3jxjaSaFDq5B43vwPdDrS7INYqiQC34CY=;
        b=DZdu02RmiBxJXMMnk9oFmdbhBEoURATV/eU74Oz60YftRLBA4Q47xbLSKeV+PHy/De
         0C47PzPZJjGB0OVdic2DtU679AMQYh/5U/20skx81Yj9dlZoT/TzrYII3Cvo4wCpKCzN
         E0ok0mTYSyW3TtuEInQa/Z7Svospr2DhRWnRilqaQWSnNjxspHiNKfbIvoKdfhb1nWna
         QVX+aefGmHt+ZSSpC+XKi/ZBf5wvoQQfN9U025MxD72Mq2fCIgBU4SfYtE0AVioomX65
         zREFAMH+VtDYabA0dCzrM7FJdqGpjsK+HQP2gYM5bY9DdAYv/JFusdG5GQ7yOykHngat
         11lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772920058; x=1773524858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTCotYBdAN3jxjaSaFDq5B43vwPdDrS7INYqiQC34CY=;
        b=oE783sOz98GwsPw0bJYpZ/zBps/keo/dJSJnRR6GOO3miNSRUHRuc1vRFHBRLKR6MU
         S5s5qh4Cmk+UxiifScYx3hW9lQXrWytHeyeNqbL2/nlWEXOQggPaxhwYk47WXDKVaI77
         /H2t8Ug8RBY3FQDQ1hLm6rrBvs2F6S+IallSXZa03IkEnAphvww7BQGfKPe2Wh1JSxcs
         wvOIMU0G+h1egulYgd3AITA2Nc81vbfiuXWJpDE5iKYmu7YUtHDW5hviX8iQz073ctwF
         d1HqBJn2HeM5b4T8kkmYbe5755iiNkqCzIVktHNkEFh2+p0xu9/XEjxD3MnHvRRXhdkB
         tgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYcttj1kEoUnJBxHt9f2fxbooGDokBIzINjGGalKBI2C8dZyyQh8KqRNQZxjGBDgj4H66u6xJnrJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzM20nTf8dteDxngSbSYbt1AtbhY5VHyA8aIUebUzPmj+3DDpd
	m4HyGuYlnfjJ88igMWnAwaF/9fKkS05AfNMIwLj0B3XFYa/NH0Gpwg8lyhU4q/Nz/SI=
X-Gm-Gg: ATEYQzyHiJxVFWgcRrvNyQjaCfsHwEi6m+WxyvCwryHie4qVymCupr+zNPCcBmnsfqu
	Yi0Qu7mBrSSlUN69FSfgqcJte+aRce0A6ieebHd6px2LnpCEsU9ddV/1dZ4vaDXhf+UjXg6n9lL
	4zGOM2Vh5UEpvfnYXE9jDI/qcWR/YJrOhGhKNrgnt3Jq+wJj3gny5V+AznqAhyY015r3wZUcdS9
	SvDGgJXe8ANPpfujoc3C3bqtXmA42XuVzfpPJUjrr0Cx+iHdWoyOEMmnKelgiBPJ6Hu6244BlsA
	BvLTTS5AKGaSMgKd8fRlZlflq7No1yLufez+kKJT5KNxbfF4DtP9/5YaBnMHvwxvEIIpjq5sSUI
	zCJlYvqAS+nWdZinJUkLXEyQXBql7UR6kgWlELdFnQWrBI4FwB3HSvWOIky1x5AMu4eT8q0MVbM
	A4wZjZPWOaHlN775jfNI508OC7wfsyqmwYfyWWK9rXzHAHRKh30onOcr1cZLhCSwzNI+MXsZO3k
	Q==
X-Received: by 2002:a05:6830:d18:b0:7cf:cef1:50f7 with SMTP id 46e09a7af769-7d72704b8camr4420944a34.27.1772920058500;
        Sat, 07 Mar 2026 13:47:38 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728c5ae94sm3557563a34.4.2026.03.07.13.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:47:36 -0800 (PST)
Message-ID: <7eff9f93-cb69-419e-9fc9-a7d3392ba02b@baylibre.com>
Date: Sat, 7 Mar 2026 15:47:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ti-ads7950: complete conversion to using
 managed resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 1:21 PM, Dmitry Torokhov wrote:
> All resources that the driver needs have managed API now. Switch to
> using them to make code clearer and drop ti_ads7950_remove().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

One more small detail...

> -static void ti_ads7950_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);

Since we are removing the only instance of spi_get_drvdata(), we can
also remove spi_set_drvdata() in the probe function

> -	struct ti_ads7950_state *st = iio_priv(indio_dev);
> -
> -	gpiochip_remove(&st->chip);
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	mutex_destroy(&st->slock);
>  }
>  
