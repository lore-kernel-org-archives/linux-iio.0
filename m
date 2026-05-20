Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BA361656
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308034; cv=pass; b=r8l85/8yupdkfMXYnXecPfaX1slmaK5h5vT94A9FoNJaA4WAmUM+CSntQewrPu/dcP7DJACR4Ct44/NwvLuRIiKt8Lg/RVXZRCEwt1fd+67uTYNP4v1sS7phoBXQOZ5LrDykU9tt2HQWlA8Thn3UxDzqjYelPF0g4t+jSSVeaes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308034; c=relaxed/simple;
	bh=nL3nJk7GL47p+RHxgz3gMmM/OIhmqXrnyUtrJt6CMtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qt9f87HyMCUp9KU+YI78Ch0H/r9jMJu4dMBRwNi0XbpeA1ZQ3X1eWWIWdkHCztSHsbxU0fqKKgFMTcZY5MbRc2HO4YvPv0oAwN/TCuJWhnUpavix0tsczCQLLb25TS+pK4CK0KO/PXcRWH6dtLrWKzMnFGNYHigNyf6fRzX3+Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA3DkLFy; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA3DkLFy"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65318dafbcbso5284152d50.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 13:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308032; cv=none;
        d=google.com; s=arc-20240605;
        b=EBUbrmB3RhZYR54oNZY1L35SOle2RdBplV5lNE3AtpKBm4iCLxVD7RuKufsdw1MV7Q
         tLUMmgVbQ+artjS9Ie9kqxPm897AK/v7M/O2GlVERvr6sXiiA43Ur0HH2HiZOVDuA7Uq
         AP5LcAJGgj9dWaX9e2hwb85Q8EnuI6J07N9i3Bx5zqw3UT8iZ3BzMfGcMlQInIl39VWx
         zT/+wep3E+q/wBdA23awH7QuWhmRzt4ap9n15pbpefXaAyl3lbfbV92ReyBAwVgjnDRV
         CrL1wiKVytS5QUIXuOSnZQ9AOFkzhCgS0/WtFlI7XoJVnRSPWkWKTGOkMl5MeIkfVY7x
         Jg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uL8S3GA6A9QKIOBXXvi1OMNl9de2tPkDuc7adsNAUek=;
        fh=Znv71rYbgwFoAqiYKZsxh06LAf7XTi5z/5k69mZCSQ0=;
        b=dqZSTtZU9qhuEdxvyC8Pv5ssp2n5PQeAfvMq09d9EZwdr2NpyeLTmzK6dwm62pPGys
         GeL5TUcAek71dXLE+jrvT989g7Pg0buEX4S7TmnYjQFefaxCeEI2Sgu0O3wKJpJH9qUx
         OLMr6yxOEypyUa9VMrdWPu6GTpqjObVuz0lgqzEndx5uE+L0vIOWpwzA5TDcl8YFAb0k
         FSEGQHsmhZWqWlWlQM2P+Ck4Vu/U9+watPTRICn1eE2ts0SKoW8nIAh8VkqWQsV+Iv5W
         2yiH3q3si0D3OXLNrWQWpdLcauSXIM9M0K7+fX2mPyyLXajSdangEGB+qQfPQx/4nyWq
         QFGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308032; x=1779912832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL8S3GA6A9QKIOBXXvi1OMNl9de2tPkDuc7adsNAUek=;
        b=AA3DkLFyBFdBl3l0DpKi0fRGBYQrZKxnsDvnxoYLdfWl4cRmEKb+bpsnSUhMv+yPg8
         DK5RHSU4cLqzsa3wV4Ckb9prn0Oc4HyHeJEvTYgiXbiYa8Fi6Eq8TMntEbB65lhtNfAx
         GzG/+2ieObFWUwNVymFdQ+a+7PocmsWkmiAtDdJKVTo41ivHDroOhFzgqfyrzkWmnmMp
         exZABsVh/IYu7EBZXVwe2GyHuxby4EBlDL7nGjQZn2sJ5YQyE3ERVGEmhnAUlc/6jKeh
         gRCsR2EjabDBHieH9mVSGqbIj+VdMdQSD27cOBOs3u/fWDeGEP8GIh+MjE+Bjd0rttSn
         upHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308032; x=1779912832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uL8S3GA6A9QKIOBXXvi1OMNl9de2tPkDuc7adsNAUek=;
        b=kclWGpBYni2XjKgqf16t2kktaHdR939A/PGJzjKJAdy4t3JthFO41Cb7MDsWVE4xbP
         c9tba1rkSDwqf8QX/jIXZayOVIkE+aDRZha8CA6UqWCCA+KRg8JURVImDSh3fcs+kXOG
         qLZRaWYJJFMLIs1Sp1K53XxmyePjpFKlaRNfZdpkLi+vkyh19aqZrXq4BBKHAuL63ARF
         HU7rI0rcqufnNtKQ3znXY8D4Q/on0I4pa2Y4lPjOe12XcBME4tOg1Pg2/44IK16SPKLQ
         2MZk5r2IYFOJiJjjyge7VnGzfm6ZSoCSG4jSI88ckrA283EX7hP5Ct5ZkxoI4MMfJq1s
         RHag==
