Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FB396D01
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111895; cv=none; b=h+MSdi1bkHXTBN061OdiSKLws7crQwbGk2SKB1vZYL2PxgXcHmTQP1i1T/hVWm0xc6U58tQMWiVTNzqwvELDRa1PDaTci+ixljBS+S8sqXri1pv6VamuV8Og0tN1pMuknR9losabs+/nsQw1XiTVvycbcJTEnNypK38IT6CZwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111895; c=relaxed/simple;
	bh=Cqs2ZJV6S+7Ur8W/eYJ9QXYkmA7dO/VTZ0ZHhCRoJ9E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hK90VMqhxwWTm7iIoXIh5OBDziQgy+7zAWcFLANJDn3izvqkWd4Ynnoo7AIwq9BuMzShygdMBUQozjId1BxVRM7HeGmQQQ9zYDRnEDREGnYctqQZtpl5YHjShr1U2pB5CT2giAIRPH/IsDSkZqOkKfEb/Wnlyn5U2WS0eEsYLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrjJMUhF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrjJMUhF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee0291921so51335545e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 01:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770111892; x=1770716692; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAfnD0LvqQD+kZ2dzGaSed0SZSeQIrOXUL16+cIH+I8=;
        b=JrjJMUhFpkEbrHQNLUzNDqNaq/BTmaEyohByciMb9anH7IsUsMNY0WfPoeJlCsVok9
         amQvOMguQDABkpr79cBnSuXigvCRfrNGEZ+JcVY0hQ8n1tNN8vX1WuwuRcqZgsJYbm5Y
         B5yeXhS6JuyR3E180UE3QPTba+8pj0q7AU3qL/bHnNOGI6isPEDvst9eyY/CV6HrP45G
         lslHm9YXiwM6DNXAExmMd80o3y7rXox3QanC/ySROf04alrxifol5RiWj2OQpf7IOFBd
         UdQJBNcQsjv8N0bqjzUjXyGNMEPmUZnEb3LgPzLhVwn3Mh8w2AWUEMYeiuNXbien4Z6G
         aQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770111892; x=1770716692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAfnD0LvqQD+kZ2dzGaSed0SZSeQIrOXUL16+cIH+I8=;
        b=cCHKbJoGij6X/rkbqzV9KQJ4U7riBDoINRTP9zQjoLTq+Wo1KV1h0Lk07a+HEl7k2i
         d9hFeSwNDv/UBHq+2cJvS4WMcStu9eNSWkiY30PbrAH6dszTZVn347FzGysPqDdDXt+O
         7hxig2BZpCXIGrmyD6T/Xzh5q4PZ247ofUlSx/JzxWa7t6h/2+v7cEqVJlLNEbMxA8nX
         3WZL7moFYXqW3EnNPsxk0vB7AoDGnjMPeDCc3GpCRL+wVSmirT1T4fvzebjskDZr86jU
         k2siZy2xyJJintX1ZnzxBK0/jvJ0QKunoKFn0pEsv5aUYjPIjZtJFMAIxx85JD/kkzrj
         w1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo8Tb34Syyjk4O3uNsG8y57KFd+DntpMbdnHpbbSsFl1REEruPvuS7MT2+73rxqXul34ZgeKZDA3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zaxkK7Sj8savkhr9j5o9AnQtAIroFt0LpDS2hVN7PgLvDK4X
	LS49Y4HUbfvGET80uSAP5sd+PqgEkdF2MpqxUpjN4VhZgvDRUzYcgTrmkFbg/6OP
X-Gm-Gg: AZuq6aLdyqKJDGvPEbEELuuzcR5joPBgJx/cBGex541DnX5qdWXJeNz9CcSo6tJzaE3
	7qU136mCTFF2PZae6JP7LJA6Wj6l45KcVGfQKOLYdUL4Y7k/570GWipkXLYuzbXmlRuhIB2ffUD
	nHoTF+kEbILSPxhO2+WU36xZFKmo2f6ttM/9zR/QV4RcHDDjihC8ytPZ9ZBJpO5nk+0o3/7TxO3
	8GFXJXzlJ91kAoOLHuyTY1lEeLMruzfOm+nKXrBitjj/xl2IH0F9/Oai+7cfoY6na/JCIWHKy0t
	7U1tZGktFVBMjWuBATcZY+XV0WuVU24IY4cwYb0bK9mqiIr/ErMIZFkO3GBvWX5YVcFzoS/ETj0
	wQZiI2Uv2vorlZazzNK+e3BJWvx+fUDBdZ5Xl/dagVbjcGdYRI4bV2KKMZVZuq4kPHrBnIbiDsL
	IckhpAdgyArcRWP9r8sJA=
X-Received: by 2002:a05:600c:3b23:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-482db49ff27mr199382875e9.14.1770111891490;
        Tue, 03 Feb 2026 01:44:51 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm48545478f8f.17.2026.02.03.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:44:51 -0800 (PST)
Message-ID: <a75be02da0b55997b2384a481d85b680d1372a78.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: mpu3050-core: use
 pm_runtime_resume_and_get()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Linus Walleij	
 <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Feb 2026 09:45:34 +0000
In-Reply-To: <3edc89e901fd9d55c5355c4ec007636b1c8d6801.1770039759.git.antoniu.miclaus@analog.com>
References: <cover.1770039759.git.antoniu.miclaus@analog.com>
	 <3edc89e901fd9d55c5355c4ec007636b1c8d6801.1770039759.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 16:56 +0200, Antoniu Miclaus wrote:
> Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
> mpu3050_read_raw() and mpu3050_buffer_preenable(). Unlike
> pm_runtime_get_sync(), the usage count is not incremented on error.
>=20
> In preenable, call pm_runtime_put_autosuspend() if set_8khz_samplerate()
> fails since postdisable won't be called on preenable failure.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

To me this is more than just reference counting. It's also about proper err=
or handling.

- Nuno S=C3=A1

> =C2=A0drivers/iio/gyro/mpu3050-core.c | 17 +++++++++++++----
> =C2=A01 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-c=
ore.c
> index ee2fcd20545d..1cc421eb4782 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -322,7 +322,9 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0		}
> =C2=A0	case IIO_CHAN_INFO_RAW:
> =C2=A0		/* Resume device */
> -		pm_runtime_get_sync(mpu3050->dev);
> +		ret =3D pm_runtime_resume_and_get(mpu3050->dev);
> +		if (ret)
> +			return ret;
> =C2=A0		mutex_lock(&mpu3050->lock);
> =C2=A0
> =C2=A0		ret =3D mpu3050_set_8khz_samplerate(mpu3050);
> @@ -647,12 +649,19 @@ static irqreturn_t mpu3050_trigger_handler(int irq,=
 void *p)
> =C2=A0static int mpu3050_buffer_preenable(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct mpu3050 *mpu3050 =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> -	pm_runtime_get_sync(mpu3050->dev);
> +	ret =3D pm_runtime_resume_and_get(mpu3050->dev);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	/* Unless we have OUR trigger active, run at full speed */
> -	if (!mpu3050->hw_irq_trigger)
> -		return mpu3050_set_8khz_samplerate(mpu3050);
> +	if (!mpu3050->hw_irq_trigger) {
> +		ret =3D mpu3050_set_8khz_samplerate(mpu3050);
> +		if (ret)
> +			pm_runtime_put_autosuspend(mpu3050->dev);
