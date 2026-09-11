Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE140BCC8
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125533; cv=none; b=lygnAO9FPImPXQuHa094HJ5QkcW1Bza3aT9JnbZs6KjVGS3CLq1cdZQ8Fi2gl+7AJ0Z8L8fk+UL/qoAn3bwI2YVcY2mKd1IECQe5zzlUu9PC6tq4K8NZEBNscfaIwSd9hOpIN6CzWH4zgiLVZj+JKTRLukhYIPhhmwpwmPi0Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125533; c=relaxed/simple;
	bh=wV3pBxQrqLKd1wlVew6gdqs8o3bVNN2kXSEU1dTZDR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxutzV78RlN0cxYrylhH+THgbG2S0laDrp1zkVqfNbI4tOTBXnxk4E7u/TosJ4/errDKvGjtNDAKuxNGCNNjHs9ll9hNqx3hgcGrxYRe3y1cO4hRHP2RKM8J1A6ruifa9TQ7sD7IgDYg/MupvMVB5a10Fnbsgui/ekXT8xyurBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkYCL5DQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkYCL5DQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso12088355e9.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125516; x=1789730316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xHdOC9EWQWOJTpdYs0NFS1/xOzQRIwZJ+gUTthcv/kY=;
        b=CkYCL5DQL+tW0oOT8/vIkSbIF6lZU9z2hcLnIdzOZUtKm2TgbZGTb0qhh/ROcUJtLG
         5xagpA0y8AtYw9QPbYJofKdQEVztUj4hkPrJHWAErZj6qdQna5K2xzfrWuwknH1Ur3TP
         FHO52/axSuKKVh32zBwx1W4PWbyIo09ImfUb3PC50WzMlvHoJNLJgrv7YwYjhnNrlnip
         w55uKw5bftlWzY/FuaAiK8R29Ft6hnG2haB26F5ngA8fypL3zuAZ7tseKX4siP1gZWin
         XwrCtVdA6NzQ2C3gDm75kJA0da96Ak5IlEoED88jcxqy/MrcDNK0rhwNrdai9f6kxjAo
         i0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125516; x=1789730316;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHdOC9EWQWOJTpdYs0NFS1/xOzQRIwZJ+gUTthcv/kY=;
        b=apv9dX99ZxLHrriFyHGvj7JbbGc4T0f6MybX+eutJdj4OKk5S2/IdeCkQUmEKGDckQ
         jWzneO1Keqyd0+KXPLHREVNoPvAbQc0umnkQXW2PcPrD8/Bxm60pR5jVWMVNNzmRjtWd
         D982xI39VaIIopljiUY44C9ey3IZFalORQTieobW5ratcOEnfJ4jNGMDJFO2s19wjXlW
         qpiB8VcQOzB41pD3md7gU1zD63hOGEyXZ8Mmgk6R/0llGS8tzXcylja9/BfjM0vx01Zh
         kRo6SDSEAZABcqG9QRGN1Prm4ZOe4lC2Dy8LqWEFdseA5re2WZab52K9fCmCToYaNCKU
         16EQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4QWMZvc3yhNCeT/T2qVqh2bfDP+5pu5lAAWhOY5QH8YLG5OfRwm38xf0MvY5BkDrBwt0U5OBEcGI=@vger.kernel.org
X-Gm-Message-State: AFuF++lu0/de05vR/o9/66j1lA6hRSD9ItNcOz28IM5kBJf/tR5BwOZz
	Ar0cVihgJqcvItX1C0c5iBGRj1aK7lFwXDtDkpfyGzEoNlC70dbsNwT9
X-Gm-Gg: AYBFou14ZflAcO+St/vIHeR9nV7g7HV5Ip0d1VxyFsjoDqEWuBXueDLqNw0OwZtua5A
	y9y14jNfl27oIX2OI6+RydOfUYQuzpjTZg4TfH3hbsvnWD7XN/hc9SIG7GbnFMP612raVWZMHMh
	N7hkoYXEkL309AJu82tbV3NYRA4s7ZVfZ73GFZ9NTnlOssBZW9+UAJVOsMfI3VsXlUCtNhUGz18
	e/80nEkdnkez5WjGohnRosABCy2FMvW0VLRnTt1ut0t92haorfg1f0UYlQnpj8OKXhy1fD0f2l5
	R1daYo2FJsx4riWjh/3qg0biUf3EZIY3aYRYiTx45fOCzA7+jJPvPRCZ+512py5SEKfOc+izbrV
	4R4DhaFItQ7ThzwHgmsAeRXLoz/BlY0iSAm/EygiOKGGs9vnFod4vSSk88qn5UjejYxGY0YrD7p
	jxfTC8btoW3qV6KkZayI5EXJKUXEFz/6bQvUAF85+vJB/aHe6iflloHkANa62KINOCVtSEg3wKz
	0OPu/t8uYgdRzyimzXLXQSgS6alSx28CwDp4K7s81BMtEuvVcAbwIvXyuEGSxWzhB9xWCmbcTDX
	02IpTt389bbeMkXCLjlg4SaaK+edKh5zF/a8WgjemSy8mUdHLiWZOIkEuyreDHdNLEHyvBxnR+B
	+s58EwXNKmYs5Rk5KrgAei8HXE6u1pjOFFt4bpjIxmnVu7KuwR6FencyCof+LKVA8HJNAMmAudn
	icvEgx
X-Received: by 2002:a05:600c:3f0d:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49e619cee90mr36362105e9.27.1789125515648;
        Fri, 11 Sep 2026 04:18:35 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm5335426f8f.19.2026.09.11.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:18:35 -0700 (PDT)
Date: Fri, 11 Sep 2026 13:18:34 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] staging: iio: adc: ad7816: Serialize SPI read
 operations
Message-ID: <20260911131834.0000514b@gmail.com>
In-Reply-To: <20260911110456.24873-2-abdelnasserhussein11@gmail.com>
References: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
	<20260911110456.24873-2-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:04:55 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

...

> -#include <linux/interrupt.h>
> -#include <linux/gpio/consumer.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/list.h>
> -#include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
>  

Ideally the addition of new headers should go in a separate precursor patch.
(excluding cleanup.h and mutex.h, you'd add those in this patch).

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -50,6 +52,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex lock; /* protect device state during SPI transfers */
>  };
>  
>  enum ad7816_type {
> @@ -67,6 +70,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	int ret;
>  	__be16 buf;
>  
> +	guard(mutex)(&chip->lock);
> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> @@ -91,7 +96,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> +	ret = spi_read(spi_dev, &buf, sizeof(buf));

No, you're mixing changes again.

-- 
Kind regards,
Joshua Crofts
