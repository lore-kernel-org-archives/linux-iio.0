Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70D35CBD7
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469077; cv=none; b=efFwdJgjDwgTVlPFWyk02hW1F4irkk22uAJXCKYWPEgqKF/J2PAOsqpA2XXs7cNPNTvRlStAtDrAnqN0M9Gq+F4Wog8H99UWHqtTms1lFfvBqKd1iSDJRPFiJPfHoZKFO0Y+RuoJY0krK0MMm0EDegIoUzP2VZrM8+luVXu+DGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469077; c=relaxed/simple;
	bh=qLsyFY2PisIQLMl+fOtmh+GE8NpLwMnRWMFJshDHLT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKTu2se/lDGFt4syWZMNgjopfe4gFuPUHQbZ4LqNyXjNP9LzMcIpmLfzDC6RYcrTXIfUPTMq8yBKdXKNjwVb8xrEl0O1MBU9GSKrTDBNiQZ2XQ+c5hP/cqUKPtrLDIoDMbZQz77TH8v06iMqr7cVgdC8z13K4u6Ke5PgSdkaCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g80OEKGw; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g80OEKGw"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d598f60eeaso3057768a34.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772469073; x=1773073873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0JygeW3HP09zEKnP/VD/fOu2e7U19JBgO1ed/d8lMc=;
        b=g80OEKGw7xlCSqpskdiHQHtCWfyRBVXY6qcBEgo6HI4gEe5nXhPiQM6TiZQR3Oh+AB
         l/Grdbx+hwEVu7HfO73Dk51X80w8oO/1opXocxI7gA/gyzeW918J65p+A1N2MC5eRheN
         et/hLl8LFrrhOGsT3tAHJnzvUo3nQU81OEin2NA/i5DfCml4qEaata4Ww6oGRpzNf+LM
         UGVAzPXv8z6dvMTiu6u+Jz1UoLC+/IWAZGOlFTBD5eATXp4uNJy+0t12YX/d+562FMAX
         V02QjWDZei+RkqeIGutb8pB1terUD7INJzCn0M9tc3AdStJmw4tex+2v7+/lb9GEB/UD
         JzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469073; x=1773073873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0JygeW3HP09zEKnP/VD/fOu2e7U19JBgO1ed/d8lMc=;
        b=JC3FtMt2PNV0GjQ3nKTDhbFKwIn4bVuafUGLfYWNbOy6U9/0OGNSszH1RoUg00tDHz
         fmPlayKyOnClPozfD3Mt6d+lgXHWyFC+soWcWx+5BSaJwdtsWFcYFmUhVMLuMOKrFNEi
         gGphdq2USOn0z0LR0DxeCIoOQT3EAJD9564EMInv2HBEuRIK3/szGlF+dRxD5uzHMZil
         pk/KFhqDEWDzPC+CzwbWSepMvsT9RJxoWMgFumHkYx6/GTDoa5nTAZkLK+tl9a+Y83bC
         trjxGEoBEZxJYa9pOpYqaIK3uTUJmq6TKnGiKYYYrGri8BoqZzqmmCzI55ZYoWmdqAda
         B2iA==
X-Forwarded-Encrypted: i=1; AJvYcCUBRQ9U6l6Sv85FoNNjwG6kEV5aiOe+c9SdcjSIWQEKxYOxH1WZ8gm2eHu6QJeucvhwFVOKtWEJlM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvNkuZWBcLWG5smrPMeAos7uNzo9ajqTWam+4aOEYKwWKUV9i
	SpErvtkogHOrSkbPI9bDGStuzASOTh66x2UQCok0ucpvy43nCUE+0L4O4e46AmMilXU=
X-Gm-Gg: ATEYQzy14k1D8VaILv67qm5MRHHz73889ufX8YHAbWuAqjRkdx/T/sZIk7dcLZamexK
	gN3ufcCo4ZZ6D8e6bkdh121Gr27IPaxsCs2O5CwjZytqysZUjTVfvh/r7qRnay4svzJvfytCMAg
	MsLOORyZ/Fh8SGtv1IHEmC9JI+4eYWj9/T8I2QemxhjisynS1e7P6Lf59u0ryKHrfmE9hvq2LYZ
	9E2w/E7yUJaxNRz3rtIzeZ+rviDJRc58Oh9Z1tvgzUrAQ6QxmU3uCdIac/mJ9m8dpTs4XbQ7ovF
	r+bghfXEnA2odn3nLwrJ3Yq8nQ0Cu8or+PEejoV3wzbciC422tD6oqViXqNw4TSDPrnxkuv/agz
	OxbyUqUWs2s1cWhL5OMksB/G4/lpTda0lTnhRQI+IzAUtzmCgYRagvppHokNsx/hq6jXGnZZYMr
	82/It0Dpg1x31jYwfMUxL8PRiFf8Ura5o+9C+MJrC8gftJGtEvwUfFc3YoTEyyiQDWVB781CBYJ
	lnIy8FsNpvB
X-Received: by 2002:a05:6820:620:b0:679:efb4:a396 with SMTP id 006d021491bc7-679faef89eemr7688750eaf.35.1772469073280;
        Mon, 02 Mar 2026 08:31:13 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2da4390sm9443084eaf.14.2026.03.02.08.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:31:12 -0800 (PST)
Message-ID: <f1438faa-6a4e-4d2c-b76a-d9903653e238@baylibre.com>
Date: Mon, 2 Mar 2026 10:31:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: adc: ad799x: make rx_buf static and DMA-safe
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-2-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302130632.29144-2-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 7:06 AM, Archit Anant wrote:
> Currently, rx_buf is dynamically allocated using kmalloc() every time
> ad799x_update_scan_mode() is called. This can lead to memory leaks if
> the scan mask is updated multiple times.
> 
> Drop the dynamic allocation and replace it with a static, buffer at the
> end of the state structure using IIO_DECLARE_DMA_BUFFER_WITH_TS().
> This eliminates the allocation overhead, prevents leaks, and removes
> the need for manual kfree() on driver removal.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---

...

> @@ -217,11 +218,11 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
>  	}
>  
>  	b_sent = i2c_smbus_read_i2c_block_data(st->client,
> -			cmd, st->transfer_size, st->rx_buf);
> +			cmd, st->transfer_size, (u8 *)st->rx_buf);
>  	if (b_sent < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf,

Don't need & here since rx_buf is still an array.

>  			iio_get_time_ns(indio_dev));
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
