Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220C361DA9
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703584; cv=none; b=fRNVooqQk+I69PrbuZ4D5UZM0ENT9J+YpMfO74jnm6nWq4BwPUghRY46OwzGoso0ulWZhYyEvaymUB14gTRruuQzS71VxxMhUbtYgoFjm88coKphlS1xpx98ufKp425Rl4HsRLaWs4hbiWMrXpsFAAqt2MeEaGTJ8rW3JjwcC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703584; c=relaxed/simple;
	bh=tI9FVh3+xvu74Y2zPQNif4JKysfG1IXGu46QtIN+5WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnD3kxlsQPix4244aFjuFY8WNOe2xar16UzNg52SEpqvjL6D1PcY4PTcMNgeKySjajoRnwBUD6gLp/UmXZZryV9HGxS5y32NKBiwVfoibIguuccTDijJ0Dull2cMLlJDQtWDhk4p1vbuJMxGXy4R5sXeJPTF2WAqWeCDjIYFfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDlUIimK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDlUIimK"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484374f54d0so1449966f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788703581; x=1789308381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gs6/YbhXKRDZGsRYZYKBM+a3pqzRoKUz45XvXh/D/hk=;
        b=qDlUIimKoWibq3/glCA1tvDeAfxICc5/mYBjdVuFuNQN6WbFubm0uMr+svx0hPfc/z
         sM02Iqe9Fn/t+nubygULNH7ez8u37TpvwsH/hxiRoyUxY3Roob/rw+18KTIO27Lg0fpD
         9kzb7SioV6BE94TKubE8ZOeRQepaXNHY39jDstwLfB2D1LrkLGQTT3v4nHkpyHNTD7pi
         TVoZz9vaOs79c6AyUYZvbgCYi4pZ/V0EZajxJCGCzDCGrWeZdpIMw3V9XMN1PRDk/V9W
         6lJ+IbrQKgaSidooik0x4xxok/OasUOqmMPxCvJeiGurWIaMHZu7VgJ8hPB8BaK/Yvqo
         7e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788703581; x=1789308381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gs6/YbhXKRDZGsRYZYKBM+a3pqzRoKUz45XvXh/D/hk=;
        b=QLPPwIq8W2zCRBd217KbDV2ioQO+M6CUqaYrqgjNzdJpHVvVDLL8UPtiUlkS7KZKdK
         X/dgQv1l9slOcwgt3vMzRE5rTqSgqCqwpEDGswha+Iu05enNMwEHWqQ/NouNEGbWkNn7
         pduMTooQkZnMXA0Hd9qrZa/zvW1u1YZKZS6nNfwl0Me5bjNKfZS7HPJHjXFiYHRb7S9X
         QN2uPHdQ9hbigapFF2i7D/5RZccdxTlzE+mkUXTNU+oE4trE7jqdLJhSZUsD9It3Q8Rh
         aef3gH/55nZTOs467qj6CQ/hOceG2vrHCvmy9Hp453MJ7mXpNVRC3IY/KrTQWwwjxALC
         AZTg==
X-Forwarded-Encrypted: i=1; AKwUvByjsN48PHiqXdvtfXfMBcIU7trVH/788AMg3YyrT0Tlme4EEaJXVQ/+SbENzCIhP0KzWpFm8h96aMU=@vger.kernel.org
X-Gm-Message-State: AFuF++kFdQL5Y4iSt0hxr/hqgWlcXGencjxmtq69AeA0azj/Yg4StnLP
	Hqqc3WXTu534SbYPFHM1b8myi/4kutt2vd+DPYIvCyLRVsE+QOjZPPEt
X-Gm-Gg: AYBFou0fH8odZc2RTeFWUKvSi4q+7dPb8XSTEOaxHZNXKh2gxq9ZSDoXZnIoOghm8Vv
	an05YsumWsgo8+Gy0TDVIOiWyaX54av6TsXG9g6pLGXtbdG05epBFJyzoww8pgls/zt5QkUBscS
	D4vA24iJMLtc9tg81EkpbMgSqEdsbLTmlBg4/ziXtDKKjBplh/iRCgZ4bTWDnIOXTmYdVRKByHu
	tBdoZT/RrtXtcRWd/uEhT42RIS2+XDY3gh6lKD6N2CgFUJfLNdYiID0dWa/JjkOfWY1brp9vYZu
	pBpnD+62F1Vc39q03oUfXzklm5J6cYfGzMYi0tTb/suDjC34FJrRmaX1mozXJgHggIivqmmutSE
	3ooVzTBdDb7pyqFf4BMabBw5JFYJWIPfCBViA389O5GF2PHJh+U0jalZqfRvmVO/Pjxyx03Fcyu
	HTlS0S6mzALuImcBUXd3JCQYcI4FXNMDHlOg+kKAV1Yohxjt5I1Ywgexnhi0B8FOol5bzZiCr1x
	/vMmXalIyzx6Bqk+UTOy+kYCOcuUpY+DEzoPqOMYTY2rSrxMnFWk6351LLrnHUhA2KTmd7deR5r
	fSuLcOxM6cwYFMySjmB/OBIe+zXbvgOIBLk8YOeRdyZu6T8L9gLpe6FOyvJB9SZfJalwOJ+QlYZ
	PiByIe55TKrXI8haUfiCFd2a97/KiUgrT4U6vTfVfbcqIQZOWruYrgUh46Zrg8O2H/Fsl
X-Received: by 2002:a05:6000:29d9:b0:484:3310:710f with SMTP id ffacd0b85a97d-485872934dcmr27595134f8f.27.1788703580544;
        Sun, 06 Sep 2026 07:06:20 -0700 (PDT)
Received: from systembl0wer (78-80-112-223.customers.tmcz.cz. [78.80.112.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883927a3sm16599300f8f.11.2026.09.06.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:06:20 -0700 (PDT)
Date: Sun, 6 Sep 2026 16:06:15 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] staging: iio: adc: ad7816: Serialize SPI read
 operations
Message-ID: <20260906160615.2fb5555d@systembl0wer>
In-Reply-To: <20260906114049.32912-2-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
	<20260906114049.32912-2-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 14:40:48 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Add a mutex to serialize SPI read operations and prevent data corruption. Used guard(mutex) and devm_mutex_init() for safer and automatic cleanup.

Please wrap your commit message to ~75 characters per line.

> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0e32a2295990..ab80b3a889bb 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -14,6 +14,8 @@
>  #include <linux/list.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/cleanup.h>

Even if the header list isn't sorted, try to add the headers
in the approximate location if the list were sorted. Better yet, 
you could send a patch that orders and cleans up the include list.

>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -65,7 +67,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
> -	__be16 buf;

Stray change? I believe this goes into patch 2.

> +
> +	guard(mutex)(&chip->lock);
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
> @@ -360,6 +363,10 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		return -ENOMEM;
>  	chip = iio_priv(indio_dev);
>  
> +	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
> +	if (ret)
> +		return ret;
> +
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;



-- 
Kind regards,
Joshua Crofts