X-Forwarded-Encrypted: i=1; AFNElJ8N3Ptxcdo+i9WUv9TGtA2cAXLBZKTCAdb6WyB5c8NK6hMo9rPv294p5v6h5fLcupVESeyO7dIj9d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpcxfOs3g4usnba9WUqYBGH4HNoIHrOAGGbU6yW/ri4eKcNcD
	NMBjm1cRhf4ML50WjDaNWQen202I6rhRnLXLXpkOJbIbEEV8WFHfn6Zx/O6Sqyk+PpPRxglTnsD
	XfSoFa1GZqOb6hv7xgjxAWRhcHqmeyUg=
X-Gm-Gg: Acq92OGSxoQ2AZjf8usWaCUjRBTFPo7awZuJS5bJcvdJEVqkY7qqEXMFCnC/wif3mmQ
	tt/lFwXYHwKrj9GiV7n72cULrm3iZFOnruIeNFHmWtymkJbKKMP7h23OJPw+mAxlCZGFs3yBzZ9
	gYL/1fI4sf/LYALkNHlH4Zi029kDb1IfYaKt2/GWkbaKzsNvUBqYSx+tXRYhYWyHKGOezbJnxJR
	N9gGniYrdPKKoqFVAFGxKC1CIkRViVeEh9y0TR+pPv81fjMeITeekIxbLpyeoLFKQJVjxX7SY6X
	k9ZKENBtPg==
X-Received: by 2002:a05:690e:2502:10b0:656:30a1:70e3 with SMTP id
 956f58d0204a3-65e228469fcmr21616339d50.53.1779308032277; Wed, 20 May 2026
 13:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520190851.11390-1-sozdayvek@gmail.com>
In-Reply-To: <20260520190851.11390-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 20 May 2026 15:13:41 -0500
X-Gm-Features: AVHnY4KCFR0zVoLdvq5JpkS8mXy1h61pU_8YFUkhW1KUZY5hKKPc0S96u6mS7LQ
Message-ID: <CAKqfh0EPXX1zh3ScPCyBWhSq70wL3MpnUW9TV0Btn5LSF2EGuA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bno055: terminate dev_err() strings with a newline
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, andrea.merello@iit.it, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:27=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> Two dev_err() calls in bno055_ser_write_reg() and bno055_ser_read_reg()
> are missing the trailing newline, so the kernel log buffer continues
> the next message on the same line.
>
> Add the missing \n.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/imu/bno055/bno055_ser_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/b=
no055/bno055_ser_core.c
> index 48669dabb..733f9112d 100644
> --- a/drivers/iio/imu/bno055/bno055_ser_core.c
> +++ b/drivers/iio/imu/bno055/bno055_ser_core.c
> @@ -288,7 +288,7 @@ static int bno055_ser_write_reg(void *context, const =
void *_data, size_t count)
>         struct bno055_ser_priv *priv =3D context;
>
>         if (count < 2) {
> -               dev_err(&priv->serdev->dev, "Invalid write count %zu", co=
unt);
> +               dev_err(&priv->serdev->dev, "Invalid write count %zu\n", =
count);
>                 return -EINVAL;
>         }
>
> @@ -306,7 +306,7 @@ static int bno055_ser_read_reg(void *context,
>         struct bno055_ser_priv *priv =3D context;
>
>         if (val_size > 128) {
> -               dev_err(&priv->serdev->dev, "Invalid read valsize %zu", v=
al_size);
> +               dev_err(&priv->serdev->dev, "Invalid read valsize %zu\n",=
 val_size);
>                 return -EINVAL;
>         }
>

Sashiko seems fine with it. Also did a quick visual check and looks
fine (not compiled, but I wouldn't count this as a functional change).

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max


> --
> 2.43.0
>
>
