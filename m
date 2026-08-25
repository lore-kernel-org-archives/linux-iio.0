Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833B3EEAF2
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650122; cv=none; b=o+cZ0x7ksie5XqUpPkpmwQgxQUNGSpQNrdFUdZiY73aYl1Bk/vPbcJNGGyxbdnCTwDvTLBEfzLM3d0yXU0H7Qbc39HayS7pWdo5dUCp7AA7jjAqGVL7umNgLDhla8zbtcvtYqUMt47NnbZH5rf9YyizOJ/t+qcqKzH4xd7mK0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650122; c=relaxed/simple;
	bh=IjtiIO5zyV292J44z/H7H3qXyCobExFnOKttFC3Znhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbTL9kMNFRpp9okxj2idb6lcyh9M8CpzdUw2C24DgzJUDG6KSI2/W4qh9r8osBy21Le5wULr3jjCr3hHkeXj5paKYlqFqA86To6kl8+CKQ4b3AgkBHVNqtK1C725yxB0gJ/vcwsDOlY6LGMn8npIkBja0sU+2o1LLFrLMYRtUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNWjSsGl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNWjSsGl"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a10d02ff43so8820464a12.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650119; x=1788254919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IjtiIO5zyV292J44z/H7H3qXyCobExFnOKttFC3Znhw=;
        b=qNWjSsGlMG9jLW8JJobGdYlBnM82ON+URjcRiK1X3ai3g+9uXjKa0SzW46xXetm5kt
         xIkbk3YxAoIJbRRufo7TrIGAP6ziydytaO2TGsqVKyFcVuOBUjgkxFs+1kkpV2fMPFSU
         bfc0HdqxrFf8+IR+Un3iSEOUDjDLHpoyfKGX+SkQeMUFA008A/63uVID66DiBaroM3aN
         osPBZP6Ooze5owQ2xWFtsZm6f5ABBSnjPUcR9PNwNOtKc1uSJF+earUYaG03CPAYK2r+
         QAO3uPVqR8J5vX1eY4MEcb5AuT/XcNuuh5XjfU+ZnsD5vbO/c1jAZaKCiKtdO2WtQ7ka
         Yl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650119; x=1788254919;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjtiIO5zyV292J44z/H7H3qXyCobExFnOKttFC3Znhw=;
        b=OLEmG+Zr7Csosu2R2y4y9ML3I/yTBc07efYwpwY2Wn4CUMDQsn7ip1VI9QQ7CRKxN2
         i+FPHXLIO+uOdpksbjp7qJeHI9rWEQgba2LTUJn5/rIip+73thQrlzDSJIGLp4G0yKuf
         lCfzqoVu/Z5P9traxBNK4QGLn/JIXr/30x5SsWRwvW7uo63ezzlfhHTbUQiXS4FHawPl
         IuQ99rIkA3oenPOgOfzWfLYOzasfZjlHkCj4KyFIY8n/psbLnC0CN0ILSRYbcDhPEWtL
         hXTzRoKVGXVvRaO1soWeS7vN4OIrEFLXrjHig16jJBxIzuOw2MpHVPrSN5ZIIWxROCdk
         K5IA==
X-Forwarded-Encrypted: i=1; AHgh+RoV9+NUdMfDzvE7eXkv/YiQAB7nkBd2g6F2tXbjmXYHqxMVj1zvZ0UBH0MKM8tKy4JLKVTX4PA7qsY=@vger.kernel.org
X-Gm-Message-State: AFuF++lq89BGJrTByy3GDuCbxIRxLWVDZYCZSbt+4oXZU5Hw3PRiLkY1
	k4cxBROs0Mqyk3AoefXf1I3dIhujm5R96mxmxnrsYg31yzF8rj45gBpu
X-Gm-Gg: AR+sD13bcliLnmMgbVJHvHuQXK1keDoKhg8v7n1wwiRsCrFrnifBok9cO47Zw5QAV6z
	cMR/5i55yHSqXQ65Hj81yFnYovS17Wr6TFoFqqNLINTeR5fi5ZddlWM6EuRUkq202R/F+fS3W7f
	vU1Y4nHUH0/LF+yt6bCyivyJAUoy3W2xRpWDvCoSOQcmMQa6XXL6BnfbV/A2pxW64nCgho+KGZS
	Pa/2mARLsQPPNfSwJBqjsw+sZY/I0usGQii01CBJQ0oR30w/f9KQkJoFw+OoITtNwFT0QuGzrsu
	e19GcZ1VX8Zp3ZqR4EjZeaZGoeu+K25i5AHh+xaA+62b3A2nZCnUBLm8V7m/Xp4WcATQB4ZYHW6
	36UBhCR1EPckXH9PstFrCpm4Af7QEMPWScjmyasVvsr3Sv+MHIH4fAksfk9BqIH/DzdsDed6rS/
	iU6S7WEotys+s5E2sMGZceG5Yy2VnBHPPu7cP/8AoekTn0DrJHR/jaoYHI64Y2cykbZ55V/SEF/
	20stetYbr90rCeQ3AbnChgJKX5slo8XIvD0tI4VXZitaOCIbXz34Msah8YTf7kVD3pml0fJ2sWd
	nv1V7z1/qGg6aG/AAU8ENcbkYgLArYOn6kFWSuyWeZGFn/2pMwSe7YR0C0O/ngIgHjYZK9QlozL
	gjbgJ25uCG4xBd/5g1PPnkd0qwEL0NjZTYT37urng0qIwRkS12vkccpGHDiXXxUuj6uNz7IHYF9
	txghEI
X-Received: by 2002:a05:6402:a517:10b0:6a5:d401:b575 with SMTP id 4fb4d7f45d1cf-6a5d401b704mr1526747a12.7.1787650118910;
        Tue, 25 Aug 2026 02:28:38 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0126edsm14409246a12.7.2026.08.25.02.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:28:38 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:28:36 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Yang Zi <2959243019@qq.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, u.kleine-koenig@baylibre.com,
 dakr@kernel.org, o-takashi@sakamocchi.jp, email@sirat.me,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9310: fix NULL pointer dereference in
 sx9310_check_whoami
Message-ID: <20260825112836.00002aef@gmail.com>
In-Reply-To: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
References: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 17:18:01 +0800
Yang Zi <2959243019@qq.com> wrote:

> device_get_match_data() can return NULL, e.g. when the device is matched
> through the I2C device ID table rather than the OF/ACPI match tables. In
> that case sx9310_check_whoami() dereferences a NULL pointer when reading
> ddata->whoami.
>=20
> Return -ENODEV if no match data is found to avoid the NULL pointer
> dereference.
>=20
> Signed-off-by: Yang Zi <2959243019@qq.com>
> ---
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 79ba46d8a0aa..305b41f2847d 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -892,6 +892,8 @@ static int sx9310_check_whoami(struct device *dev,
> =A0 =A0 =A0 =A0 =A0return ret;
> =A0
> =A0 =A0 =A0ddata =3D device_get_match_data(dev);
> +=A0 =A0 if (!ddata)
> +=A0 =A0 =A0 =A0 return -ENODEV;

-ENODATA is preferred in IIO.

Also looking at the cc list, no need to add addresses that have "commit_sig=
ner"
next to them when running get_maintainer.pl, just maintainers, reviewers and
mailing lists.

--=20
Kind regards,
Joshua Crofts
