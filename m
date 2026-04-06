Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFB32ED58
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492077; cv=none; b=TQw/dmgtURA2Qz1lhcZ0xm9bITE0pa/4nU3Iu+gIp5RrH9qfKg23/zv7QJ+1KX1MGTNc217Igas1FU1fTexyrzDi0rOsNiUVuzSy1XPADqq509oQGoGAwF5HJCqqdPJWHEuWhTrILeNrhlasQ33uNiUF2zMrxP9zzg7wmAI+u/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492077; c=relaxed/simple;
	bh=18E6fSs0FEgBgnzqYyrmUYLs0X/3n6wGNsTR2UGdEm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ak6noy/QF6W27xFppOmdZfJU19G/sAKqSkwmy7phQ3JTOQwtzTqd7efqx4kVJNzARfptekoFL9coMhVpil+DaW4LdcMQvzOSnZTaJAxOHJcEt1WtTLdcmz9owvTqgM/xuwFaybgCv/WbBsa74JlCfLKlGkK91WJRaMmoWTfviMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=gd9VQ6wv; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gd9VQ6wv"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-47018d3416aso1321359b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775492074; x=1776096874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ung52b5S8P+Lmm+irkc4wPnYl9jZuN15tG6M+cbGeg0=;
        b=gd9VQ6wvmt02UKVjta7xktvbf12UOEbaQcb24u5KyV94RhdknhxlxMlwQhlAVTpMur
         LwbkOOWQyORldmcKSaCdSZFsJDRAOXdF+e2WD4sMuP6Ec7i6MKXIyS8UHrkf5nWDKw+g
         tSuGbpZ6yjTJHbURBptjBlXfVH56OzEbrsiMGq+nmKUTV75MiYg3tAb/L6QC/sn1Qtf0
         hdbtd1peP/0NiYc9PXWYKeE6TXuWtPqWKuW36yYfq0HV33Cw8C4nVsuQVTSnew3opfcu
         JIhsk4K38M/i0s6Qo2IQVdAXI5yVYorOYmls4m0wvXKfpwQb3dxx/aQWw3jdpHg+XJ0x
         6xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775492074; x=1776096874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ung52b5S8P+Lmm+irkc4wPnYl9jZuN15tG6M+cbGeg0=;
        b=B2Luoc0mo1N0LbCsUt6cK/qAuCy059hjMTUpeJ4T/b5eYJofBaMEdMGdPZqN+/QdOV
         Wzi6USgSy8w6iUBmnvg+Wee92dj92s2yMVc/XmhhQ5Pa/tRDPBia230idx5LFc0VUQcn
         orZWDMunAn9xoznaYhwUHksZosH+X6+zjg8kU6dg3Y/pWlckMAiExRlgSHlZS3Nrp21v
         3ZfCEf5/MdmA9PoiVD9VedqKTNWVvvLQURZmJUkjiYDXM7I9pIYM6sx7vay1NCx4vf9x
         REXLLyqI+AXDQ0yIWR27ePxWPRXiGt4/3+udgPViGcZhpB6cFVcmqG95ODEHr0TevRRT
         y71w==
X-Forwarded-Encrypted: i=1; AJvYcCVqle4X9bFVg9vHJJ4FfkBbcwa0yqTjTXaFDnGN/qN4yc31AdcUcK3wPkukVLFzeQPwvpQORYbE/Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBDVfQTIC9BcFq6hcSCXaSabKQSAz3kHDfxJnTDqK5Iv6tBr8
	lcZTiyOIwO1jC6hcyY/Wxqc/0yMPgLnqrnZH8mZ6rZQjENHMqJnDenTRBhbtaEgAHnI=
X-Gm-Gg: AeBDieuvi6yYd2cTdc12bXUAl09tTbu+M6t7t8Lvyez8amy1zhcO+zSyHQEUDbzUjvl
	tmTZV+S8uM4BJ9nVzEBILWdFN/mrRKid9tlPmdpWcDgh6vjs9XKVlUxGolHi13t7FHHuAR4suR1
	fWs4tKWBIiU3UPE4wJmjNMxba0WfGadaCYfDWbNpFvCJW11q5zLZU2kH0iwxXuVHt50/p5EosNr
	NMhY/np1i/yii7meZW4ZmdfBdaARyQ3+FKSB/yS8h2v28BxCs3bdGjUV6eWp9gIF7Iqu3Cl3Boo
	k+DYnKGeFnw91l6IN5sTLfRypewhuB0aRIr1g4YqQl2Wu2EKXvFdoASLfxd0DpLSF6YX1vWpaAM
	5bLFhgSy4QVK+CAmRtdWtRfbV+alglIh7Gpg0b2l6ESF/TM2nm/PAqsi8pu5ggznQd8EJqaQ49e
	Fc9utOBEVQwgrBKD2ngUkwTzSqfNOKhPtzshptUrLKKmxv51wxZMEhme/AM0J8m0d8ECARSqY=
