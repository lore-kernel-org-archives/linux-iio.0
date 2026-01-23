Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA32DAFAA
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201797; cv=none; b=Pt2jn3Lv8ZcI1AAeJDlz8zINmhryThOoJGHpJYE+fBzctIyOAB1J2O5qot06F/LPkvUyE6PcOfNppfNmWaCTWZMTw8u4M2Z0bJXlpmB8oSZH5i/3pZHswHA8oMdRoG6AjAEuS4lK+udiFGdMdhLcND/ipkW2pm/AKmII4vP9xNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201797; c=relaxed/simple;
	bh=GWCI8sC23CD6DEJIwzN+W/7LwJ5KltaH+8qw8iBLyU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwCOXf8VXDMxQKv3v9TZMispARXeF4iVxKntaweq9OvFMPAtFJBsNINHw5s0VpOw2crCMiomyfPTzmXvd8VIr24BjL5F48C+SI9SuNqF2lbaV5kTC4ptGGvEJKGFG9VfZZtRdtrJEhNzA3E0rfJHeqxquqZ/6rVUFV35HoWA4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pp5UDtUz; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pp5UDtUz"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45c9fdf2a06so1866348b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769201794; x=1769806594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlVn1KZ/ohz8496QMrVjVa8IR7RgypRaR2xz6SXBEL8=;
        b=pp5UDtUzpIF4+ksMo4EtorQF6ecBl4Hm00sQBjLS/PJEExIPggJDz7LVxBD6K+tMzs
         VhJ9hzy+1FP7k7rxRMA9MmZeY9TBAx1Ma6S+8unhzN7iXVyu/9LX96rZ0FMaWBYAsF/L
         /li8ORzG/nFO/lXJ46d8+/B7aH3pR9U5WGe9Iml8vGzfx1tjyF3ojctCce2uzYRAJhB2
         Cwjd9Tn9p0l02h3AWJ/qNbOOsEKYD4VkA/qQbUEz7IFlEvHLHVTA5cUD86xn6wVO0zky
         eL0q54ofNwXU3yyXd9196TBT2nAALpeOYTYrzKA3hh3Ew/E+jwiFZNmNq37VL3b6L5s+
         zPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769201794; x=1769806594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlVn1KZ/ohz8496QMrVjVa8IR7RgypRaR2xz6SXBEL8=;
        b=chQw4nVZ6+X8m2n1T/AiCI9P5wyce36DkjJgNN2uo8OtJXS3Ub2eJHWuzpp/GHTf5G
         Zgaans4jR7B1RXMt/WEpnA5wN/Ao/azVU3O1X8dB6fJzCEnTC9gKLL2RhQNY3BQCb5//
         u9XOgA4WAwTI+ucvlfh3jGukiePAV97/qc9iZ56ppQD2XpMJQHCBrXu02hrIgEO5Olfx
         IwU6UBlx/rnnChUWuvd3AM+c17I8DFcjhfghdnCUEImvnAgwqFr7on1XStX3A2oI/ZJs
         VM5mkZ2w7GKKRItqhfzwaoYMhVWQ+6k9THLs4BFT0LO2bEeIHinWqEm4O1k8F7N1EF+j
         suyg==
X-Forwarded-Encrypted: i=1; AJvYcCUumqN8bXoP60Xl9wSUohqvjv4BhpF5ZCoxLdcXp7YRBSVd9z02lfpaSE8MXnd9nixw3uWWV2QvwdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0JNdqZWk8iMIT1p0CULh4i0eyZqO/74Dl5xmk1/qKy11gAH2
	NtR84n8mscEQRm2BlM2vBl1A4v64Fjtsf7Ko+vHllipCeSkwK/XpUIxYhsKBsFcqgvNOA1UWlSG
	zn14s
X-Gm-Gg: AZuq6aLWYDR1KRKxNmi2anVhLsSUjYMcndhjhVF+eFrtkyjGIwpn5+57U24xmXEm6aB
	WueO8V3wo8/Lt8Oq9PbIRH1e5mxMNmNSMQ9bY/T4v0U8qwGQjSzqESyRMrn0lSJpLpqRzkjKwo8
	t2KxuyphXxM9zhYjDIoGcyW1dFFAUvYcKF0MPkoT5b8mmZD5WreqfgRu7um5rgg1Hg5RCAAUsEo
	uchNADYZwVJ2EGkGvpAiesTqGJdkTGPs8SGMjCLpTKrqR+C45wkpqiZSDaXCFcZQ0qGMVLylo5m
	/+KNsPLsAF7oREncYIkVM9QL3wiuZGdAWFBpjYuXvj2z7jm0kl1r+j+XfTPvqRxUgiHTCHV1WGe
	rd5UmzAUk+myq3PasT5HeXeVrPo865T+KhAANCM45wNJYK/M90Twmbtn4J0gbFc8Q5W4zq5FbS1
	7zKaWj/vZrRarjD42kkB4HJQXOqJoqvJlcII8cv+Hy1nsh3mAzWVPKpbSQLQ==
X-Received: by 2002:a05:6808:191e:b0:45e:a501:750c with SMTP id 5614622812f47-45ebb8964c9mr1030209b6e.62.1769201793939;
        Fri, 23 Jan 2026 12:56:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af7f940dsm2110331fac.3.2026.01.23.12.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:56:33 -0800 (PST)
Message-ID: <ac45bbeb-7a76-42f0-88d8-35dbf9742a0c@baylibre.com>
Date: Fri, 23 Jan 2026 14:56:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260123113708.416727-20-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 5:37 AM, Sebastian Andrzej Siewior wrote:
> The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
> other interrupt handler and this supposed to happen from within the
> hardirq.
> 
> Use IRQF_NO_THREAD to forbid forced-threading.
> 

...

> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 4d570383ef025..9e4a66477d2d0 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -184,12 +184,6 @@ static const struct iio_info ad7766_info = {
>  	.read_raw = &ad7766_read_raw,
>  };
>  
> -static irqreturn_t ad7766_irq(int irq, void *private)
> -{
> -	iio_trigger_poll(private);
> -	return IRQ_HANDLED;
> -}
> -

Replacing this with iio_trigger_generic_data_rdy_poll() seems like a
separate improvement that should be in a separate patch.

At a minimum, the commit message should explain this change. But I expect
the reason will make it obvious it should be a separate patch.

>  static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
>  {
>  	struct ad7766 *ad7766 = iio_trigger_get_drvdata(trig);
> @@ -260,8 +254,8 @@ static int ad7766_probe(struct spi_device *spi)
>  		 * Some platforms might not allow the option to power it down so
>  		 * don't enable the interrupt to avoid extra load on the system
>  		 */
> -		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> -				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
> +		ret = devm_request_irq(&spi->dev, spi->irq, iio_trigger_generic_data_rdy_poll,
> +				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
>  				       dev_name(&spi->dev),
>  				       ad7766->trig);
>  		if (ret < 0)
