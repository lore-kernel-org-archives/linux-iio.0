Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4EA3C09EB
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478204; cv=none; b=qAdWGQ1noI0tHCEhPWVTjiOekAKxrI9m+NNsHZYdEJXKkI71qolXjZZ49U59lrf9zqh5bUsiHRrEOcWBFLZ49Ih4CIAvjyK6WsBh4AOOsXPgjiL2uukb5lgX2pzysx/9nuCe9OSU9+7yK3ao5/Et4TrjMgnwcPNeQVluk9UPHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478204; c=relaxed/simple;
	bh=usQ6otGy61tea2/+SN0kWeGAn4CCH12vYdkTnhTHXWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8VIpLezMRUBzbO++q1yd+OI9V6yUJ5r9CpkhVQEx7pt5gWXvIQ/rNqwysae0hAuZM+8mUs9FLkklnxFFawfRQiNC9DLaLkv838WtSMIsaM2NeP3w5bEgDzK1JdT08LE3m43dxOXwkUf13fTh/OvAJtfinmlhpeIhjrB9Ie7AJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJnhYlRU; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJnhYlRU"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so15331255e9.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789478200; x=1790083000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yOh4YxsUy9cnJP0mnCeYYmhsQkJTthFN6MeVe5U5BCY=;
        b=UJnhYlRU/5gIjw4B+i5fNFyGDdvGac4qD0oSJLTa1hxb32IdKLnWoG9AsEEffHOwFS
         bY5ODFPDQSWAycunF7gGXt+RUDrxFjcaRZxFo1aJb9UngFYcDVXTa5GVdIEhunjscQt7
         EKm6yVag/XgVqX3t/d6xLjxaTkGJ0VwSeGBZjRB2ip/TogwMfe3Cnukb/pDm/+HVEZn5
         xlamzWwZW5Tn9LzXNd0xi4PvVS2g2Lo4rbd5CgxOBY2nrihyER2QKB1d5lKkFrFXdEFO
         AlkLzFmox/Wank1DwRPAelxSeIQMl9mU6LycvQyPssLMF9e4MQoqgyv8k22H4CJ8lby5
         PCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478200; x=1790083000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yOh4YxsUy9cnJP0mnCeYYmhsQkJTthFN6MeVe5U5BCY=;
        b=ySwToP3oZkX0BnDeSbsQ3VrgBkmZiL6AiCHgfqVnBG8XqVwy9iZRvwS/j/JRvU1wsb
         EbXWZ9vY6WfzgW8SgVDraPuGPsHlLBNhQWA1dT7+/Odo/8O575TGYeAG6YPaGuYvR3nd
         D5ekWc+PlDMn/w1IZXqDNpyJcBVcY40UFnCeOuMKOJAwwJALeh79TVZvVlWKqyOPxlsr
         9jo7sS52meUMvpwnQkPob4SPwh+O2h55pMVPumpTq8+fGeYykcUd8MjPcCp1lIgVQOiY
         CBaF+TwqikA5QJmxBS/Xbvb+nnvUl3L8YQ/OyUtNwS6bAphg0X2rlrQUoQCRc2G4tgPz
         m77w==
X-Forwarded-Encrypted: i=1; AKwUvBz0jNDItJffLatiq6RRJtFJAJRgzmxvEgd1LCTJcIRKuNZFsvT+IkA2btxw9rIpj4RATMdDwqL2HEw=@vger.kernel.org
X-Gm-Message-State: AFuF++kN+92XLc+5roaLOXyWy39BAV32SWiCcAmIWy3q/LzA46XQJwCs
	QJIGEH1gy1ns/gv1jwFjlyFFLGMHYFBquj5fgVz6RdFsMOSFwRamgkRo
X-Gm-Gg: AYBFou29W0XMUx0Zto99kwQFyQN+dTSfx2Hs9JdP9dXSuV/9BH9L+mrB6jXrv//GkAV
	rOcvox31xjXx1RWCmfAmqPxWkfbJEOHFBl/IIVBkFpxvvaC90RHr2OE3lNC5qhAbPCMBz0e9GOF
	0ewDfIU2R8xnmbYVgcyEXXPSJKOQellDPzDG+/Z4rjgbxrBANU4Cz+XE/DiuHSrhaIrAsxebzjx
	Pnzy8UMNlvkqJggBlrIVNsfTpbYqZwzvwGpfmLPV7wKq8NMoempcsLAU7y3KRN3X90PadDLeCLM
	f/EjvKNRa5oTV6Y2gQhPLgd/EOOrF5WjBuI+Lji2XvPAnUj+Z0jDOWE4G8Ra6Xoku2i2TB0KMWR
	A93hE2ymmxH51u8lL09cIsQotdG9/02Sg/RAk5ZstGnaRc1QmGvMqbuYgs/1wUTYWENPXXnn/Pq
	rf7b7w2uGswbKG5rAzH5WhQGB2moua+i23BgLx1wugbaHsutxOZcFgQKfH6WbZRpipjWAbF/tiy
	LvImgiXCe5jUGjZ775w5BbctbeZHU510nGIhIOXUhtqglmDGMh+fbH8esOUzdbG5C1R77a1o6X3
	cVxA1PmU34YcHinQ4tagPHJGOyhJzULEpYm4fdOdQo8tKVH1Al9aS+xQpT0vtaGoHuQJVDOB5Co
	fHZpy6vWn6zr7h4kjPLhTy/Ucq6qnYLVOL5RVQE9MtDxFj9R9V7CJFOs7lFPNXHpfCz0ozgC5XL
	uaqoTB
X-Received: by 2002:a05:600c:81ca:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49e7a69ba24mr89660425e9.33.1789478200316;
        Tue, 15 Sep 2026 06:16:40 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef735cesm65466155e9.6.2026.09.15.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:16:39 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:16:34 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] staging: iio: adc: ad7816: Serialize SPI
 operations
Message-ID: <20260915151634.0000787e@gmail.com>
In-Reply-To: <20260915075939.18180-3-abdelnasserhussein11@gmail.com>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
	<20260915075939.18180-3-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 10:59:38 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

...

> +	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
> +	if (ret)
> +		return ret;
> +
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;

The patch in itself is fine, but Sashiko points out that the mutex
could be added in the ad7816_store_mode/channel() functions. Nevertheless,
this patch only focuses on SPI transfers so you could add guards to the
GPIO functions in another patch (I don't think you need to send a v8 though,
just another patch after this series gets merged).

Does this newly added lock also need to be acquired in the sysfs store
functions?
If a userspace process concurrently writes to the mode or channel sysfs
attributes, the GPIO pin and device state can be modified without acquiring
chip->lock:
drivers/staging/iio/adc/ad7816.c:ad7816_store_mode() {
    ...
	if (strcmp(buf, "full") == 0) {
		gpiod_set_value(chip->rdwr_pin, 1);
		chip->mode = AD7816_FULL;
	} else {
    ...
}
drivers/staging/iio/adc/ad7816.c:ad7816_store_channel() {
    ...
	chip->channel_id = data;
    ...
}
Could this concurrent access corrupt the rdwr_pin state, chip->mode, or
chip->channel_id variables during an ongoing SPI transfer, leading to
malformed transactions or corrupted ADC readings?

-- 
Kind regards,
Joshua Crofts
