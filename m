Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B22C21F1
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365864; cv=pass; b=E9pfJ9oZoH1WQXNqAEEzCpgVneCTQ/D+ri4jDR01QkEzTDbBk2GVdh/sFqoLuPoBgkQximLrnKXmdOAZT9a5k16eZ1h97nezd7INGHC69/trdTaB/dOy1nnsnLDsUxxm3MyM7RVQrVlb7cn8HCnVpQa6cBEWhug2II9Y83SQcvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365864; c=relaxed/simple;
	bh=5J9CqOOH8go5xmR1/RNDl2/1339xnh1rexXK+PmNS5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipy+6T4oGYpiyn93ODtlCiJS8AMFmu33aqN52Nx62Qvq3bifacywyAZjHrg5nuv3AKCFNgeSWZgqszMK2nnGgOgKEP20hh0VIWeT5v3tz9DOaCaf5JRNgVhTuSg0nDUpEK1LEbsEL6dOaQeLAtwCWwlm7Ipn37PZM/gAV+x8pBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5QZZCWx; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5QZZCWx"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80c5cb9a888so74523297b3.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 02:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784365862; cv=none;
        d=google.com; s=arc-20260327;
        b=JZJYL1CmU5zg2mVvJlaaE3iQX+cLfe5w6wQ4wMRhTyZc+0kKuOLjv2tXR7WpvCqYJA
         gruVdd55TnJAr/Qudzc0wyqbPwdegtPCDpGyJF10JPpA+xdv8W1292usi8ouaDmdC+WT
         EN5BNWPLDFl12DBoJ8/c1mcPYLJ1K0HajkYgfGP4avUWJeqYBtK5QXn39Hr9mRkxMSQp
         rDuBNu290GEvmAsZaDvl9urD4GnKXes6a34+mtLMq5YxCzIUJLA+YBHVLangCEGA470l
         tFksLmSkhk3EWtM2FVfY0V4a3Q72FPC6MQlxyMgftEkAJggMzF7fC5gbuy7F5FaL4Git
         EGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZacEorimgeuSylOQpgqhCkmbSUHELcnUt9DmQg6nUc=;
        fh=OQM0bJRJlx0mvNs2ZXGRWrhaQTKnyjq70sINpqXJ9+A=;
        b=Y6KRexP/gdi6bPaA9CmzKy8ikFUFfXlrkXvWDq2LhHSyRYIYqKPJ7WPiGaaj9BPh/r
         LUT9gXX+p8/FYfeGD9Q/JFGJLckh1IKnK1XHoXlOYW8sJ3A2xhUKG3Z9yLaePGI8Yr/O
         Qv6NfoPoAVzZTWU/X03LP/4c7lELPG7MQcfcac02Yyp8tcimPaD4aWO1cVfsR1DArkkQ
         drTkoyMKJtqIFftAGq5OcT+3zn9OTrD0jmJjyZuh7Ov+ial+YvixuEjRp+QZ9siGwRrA
         ckWvQ8HgKvbg1jzrDFo5KSbKGrbSw2t+VsY0dNb8zgrbXiVbcM4RIs9hNvg3YemnpnW/
         9PTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365862; x=1784970662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZacEorimgeuSylOQpgqhCkmbSUHELcnUt9DmQg6nUc=;
        b=A5QZZCWxB1FLaDRvhyv2XvbmNfuVsCeUoQ9W4QXljwUFS4WYj2SHNZVFnhm4EVyisH
         2OiIX1NWESQPRo6HVLm38tsWVhCWcu59QCFsaaZy8RpcNihq4wG26RjUv4jodH/gAzUj
         APAFj/FT3BTHvaTpMWVGbJgCkZNfBrqNQwH0JEjfwYgdcaboR7WBB7VRqdMEHFn8ykFm
         wzqsy2xMRqYdZGG8iLkp6uo1E+dMAzXlUnL9OVipkXwEpQptIktGu0TJrZlpsjgh7Yjd
         L8jrcjW2OkKwmHDpSJ8Y1bmPPxoU1CKPBVAp/2A1+E21iiUJq7XW1KIaHKLkpf3Z0WqH
         uOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365862; x=1784970662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZacEorimgeuSylOQpgqhCkmbSUHELcnUt9DmQg6nUc=;
        b=OZNdefOdEemdMTDpvESYI8Al8n1I9Ex0c4VIBPDH1TtJeSHkGSUwZX8L9kcorvpbz5
         AOS4Vkw5Q59llv+NWy77eE35GWk6TFp42oRWPdJyiUM25QK9gyd/S10kXmsZRDLYH+WC
         4GmMQKvePkqILn8qu56TxX85E2yYce0MDwsLPHISgv+OIk8cZo8RYl9LheUadoKzzi5r
         yRo0Fx6lRW6FQQTM+8Ue3CPW/9do4tqvQ9CFmLmhjos8s8Tqc9Bs9ayrS5RAHTeJnmjJ
         VgGCbsWzilptSNw7ODb9IMxPlX39LiP/FwxH/CXzyJFOJhK2PevYpwsvoUk+lwO/6ZGb
         dSjw==
X-Forwarded-Encrypted: i=1; AHgh+RrT4kiQpLNTIYbLYexAUcxDZPtYI6H/3IPKSXA9dOd/GXPV6QMEgph+J6WN+cTvk8vjzRiw1Mapz84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAsZChZ5kN9VqzVxpnWUjzIEJrGJdNlgNurNcwT047UuGHoEm
	Q9wZKLD0xhUbBt1P5AvrBVkISFdho25ocZ/ExZY6/zs+m5kM1FpouoHxPn+JdR+mFvhBOHQnjXk
	DIabLn1S2MEPoZYLA9ko8e4PdpFMvayM=
X-Gm-Gg: AfdE7cnxiw7AkkKX8X5+ybLz86y/1mzcRf6sxXi9kGzMSBd9V3HIEONUoBMRhwMR/ry
	9fwkwgnvaXlndFGS5d74dr0qmBGXk1BMWFx59nSY1Iwtgke24V/BU+E2CuJ2dis4O6iAPjKnxCZ
	4t7pVLe0CzJEy5EyQ65j/ekHnpE4/lUSNY8REwVXZ02MoHM45Qg0J5UeCpAdR4t8Eb9J8T7mN6T
	gjsDTTsLFIeC4/3EMeMi7C87F067hiqU2DtgMbbF4aCdHuNxRQBGOPZZbziFX2PrgpOxu9Lpx1A
	0rqYR2Ep8GF1P4Z7gEw=
X-Received: by 2002:a05:690c:b06:b0:80c:85b6:75b9 with SMTP id
 00721157ae682-81ef286e6a6mr21671667b3.66.1784365862160; Sat, 18 Jul 2026
 02:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717094408.509583-1-panchuang@vivo.com> <20260717094408.509583-4-panchuang@vivo.com>
 <DK16R0RUSGG9.2LHH6CNKD0IAV@maxwelld.cc> <20260718002403.6034f4b2@jic23-huawei>
In-Reply-To: <20260718002403.6034f4b2@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 18 Jul 2026 04:11:58 -0500
X-Gm-Features: AUfX_mwfFq5ChrNvPPUrty77VwcvBPCYTVWQgunI0oEdwH40QxWccLVrG4GyFAU
Message-ID: <CAKqfh0HT3qxdPjw5s-5RrZUZmCyNbJbLDsQ9vaCYRXhj6X0KCA@mail.gmail.com>
Subject: Re: [PATCH 03/13] iio: chemical: Remove redundant dev_err()/dev_err_probe()
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>, Pan Chuang <panchuang@vivo.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>, 
	Tomasz Duszynski <tduszyns@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Siratul Islam <email@sirat.me>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 6:24=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@oss.qualcomm.com> wrote:
>
> On Fri, 17 Jul 2026 17:05:22 -0500
> "Maxwell Doose" <maxwell@maxwelld.cc> wrote:
>
> > Hi Pan,
> >
> > On Fri Jul 17, 2026 at 4:42 AM CDT
> > Pan Chuang <panchuang@vivo.com> wrote:
> >
> > > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > > devm_request_*_irq()"),
> > > devm_request_irq() and devm_request_threaded_irq() automatically log
> > > detailed error messages on failure. Remove the now-redundant
> > > driver-specific dev_err() and dev_err_probe() calls.
> > >
> > > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> > > ---
> > >  drivers/iio/chemical/ccs811.c      | 4 +---
> > >  drivers/iio/chemical/ens160_core.c | 2 +-
> > >  drivers/iio/chemical/scd30_core.c  | 2 +-
> > >  3 files changed, 3 insertions(+), 5 deletions(-)
> > >
> > ...
> > >
> > > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical=
/scd30_core.c
> > > index f85cdd8bd84f..770571c21521 100644
> > > --- a/drivers/iio/chemical/scd30_core.c
> > > +++ b/drivers/iio/chemical/scd30_core.c
> > > @@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *in=
dio_dev)
> > >                                     IRQF_NO_AUTOEN,
> > >                                     indio_dev->name, indio_dev);
> > >     if (ret)
> > > -           return dev_err_probe(dev, ret, "failed to request irq\n")=
;
> > > +           return ret;
> > >
> > >     return 0;
> > >  }
> >
> > Please split per driver and resubmit and feel free to add
>
> For large and simple repeat actions like this it's a trade off between
> the noise of a lot of patches vs easy handling of any future conflicts in
> backports.  Given there are 60ish patches if this is broken up, it is a
> bit marginal for which approach is preferable.
>
> For more complex changes I would entirely agree that one patch per driver=
.
>
> So I think I'm fine either way for this particular series.  One patch
> per directory, or one patch per driver.

Just personal preference given multiple drivers and multiple
maintainers. I suppose either is fine but I would prefer it split for
this one.
