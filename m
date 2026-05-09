Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94253390C8E
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317472; cv=none; b=kh34W3zhd1ypqw9K/G5L+fR4BlRLhtuaNpuZspRV4qZaOZ0IzQtO5kM4/Ta0yQRSCcYaUhnPX1xcme1nYk0iHWYuedDY4tYr/tfvMfCH8q6CvrPXkQnqKQuPgbvz3o8v9VFDpEh8R//VDtu7ZfoCPBMoc7fs0ItOMErK+vIULHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317472; c=relaxed/simple;
	bh=DYme4U5tBeDlOlGO5mVH+Hbs644IYeTTAEDmsHGh5eQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnN4UJeyU4MBlV04oZxV/logzuwKs6+U8darr9Y+f9I/WrOou0yBtbjFLlcTxAJ4FiPDIfLcejHgtVMdpGrJL1JFRHMsHDlhOeo6IxRPjPBubldo86vVFdqvqKs1HISdHjW6Sv0+6PgNOQ6Ba+BLoCNOWHulvmWWXXqm+uHAGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTgY33l/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTgY33l/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso25842405e9.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317467; x=1778922267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yTklxA9mUolFUhX4gJcOYo+2iUoJ0Qe5C3TP7EKWbm8=;
        b=pTgY33l/DRjNlIeLDUCy4HZWEK/1GdvaXKUUPnw3nbtkWURb5vmLMMFLMwM3G5+1U5
         pLVBSKdVMx3dK4HVe7tqzV8kwS7ALsyR5ncFWA+EYr28Wat4iM0DihmDnzvV+OADPVaB
         dcyM02TwLbDeJCZVQNRJ9k7WTMnG2aVztB8vDhCDcf9dr8yB7UVuJKL2MJuktfx8AlMX
         r7c6BKlDEE0kWZ2rrDo7HUWNfwfWYr6k3ezzAVjgc7lZ8qTAFFNrSwqzYS6g5gJ2KWnA
         HytGLxofRGhyegsBzOMfIP/DVHkKpZ0urhIhEODWQjQTJOQLa9j9gmAgPNsigOyVC2T0
         QmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317467; x=1778922267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTklxA9mUolFUhX4gJcOYo+2iUoJ0Qe5C3TP7EKWbm8=;
        b=agm767EwQlJ30R3sezncbqKZJeCBgu0iBPnmbWndY+1NyUnkKrwk06UXtfnl9vKvK8
         B5TVUrWgZdjmaLA1lz8xa3sal6QWIQUeaTfH+UoEAXyrMaUrwp3i0JRWWfBR6HceWwTf
         qUGCsmL22jv0arAm4VLjoJmhGO7J3tk4tPr/qfLkJKuYHOYd4TaDmtMveE1wwD4wsgra
         Pp6FnzymKf3LwwpAY7TdUs6UbnDiqBwiSEH5KPIkoD+XxLcCDHMPCzIHCJz61FniYKWX
         a3RKhajQXLToe4nGCoXnEEaBqX4EN1Xptflnz6EIK4WwkjFZQ/Wl1xgubF/N95Svj75v
         jadg==
X-Gm-Message-State: AOJu0YxQpzap1HSnSNY6DPUozuMn0N5KXpeN0p+CcSkvrB3NveD5T/5F
	WO7OBQP8CiITKzbafr3r0gpPC+2r/OFMmeImTMvGlKjFA/Hb2R3JfUQh
X-Gm-Gg: Acq92OGiNY5AWLx0F5+nv7oqE7c+n/6/j8yDRVapyzMFuUzCgBCnChvcbVQCK2Pyras
	WFA7w3r2eR4w9as5tzsmj1/6yKkx0yIVx8s89o8JjlOfbGijsLVKxNNax7wi2XLTDH58w0T2KcY
	RXHhC+dNYwL0hUxLDpLCK/xUybytDOxGR6PR++OMjLEOj0SunxDteX6BgZ46eM/W3nH3s2G48kf
	EhiMF4ZKAcv/TSzIWDsyFsyrxQ/K52OJmzCU/QdboF/If9jq2ChjdgCfnn3xlHcN+CDXiWopiKN
	dYhjZaIvZIH8TTy9/cw0wDVvA5PHT00j8i8zGB2RMWWUbNaL6PmOGd6q+V5PulZFc4NQ5OuZqSz
	DQ+HxfRxlEAApx+CY61DSGjZKZkmYkKyugnn53yasR7l7jgk85NcWkmQNCh/NQMysjixDVEBnDf
	f95q1i8joFNNukn/w9fSZSJ2FChd1ysopLOXnWzrORUu8LWOij/M1tDkfQZsi44M7bFcbcKv5J3
	Q==
X-Received: by 2002:a05:600c:8b65:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48e706c7e20mr28057155e9.22.1778317467392;
        Sat, 09 May 2026 02:04:27 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0ec25sm18644865e9.24.2026.05.09.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:04:26 -0700 (PDT)
Message-ID: <43aeb1d7077ceb22c0049ba93a5b9e9466c3bc3c.camel@gmail.com>
Subject: Re: [PATCH 5/8] iio: magnetometer: ak8975: unify messages with help
 of dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Sat, 09 May 2026 10:05:27 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-5-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-5-37827ca68fb3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Unify error messages that might appear during probe phase by
> switching to use dev_err_probe().
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 30 ++++++++++------------------=
--
> =C2=A01 file changed, 10 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> e575d252076acc3639cfbb718a76811636fe56d2..394f930b862e82fd41c02d81bc6fdb3=
cfc8b729f
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -495,10 +495,8 @@ static int ak8975_who_i_am(const struct ak8975_data =
*data,
> =C2=A0							AK09912_REG_WIA1,
> =C2=A0							sizeof(wia_val),
> =C2=A0							wia_val);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Error reading WIA\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "Error reading WIA\n");
> =C2=A0
> =C2=A0	if (wia_val[0] !=3D AK8975_DEVICE_ID)
> =C2=A0		return -ENODEV;
> @@ -996,18 +994,14 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	ret =3D ak8975_who_i_am(data, data->def->type);
> -	if (ret) {
> -		dev_err(&client->dev, "Unexpected device\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unexpected device\n");
> =C2=A0	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> =C2=A0
> =C2=A0	/* Perform some basic start-of-day setup of the device. */
> =C2=A0	ret =3D ak8975_setup(data);
> -	if (ret) {
> -		dev_err(&client->dev, "%s initialization fails\n", name);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "%s initialization fails\n", name);
> =C2=A0
> =C2=A0	ret =3D devm_mutex_init(dev, &data->lock);
> =C2=A0	if (ret)
> @@ -1022,16 +1016,12 @@ static int ak8975_probe(struct i2c_client *client=
)
> =C2=A0
> =C2=A0	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ak8975_handle_trigger, NULL);
> -	if (ret) {
> -		dev_err(&client->dev, "triggered buffer setup failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "triggered buffer setup failed\n");
> =C2=A0
> =C2=A0	ret =3D devm_iio_device_register(dev, indio_dev);
> -	if (ret) {
> -		dev_err(&client->dev, "device register failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "device register failed\n");
> =C2=A0
> =C2=A0	/* Enable runtime PM */
> =C2=A0	ret =3D devm_pm_runtime_enable(dev);
