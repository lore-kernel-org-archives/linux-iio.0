Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05107269B1C
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037963; cv=none; b=lqMDqV030FM6TZYKlDMKYbdGyu5WSuITUEmGsuntbjxN2jtle1T4eUTcXnp6PV1SwkOMUplqHNYhdvNtuYMNfeWgkO2ND2K85I9d9ot4OYFltW+7ozD3xxRNSXi8pncXpzKx9a3EewUe4kTqTkSUAPS9ePz/qVGfMs9Bp598ZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037963; c=relaxed/simple;
	bh=rncEqY2lnCflhGiKv/GKEoLLk/JmJ7O9b8tC7N387QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQuB5g6vvkXRF4mQNAu84kqMAIoUbI4bk0XzYGrge3e/FwP3qqY6NQx0JKAQ2eU0G/4FvrEGbsTZr6HG+++65YJSRZynmzSzkvdJSK9OLAhtRM4UlGpBWDoH3H4Qp4inFbnrfKH33q6oHEFivfxCRcrXTH7ojtH+bAXTycMNC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kRZ9RGN1; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kRZ9RGN1"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43a2ad7bcc4so498238fac.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779037960; x=1779642760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xXk1rxT9NJV1FgwYVhJyOKtq8DN0GT5xvOX7oCK3To=;
        b=kRZ9RGN1n1X1S+xxGXGESjXX4bGdBJrR6oAPHSLXBhf+3YbH0Vvv2wqMIYitV224TA
         Fkli3ritROMh6JYMb5tCwAgk2erWY2yi2uaccJ/O5isWKPdr/513Dap9LLQ/oFfP3oUs
         /bnJUuBz6kOTnIQLGsAreZhj+dpHiBk4JO3gqYCxp0DdSc5fGwUC8sX6eZBymWAzVM2C
         LTbxZ4/zaTgSS8RaegvXiQW6D1QC9Epht9z2rJm01TbgVjR+4sNb+4p0wFAPFyVe50eJ
         /hrOzQGHsZPQs+O4YPL9/KOL+TcKWFKlMeKPQbWoU1L7povjMwRydzUfIg4LM1nf+qMM
         luOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037960; x=1779642760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xXk1rxT9NJV1FgwYVhJyOKtq8DN0GT5xvOX7oCK3To=;
        b=VACd4YSEADEHicprq1sStvyltnNMSUNgEdkhjRcmrPZvC7pEqPTCG1ZDT1ExOgQpfF
         0qwQDx8AR+eBxc1ro75EIWN2OS+o5hCyO4D3FbecAzPZvFxKywAiYPT8cccBCGf4jYcM
         p7lJGIYi/SOWrb8J9kfHgA2cgJ+4exlPaVD0fGDXtD5dYGCTJ1ooMR8xSPnYQfY0xzD8
         Rw3LLPEIaiAd6YG+uaGZwGxpvDBDRSQmy38lFaua/JDtBnzE5gUeec2apIC4oUvjzErr
         jlrdOlPNzrOrGzNuG2r4YMfnCNATd5/64zZ9xKzx28ucKywh0Dn3A+MJoQU8etCsRkJZ
         fdfw==
X-Forwarded-Encrypted: i=1; AFNElJ+DK8lWV02GtGWkl1y5ocpP13Mbdrc77DPOqP54WDc4pZ6fYmte3zrXM1KqHvwiLRKQiKUz4vysK+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbCVkCTW/BaWPoba2dkdfCSsRIsUZ3M4Eqwkb4e+HDUclw0mB
	L6vXTvfHnYczyuo4xfldsJuCAdbQJX7c0aPsUM/N+ITkac2+dHZdswvE28XfXYl9ozmFo04l5zC
	/a/g33xw=
