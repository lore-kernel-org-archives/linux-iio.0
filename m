Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911D32860F
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661382; cv=pass; b=LVgQX5EhW071kYtaNX3L1Qy7haIoWZmegpxS2kpL6/jA3oizesKuS9fedacgrmFdyZumyyiqN9lhSy3X3yrQepygZMpXkgaq/vFY21E2NDllL51LzgjG7qBqhuF8rWducWLhzD1w4EdxpuVidrCp3K9Eq60mg45pVUmNwG93bH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661382; c=relaxed/simple;
	bh=cLr9zIjW/lPUtzLFwkeLnyeAFKlnWE8LbrN6Kpw5kWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODAzjY6M0EkPCw2+J/RTqtnL2PsKTW2MxzgKEoonu/oqthgIgvOjWQ0XCf2JHxynfCuKWdfYtZDzVMgMc/IVQ3bN/QrAxWm5dZQK2pJRJ7jlIE2bHzkwBpi//3xkVm53Or0lpQeUHZbpLTgtFk8ux1yTuQmZoeFS3PXBdCxAemw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDUBCijL; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDUBCijL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba36357195bso280609866b.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777661380; cv=none;
        d=google.com; s=arc-20240605;
        b=g8yzZfXzweCxwzqgbOxtdCjsV5qXC3TZ/OzL7+eKrXr+wZMK3ryhZeR7gG9Le1aHRt
         +Ot+UTHkvnL4adDhi2AF/wm/1rT5sHNTVW4zaBILaZU1bI+vb4SoCsYkyg76SvHj5t2s
         1d7jL28jsvOD/KZ9iAgXCTsR0Fi9wlgK8kt0GE+U++O1xI+i1MUm2FMoK0QbuhDOLTAO
         Aj/Dx3/jcmp532tZuyG00OIGBi2NdTNQYkOaWComb2xxZmAxpSacO1/mIaHnWjMln5PN
         NfWN1Gi504XMdbW9zAI0IJtQQdM4dh3Z4xkFRxSOrjthp5hVSX8p/PVc0ClDuhUIxAG6
         8rFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLr9zIjW/lPUtzLFwkeLnyeAFKlnWE8LbrN6Kpw5kWg=;
        fh=P7xZthpgtR5f31RKQdTgMur6XPHm4VxndZ9Uxe/sLLE=;
        b=XcoWVr5P5t2CtpsXM71bZ2aGHxGlRrZPCRUkhKZcyFerU2N59MwoxUYX6mNdW0ax4s
         m1iLBaiQrC1I8ZQH5JYl0rGHpJswZ+1awofIQ32FHj5UGsrid2CXgDOKZLPU4WB/hfis
         G3YGkycLrNmgdA6rqTdUa1dYuwLnaftoPHSRZEpzBPZwseIL09j/3uDrQueB+SUBSkZp
         CRPVIKQa4SFWYMADEPfdFeMTfWSb0zDo7La4UscyGBbIHNMKoJUL62ljC2GwX/5VLM6z
         HeguDVdqBYF18aRcAE8m8k2ViDYGKNbM3XDfR5bFPgi1NOwZV5YP4iUU+VfdEiaJM+Dj
         R9YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777661380; x=1778266180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLr9zIjW/lPUtzLFwkeLnyeAFKlnWE8LbrN6Kpw5kWg=;
        b=qDUBCijLN0G2Uy2Q4+5CAPY/At6O2Hoy4cND4Z8waw7rHaICnOnHBwSDeJt8JtCrqE
         DVYp4yiJCxSiOQrS7+69QxNRwPIDDmkisvaTZw2DTIlsEMRyC7bfs1NuJo2pGxU+ZNRo
         cG6LaXvPkN5zJZX7/z5Ke9utpnx6H+LCUJrm9wLVCN6resictmHZ4KbJI8CXYucjby2u
         wllZOWOIXMKmH67hOu6SeAUpq7tfMYkIQ5s8I4OYUHR488+9lEEdbHBfIrgcVWDRdYx8
         JkSclsFgfsg/V5ZJo7PNeQ5oruUaJi0AoL9FVv3Qb+M/0yoyzXoe7XSl0hCRQg9E4MJz
         iLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661380; x=1778266180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLr9zIjW/lPUtzLFwkeLnyeAFKlnWE8LbrN6Kpw5kWg=;
        b=jAZOdpHb5dt+zxQCqNg1WJAuoeOe0+b+YemQwS7jmdsyTjAHGE/kD4GIBD8S7x3Mkb
         IDeuYa1tuZJRPSs0WlbwWcQh91Lu4L5knXEWZz7t7d6islTY7F3obo0aLLVOfNKR8GB5
         1Y7KvvizDrPe6RiNvaaSbpCZe05K68tIOJv6BiyiLST8sm32+b6fhF4SUzcnL9JNW/gU
         J1X1LQz12KBD6TnwFvNsMrFAxs2HEYYX8DmtA7P+xtYkjojKuexHmCB5trWU6cSQzXyI
         2eh+WmyCepaQ07L+CKPMjI41Lj4qkayJzrO68NWPtQP9Vbi9J1jVN1JKrNtjVA1tMK1W
         o5KA==
X-Forwarded-Encrypted: i=1; AFNElJ/6ETAyp2kduavjpedIC8r/nuOsdxFKN5OMNHDqq+WY3MNLYumXeEdRp4/CiRtmsXpjGdOcUGcajaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwaLl2bBfVisudXIXKaoqV92nyWFnx4Oj39qBPOU8DELqitpV
	mAWJCkMI5mPjM2w3SMJkykGx1MhA71jBV03qA+j77Rmv7j6TwSuENavSK+zWaFDeg8rq+0TlCOG
	ecDmV+4ZpNsHgir2O7t7epawo/GA7CJ/zBMYIhdE=
X-Gm-Gg: AeBDietZtUZWvVUlR2bvk4ZoFRVz4kgHVuf0ldEn0x+GhaFCHBIxBsaXRhLZPsuYFbe
	f+WLsHNvFG1LhT3WFk8jxsKo/yyfuGU1arav0PZc3FKksjYqunBGlirln7ksbMcwdSKvhpqIlQd
	yPvFkMhNSSEvwg6DeG3Hlb6g218paLqzqQJZhQ39UXG6GYDNz4yLl5/fVXwHldIvOwH0ILwb9cw
	szLGzVDU1JO8zr473H31ScbYZIiNt7c4xd/+LyQqJFkX18iwbPTVbzSmiVwZnVXOcYDwRvu17Z4
	bRFMDCz2whDtkeiizwuPyiGIBPLAa+JfVPoQafWxyC2GO3L47RFy/QSYDtpq3A3RmZKgq4C2uM4
	5t0SD3BShG4jxZ9bTZZvEXGvRLcdw
X-Received: by 2002:a17:906:ee8b:b0:ba7:4cd9:ca26 with SMTP id
 a640c23a62f3a-bbffd8cbab8mr16230266b.35.1777661379599; Fri, 01 May 2026
 11:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
 <CAHp75VfsEkAWfiiNu0xPLLPN_1KLdxfoY_g+mv2bQRkgQpfyUQ@mail.gmail.com> <CALoEA-xP8PUpLFWwGrohHPUSC45jJhNuD2db-kFFo0AoH8SX5w@mail.gmail.com>
In-Reply-To: <CALoEA-xP8PUpLFWwGrohHPUSC45jJhNuD2db-kFFo0AoH8SX5w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:49:02 +0300
X-Gm-Features: AVHnY4IVPfA-4HBK_wh_m-ON-Rf4cEK2z0PfVKmx3sMvVojzKTGFn4DPx15ChuU
Message-ID: <CAHp75VcVmhO0WwFwUL=hfXsNd=_LaXMBQS+zTx4UpC8RvKytQQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nish.malpani25@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 9:37=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> On Fri, 1 May 2026 at 20:15, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
> >
> > On Thu, Apr 30, 2026 at 11:05=E2=80=AFPM Guilherme Dias
> > <guilhermeabreu200105@usp.br> wrote:
> > >
> > > Use guard(mutex) to automatically release the lock on scope exit,
> > > simplifying the error handling path and removing the need for
> > > explicit unlock and goto-based cleanup.
> >
> > LGTM,
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> The code is still missing a <linux/cleanup.h> include.
> How does this even compile? (kernel.h does not contain it)

Ah, a good point. Yeah, if that header is missing I dunno how it might
be compiled.


--=20
With Best Regards,
Andy Shevchenko
