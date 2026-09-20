Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E843CEC7
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789912983; cv=none; b=VUy7dBhK5dZESkA2z4eIpgPecwVe/tYuzIPZx0xORcH/5Eua6M3loWop6X3Pk/WDJUoK9Nv5TsOQpTqT+PiYYTeGf375gXdbjHK77+MLYzJZLAP8fECCa3TSlv9CuyTjrv+a6tiG+vd24oQc3raHCODybvHzgoACNKSFzLJUA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789912983; c=relaxed/simple;
	bh=KBEWERMKVz+kidmKpZBAbGJ4UDpVNu5XhVT7ZOFCQzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqaB6gaTte7a1TLyMEcEt+B7T6NgAPEMCm9Oz6++L6zqdNc4CWQrM7Cr4M2sT9vlOJh7WFbOE/RhXz56pjnXqz4lATYM6iJbFHoj3Xnhe7Ods2vCV1jGv9WhbEEEcFqXairQR5OK+BKGQwm2tDfZP6YOqOrR4anYRFZKbmIrBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0rxR4ge; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0rxR4ge"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059faso705898e0c.0
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789912978; x=1790517778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qGOBrazGO1SbR4ysdjTYnrXtGS2lZGrR+BRy6J/y9+M=;
        b=p0rxR4geQgJyn1lcoOzcm42MinZN/j2Cjba1iZqi1giy2HYHWUNZNvEjL8nxMf4Bjv
         3QZ1Da8Q3uS4qiYPBctPCew5XU26KXUjh2Cr4mJ4SdaWglEYvHW7p0suOEf9N4rQegUf
         6DCawZO1QbBWPhiZt/2ElFI8PQYmgeWFzHG+doCXWDecIGWzVN3pdTPCHM7MuXfsNR9i
         kkwXGIt3gQZSw2mX8QC2KqOnAl/cgai1AiuoSy5EudVAU8mb2GNMKyCaEJ3qQgtmr/MQ
         T7QXgCpjCG342pMqTNJ/J8Vea43JqlCQEFOM9KrueY7lD7lyjZY9EnIuff7SDYXTz5yX
         V1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789912978; x=1790517778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGOBrazGO1SbR4ysdjTYnrXtGS2lZGrR+BRy6J/y9+M=;
        b=x1yRlP0OQHfxJoax4c4Csc/7tLSdKb6OaqmZqwIlnJM39H3dONdC9LMW3q8DQmZbmY
         clHhQDEXUrmGsEkG3e5aLnEr+YsBtonz/1kAEvqps6YRNQVZtnP2UeJ4zsx1U9jdg2xs
         ZupoOekItjuHchj07sgfTWJX0z/s9SnhSosaYKI4FC+QuthJyJHDRNfKXFVKO5o3SJuO
         h3+Mf2okhpoYV9H4J9nEKldVF1n7axLG/g0ZXbD+nAgIlBxiqo81ZEl40lzHY3+eJ7sS
         /NRLvZrz13dVhevGRg/E8adasYZ8qkltOLbFy2B/C69kmRuf7ekC8/LdMGWn8F4Q/dFE
         3Oyg==
X-Forwarded-Encrypted: i=1; AKwUvBy/pxlE77oCbznL6UPaDi7a1/kZi6IrZp195zthX7S6awTrrOIUWB+qQ5a+bad0aSi3SYzC5a+WvHc=@vger.kernel.org
X-Gm-Message-State: AFuF++lTG6yp8cThajJUeqBcjJlVxM8b5Fh4y8DUqA2CxRvbpcPTYoK7
	vSFT/RTQA3iqXOzVxaBEo5E2oIRu9f6nGwglNwpYhgnpeTKaZGfBffAj
X-Gm-Gg: AYBFou0UYWHvkGTPmSn2PfSFqscIzDYDjRBA2/kbYDEKvIkQj1gigZE8VZ5PoA3iGef
	FDgZe6zn9d8fvVumsN4Ar4JqBP9F8+m5HxG19VXHutewkJJWg8Oh+fCLUgZm+zppEODVmPBht/f
	47Tcni16n5l91yNQ+cu+YDqc7yRf0tfG/EEa41zMo2j4i57Gkqyqq5e0d9mSB1Fu2AXqgWYVL++
	lht6NBFgQ/BfJvtGSYbw9XYvcDLTynNMJKHsBVlkd+/zLScEJmu0BaafgPB+VW3Tr4e7cM3kN3L
	14o7D8Ou00i9pfNeig+vHXz40DicZmjIk53SYp8xIUcYeBZf3xSseshZIOTEIGh142cy94eMI8D
	zgY2GpU+lzL/jrn4UjdMjB6uilYyHKWIQmFPUdn+PyhnWs4xnqp13bEwTskIrjW4cbxTMXn0qRK
	j1jw3xpC/cYdge8ajja6KxdPL9TDJDPaPPElvsOObo4Mk2RhZKHNglxK3h/xXqH7rzfemwZn6hF
	sq2qEHEdAgpCaM=
X-Received: by 2002:a05:6122:3291:b0:5c9:a617:580c with SMTP id 71dfb90a1353d-5c9b8b29d50mr3290274e0c.9.1789912969770;
        Sun, 20 Sep 2026 07:02:49 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9c198f790sm4743292e0c.18.2026.09.20.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 07:02:48 -0700 (PDT)
Date: Sun, 20 Sep 2026 11:03:55 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Message-ID: <aq_nyxWauKzWQwFC@debian-BULLSEYE-live-builder-AMD64>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
 <20260917-b4-inv_icm42370p-v4-3-fd9373f123c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-inv_icm42370p-v4-3-fd9373f123c9@axis.com>

Hello Kanak, just a couple minor suggestions to this one.

On 09/17, Kanak Shilledar wrote:
> Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
> accelerometer with built-in temperature sensor. This device is almost
> identical to the existing Invensense ICM-42607-P IMU, but lacks
> gyroscope. The device supports I2C, SPI and I3C, implement only I2C
> support.

The device supports I2C, SPI and I3C, though, only I2C support is currently
being implemented.

Would sound a bit more natural.

> Provide basic support for raw sensor reads via sysfs. There is
> also a built-in temperature sensor but it can not be turned off similar
> to the ICM-42607. Return with `dev_err_probe()` when WHO_AM_I read
> fails.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
...
>  	/* Warn, but don't fail. */
>  	if (val != st->hw->whoami)
> @@ -630,15 +648,20 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(dev);
>  
> -	/* Initialize IIO device for Accel */
> +	/*
> +	 * Invensense, ICM42607 and ICM42607P both have accelerometer
> +	 * and gyroscope functionality. Whereas, Invensense, ICM42370
> +	 * has only accelerometer.
> +	 */
I would specify ICM42370P (with 'P') here. Since there is ICM42607 and ICM42607P,
it wouldn't be surprising if ICM42370 (different from ICM42370P) eventually
shows up.

>  	st->indio_accel = inv_icm42607_accel_init(st);
>  	if (IS_ERR(st->indio_accel))
>  		return PTR_ERR(st->indio_accel);
>  