X-Gm-Gg: Acq92OHuPOK48dGIfj5uMtoBxPo4xcegCHRcY4cSgkENRnSJbY5H07lN0Y1t36mjC1V
	ji1JX7RQYw7yoT+/zIKeq5cJYuMgM6Uz/8Q5AWuS5qb7RyE4ToOaHDDRsoNgAni9kb/IDVB/j+7
	5BrIY+RFlGxm/xBVj0FVmYFDThSXpuGdiVcwYf8jDr0e1mZtRizHFW4EOdzWUUuyj5W1GAMotY2
	gH1t/OEqwdetfug9gRuXXqeHZsf29vzXYXTUW4Nh1zjmSzEBuKHFk30ptuDLqFXOWtLpUyuUGei
	XfIpSxBCBqT5qesTA0L9ftVyVrLjUGAj8WcVtaHsUllpKXH8pyEQ9uOfoms1QHOjzmoucIf7ojW
	uZUT3LZXgRiAZH+QSNtlWaFYpVJUUPeU6VhfkHsp2eS1Io9pxbiu8H3UXchLta6CZi6JSVyeIaj
	rwGHu4N8Outey3uzGq31hirUUI1atpGdtWqs5GbEL/KG60WIgyO56+POdEmpKblj3LoHkie8UrY
	kiIYfEHsA==
X-Received: by 2002:a05:6870:b0f6:b0:439:7835:136c with SMTP id 586e51a60fabf-43a2dce8716mr7226411fac.23.1779037960055;
        Sun, 17 May 2026 10:12:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fc2cdbsm2007319fac.6.2026.05.17.10.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 10:12:38 -0700 (PDT)
Message-ID: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Date: Sun, 17 May 2026 12:12:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
To: Stepan Ionichev <sozdayvek@gmail.com>, mazziesaccount@gmail.com
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260517160801.269-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/26 11:08 AM, Stepan Ionichev wrote:
> bm1390_trigger_handler() has three error returns:
> 
> 	if (ret || !status)
> 		return IRQ_NONE;          /* status read failed */
> 	...
> 	if (ret) {
> 		dev_warn(...);
> 		return IRQ_NONE;          /* pressure read failed */
> 	}
> 	...
> 	if (ret) {
> 		dev_warn(...);
> 		return IRQ_HANDLED;       /* temp read failed */
> 	}
> 
> None of them call iio_trigger_notify_done(). The success path at the
> end does, so on a single transient regmap or pressure-read error the
> trigger never sees its use_count decremented, and the
> !atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
> drops every subsequent dispatch for that trigger. The buffered-data
> flow stays wedged until the trigger is detached.
> 
> The IRQ_HANDLED return on the temperature path additionally leaves
> the temp branch's last partial state in &data->buf.temp without
> pushing the sample, which is the existing intended behaviour; only
> the missing notify_done() needs fixing.
> 
> Funnel all returns through a single 'done' label that calls
> iio_trigger_notify_done() before returning the saved irqreturn_t.
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index 08146ca0f..c18352399 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *idev = pf->indio_dev;
>  	struct bm1390_data *data = iio_priv(idev);
> +	irqreturn_t result = IRQ_HANDLED;
>  	int ret, status;
>  
>  	/* DRDY is acked by reading status reg */
>  	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> -	if (ret || !status)
> -		return IRQ_NONE;
> +	if (ret || !status) {
> +		result = IRQ_NONE;

IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
and the handler will likely just run again immediately. So it probably
isn't the right thing to be returning in the first place.

> +		goto done;
> +	}
>  
>  	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>  
> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  		ret = bm1390_pressure_read(data, &data->buf.pressure);
>  		if (ret) {
>  			dev_warn(data->dev, "sample read failed %d\n", ret);
> -			return IRQ_NONE;
> +			result = IRQ_NONE;
> +			goto done;
>  		}
>  	}
>  
> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  				       &data->buf.temp, sizeof(data->buf.temp));
>  		if (ret) {
>  			dev_warn(data->dev, "temp read failed %d\n", ret);
> -			return IRQ_HANDLED;
> +			goto done;
>  		}
>  	}
>  
>  	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
>  				    data->timestamp);
> +done:
>  	iio_trigger_notify_done(idev->trig);
>  
> -	return IRQ_HANDLED;
> +	return result;
>  }
>  
>  /* Get timestamps and wake the thread if we need to read data */

