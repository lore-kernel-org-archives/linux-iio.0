Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9A369238
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887288; cv=none; b=WX+MJ1B9c0s4iGDOkkdBOGbRpz7EvAVsWZRsTvBdCw1xYbKxuxqHnClna46dxggKq6VNZyNKDfFmW9Rpwb2TdCJN3Gxhfwk/XJiA7iwf0GBtAH4fiKKtWWIoMSvGJJsF365n+i8F14bjugBuSgU3MLKcwtD2janIZMLgGHqBMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887288; c=relaxed/simple;
	bh=twjPrjnXgWq9BihAJShadALT5mdKLYOhW7LJw/KQQdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG0g22fM9HXi32CCpmpd8YYmj545mAnf7Btxpq9fYZnhBdZr6iAi1NCE2siKpK/CibR+EqwAq2ZS7NweJ78QXe7BM77Lpm4X8nn050g6i/M22I18G5bAH7fZMUClWi4gSYXtgeVYn8cep4H5y+qJVHc/UYmgxnUavxXLF751Njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fg+kbTJI; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fg+kbTJI"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cfd0f349c4so1992568a34.1
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769887285; x=1770492085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mg351UXmtMA/dk9xyDkawr0wqd4z8SkQhGWvqh3DLjE=;
        b=Fg+kbTJIWRhY6a0ETUNCakF38HWBeKfFPa2FTmbYmqoQUrPVrampgZniEbzttaGpEn
         UdzXG/ic8eDt+RAwlXm2WtqfcSDzhg+2JARv7x54ysdyOTmEMjrtSiCzWy5eUOP5UKCr
         3Unp4O77hg0bkc+EbFbTXH4muW0L3Xnvkg+ztW6nN5SdjohXw8oF7dBmBTkEObbcJ1ep
         oBchdxdcPPa95HpuIuvxiaPJhRvwueDi4a0sunGqESZnxLkt/SKYuSDx0ZpziAv9VrPI
         x25X33Sr1SnsH4YCNkxRhkpg2jA+eCjNJPH8yBXFcXTTkSQsH84zUG74zTbsVuYWpKbN
         BFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769887285; x=1770492085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mg351UXmtMA/dk9xyDkawr0wqd4z8SkQhGWvqh3DLjE=;
        b=OgfNey/pb1ml9HF8rFOrMXk2Ug4oEXj4M1v67ZRPNPYJwxkoajWMq+MRLXCn3RUbVM
         hqz6y7cqZ+0x3ZTVlJbYuHRfAVkKrz/8mjGVkh6nBQWKTHQEMCvBmKwdErEQDE1vIMeA
         9oRAjx7svqx4elnkCsd4JcCzeMVUvAYEwr1bDZZicvWKLR6FiKCsbRgrdDZPPa0giESa
         joBfa3+ovRmPR0amGvVarWaumhVwik63qtdfGAieZ9pXnuum31IFJPWNCGX/D4Qhew0s
         +Y7xGKthcRG+q6D80oF9n/xTI9xUWnl8LWrvm6zcxanTV597MzuIBp8AXzAuvlbnkYG8
         JMjg==
X-Forwarded-Encrypted: i=1; AJvYcCWJsaCnmR9FHBJsi5Oxr78WscI9ic+lYMOUZTYi2+stcGkVGKRQyNJKCcJVzvDsDed+OvNdxrJJag8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsdeto5KMjl1q3e6KOP+veuiODZSVihOhKtC2nScHwJ5vlttVy
	iBqk0K8AaZIJun2VEDcLLici+CM/rHYXWgaQWl2CSDyYHFj2X08T/qrT+DJ66owzfiQ=
X-Gm-Gg: AZuq6aJZB86fHP7ntHEENinm95X8OMguvZklnXTSo6nb5BU7HJL8ZNJE9boCBM9CwVr
	nzQDTe24JTyqbn+ft3znf8YGUxmIJdL527JxWnz39SKTbWg9SNNbfghob/QJeYVlYF8TfUMXq4e
	FUxe9U9xIxiMmwbmGW93Zw8B52VB93N8rvcIvx/QvU8ztLDV8uyH5EGqMEh4i4iM1YsG7V6Linl
	uzYmHg5i/iIcAP84E0GZxeFyo+5aNkamJaZVQXNvH4ZmiK1zDI7uNSOb1CjklCEVfu0CgWwEwc4
	E8R5AF0uDrXHh+NaI1WOrxkiS5BMbQl/3pPW1cuJLsIuzBW5Iv0z7ypIyXrVY71rjd6D5WkShkE
	zeHpws70Wyz7gUjbWo/lE+uh16C6+2Bn9fU8AhJv9JMVjqoyKidqCqiOzQbJFGIZ7MVy5Ruevii
	AKiXONdn6X4sXdnnsZDYXKFDnkqACn3fqr12U8Z31vghwotQZEspbg63MnPjhH
X-Received: by 2002:a05:6830:82eb:b0:7c7:4f2:e15d with SMTP id 46e09a7af769-7d1a52d199cmr4698200a34.16.1769887284722;
        Sat, 31 Jan 2026 11:21:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69e63esm7677530a34.11.2026.01.31.11.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:21:24 -0800 (PST)
Message-ID: <298d1c61-e6c9-4aa8-8f94-82f218ac37b5@baylibre.com>
Date: Sat, 31 Jan 2026 13:21:23 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/4] iio: sca3000: switch IRQ handling to devm
 helpers
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andrew Ijano <andrew.ijano@gmail.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
 <20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/26 3:43 PM, Harshit Mogalapalli wrote:
> Convert the threaded IRQ registration to devm_request_threaded_irq() so
> that the probe and remove paths can drop manual freeing of irqs.
> 
> No functionality change.
> 


...

> @@ -1484,23 +1483,17 @@ static int sca3000_probe(struct spi_device *spi)
>  	}
>  	ret = sca3000_clean_setup(st);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
>  	ret = sca3000_print_rev(indio_dev);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
>  	return 0;
This can `return iio_device_register();` directly now.
