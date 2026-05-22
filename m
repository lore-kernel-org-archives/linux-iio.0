Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BB379C4D
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427607; cv=pass; b=E1VnXWm0QzK7kMf7qf/C9VYDhWdI8EJ1U8SphiCiVdTgXjCXZXYPUHafQvQPgLaPZoRT4TIWespxx0y4+7KchUPDBHj3Unmnnfgx7rtbvVm6oaVp3fEF+ldFG6WxWQyVULs64yrvEbw8EX0x8k+nL7WdsaRuekYJJXuMC+Wh20w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427607; c=relaxed/simple;
	bh=+BBccyAHcRtQ6Qwu8z7bTYO4TH4WWVTe93LCAGz5K9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z284FJs9w9Qu4DrYTAlim9ASHAxf2c4eZA+NZUf4N8CMMzDWYHG0R/W6FqF3qjfNeGpK6uEz+celoVyFUvZjyYwYV1A3TbjYlZ+LSJ7ZZIyV1J2z/dd2jqk09QSTBgbcDmAyaepmAzVZZX56ojHN906565n7YOYv+OPY+M8Vp88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/2NKgBx; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/2NKgBx"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c37eafcbeso7391649d50.1
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 22:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779427603; cv=none;
        d=google.com; s=arc-20240605;
        b=Txmc3no0sI+6cqpxQCwLWNhx3jS7TlIrR9mV8chtJVY1JMvZtP+nyOIDtgiVUi9/5+
         6OjAYGHRQdbL8gXTIk2eDnosdqiDVp4bkCGdydlNSWWrkyM+GplP2Z3x7gLPfQZ2GCWu
         3vID0fSfIfnYAeSz26WKfbGBgZXL67gER6M+dhrXqH729GgXb9VEzp3ZrLUb/54163CK
         D6owX0HZ/ePYiYiwOJD8uLr9mMLFr90q0uW+DmM2tSFIpU3X6h1LBaKLqJRPWu/fdIGb
         NrURK7r1Y13vEx+qgUkuZ7T0/6sRW/H/Eso/SpVVOY++Kcm3Ekd6zR6CQnFD4C42R7vr
         ceIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wxAjNFf+5Hga9WfHjd2IVBV4xnV7RFbXS0JGXLCdaG8=;
        fh=4P/CDjhjpBFQ2fAhQLgsczO7z5dEKUU6A1Ybdaa5S8Y=;
        b=ZdEjn5fwmDJhHRnFEmtIYYcsw0CXhtSvOJPVQhTeW5I/DEBTnuiEvNV+Dwz/WuQ91Y
         6j0a9+ZuvuVaiiT27mDWCeYlexzY6qBZHTRMwcnxX6kEG/8uZQNPcplP1Z8FCHXHohHV
         RrpL0HdgxiDlH9eRfZ5E1H0qJpSy5gr8/pUNagi1VA+CtGtOdS/ukhH6bztZ6XoDO7oL
         y5MiztK6Eqjt6eALpYkwe63ngRJj2L0eRfFYmZHBloQR1eB1coTmD7AA9SQgmSNF/zps
         NIYnbZzT8VrPqm5+SNMk8Rt+c8aj3T33EPtDPuedKGvZGwbxe7HrR8LFR1kUJ5YRurB5
         Y6qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779427603; x=1780032403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxAjNFf+5Hga9WfHjd2IVBV4xnV7RFbXS0JGXLCdaG8=;
        b=K/2NKgBxdoKwxCdJY7yw3x/i23HbVa87322umUW6xI0lBkEUr+jzBWknmx0emszSti
         t6L+CHWGuZyLv+4E4FYs65RqMb7bnBTBKdLzB/rvyHzoDrFd/XszFOKy9li0S3L8cZpd
         AQkREUjRRjHZXyTCoZWVipdFeTilTls1Io65qCaooU/bHLDjKVph1tjHdEjgLs6myGM+
         4wVqZiHZ3s/atHOzqXcRQaOmYdhCsJlxxmvTzQW6prn7rCL6LV+O+hyc9PW45pb7lf+m
         pvZKBddL55c78t8d4WJFyMxuaQ2qxt1OD5OHR2BD3q1TBihzMrhQnhziEcf6RrS9D2u3
         5qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779427603; x=1780032403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxAjNFf+5Hga9WfHjd2IVBV4xnV7RFbXS0JGXLCdaG8=;
        b=KPR2BNrSnsoNgdnkaTDJ5SUlnhHkJ02/oZMGv9Wj857A/W+BT8hbqOX8Ff17cwuMAl
         SzrfCVIppUQnjz2eBTh89b9HiQWuoiNiAB8EQHvmGBiF9VktjLbuJURyB8Ba/GB/mQIl
         4rBdEyI8NP/jXPjNMGM3VX4gFvflz0aj/kPJx/25TwulG0vguz6iaDBGBZw7J5B2sN0d
         dVbvVIl6oC02lq7y7+8138ok+gbxMPF7G9zmKLWC3KoJ8EElpeDXiU3hWQFPX9VhEXh9
         YrJ1USgrQZrTlPgcqe56ERCM13CZTMkNtJKWZ2YCCf+7H7vKhEQn1dn69rKOgd7+Y3Hc
         s7/g==
