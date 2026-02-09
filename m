Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B137AA91
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647194; cv=none; b=LoAZbv+gOsPM7qtZszTgxQp3P6Q6KN/4y/JE8EQUYENXvFsfV2iVaSsXA1B1fYor8m0Xv3/9J4eA9nGJo8tvuMzHIIA1VuLJL5ygNCteruv0yBQSiWpcp4oJBj3XC0ggjg7R5Va3Qxgf14DYkuK4S6gf9pX9U1bbxkGcjYX5qWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647194; c=relaxed/simple;
	bh=BzEjFgepZERwX/b44bRhTJvIWkbe/M4u3D0qZfrEsM0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLGSNOQAK1Q4lPAvRn/r5JXINPrvFmAlHEL0z5xavKgnSwxOA0BwBW0QyCKNEvnGH+7oyXd6VF1gpiGErVAIsUi/Q8QK7nmyDddd+N7aUsyyt47ubeiFp4MJccfcED9kKIogPbyMc/oJ+xoBC3NgRBzuSq7DziuEGXk17FjlsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTKg8G6v; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTKg8G6v"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806bf39419so34558035e9.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770647192; x=1771251992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbS5n1MOS9GdbQU1A6K0Nhy7exPzbmyPaVks9R8jQL0=;
        b=bTKg8G6vYuTgHwE0Q5hhftZtaV1t18IGS3gr6pTweMvnSWIBCtlt1+Z91GI2lQMrUt
         XjgXRDOwa/Pj6Om2BuC3YJVYXSIYLw8IYq63txZmuA4OdogmMvKE6G2IC0WgCJ2je8T+
         DOEcHf7IKlkc3yfQpjvay1Z6W2bCcsnMz0grgLe8dqRY0pPMuiX2wRRScW7VQ2j6izla
         Xofx0ztJkIxxjeg3gEcVvdXTzCjH8rkY9hGUvVZMAEwh84jAO3Y6HeQDcFPrPJP5vxEE
         iH2UNclmGamq509to8Uj5HUrzYFZwBZnFIK2uJ9VREj+DfwpZv7zdZ0qhaVIAeXxES19
         08qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647192; x=1771251992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbS5n1MOS9GdbQU1A6K0Nhy7exPzbmyPaVks9R8jQL0=;
        b=BAIQSjiBnY0f44koe0QpoTxoKqBmc4zGsulh+BSf7RjaQgahAPtWq1XWokAvuJ2eGY
         KSD5zdDXf9pCUuvvLdf+X0tykYksWhWjUqtcD2JrGUPtso2KTVDMDnFycVAa60mrf3c2
         Hw3Z645tkcwjSDxBy/GwqVx1Ou3j8iMwTpDAowDiEynmQyeJwBdU86x6hbGGJfqYC+yE
         7mugzHFMTgCZBGjvEKr+C5PsgM1co2JAIM+4jPDW5BYfqqDEN+/o4UJlMvfw1OQ11vpz
         xlPL0mQtPfo0jyMoYUQSC2vMMdvFEQtFgE556eT9p8H6xXHpZ8uVGMZxr0jpyrFOxuiW
         O1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSGoXTbVZnuyuRcwNWvwcQ3pZlZbfkT7tkMfgylJc9YpDjHPMcygutO5vnkZ8GmrLwTClesskMH6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTcF0zspyqE5huNzWxqHvwNJvUPt7P70A743CNvDXIfMEuHBj
	XbM0sxAaQoUj7mY5P63D9Yq4iGj/c+Z+b+5/oYXfszoh/mgiV8wOwciI5LMTptoCWXU=
X-Gm-Gg: AZuq6aKt6AhQmsJLVDI08hUDME0niG6f9X00Q4NPo6q1D/s8IN+6lW92idM08z/IDsw
	OjruNfDSN8dNbETb8LmEFCCWvWH9ns3/xj+RQ7T7sXbxjDFgbLyQOX9Fd667EQPKf3vU9P8NbpE
	t9YxrGWU7bLAbuWOUQxzVJaIv2cAAm0aVUybPoLH5YmMCp2iMnmtmHcX5MzNpOV1LVM7Ov+R2KD
	f+Hvz9FPSLwAOQEqFMKsH9dnW+9imy4bwHebFph7nDKl2OGsyUkOqZsxt/bGDuEmZKIXI+5JSku
	EZ7+GJbYHQbsjyGFy6FE4Tx6qRld0FMMczrKRlLm0hBbga+O6ne2PJAKfKGHY0TqMgzOC9nh/kC
	9MQ9f2O59/PaLjlHbP6gIiYtD3KFWFH5vGomOr46IP13ltXyVS41lXsnrb+sUOH0JyxkWn/91xk
	hhe2h1tju/w9yBlBtl+UvDskFERusImw==
X-Received: by 2002:a05:600c:c3ce:10b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-4834b3786a4mr780915e9.10.1770647191980;
        Mon, 09 Feb 2026 06:26:31 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43768d07fa7sm14456076f8f.35.2026.02.09.06.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:26:31 -0800 (PST)
Message-ID: <24904c919d52e40bbe6089af54e013d2351296d3.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: gyro: mpu3050-core: fix pm_runtime error
 handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Linus Walleij
	 <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Feb 2026 14:27:15 +0000
In-Reply-To: <0309164453650011ec4d72276c8386edf1bbb88d.1770636034.git.antoniu.miclaus@analog.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
	 <0309164453650011ec4d72276c8386edf1bbb88d.1770636034.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-09 at 14:02 +0200, Antoniu Miclaus wrote:
> pm_runtime_get_sync() does not check its return value, allowing the

I don't want to be too picky but the above is a bit of bad wording :).
pm_runtime_get_sync() indeed returns 'int' so the caller is the one not che=
cking
it. So we have two things happening:

1) We don't want to ignore the return value from the PM API;
2) We don't want to, unconditionally, increment the device usage count and =
hence pivot to
use pm_runtime_resume_and_get()

- Nuno S=C3=A1

> driver to access hardware that may fail to resume. Use
> pm_runtime_resume_and_get() which propagates errors and avoids
> incrementing the usage count on failure.
>=20
> In preenable, add pm_runtime_put_autosuspend() on set_8khz_samplerate()
> failure since postdisable does not run when preenable fails.
>=20
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v3:
> - Rename patch to focus on fix rather than API change
> - Reword commit message
> - Add Fixes: tag
>=20
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
> +		return ret;
> +	}
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
