Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B632DB7A0
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772915829; cv=none; b=pCD2Li1lPdAy7aOn/oUQqRDo9MZOFbH/cRZXZrqjH8uC3frtBkENeef6pM24G4UO9UIB+sQjW0vuO/oDLaRr+unu00CBi920aO/eWXZoyKpR+PHIgkrUzXvbzJXoEWNWTJkp9ooxKVw/eRxoUrRepAbmitohFCyQ6v11mJQpAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772915829; c=relaxed/simple;
	bh=IjBOwiHWwDAplGXF3s7gu2jCw/OhZ6b0Q3mSOOl18j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOo+qyNnrPJCn67MAS0LFqRHGGaHs0xiFTN0eY1M84dn83m1goETxXpIbNJiYp9DGYHs5KFwp5ArvPmxe1FNhc3MysYGqh/Gw5perFeRAC5sZtp2TCYzMnB/G5EaH1w39gSzZNsYz3fCBwM2u7arl4Rr8wtQ1R8nXHCoyFaUC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wc2QxkAp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wc2QxkAp"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4645dde00a7so10463233b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772915826; x=1773520626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuiXX4s6eiDajFGdJAZ+wVHabHyzBcBn0KoLcdMdMJE=;
        b=wc2QxkApVUN3nShXqI0v5ytYcDnm/5eV3KtRXllLFVSYdAHQVsuoDmNkH7y0yDWBD2
         E5WjAjQ4QukNOakGFFTIeq7aHYM5DvQyz9NE1o2RMx37J2YPhqUI4+KyWroNO6QIdRp2
         HjImUKLs1bSuO5pdhLDqqrwo9dqoU6DND52vz9BTY2FZ5t97baZ0Xi20l3LIHIPxWDv7
         2J3s52DY+WPAF0RNOzODDYWJANvCQHVO7XY6QijIGn2tL77P8adUOTJGM80ZwDAd8ASc
         DH2+/F+224KKmbtaxuJPWQOkCfjcCBjJVid1C9D/IIJs49p0qdNhzb5zDtp53DMoitKL
         ycjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772915826; x=1773520626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuiXX4s6eiDajFGdJAZ+wVHabHyzBcBn0KoLcdMdMJE=;
        b=xQaH7EBb99QClXEMB6Zt5Rbji/HRcthbxHSaweHR5XVrGd1F+E252UD+245zFYDr83
         fENb7JNBaGHN7d6YC9JrIjnLpopwFnHLYiK55rcy7wSq8GOn0kuLm6TXTtoVxtPuFyhx
         KoioIkHl90PT4PMMFbUhD9yNcTaw6HYwm3Z5MqYuIJflyaG47znAJQm0M7coPeZCnghP
         YYjqza8Bn3eKTlCtRHE1BYgOfAdLG8YYmUEq4k0SxaNq8L6zCFz+nsqPh0Cg3BIQJ6pB
         W8Sa4d1ZeboKoYGdgovaAzZNBkH6BnwgpTvYmxu6xREcboLIfGnR2kcUPoFlfAityqSi
         6eqg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZMtndZ73p3yaPpV17+ekRev7MlSxigMatwpTmPAZ7+aqGHupiWVwW5lW9MDv1Aj5c6atLa+e5vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlW9MZ0s6Kj7vHNDU8YaDX5DpYaKdu9ZFMUrUCi5izsKLSC651
	FZNABYOr9pyWQZr3qL2T26+hzEqLBVcVelwWMsGj7lT1zBy2UtGgHKQ218BXkwxIxXw=
X-Gm-Gg: ATEYQzwegSinAV4Vacn42iv0mydEIc2orZmYcLFb2tgLoihfC0mH29b1ABSdtqGyk5/
	UtmuadwCq4QrAr8hGNyIvDs4hhdI2VTOUq7AoL6eM73k13PHnBYg4gNrOjKpTrddO1fqaM0sKVR
	qmZO7NHaaku1l4cqCNQOyZFjOSj3nxWlJHm+/ztPlPxgRCWFo8xx1SNNWEyK+CXwFRtZwIVonnp
	NYhWDBrObAbeUsOw35vpek/o8eqasMES0KwU0Oi0XqNzhMEF2IZoiTpsU/1aIKeslGPpps+ZHER
	1NflPPVZyMbPuiVWI3Jo0EwgITnnGaD+4e5VXa7ERwhGUjPlglM1hWnr9gM68rZvDeVy7zWqs0G
	YDMMlEG73/MDq8X47kimqzyiML1aC2vxaEReJkJh0MCfWNYU0mMMuT1H0GpQ22xc+Bayxy7O9oC
	4yxTESv/G4KKTKy/bw/tmK594KhFdAi+yYGdBvlCSgjFKWg32J9rdyLyz3Bsi58enkqmDuqAtN/
	Q==
X-Received: by 2002:a05:6808:e803:10b0:466:f4cc:2b3c with SMTP id 5614622812f47-466f4cc81a2mr696529b6e.8.1772915825738;
        Sat, 07 Mar 2026 12:37:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm2918496b6e.13.2026.03.07.12.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 12:37:04 -0800 (PST)
Message-ID: <75a16958-8a14-48e9-8b86-03d9797f3d4d@baylibre.com>
Date: Sat, 7 Mar 2026 14:37:02 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iio: adc: ade9000: fix stale data in waveform buffer
 read
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302072001.55737-2-giorgitchankvetadze1997@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302072001.55737-2-giorgitchankvetadze1997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 1:20 AM, Giorgi Tchankvetadze wrote:
> ade9000_configure_scan() always sets the SPI transfer length to half
> the waveform buffer:
> 
>   st->xfer[1].len = (st->wfb_nr_samples / 2) * 4;
> 
> However, ade9000_iio_push_buffer() iterates over the full
> wfb_nr_samples, pushing twice as many samples as were actually read
> via SPI. The second half contains stale or uninitialized data from
> the rx buffer.
> 
> Fix by setting the SPI transfer length to the full waveform buffer
> size in ade9000_iio_push_buffer(), since the trigger mode fills the
> entire buffer before firing the interrupt.
> 
> Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  drivers/iio/adc/ade9000.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index db085dc5e526..c6eb06ef8d37 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -804,6 +804,8 @@ static int ade9000_iio_push_buffer(struct iio_dev *indio_dev)
>  
>  	guard(mutex)(&st->lock);
>  
> +	st->xfer[1].len = st->wfb_nr_samples * 4;
> +
>  	ret = spi_sync(st->spi, &st->spi_msg);
>  	if (ret) {
>  		dev_err_ratelimited(&st->spi->dev,

This could use some more comments in the code to explain the different
code paths. I have a feeling this isn't the ideal solution. Writing
over .len in a separate function from when the xfer is set up is
a recipe for more bugs.

The xfer is set up in ade9000_configure_scan() and that function
has an argument of either ADE9000_REG_WF_HALF_BUFF or ADE9000_REG_WF_BUFF.
Could we use that to determine the correct .len and set it in one
place in ade9000_configure_scan()?