X-Forwarded-Encrypted: i=1; AFNElJ+eG+KrK1MgGIlwdhrr4+RvVGCviQUVKq78iaVrUCVyoHa8zjWvAxsoWjANWunylRzTCliQfHybQc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSEMguTRDqzkl/lc7YIJccvR/3JieI/Z93uGbqHPfSoq0uFHD
	C8qFlUe9tWKL36rzR0CL6p+I0LTLx15PRtbhfIF6SGAZUydRyg6q9UAAcIhBosCTprN3ts26/qa
	3cnvAr4X16/+lsa67LAdNPq6W8Qpv0UU=
X-Gm-Gg: Acq92OFfFOu8IuyIQ+zOxoNHa2k98Ol8XtgWm83GcIrKkm2XgNuqx18r+JT5tdIk1rT
	lF0baoUdoQ3Idma9D1n3jHk8fGKbSKjyBHL3ANzgjRqUpkqU5LiFFBcqY/J+T+JqavV0dW8jmVB
	o+fzzSyPTxDzaA+3ItOiupShN+CcsHe0IegkHRO6bacXex5wI5PZ58foXDJsvnFBktAmHP2aKmm
	mZ81wXs3zLlVvdC0fV8wLmHPa+tBA+rihPd82HpspX1jmKze/Y3NfEGV7VLuGkVeJb48OmMJO8S
	pKWg
X-Received: by 2002:a05:690e:d58:b0:65c:477a:2ad7 with SMTP id
 956f58d0204a3-65ec980d0d6mr2446703d50.25.1779427602699; Thu, 21 May 2026
 22:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-iio-humidity-ens210-remove-hack-v1-1-9528ac1b384b@baylibre.com>
In-Reply-To: <20260521-iio-humidity-ens210-remove-hack-v1-1-9528ac1b384b@baylibre.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 22 May 2026 00:25:08 -0500
X-Gm-Features: AVHnY4JvJEtHT3B8WoD8xfLnYC1PsJKyd-twWnqIdmIAtHji-kIm3xcvrI-8EJk
Message-ID: <CAKqfh0Gwon4X2aCoDSNNBg7wXnKfbh69kj1R2HopKv=jHwfL-g@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: ens210: remove compiler warning workaround
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, May 21, 2026 at 8:26=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Rewrite IIO_CHAN_INFO_RAW case to avoid needing to add unreachable code
> to work around a compiler warning.
>
> When scoped_guard() was first introduced, compilers could not see when
> it returned unconditionally from inside the hidden for loop. This has
> since been fixed in the macro definition. So removing the `return
> -EINVAL` should be enough. Still, we can improve readability, decrease
> indentation and avoid the hidden for loop by rewriting the case without
> scoped_guard().
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/humidity/ens210.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.=
c
> index 22ad208e6aa6..49543fc389bf 100644
> --- a/drivers/iio/humidity/ens210.c
> +++ b/drivers/iio/humidity/ens210.c
> @@ -149,15 +149,16 @@ static int ens210_read_raw(struct iio_dev *indio_de=
v,
>         int ret;
>
>         switch (mask) {
> -       case IIO_CHAN_INFO_RAW:
> -               scoped_guard(mutex, &data->lock) {
> -                       ret =3D ens210_get_measurement(
> -                               indio_dev, channel->type =3D=3D IIO_TEMP,=
 val);
> -                       if (ret)
> -                               return ret;
> -                       return IIO_VAL_INT;
> -               }
> -               return -EINVAL; /* compiler warning workaround */
> +       case IIO_CHAN_INFO_RAW: {
> +               guard(mutex)(&data->lock);
> +
> +               ret =3D ens210_get_measurement(indio_dev, channel->type =
=3D=3D IIO_TEMP,
> +                                            val);
> +               if (ret)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
> +       }
>         case IIO_CHAN_INFO_SCALE:
>                 if (channel->type =3D=3D IIO_TEMP) {
>                         *val =3D 15;
>

I'm questioning how that initial commit got merged at all, they
could've just used guard()() with {} (the kind of thing to make me
want to take a look at this file even further!). Visually looks good
to me but will follow-up later with rb if it all checks out.

best regards,
max


> ---
> base-commit: e1a29334a9c043defe7a9363fa76d399d3fdfbec
> change-id: 20260521-iio-humidity-ens210-remove-hack-7c5a6496547c
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>
>
