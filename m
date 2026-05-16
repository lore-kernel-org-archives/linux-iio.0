Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7D2C0F81
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778974599; cv=none; b=Elg/4Y1OU8tN52N6J8/GUnbZdbWy5ut1H9G77tA0oTNGkygZqpmYs64UzGrcwZD0kQsBu7LNLo+AcHNYPrUpsbIIQXmP13/YYReD1/jQp4KQxy+1Bh3VHKH7rk47pE4VaJ7xHtbREtgG8Nm8XJYLWWrJk+EmBUDrqXENsR26YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778974599; c=relaxed/simple;
	bh=lEx0X1KLDFnHN+rGKHOQm4uTV6GYt7OKSzT7ZhTEEPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4Y6kId1F3cXBqe7HWpsg3wn8ucbMdoZ6HZ7sXrm6KQsr8xGud/caPFZEPB9Aga7mg6P7jqWd/We4jdjHPxPGpoCcovh4pZp21+1V/pjHVS/uIZbrvT/83f6iAja9dl8D/wFwueTVUgrnnY/huAkiWnfVlgg1a5+sadoxBy3KT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=p5heCT4/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="p5heCT4/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dca00c1591so277291a34.3
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778974597; x=1779579397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5+OvsnY+lCXo9LuaLsj5tvmmBLk3LiafYOov4NjRE0=;
        b=p5heCT4/tWcJO0LiOoeTAURjr1/GtQPSY7x5FgSgVjRG2eZgkPaLPCDHDR3WROg40W
         KfjVGufIUwrKWTZjK4kODzugwT5CVmtP1IOjKPuREbFcDfihmpY0PECTlkQ0oRbGdGrv
         wYLcxA6Ip+EGbz97Qy0apYg+kUdSHCR3fsh3TZXBejiK0v1xD/CzohqkEEik/vBdQtNR
         VY0s6sXY4U78yRA9FSi500TFWOGoVtj6oiNmCjLmyDnOHG9j+hSxBwtXkpC6o0ypcvRz
         bW49GgHRm8cNXH5PB7Et6mlSiKvbSw5t5MphZktJEKEcJ5uKZSMLpkzkSPBib1P87r4G
         aQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778974597; x=1779579397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5+OvsnY+lCXo9LuaLsj5tvmmBLk3LiafYOov4NjRE0=;
        b=XyIkvnWQ0xD2UID2pfqc/sBoHVqBaZ6/eW8fVc5ClKpeUjFSiPD13q+l4PgRz8MCf6
         ieu45tZD0a1dAwm8i66Bki1NrNVn5XmLawUenDH4xxPfU8sExUQ6yAunhTKkwxDHuDFr
         /8WOVtGQLILU0J05fv4wtj7FhlMfBBDexVwkE4z+t+XzojM5TLc111RHcbz84xkifSoa
         orlk3tIOtwp/KwRa+5mowphHHtMtHEKIhjOvz8d2tCtvovpygOR5JcO6d9FPYUYJdptX
         CEG6JFQL/40+9gqVZOow2pH+4qvM5V6TU4ZsrBVQ6dygTrmBaXA40T5W8Oyqi6JD8ZG8
         579Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yWojID/twZ9AgrnITsJzmkWX+1+4HaVjNkLY6YmsQy9TcUIK96cz4bbX9tkt5UE8cPMvAhaYNPZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwt2OZF74m/5Hkisqvn/7pLYVY/+z6tGEPMGZwZkxSJwsC/jy/
	iuDqQZ66mwGjRYhz4kLNH4YGWR5NaelFw7Ztv+JmoG/ReynqtgsX+PUqyomixtJXKuE=
