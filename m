Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50741D226
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751411; cv=none; b=SLi7pBEx0/cMrhfj24Hvk4zUMtX6qU/XUDfUuFUQvqgWBGr1cvCnSy2PKabslaljwsPHkCLunhliqZJAnsNn/+Vycq8cLUS3wzS+uPh4u/YONWc5IS+G176CoMlymPwH3nfTvnkfpzQu/PgVnAGlKpM7iZWdBz9VxxH2s5Bj17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751411; c=relaxed/simple;
	bh=+fxZlZKcmSzpMyXlmu9ij0waNERL2gFRxhZvKqLEvEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKOimA1gXzrm4RflJ/M49n51MlYITMMOzJ9wqtVXv9ufvWiE1opxkbeFeCbs8b2MyZEAG8GCL660i+yYgF5rKudqY5l9PYwPlYPOavucHQcY7wlunIFcouwXwjMiUMLww8jXxqPoRWc6IkTViV8DV5LqibMHNtk6j4FPS4ks1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDaAn6eJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDaAn6eJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so30280185e9.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 23:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751402; x=1791356202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yuHgAjHOVltJdZTQWjHDacQSlYBFWHEKS15iSGeBiRw=;
        b=fDaAn6eJE+OigXn54lWTVjyaiFZYNP02eHtVLhFZ/K0GSvLywAjaOUscRvr/WJ6Hjn
         jQPs640a/iR/IvLr5mrvFMJ/ApxsUDt2NBZ0ofp3r7ziWq2wwYIwHpxnoPlmq2lbk2SQ
         D0EBYP21/fYguasvOxB7cLQpRoyufw2zetdUtxSxh/1tiOn35VN3pX1VNbljPDID8dCH
         zVPXSTbpeI85p6qHu1WjBhLS8hzpPhjZieDN6yonp3n8Fddi2O9zXLDOZ71DBQWXIA/V
         gCmMP7nqc/zQDrRonnqSam6VFOndd4WOwOYiUbLSEdbNzyzRPEFt2ZT69AQRHeXnPoj7
         5pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751402; x=1791356202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuHgAjHOVltJdZTQWjHDacQSlYBFWHEKS15iSGeBiRw=;
        b=deH5jCODg2R664IevfQc1llbo7i9IzVlf0hC3y0j4Klbk6V4fR0JpEvtrS9X/lWmT6
         HyR+JmeQxMrFo+KdwxaX5kr2KaIKSDB85lkt7REV53ZAU3QPej41THH4rnHJOQSmINxE
         NRfnwMLiEDgqEZOZsAtGzUxmefspqcgH1RcHm81XbTziIa7TRSJ5cXu+QRb09EXKXSzd
         0PWjpwkAAfZaZFHDbWeOpXShsIqesoe7PKOW+dbP7Z214BeNqdod0TXA/QKQIuFm8c4v
         fwTn0aG4Pn701edpa4CpnJC4DS1ors0kZHxbx09LEs3Pc9FlBiRdOFzYkB9yCU3pn6B/
         4pkA==
X-Forwarded-Encrypted: i=1; AKwUvBxnRFUwOYw92zau+G4cel+fpOczJ0fYd+8ANHVOqxaC8mGgTQW3Nj8eJGrkdOlT7MpY4RYsmC4dWh0=@vger.kernel.org
X-Gm-Message-State: AFuF++mmT5CzTbMco6ks+KHke+3g6mJBgzORbiAzlYL7KGrsRzL+vZ8N
	QvJYYEEGn1ZjkufHC4G3AtuZrt+P7YYw8O+8CqDuo8+iW0/I04PPFovr
X-Gm-Gg: AYBFou13tUsx/vPGkc5W/mgS7W58qCUhd3zZH2i6lg8hQe3bTVIGqHC48XrfDHEU/pj
	j+cf3auo1r15WmGJF80bmi9GtNEts9/TnHbR49dikAK8ZOjzrOnj7KbxwaAqgWTF6ZIyTtvSI6l
	Rx6Ei7tffH7rQE4RWq6k0cHHlbHhpgB0TQ2Hz++lMWCdoCERLbuwuwoNqpTlJt5sWH7j9HaUMbB
	5JWWQDNXrDj8G0WKTwDgBw9RBXXOQSUaYnkASXlfphMv2LAeLDobhx8EESFJ93970KTi8NNiZdv
	D9GcHJo1PS8/7IDbp61gxtV+6aZB4UNzI4E4Z2EV5X499/xMMbIj8RvXktoHxZHhnnHFqaPeztq
	89RtwQ9G41hrs/fTJWQk893f8fIVYYt4my49pa9xBq2lH2QjiBeorcJrz1ivYhXtA6W05Zkg4QG
	xkzl8v19NyAxNAdYh2VB24/jHtu4VTYpujsMnq1MDhrc70QdPDgLptOilTqptCKj1kOO7y3GUgH
	Hc/PerJ6ez7Qd8X6V3K4khHy8w4PKuRHi92oNEWAXFzulAGVTljcvPpL72tIR927lqjReWd1+Dm
	jWaXXub+qRBdN5dLczk5cFeSZ6fEZupw13wq8W6Vg84ig7AoTLO4qU31vnVbwpp9UGLCxSXIOxG
	GaqtAqRMAQsuMCIkyIGYf8H+ecJ/6B7HD1/r3memirpytnf4HwzkpCxkXPKFwL65h6uqNzrUibG
	MkxUpbBRUwZjyKQIo=
X-Received: by 2002:a05:600c:1c01:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a01aff256fmr6408235e9.12.1790751401995;
        Tue, 29 Sep 2026 23:56:41 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e165fsm34856325e9.6.2026.09.29.23.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:56:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:56:40 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, error27@gmail.com,
 narcisaanamaria12@gmail.com
Subject: Re: [PATCH 2/3] staging: iio: accel: adis16203: add missing
 spi_device_id table
Message-ID: <20260930085640.00000377@gmail.com>
In-Reply-To: <20260929184900.39515-3-abdelnasserhussein11@gmail.com>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
	<20260929184900.39515-3-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 21:48:59 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The driver currently relies on OF/DT matching but lacks an SPI device
> ID table. This prevents module auto-loading on systems without device
> tree support.
> 
> Add the spi_device_id table to resolve this and ensure the driver loads
> properly across all supported platforms.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16203.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index eddb786d4747..905485fd556f 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -11,6 +11,7 @@
>  #include <linux/iio/imu/adis.h>
>  
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>

No need for mod_devicetable.h, this is imported using spi.h

>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  
> @@ -292,12 +293,19 @@ static const struct of_device_id adis16203_of_match[] = {
>  
>  MODULE_DEVICE_TABLE(of, adis16203_of_match);
>  
> +static const struct spi_device_id adis16203_id[] = {
> +	{ "adis16203", 0 },

C99 initializers please.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16203_id);
> +
>  static struct spi_driver adis16203_driver = {
>  	.driver = {
>  		.name = "adis16203",
>  		.of_match_table = adis16203_of_match,
>  	},
>  	.probe = adis16203_probe,
> +	.id_table = adis16203_id,
>  };
>  module_spi_driver(adis16203_driver);
>  

Additionally, you should delete the MODULE_ALIAS("spi:adis16203") line.

-- 
Kind regards,
Joshua Crofts
