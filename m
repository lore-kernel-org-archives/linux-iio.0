Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A902DA756
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332759; cv=none; b=Md1TgOV6U73faImbRklvveOONrXzygVEtCpy6fkS063ShkCFfW5DzO5VvMKCDRRiOaB2Dfxu5qmBA4lOWFjtXJJqIgdGt7fo7Qzntqf2qejgAoDszJ00U3Fl0OhpTvpAVtxr/nATZSiT7a/xmMvBPnQ0RciXGrfmJKnSq8SS6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332759; c=relaxed/simple;
	bh=nu+PU2gUjB9x+fLthGFREovw4Q33RRbgNLncpeP4XWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwl5R4nZBTIEE0Xf36Ty4DLHApyyMMrBLZYEByeHecPsDLjteZh8/AoXT+qCNCuzCdp6hkMdzmqvoor8Gr6FIoMfy8rC1Xc8iQ1rttaAM8RSS0eW0NkIoxrEibJ6ATBxEF9YpGC5LqJhYOBDqALT2PtRA5Qw+WsUVcYjMlbUebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCmja8Zw; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCmja8Zw"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-48544493bd1so5875114b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780332757; x=1780937557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9MsqFhxLpLjUS+B+U5UhID4RTVWC4OiYp1NX3pQYBM=;
        b=GCmja8ZwlRUIHm5dCk6TiQ/DT75WTp9cvMCR2SBy+uccsx3/q/JbDRxss2XGyYh+zU
         9ySw1/bnxPlck+5AphwA0N84Rx+9nLR2ed4sLhDha2nXXdyjOP1OhoXifg43ofkMrzRn
         Gewjp/EoUYEyZJF5WLfq01IW2NVLD0cOinBMRKSzV/0J68O3Nk7+JSMjNIzzRUnr7bFk
         SflulRXCwRLj1W6Ta5/61Hdb0m+iqhWA7IR1L5RRpK8gD7gtiY6UPqU7+sRoDF/zawAY
         Eee6u4j0XGMt37AlUSuUKs/p3MBwsc0igXmEG0Y4Ao0yvONr5wMllLt0kn3MqR2zPl6U
         iiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332757; x=1780937557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9MsqFhxLpLjUS+B+U5UhID4RTVWC4OiYp1NX3pQYBM=;
        b=nTMFDS8aWXaA3PFnqnVCzfce32ztYLQzn3U2D5eBr9mOwy5TJulbp2q8ItTZQrdoid
         TSM04YlvCuX4ilgSU3Kzj7IO3vyXU3gmoUf8epDa92nvPaGPh3bKB69UHO4pR0IYr9+p
         lW+8txh2M5wO90SdlgeuUJTtGdhHZ4vIgYludNLgMfHTKModWO0darsSwVexvP0Ao1Yn
         p1/5n1NCPY+15JVTeYiEOiS1B0o0LQg6cmUjlRY+7zXF/7oVS7HscE4IH08TB2GIkOiF
         YtwKtopDwYfoafE//d3YsvqCoWTlBfqAYAxNh7Iwput5zbzZ1Gkva9Of0ND1yob0qU0u
         sbvw==
X-Gm-Message-State: AOJu0YxnoiDmIJY18tLV29g39B96S1PN/0iL4Fihg9o2KVZEGgIPrZgI
	wq19+UeWb4DwiSZad0DIo+S6wnj8JIgogGtXlMhqaQDomVwhU4OoD3Np
X-Gm-Gg: Acq92OGV+BnbGYsJe/kYBLaJSIXakWJLWMgYYgmFjz2MWEY7/WrAC0c0aaC0Zw0lLbV
	+wMj6FfDyNmBOWhYziGaCnLWpYDU3k2yNz+ChKbvEDzux+CRY/S0tMytm82Lje/XwxUYLxnzd4n
	kaRSLtWyqvMls0JmskPgyT8wzWPKcDhC9vJTp9O+YgmjrklsEA6Tvzde+ReKHqWGxX8XhmMDYMV
	Pd4lryfWNutAe1WsW5ZUHXLXYOSD6GKbqGXmmeMGC59qNSJ4GS1AH4xAC9LQprqnSDXvWdBXgrH
	oGt/lbBPUCGFszgJVgYWtl3Zq6Vqr3nfZnwRaaXVrwZaFohKFortMLoLj7hGnOAYwHZxLi10lcC
	ZcdJ99PASCcQMrpOxieY5AnatdiaNWCVtNCkhVjNGn5WSGdnv863EDDZQkWIuI9LH71JQlMsY89
	I9zdDEnaowenTqHbH1IK5s0camP7jg/+PwbMilCHMj49IM1mAGVddP9d1Bn5ix3JY=
X-Received: by 2002:a05:6808:c1a6:b0:467:1a69:d0be with SMTP id 5614622812f47-485fb47f366mr6604182b6e.32.1780332756955;
        Mon, 01 Jun 2026 09:52:36 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48606166287sm4481012b6e.12.2026.06.01.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 09:52:36 -0700 (PDT)
Date: Mon, 1 Jun 2026 11:52:34 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Joshua
 Crofts <joshua.crofts1@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH v6] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <20260601115234.36867d97@linuxescape>
In-Reply-To: <e0a07428-9931-42d5-8b29-f92806ec39a9@web.de>
References: <20260531233828.60697-1-m32285159@gmail.com>
	<e0a07428-9931-42d5-8b29-f92806ec39a9@web.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Mon, 1 Jun 2026 17:38:44 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > patterns and to improve maintainability. =20
> =E2=80=A6
> > In addition, small refactor to replace "?:" operator with regular
> > if/else returns. =20
>=20
> How does such an information fit to a known patch requirement?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.1-rc5#n81
>=20

Good point. However, I think that it's such a small change that nobody
is going to care that much. We'll see what Jonathan has to say, I
suppose.

>=20
> =E2=80=A6
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -368,11 +368,13 @@ static ssize_t calibration_auto_enable_show(struc=
t device *dev, struct device_at
> >  	int ret;
> >  	u16 val;
> > =20
> > -	mutex_lock(&state->lock);
> > -	ret =3D scd30_command_read(state, CMD_ASC, &val);
> > -	mutex_unlock(&state->lock);
> > +	guard(mutex)(&state->lock);
> > =20
> > -	return ret ?: sysfs_emit(buf, "%d\n", val); =20
> =E2=80=A6
>=20
> How do you think about to preserve lock scopes by using scoped_guard() ca=
lls?
>=20

Generally scoped_guard() (at least in my experience in iio) is frowned
upon because of the hidden for loop that can make normal things (e.g.,
break, continue) really weird, plus guard()() with {} is also (in my
experience) more popular over scoped_guard(). In the past helpers have
also been liked over both as well.

--=20
best regards,
max
