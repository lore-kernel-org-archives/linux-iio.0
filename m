Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234A2C2360
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617890; cv=pass; b=ncpu6JGN27t3pqoFpNJQPiw2En/fOXToXEHe9e0CosWyxgCb39xUgFxWu4FRxI/IVOO92d+CRs/M8Su1FlyAYCkmVz70eo6UU1u+Hn2s10qK3r0c8NgVFxQkDJ00zUOy8BetdvZGNUDnDFI9gypkwaLYkyIgczhKR6Sowt0vs6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617890; c=relaxed/simple;
	bh=OysBK6/T8sqagrrfXov/qMriJpIgzowEHeSiKVFz1QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W73KP3aqDfbdNd9ecJHF/DGceTofFIm8eH++dk6pQtguJVagJm2YA24o4JAm08g2GgDPBdpd4Bz82+FFhE9PI2w2Nr73LGdd5lNH8t3SigtnQTJ9P7I3Jg1PcwXhWHVNIivYo6AAG8+yLl0FM7fgsfUTK0BupfDAd/C3/skImEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb7iSdZf; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb7iSdZf"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so20868201fa.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 09:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776617888; cv=none;
        d=google.com; s=arc-20240605;
        b=aDWSHp7i8x7XspSvFX5UG74CDIQUmt+J4E+mEFbE+yMPp2dHNkv4bMGSUlrJpH307w
         0BeArLUdsuI3JOXBypfdoy+CyRoJMUEVULOfMLERXprmjl5v8xVx6WgYSMTFadqf8Jsg
         zvfSniQTl6S9lXsPGVM/kGRrASv18EGEqQHXnQ3NcVmE1ZdSixq7wetiWLdzK+rZxrHh
         r4v7aReSvrDHcaVvKP5nMajJfE/wzn6x0c+vBj32tyUe2LvtZx5T4K0AkOAjpH0RBVTv
         Usq4R6Sm5n+j92ZgjCAGq+QnmymWfsdlPYQ0/unpkyHOiU/chwNLLxBzmHdpqx+/LSK/
         ADug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9SFZhjUcZHpBupNVxmgoVYeJDEYl8FL5eJ0YhgomFo=;
        fh=xPAG54XIgBhuBOmkmKBB9eZ1/py0Nxl2bOhzHYnbfnU=;
        b=Sa5NG8VwY9dgti3Slec2sKc2hpItHn4vVGeSjGFQA9MJVeAX35xhfcp3GHzfi5zD8c
         2Xlu8oga8yEeiUBZytb+c4/5iHo/jXYZeQ0HUhcjXVMU0AomYKiEjKvGAbpzUkVRAun5
         qjao3ES5KHGBVKkBdeJnO57dJdxJYTX6ovjVxSXiKlqOkzGKgzpo8WwEDxDQvjtQMXCY
         vSOzJMtN7xzpmJlYK/t3Q8hXFxrtS4QQv9e/MHTF6W2P8pR3b4GTuD1ioa0PkMC1v4R4
         judgmCGxjxloF60KwV87u+4+Dd1uZ+92Oe9sWGGPTfLM1qh/dhy8dAi7mqov3wK2vIKp
         FPkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776617887; x=1777222687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9SFZhjUcZHpBupNVxmgoVYeJDEYl8FL5eJ0YhgomFo=;
        b=Lb7iSdZfzUEc5/jKpc/eRKivI9qn7es6SMloFfk8UuolgWyL/Tpz6blIZ41IO6P0wh
         hVs/TMZMZYYBSkkS/xdQ2Xrk+iYgY04yOqJNO2hsNpsosARI6Ii6gqJYTvB1zOU4jRSe
         DHUQsHpgLaAqwSjyPfdRAtBywD6HLopepWZ8FpsAtmmQO2vuSJwhvgTPKtAHpah1P/hG
         ki7OnGDiBz2AMfTdk6B7hYzlfb9JIprxNmfQTlUHFUobEyd2XtRbdK9UTSorwMHq3edd
         VWxyyJ1TX4g+wpFWnLmIEfq5T8g2wXPjB6aJLkCPrfRXdxzhCCzSheRmPabyK0+kYs3B
         +QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776617888; x=1777222688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9SFZhjUcZHpBupNVxmgoVYeJDEYl8FL5eJ0YhgomFo=;
        b=YhiwjDKZIRF2emH8/LYYNZIpAgGY3T+VHaidQDSgJBGTab0ds9SXLJCrmkgFpkI0mp
         yt1PSsU24etaF9cBiv+GcnBmVe7hVdlh9upNcCdcbpPa2RmraxtrOMDQalsC1bCP5lmb
         q4Y2U0GjdmO8oC17txfn8ywNcjkCnchACY87MetZ+Dg4VFxCLHfmWb7pgk9F8TEoBpfM
         SnW2yDGtM4D/RKSvUdGwypacMVBHWoZpYfqHOz07wJlbcNkcOBGcQWMiNwyyp1uzPcBv
         ALWgpMNls51ejCtC5n2LbJyC8ZZyDn6786hbQz7BHI2D8AYFODPb9y1h9C7Yg8splIfU
         AXAw==
X-Forwarded-Encrypted: i=1; AFNElJ9v9NzBsGBcEluoGzq4WHmqiXM5y5Eq1wYADjr2mhFoHvyH/dDYmUZBe93EIcoWRktVzM3rl2C/B8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/GWfuRtmkn1zs4G8BZl7pnhoOO0CHItlpI+2wrd4UKSM4RID
	OyJbhG75S47pFC78geIL55S/baigS1Sr3ByW7s2v1c4VasBztn46Ty2/z+z6fDQdJczmfeqIoyL
	A0qysJ/MrYCE75JYKLn8X3ik3qDXftMI=
X-Gm-Gg: AeBDies7RTLq6BmzAi1MXjUZW91F6jqtQPrG13jHekHYnodhfBGSLFpsxJF8ksKV+Fb
	xlOtJWq2T+tfVZeYBzhYJbwlmj7z5H93q9O9dWHTvUmWfnBvNSQ/C00b1Cmg0rsTxfj0HUlzu/0
	CPmOQhO48fNfE1Cj0NgRcdep9S7cpfSnHjangTDsZyAPbFRa2H+uQkig1u5e7PfsYmg1MadlhI5
	pjCG+oUFGttv7S5VwTq0/rpP03jmAXjKJojH/qruUxjXqVuOMDr7f2E4hB1lRI5cxI6gQUD0Nkv
	JTadWodLAkwLwLAW8XYxPLBz/dx6rjUfnmFL3aL4PK5jfFFcz/rrI+7nxtJS/W37fLPVjZMAdbR
	URkZc
X-Received: by 2002:a05:6512:1590:b0:5a4:50:ac71 with SMTP id
 2adb3069b0e04-5a4172c58b6mr2863332e87.13.1776617887293; Sun, 19 Apr 2026
 09:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411051650.11949-1-piyushpatle228@gmail.com> <76eda9d5a2ff1a3a4d21466d78632081dc9a5cd0.camel@gmail.com>
In-Reply-To: <76eda9d5a2ff1a3a4d21466d78632081dc9a5cd0.camel@gmail.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 19 Apr 2026 22:27:29 +0530
X-Gm-Features: AQROBzAs9N2oNI7ok5t5OZWLiFocJw1MLlmnnL9Z9RGm08C4-r6PTSgkLuuhalA
Message-ID: <CAMB+xkaXrRPzywrGeDt2toMDTZSp+Tq6ixa+QR3X3hY1VqA_Cw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r: use field_get() for power-down bit read
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 7:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Sat, 2026-04-11 at 10:46 +0530, Piyush Patle wrote:
> > Use field_get() for the per-channel DAC power-down bit instead of an
> > open-coded mask-and-shift sequence.
> >
> > No functional change.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---
>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> >  drivers/iio/dac/ad3552r.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> > index 93c33bc3e1be..f206bba3a701 100644
> > --- a/drivers/iio/dac/ad3552r.c
> > +++ b/drivers/iio/dac/ad3552r.c
> > @@ -167,8 +167,7 @@ static int ad3552r_read_raw(struct iio_dev *indio_d=
ev,
> >               mutex_unlock(&dac->lock);
> >               if (err < 0)
> >                       return err;
> > -             *val =3D !((tmp_val & AD3552R_MASK_CH_DAC_POWERDOWN(ch)) =
>>
> > -                       __ffs(AD3552R_MASK_CH_DAC_POWERDOWN(ch)));
> > +             *val =3D !field_get(AD3552R_MASK_CH_DAC_POWERDOWN(ch), tm=
p_val);
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_SCALE:
> >               *val =3D dac->ch_data[ch].scale_int;

Hi,
Gentle ping on this patch.

I=E2=80=99d appreciate any feedback whenever you get time, or let me know i=
f I
should resend/rework anything.

Regards,
Piyush