X-Gm-Gg: Acq92OG8jfsyytMPS5WhyKV45K7cHYygzSLeWPNLIBjldj7QSYMix8GTsrH+Gmjgd3T
	sWh9e5vBP1G5EqYtXMd0+xXaFMO23i4BKL7iDbPsLCdR2nq7LYQ8j/xl3vI01f8y6i+qBKcecc5
	R/u5r27DxaasHsIC+uYZjwmsbJyo3iSjc/uvkQH8OV98oIdvK/zHC+DCjAuFiN+1cbhR4/2r/ru
	flpIbpR61nx1VLBp83u9IKwmd+90/L/TYZOTXWgl3DmmBKppIfnLd4pIBcUOQfEmVgKT2q6p6MO
	gejS+0uASDTtb6PiWJyxhFtwdwFZhSFZydZaPGAs4wf1Fx0x9ZofGgbgEJucMb0DpPSFFcKo8vl
	ndmX+COmkwv0gYI6Z9undIigix+7x/BAsidIFmB9WWR1mnFyfBJjoR0Bxr8/3rKeDiXd4F50mkD
	xN9Q+L43LiwfUCMvXbVeJ/tiTct14cue9nux0bPbc4jTs6YDzcjG1J8WWV8Dpg3Pex7fTFA95hC
	Se0BY533Yl/
X-Received: by 2002:a05:6870:548a:b0:42c:5ca:e7f8 with SMTP id 586e51a60fabf-43a2dd598a4mr6913973fac.26.1778974597271;
        Sat, 16 May 2026 16:36:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a946f3b20sm252665fac.0.2026.05.16.16.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 16:36:36 -0700 (PDT)
Message-ID: <ac4f834d-5427-4455-add9-649680660b79@baylibre.com>
Date: Sat, 16 May 2026 18:36:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
References: <20260516211935.36773-1-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260516211935.36773-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/26 4:19 PM, Md Shofiqul Islam wrote:
> The driver pushes FIFO samples using iio_push_to_buffers() which does
> not attach a hardware timestamp to the data.  Capture a single timestamp
> per IRQ with iio_get_time_ns() and reuse it for both the event push and
> the FIFO sample loop.
> 
> Use IIO_DECLARE_BUFFER_WITH_TS() for fifo_buf to guarantee the required
> s64 alignment, and switch the FIFO push loop to
> iio_push_to_buffers_with_ts() which accepts an explicit data size and
> timestamp without requiring a separate scan struct or memcpy.
> 
> Add IIO_CHAN_SOFT_TIMESTAMP(3) to the channel spec so the IIO core
> enables scan_timestamp and includes the timestamp slot in the buffer.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
> Changes in v2:
>   - Use IIO_DECLARE_BUFFER_WITH_TS() + iio_push_to_buffers_with_ts() instead
>     of a separate scan struct + memcpy, per review from David Lechner
>   - Add IIO_CHAN_SOFT_TIMESTAMP(3) to channel spec (missing in v1)
>  drivers/iio/accel/adxl372.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index e375d068a..266e80e27 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -344,6 +344,7 @@ static const struct iio_chan_spec adxl372_channels[] = {
>  	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
>  	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
>  	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
>  struct adxl372_state {
> @@ -365,7 +366,7 @@ struct adxl372_state {
>  	u8				fifo_set_size;
>  	unsigned long			int1_bitmask;
>  	u16				watermark;
> -	__be16				fifo_buf[ADXL372_FIFO_SIZE];
> +	IIO_DECLARE_BUFFER_WITH_TS(__be16, fifo_buf, ADXL372_FIFO_SIZE);
>  	bool				peak_fifo_mode_en;
>  	struct mutex			threshold_m; /* lock for threshold */
>  };
> @@ -703,13 +704,15 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  	u8 status1, status2;
>  	u16 fifo_entries;
> +	s64 ts;
>  	int i, ret;
>  
>  	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
>  	if (ret < 0)
>  		goto err;
>  
> -	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
> +	ts = iio_get_time_ns(indio_dev);
> +	adxl372_push_event(indio_dev, ts, status2);
>  
>  	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
>  	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
> @@ -733,7 +736,9 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  			/* filter peak detection data */
>  			if (st->peak_fifo_mode_en)
>  				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
> -			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +			iio_push_to_buffers_with_ts(indio_dev, &st->fifo_buf[i],
> +						    st->fifo_set_size * sizeof(__be16),

Should just be sizeof(st->fifo_buf), otherwise it doesn't
actually protect against buffer overflow.

> +						    ts);
>  		}
>  	}
>  err:

