Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C71624C0
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784463376; cv=pass; b=I3Mu58InZm4QoG96YQrB5ya+vCGIX950Gf1UkmQ6+LKVKe3lGCLbcF7gSsLLph5N1WS8zG7yRlVenTxMsFAek9yphYsek4rrTFd4mgLjEkI4XSEzDhpYJWFnveJj8OxfxSloqw+eus7WMxGkZymV9H7ADpNo9IhXZJFCk//KT/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784463376; c=relaxed/simple;
	bh=7k1ompG3OU00AioG3cVhRo2AcAAVm/R4Z0VlwYZ8v38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS97cczQTMALbDy7ed/R0uGkDtGu25kfJTcwHIklc0GYVMfTSV75lS7CfmLR3+lWg6WVMdjYNJdgnPwJk2vAs5wCmutAxmuXF4Ul7y2pDG7aMI7cPk8WPONX53pG+YUcM7Nwk0yZBxTYIu9J1hSG/fh91hN+ODkgioLvhKoGnZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6WrBuf+; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WrBuf+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2cce930cso57513321cf.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 05:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784463374; cv=none;
        d=google.com; s=arc-20260327;
        b=DwNSE3F1/TUee5u/qJqMm+cSm4i+W/ZVPrr/zTFugDEHEi3eu/8lqdlCGgJhz988NS
         DDDeU7XieUbUpNR9FBTc9uTsyjwraKn6wQ13kTbwLssxXKBksW7/FHl1cLvVe4lAxrMt
         1XDLD/AEnShAK3/80/KS1mzVurDKlmaUQCp+ppUxJwAgzy7d0z+p3xyPYgDVxQEuebr9
         UW132Dg4DCRBh+s+8CdS5oJUcqLmuTAsLXja2QB0SGUrkXCpwOgUiz2Vb4JRTvUbGLJk
         QSI3+UUiG+NGxwFloXFCY5bsjUuKpK4uN/tkuik0n8YVwgoMHuZuVmb/QfGkQpmUZIGo
         vkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0fzMhiju8K2JgRkrOvtst8zgzDyvx9Ag1u6YBLmwqk=;
        fh=WldqJ5elk6LDaSapTxVW+5g+Kkvji1Jxzv2cn/cksW0=;
        b=sHwmPHkn0xq4PKbYMinuuDGsZMS9gmH2gPPUOhyMG1aBhthouiUu5CcN4En1PhfgMV
         fb7f0gn0kXAD7r9DVixB9LKk1EiudzC4xye9D6a9Gqwl8PdKTY9WQ1ziWEPYVAKuAjKf
         G955Jk1wRnw1As0/QgnP7tQb6YZjmH62efyqVTTJHpJ2w/XzoPyFjgyfhC0Juc3nSf12
         JRen0AB2k6N5gPbrc99mKS/nkUnO4WhJwtLGo4idEkOPho8KRlulYoJrBK4SsnDyzvx1
         D0vQ3ibJgMSKgamXcvNqwoZln3q3zC9IfYM8/gvjiXpRYZN2N/KgHPQzJPoHED6YXmQE
         oR2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784463374; x=1785068174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0fzMhiju8K2JgRkrOvtst8zgzDyvx9Ag1u6YBLmwqk=;
        b=U6WrBuf+9z7yrutMtr+QOuySIQOx2pKgfxP5graAPr97T3S07X8NRaEMuDu4+f5F4U
         9t0vDfV7DnERrFnMtgfij5itkxWc6lWnfKMyayQFrg0kNLYrSvIYEOR7ej66P8s3jO4u
         TMBCoKv4roXvZ4Zyp88qs1WCJuXDOduo0hMZZ73Zmea3uyaTvSi8EvJoTTvqRRJssqzf
         +zctM0MM9tbfq0XbCcB6GrlqU+ivOnPwGNg5gJg0kWyAEd0p+6LPMG7EApN8Y9fRTge0
         VoDiW5IukyNMO7ormjajO+bh/wu46rp5HDZl7RIJwmX6tcMlD/xW92gKOYNTJgyGrrtU
         nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784463374; x=1785068174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0fzMhiju8K2JgRkrOvtst8zgzDyvx9Ag1u6YBLmwqk=;
        b=DGy03uP2brH/67iBLJWR6kgKBwkLvSyBgH2EuYHddNpSTgGr/Poou6oGVoEnsEsEck
         OVcBhAY6VHmfn/20XzVliw+INLkUgm6zS/RfRpaaU4Co3Dagg5zKawp8u+/jn6c3khee
         5muOahD/focXRihYiykY/UFB6mUSIPvbkER6vC/DnMfGcl7vlF36NQB7dTSyUiiU8cEt
         vv6BzhdqWu7uifqz/Ve6+2d8BH6nUQ0oruvaGzphgMEAu+Xo1t3a4ZDJ371Hs0OBbzWn
         GmmsyXACZ8Yp3R4WhgweB+iFborqxbS1ThSsEtC8dGXe1JOMMx5tEDtCJnNtlxJPoQQX
         A2/g==