X-Received: by 2002:a05:6808:c1e9:b0:467:27d2:96a7 with SMTP id 5614622812f47-46ef904d90cmr6699038b6e.15.1775492074540;
        Mon, 06 Apr 2026 09:14:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46ff2f94b71sm5445356b6e.5.2026.04.06.09.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:14:34 -0700 (PDT)
Message-ID: <e7ac60dc-fcf6-4ed8-847a-dc29ecfca142@baylibre.com>
Date: Mon, 6 Apr 2026 11:14:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] iio: ssp_sensors: use devm APIs for mutex and IRQ
 resources
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-5-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260406080852.2727453-5-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 3:08 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Convert mutex initialization and IRQ registration to use devm-managed
> helpers, tying their lifetime to the device.
> 
> This removes the need for explicit cleanup in the error and remove
> paths, as the resources are automatically released on probe failure
> or device unbind.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 36 +++++++++++-------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index da09c9f3ceb6..f4fc869fc770 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -510,7 +510,11 @@ static int ssp_probe(struct spi_device *spi)
>  	data->spi = spi;
>  	spi_set_drvdata(spi, data);
>  
> -	mutex_init(&data->comm_lock);
> +	ret = devm_mutex_init(&spi->dev, &data->comm_lock);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to init comm_lock mutex\n");
> +		goto err_setup_spi;
> +	}
>  
>  	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
>  		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
> @@ -523,7 +527,11 @@ static int ssp_probe(struct spi_device *spi)
>  
>  	data->time_syncing = true;
>  
> -	mutex_init(&data->pending_lock);
> +	ret = devm_mutex_init(&spi->dev, &data->pending_lock);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to init pending_lock mutex\n");
> +		goto err_setup_spi;
> +	}
>  	INIT_LIST_HEAD(&data->pending_list);
>  
>  	atomic_set(&data->enable_refcount, 0);
> @@ -533,13 +541,13 @@ static int ssp_probe(struct spi_device *spi)
>  
>  	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
>  
> -	ret = request_threaded_irq(data->spi->irq, NULL,
> -				   ssp_irq_thread_fn,
> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				   "SSP_Int", data);
> +	ret = devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
> +					ssp_irq_thread_fn,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"SSP_Int", data);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "Irq request fail\n");
> -		goto err_setup_irq;
> +		goto err_setup_spi;
>  	}
>  
>  	/* Let's start with enabled one so irq balance could be ok */
> @@ -553,21 +561,16 @@ static int ssp_probe(struct spi_device *spi)
>  		ret = ssp_initialize_mcu(data);
>  		if (ret < 0) {
>  			dev_err(&spi->dev, "Initialize_mcu failed\n");
> -			goto err_read_reg;
> +			goto err_setup_spi;
>  		}
>  	} else {
>  		dev_err(&spi->dev, "Firmware version not supported\n");
>  		ret = -EPERM;
> -		goto err_read_reg;
> +		goto err_setup_spi;
>  	}
>  
>  	return 0;
>  
> -err_read_reg:
> -	free_irq(data->spi->irq, data);
> -err_setup_irq:
> -	mutex_destroy(&data->pending_lock);
> -	mutex_destroy(&data->comm_lock);
>  err_setup_spi:
>  	mfd_remove_devices(&spi->dev);
>  
> @@ -589,14 +592,9 @@ static void ssp_remove(struct spi_device *spi)
>  
>  	ssp_clean_pending_list(data);
>  
> -	free_irq(data->spi->irq, data);

Do we need to replace this with an irq_disable() so make sure
no more timers/work is scheduled after we delete them below?

If it is safe the way it is, add an explanation to the commit
message.

Alternative would be to use devm_add_action_or_reset() to
handle all of the other cleanup functions in the correct order
still and get rid of the remove function entirely.

> -
>  	timer_delete_sync(&data->wdt_timer);
>  	cancel_work_sync(&data->work_wdt);
>  
> -	mutex_destroy(&data->comm_lock);
> -	mutex_destroy(&data->pending_lock);
> -
>  	mfd_remove_devices(&spi->dev);
>  }
>  

