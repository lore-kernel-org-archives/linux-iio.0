Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9371427FBF
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764981; cv=none; b=Z3qbvYd2noWw/BfvjO8O3OP8DvL6rRSd3LIlMvTHQrxzG8mySx1c5C3S4Ve1uP9DodOdiDv3sD6rDybfAm4AOg81ks1bjkOVmKwfRqmkuMs+OWS9a0oF+RWXLhGwaQePoH8Q+Re6S8ZK+8TB2GcLUcTDuIy+cx9AuwaGUhnklUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764981; c=relaxed/simple;
	bh=0sVuVy30zvai5kKbo3WJN7Jypck4UVRGwg/D/OjuGTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVVSETMadbhGlnBMY5J4yMW1w8BPGFLFPh5FdGYtMHr0+QWtRLRsahDHhNU8SCLs46zArW7615osMA4uByIAzEW6BOecq04pyfxKWob7pgRqnahYqHFPxspGroPeN6QE8YmgAt801Awxr8XaiMzfQfDqlNARmt5Rez8Nd6bkUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNF4iQkS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNF4iQkS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49800c6a846so18562405e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764978; x=1786369778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vtm/qhV7r620+a36+fltihLUGsMjtPQRBYKm3XNynmU=;
        b=sNF4iQkStX3e9dBht6ulBOQxDO98xEK7xgzYYxZ++Tn/eTpKxl7S9BkVUQT0cxH9Fu
         cG3oRaP0erkc34z8DqR/s7zGWryP7oxTfO3yQNFxoCgjP3OeR+ZxLYfhmC9BgU6OFhXt
         bOW2G8NaBMSdXAyvez/Z0XMtbBPiYHeakdqEpdaTsuUuQsRvaH6mtwR2mLy0G4xDzktH
         AADbcTs2lbB/+IpEwMJClJD2kcwXPrn2cefEof3CoWvHwqxdBCvoHXCIX/HOutYkPXph
         scSPqXlkfkzKuUV5iwlv3xZexbT5PQPocVnWhlY3EGYHn+iZWGyjj9vqBnBittYgPSEc
         nGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764978; x=1786369778;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vtm/qhV7r620+a36+fltihLUGsMjtPQRBYKm3XNynmU=;
        b=Yk3sT9QFDt51nCC35ww/ZfKqOnqincmr0ylLoGRo4xJ3KT+E4WPE8YCtcSURloW6Y1
         L9EZrzqf/U3OaH4nuT3e7htFfrIBP0Cr/fK2d9QXCpeHQgEGTWfa/8fCrUxr3QHX9BMp
         Ra9SAx0I4gQ3/OWAOf1QY6TttUtN8I07VJXZZMplyv2TBx9O3ZqI6gTaYPGvfvNUCuCQ
         bzykEC8jt+1f78NGquLeT5t7c5+Bke9YSREoS8g2YTehY/tz5GQZuP9Mde9r1c3cpKyD
         /3M3nBLO2EaSseEF0A3hLtgVF2uZR3bvvrgmb8HU0jkbK6VHPpe/QdGDZ/TjzeT5lw73
         3hLg==
X-Forwarded-Encrypted: i=1; AHgh+RqgCphQ06EIrLHfp5jiTILCdCZDJW9RiYDxaEgXwYql97umjliKphfpKVHRS9HgezmOwTka0LtS+AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAIYbtDp0ETjyfjF4v8hxEMlY0MmcdjzHQJkHu4TjvheCIaie
	YxwYSl6ZjLD/QPeKHo0sKUKlfIQcnZsvbZDBy6mYfPQDSrOjLFph5qBT
X-Gm-Gg: AR+sD135a5oIlAPJzCVX5zy2xRQfNl2+b8uwx4bBv3fbJmWJHbbDqymLuZAMXl7wdvE
	Z0mOpz8Zi2fd+WFis8VOcGNoyy/DU5dsD7wWHRa79cdGTHaEfEZc1WlXcyKHZX7YztQWIWQme10
	WD0E37WYLhy20VLhz0wrlPfUavaGbSVTiRyYuqiLES3sKV2gO1ybzHy3dRFcAoo/u6hqDeRxR5T
	HMESBjxLNNLH041wbLVn/4anlS5mWiVWvo4B7qbbfGpKjegz3fu0n9nERsoIgctmTOLb0FSxNIO
	RUQz6xjlQ8Wrfn9TszpF30xsoJrs8POSOqxMXCO5j13TfqyMbgCrc22xWRhDF4tmSlnJ+t1AmUf
	tYgfOb82RvipvEu41WTIOWZf5AcFX3OlPMBEsbvu7BN21B4l07o4koIEYyephN4qEV5ehnKQzZR
	1lwAzEmGxpE/bZzrdDD7BdX58lUY+ybNPXcXkdggE/Xw0EdILgANIOBHrNnYhGO35og/kvJJ+KO
	wWYZtqutacYpLj3ulOjklTnvtUmDfweVC7kN3+/DPph9B2GpYm8AJ294/gilvL0YO+FPv2g6F1h
	pKKfvLedwjlXE5Okvp9aOMs9lvkh61L3CagXM5y47iw39cxeT+qT1t9mogdK1JIXaqP9o555rl5
	jukOrnhhFKP/cG/SGmmWCCKZYzQlk+Lu2uC2W52+qqI+vpWCYTiwmGo7/S8UWG/mkLppGSRk=
X-Received: by 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-4980c6747fdmr140518405e9.15.1785764977771;
        Mon, 03 Aug 2026 06:49:37 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b917efsm367415595e9.11.2026.08.03.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:49:37 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:49:35 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: iio: ad7816: serialize
 ad7816_spi_read() with a mutex
Message-ID: <20260803154935.000014b5@gmail.com>
In-Reply-To: <20260803121520.6274-2-abdelnasserhussein11@gmail.com>
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
	<20260803121520.6274-1-abdelnasserhussein11@gmail.com>
	<20260803121520.6274-2-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 15:15:19 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The ad7816_spi_read() path performs a sequence of SPI transfers and GPIO
> state changes that must not be interleaved with another read operation.
> 
> Without serialization, concurrent callers can interfere with each other,
> leading to inconsistent device state and incorrect data being returned.
> 
> Add a mutex to struct ad7816_chip_info and hold it across the entire read
> sequence to ensure exclusive access to the device.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0e32a2295990..b5a0c2871e00 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex lock; /* protect device state during SPI transfers */
>  };
>  
>  enum ad7816_type {
> @@ -67,11 +68,14 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	int ret;
>  	__be16 buf;
>  
> +	mutex_lock(&chip->lock);

This patch would benefit from using guard(mutex) from the <linux/cleanup.h>
header. 
> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> +		mutex_unlock(&chip->lock);
>  		return ret;
>  	}
>  	gpiod_set_value(chip->rdwr_pin, 1);
> @@ -94,11 +98,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	ret = spi_read(spi_dev, &buf, sizeof(*data));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI data read error\n");
> +		mutex_unlock(&chip->lock);
> +
>  		return ret;
>  	}
>  
>  	*data = be16_to_cpu(buf);
> -
> +	mutex_unlock(&chip->lock);
>  	return ret;
>  }
>  
> @@ -359,7 +365,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	chip = iio_priv(indio_dev);
> -
> +	mutex_init(&chip->lock);

devm_mutex_init() since the driver uses managed resources. Additionally,
please check the return value of the function and just return on failure.

>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;



-- 
Kind regards,
Joshua Crofts
