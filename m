Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF1420476
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120901; cv=none; b=SAPL8mXymZGmfRKO1YWgM3F9wGQOmn5RrZloi4W2ZcMTguPn+izRerVD5J33j3IJG/k0REoWjnjSvGpbIr5bsAKwlMzdGTS3ZzWXW3gVW8gOR7aBvU2q9TAgNfFfq32At5bRjXK37+eE4KF/ZAVw7JcDDiPJ/G9XZnAH23R2q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120901; c=relaxed/simple;
	bh=q7OLCL7VgoNJ870EwkW5fFPMIBWQZC0+C92RMBAqFds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liXTyGUdwF4gukFn5FCqXt+th53IrdAOe1JVoNzF4HSj/Wsj2dDPy7AYSpzCKEWjQu+lzWSjaLz/gcGoXMTIvfyO12c7bMejoxkigqcchqodhWjNMLwsdUTjxx90CLjEnKUwyb7i19kZJvsKJ0QI9+mgQA5glLqv9efgkq1QiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXzGsfw0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXzGsfw0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47d70879764so3699910f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120898; x=1784725698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UfonUu9ln9gTilLrABAupaUf7sQqFWMryYTmRFohNbc=;
        b=JXzGsfw0hYKTM3PjU+vY/5iJNETA1kJwQEClzuquNmBNkoqGZVldJNSBwgTIlpfw6Q
         M0EuO2POJrj6taJ47TEoKuSk49xc5L++UcEfX/2htq3Oe7vI5RghSMYoaNjj5Gil3Dc3
         X0HC73R9/foXxZ2L/UkuYYmAl9uihPH/jEOkH46Qlv8kECyCKvtH95ghjI/LfmlkdbSe
         Ijsz942c605Lv7UAOIfv5SMrZbaQen7FRLZ/gZcEmB5zEo5pRCIeGQ1WzAkA1PMceGw1
         5Kd/qkLYxM08Wr5ixCPfXtfhiJsvN2TnHtH2zPY6NymnTwLXPv5UvJgiHxbdEUWEWTvz
         tVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120898; x=1784725698;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfonUu9ln9gTilLrABAupaUf7sQqFWMryYTmRFohNbc=;
        b=BiflNfko6+Kq4HSNlSNrzfju0GwgyZjIIdnOqwCzWSN62g6xZl5qCZEFZB2REw6cTP
         UGWwnIFyME8vGQlAC2i4TX6a2KDt9tCIggy9CKKKMV23gsFcKcO2330BFboxva3NQwV8
         vldC4f+mmbvWMGtkgkKmKZICnJkqOVyO+yJ3v5sX23C+TSZPi+4ukzO/NHPkIhYKnw+t
         vIXS6Jn3Ae/9dE+9nP0C1zXlfxDjqe3al9gr0Fk7YsKlYhzYV5DH94J4YgYcCt/qzlGi
         hLVCqFTD4dUKbnpK+R3VGLZKWKsP8CSTU6LxvhjdDow18atLOt+vblF+Uv8pxeUWxhyO
         SaMg==
X-Forwarded-Encrypted: i=1; AHgh+RrL6v0cQ83yxE1yQWGjRRz3zNTKy4udwB8Y0RshNu4qv0q6v2Y3jzvdHWwEjCvjhlFLUnHHGsq0TNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4UPCQqUBwJ9CgvZoT4sv4PSblgF0G0quAu81nX6pIXhvuN79
	6g/oEGCzx5ta0j+1KE+HeUv3GYJlNKLrFEWFEHB3sQDXdiiWnkJMOEdm
X-Gm-Gg: AfdE7ck0XaiVhDI8QcHgUZmluwMGRlC2OMkQTw8rwsAdct+uDXfhmODB1PiFdr4slZG
	Bdy0o0UPfGQaK6PYrboIAJoOFn8aPtGKIO0zNxzC9laRddmqbMK4LK7HK6ACQJlZILFRnICEtaz
	9apgj62EorNP7wcuvRmW/GOyQQjv7keObOU+hIrXLo1X0YMmZmR1b6OGUTVj1ExwL/IFy16RJJY
	J3ogF1nIi0eYBkhEqN3GbmIr3/rxCOz/1+9bCWKcBMwK/JIA0hx5utl8zHCNhf3xwBUyPG8iWcO
	vwO3Fpmsf855U9APygXBbFH2pSpcDg30kv7/A+2BTDHogh1TTbkQqpzpxXg3P24wHOJncO+S1Gk
	rZ1tZ18sIGGUhJD2yJTx/r1+g9EAImgIYkRToGj5O7iQq93I6lDzIlCkNMol/rfMwFnNWqY9ea/
	dKrAsAJn7+Jc4iMJV0CDqWfJH7uOPgF7KoQ+wsvQBwSvj1JqgYGW7fe4T24oqaaMQCYg2065+63
	Oh/XKrEhWhG/Kj9Txm6DxNzuc4JpbBgEQRuah90lZbcY3TA121MMlPTLQ/Vrvzc4IxOayBu+Mqv
	j3Da9MRvAronifRb5kUgE3BJ26xVNvUAid9BaVtZFiXw/txuB4NOYBBy2Vgoyuwtr9FiljDQWQK
	9nKwV6K2Ac7xkvHtDzPi+ZvDxQsYxlOCy2g==
X-Received: by 2002:a05:6000:1841:b0:47f:4e42:6f1 with SMTP id ffacd0b85a97d-47f4fceef3amr3279570f8f.41.1784120898478;
        Wed, 15 Jul 2026 06:08:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm17579561f8f.4.2026.07.15.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:08:18 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:08:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Message-ID: <20260715150816.00007d7f@gmail.com>
In-Reply-To: <20260715-mma8452-open-drain-v2-3-95be9f5f4795@geanix.com>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
	<20260715-mma8452-open-drain-v2-3-95be9f5f4795@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:33:29 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Reorder struct mma8452_data members to avoid holes.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index fdf7364d7fed..537263085215 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -108,11 +108,7 @@ struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	struct iio_mount_matrix orientation;
> -	u8 ctrl_reg1;
> -	u8 data_cfg;
> -	bool open_drain;
>  	const struct mma_chip_info *chip_info;
> -	int sleep_val;
>  	struct regulator *vdd_reg;
>  	struct regulator *vddio_reg;
>  
> @@ -121,6 +117,11 @@ struct mma8452_data {
>  		__be16 channels[3];
>  		aligned_s64 ts;
>  	} buffer;
> +
> +	int sleep_val;
> +	u8 ctrl_reg1;
> +	u8 data_cfg;
> +	bool open_drain;
>  };

Also quick thing, in order to prevent too much cruft, could you
please move this patch before patch 2? You introduce the bool in
2 and then move it to the end in 3, better for you to reorder it
first and add the bool after, otherwise you get these "ping-pong"
style changes (Andy's words). My reviewed-by still stands either way,
so feel free to add it once reordered.

-- 
Kind regards

CJD
