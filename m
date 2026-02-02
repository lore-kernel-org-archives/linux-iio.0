Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DE3806B5
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073620; cv=none; b=RTy3u6ckhQ+CnfDGnFmpb45T+CocI+SG/DDn5v6PKXFiYUSOKLLkEZA4d6DNrB4FSwi+x3rEkz5a4vLtP5CRQDQNwiigMxlXxLbQKJDDLOH8AkT6fiNbu6bk893ZWDCg98Rpe5U2V7j5H5GoXlBafNL6iJjYGhrrJoGFEONoypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073620; c=relaxed/simple;
	bh=0fH9YxT6el6nAOYunQ7GfUEIZKSKjYrlP/DUEJJpERI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVJPaKVIxpjzZ4QWE95rSsxczd/MC2XSxqfBGSTf3eb1AR2Ovd1EF3tDtnHABoFnSbXImETFizNS0PqAycT6njQOkQR+m/m1baIwWvmFgESWtEj2a66r3yZ8dE0s1oIbBxJZqvz53zu7/hMeL/XzKYycEyfjieu2RnXAjH6NFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HyNXgr0p; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HyNXgr0p"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d19d3c7208so2755264a34.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770073617; x=1770678417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9W2tEIPpOemC2y1227Ea2S2cPiUPDeGonw5JxA3WiVo=;
        b=HyNXgr0p8Lqh4QKdYUiFrZMO/Q9ptuF/7B+nCMI9iJMxGV12JlTJvAJn/c+yIkpibR
         QZb18Bj6HyqnFcE+jtf5r4IvtpeM8Q/s39+4n5seWXr4ZE3XUDvgW0eLmfNvRlDMiiuL
         NUwqNa87309auo5peyiV76IsFvlrLcIIQlr9L1Ha2j3gsRcmIEdAW/iRvlr17pQUNlFP
         5PP8W6AGkUz1ateALQgNhEcVwCTINynbGhM4OAKR0t4D/H1n05JsBgnfohtnvAyUERIX
         V20Ne7g27ESpSQlaAtyxhGpRwngRyHjXEFbCA738/r6L/v3+Bwu9laTdi96wrYCxsdsQ
         YxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073617; x=1770678417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9W2tEIPpOemC2y1227Ea2S2cPiUPDeGonw5JxA3WiVo=;
        b=o2UgBx1Vz/g/rTAwmN5tOs+7GxKsSYd96zNUfwczDWiuC/A5GmedMfsLjqsLxY5edx
         7hrHvapBGkp310NwG3GeEW4usSwUQVdFI3qpS2Gd9hYdoEKZWwlTP0PSXJFruRwOzWrJ
         bD1ykA64+vm+FdYBuEQawzy4S7dZQZXF7Mpi44ekeCLDgbzw9aqaSPAehgrsmGkroCQA
         H+mBAKyWNv0reEKWAH8xlWep+Dki0pla/ey0ZZYRRCqAIpeIgzoK4hbd1GrZQXyiatIV
         7pM0kp+ApEwPAQlkwhS7tMw5Mb3NOBDxryD+o9mhO6AGBP3f49VBLJwwzgo1kkuoCKoW
         vACA==
X-Forwarded-Encrypted: i=1; AJvYcCVPiK1kXz7fYFcECXYhqAYz0lOkgbktaJeuPmLvz6fxLzRDa2ddvLzF2gGUFQ/fxCzJO4v2c05XCYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09gpmPIXT9AVFxQ2pLZLf+lJ7XAmmlbZgBkmsFY7IqvJ8Vr23
	+kwNy9J/8PbmiuANQ9wKQGa6iGkuXYOelC21OnolBC5edY55XZ5CEwKIJgHoocl7jBc=
X-Gm-Gg: AZuq6aJvpBLVvYRFJ3iQR8VXEI/Hyo9zCWZvEBYPKy1RqXQ7sLk1VEGaNMSCN5vXS/5
	wdbKK3v9FMvzTMTba3wmEjEnmj/FlLUON4fnyBJj0dOzz05PQD/fpVPi9dsvrfeh3wPrVzTYf5C
	JcwnhAtOvEA9IVcbp1QVX3EX/nxvcxcEjuWDMGZTSZ8t6pA69crHy014X4Eap8EcTnY3LwTnOJc
	JTqRAy9QpnXytyfkEqVxMS+QlbfUAfpWQcTCKZpCU+yArhQsKGy9CfMzdBwY46dSQCZmxoFBK7f
	0br1aNPgcJ5BD7Bv2BZWbx+Y05aE+sIWaBxwO2/RkUwftCGKnakDUgY0bpOpIggivcK7ORfEvn6
	TyIvBT7baxnaAWfLWM1jvGnR633qc4WTU73Zh84KAtTq29rbAuDF7HYd5TCuB51rJm7fX6ie+yF
	KpG9HeOL/AxMJj2nIuVRukPMIX+jOYP8Nqox0pqPw9NoDJ8Q7USC7vjtH81NEi
X-Received: by 2002:a05:6830:6add:b0:7cf:e539:dcf0 with SMTP id 46e09a7af769-7d1a52974b0mr7884674a34.10.1770073617617;
        Mon, 02 Feb 2026 15:06:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67100fsm11635469a34.3.2026.02.02.15.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 15:06:57 -0800 (PST)
Message-ID: <62d09f1c-9869-412a-a2ea-3be81ec13ede@baylibre.com>
Date: Mon, 2 Feb 2026 17:06:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 2/5] iio: sca3000: switch IRQ handling to devm
 helpers
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andrew Ijano <andrew.ijano@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
 andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-3-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202194033.627967-3-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
> Convert the threaded IRQ registration to devm_request_threaded_irq() so
> that the probe and remove paths can drop manual freeing of irqs.
> 
> No functionality change.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> v1->v2: Fix indentation in devm_request_threaded_irq() call[ Thanks to
> Jonathan]
> ---
>  drivers/iio/accel/sca3000.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index afe6ef61a53b..37ef724d5dc5 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1473,34 +1473,27 @@ static int sca3000_probe(struct spi_device *spi)
>  		return ret;
>  
>  	if (spi->irq) {
> -		ret = request_threaded_irq(spi->irq,
> -					   NULL,
> -					   &sca3000_event_handler,
> -					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					   "sca3000",
> -					   indio_dev);
> +		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
> +						&sca3000_event_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"sca3000",
> +						indio_dev);
>  		if (ret)
>  			return ret;
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
Could return directly here already, but it gets cleaned up in a
later patch, so its OK.

Reviewed-by: David Lechner <dlechner@baylibe.com>