X-Forwarded-Encrypted: i=1; AHgh+RqZYpCWT2fMIXjWfyxzECvz1FaHv8gKvukhLAp7y1lYN38kG8vfhelsYBXsNEgCXM/FPAVleWUTNS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEglCqu1Knos+WFsponWDltfB12hBtTlizmvqyziFA/epQfQXl
	MCQLvWrkwVmtGrcIAg4TLgJhkd/oez2zEPDn+cG+Lu7lmPeyeaTr3lmtsqhACQzYD01pygDmEDX
	Du/kbIJ+l6fUOyCaIktsAkeeOuHyIQSg=
X-Gm-Gg: AfdE7cm5wctCa89k1/btOUvldw0BG/yYEkzjkbemI67iywa2OmPaz51sF7/59kcp1gL
	xevhlnE1KHILua9/5NsSwhcCJLVF2oGvmjLpZ11N7v7pw0a8nVrW+lCzr3RhCpcpaPU+AR9jSnI
	niLFTAtuMgghNOqIiQLkQDBxdmlrCvk0jGdgTLF1PWSTYzjbZggk8jNLQmFcEZM8NFRqnf7vB8P
	HT+tgSwX5n8Ppy5y9t5xD1aE0irrUisTfQjefjwlPIBKQyxCZQTTgF9kQOmzNqJuMYwTqF34yeL
	d6BEBJU4dY1X1Au16mc=
X-Received: by 2002:a05:622a:22a2:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-52140344f93mr93303961cf.79.1784463373833; Sun, 19 Jul 2026
 05:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719000752.75936-1-zoone.rupert@gmail.com> <alyTjkq2bCuTE3OO@ashevche-desk.local>
In-Reply-To: <alyTjkq2bCuTE3OO@ashevche-desk.local>
From: Rupert Zoone <zoone.rupert@gmail.com>
Date: Sun, 19 Jul 2026 15:16:02 +0300
X-Gm-Features: AUfX_mzSykWwwbvhk-HtZVX9fE65Bl6c47yBUyOuOxGzhzAqaReG3QAU0-ag74g
Message-ID: <CABpb+S4sg=HtYRAKOBcx+rH+1LnNbxqvfsxRuW=_kShGc4d6Og@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on
 ACPI probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Eddie James <eajames@linux.ibm.com>, 
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  On Sun, Jul 19, 2026 at 12:06 PM +0300, Andy Shevchenko wrote:
  > As a quick fix this patch is okay, the proper one is to go with chip_in=
fo
  > structure in the driver_data. where the name will be defined.

  Thanks for the review. I'd like to keep this one as the minimal fix so it
  backports cleanly (it's Cc: stable). The chip_info/driver_data rework is =
a
  good idea, but I'll do it as follow-up on top rather than fold it into th=
e
  stable fix.

  > On top of that mutex_init() should be devm_mutex_init(), which is a fix=
,
  > and some cleanups:
  > - unused i2c_set_clientdata(); may be dropped
  > - C99 initialisers in ACPI ID table
  > - IWYU principle for the header inclusions
  > - some unneeded GENMASK()s due to use of sign_extend32()
  > - perhaps converting to use get_unaligned_xx() where it makes sense
  > - use time multipliers in _read_poll_timeout()
  > - use fsleep() and time multipliers instead of usleep_range()
  > - get rid of min_t(); perhaps replace with clamp() or min()
  > - use SI multipliers from units.h

  Agreed on all of these, including the devm_mutex_init() change. I'll send
  them as a separate cleanup series once this fix and the triggered-buffer
  patch are in, so each change stays easy to review on its own.

  Thanks,
  Rupesh

On Sun, Jul 19, 2026 at 12:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Jul 19, 2026 at 03:07:52AM +0300, Rupesh Majhi wrote:
> > When the device is enumerated through its ACPI HID (IFX3100),
> > i2c_client_get_device_id() returns NULL: the ACPI-derived client name
> > does not match the driver's i2c_device_id table. dps310_probe() then
> > dereferences that NULL pointer in "iio->name =3D id->name" and crashes =
the
> > kernel during probe.
> >
> > The IIO device name is always "dps310", so set it directly and drop the
> > now-unused device-id lookup.
>
> ...
>
> As a quick fix this patch is okay, the proper one is to go with chip_info
> structure in the driver_data. where the name will be defined.
>
> On top of that mutex_init() should be devm_mutex_init(), which is a fix,
> and some cleanups:
> - unused i2c_set_clientdata(); may be dropped
> - C99 initialisers in ACPI ID table
> - IWYU principle for the header inclusions
> - some unneeded GENMASK()s due to use of sign_extend32()
> - perhaps converting to use get_unaligned_xx() where it makes sense
> - use time multipliers in _read_poll_timeout()
> - use fsleep() and time multipliers instead of usleep_range()
> - get rid of min_t(); perhaps replace with clamp() or min()
> - use SI multipliers from units.h
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
