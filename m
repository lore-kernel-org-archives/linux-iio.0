Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54E3A9D89
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855716; cv=pass; b=VTKLrJPU0UHvYgplR44ixS8E4ZUOYlY8x/7uN1Dk0gwnJxXT4bW2zhafCkSIud0ajXUufmttrifnZ3sQsYwtWlpBPekm/rxwKCD5B7CfZ1CZqhvGX32nvA/2WODgKw2dIvI5bqurYV1ib4oxI2Prq4lsk9ObXMMhDR3vGhEbxAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855716; c=relaxed/simple;
	bh=iIGx3wWcvy2hW++9/pqWeIQsqWoIHGLW3SARD6WBHuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxhqA/5F6PWgESjcbp7SO8WJutW/tOOAGikeN6/mNZRj9Vlr/7MZgDWLGBDlBXuMHSqFwJi8LQIcePR8s3nfpSfeJzsQ5c2TyTwLUg83/ts2csDVEeQVhMXFJ+BE8Dk70zjVZbR3DOM9IuYl06ds8uoVhhYxynKDqwNKgsIxbww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhqRS7YH; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhqRS7YH"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c5361142fso12393450d50.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855715; cv=none;
        d=google.com; s=arc-20240605;
        b=RZYIW9KRrVK2sJX0+QlKMRp69udj0eTwMC30p2sjVrVTapdFHo4LpcJ7rzDlSfRKiz
         uwwg6gQ3bR5KBqZfp8Up2wQjJY2jXarfGXv8G8QIF95lksb92MmKXjo/kptSJENLYOAb
         uYQ022M4HTjyb0ljDzEvX/r6/DTU0uuikc+qh5YkSnFtHZ+4sRB5fKvnf2W2m1zdJCZx
         B35EDQzPICk7pyxF9BZv8eptvpr6sfxTbRzDxjGFxyAkhCyoWDL2PG7lUQZC6RQNXKo5
         M1m/BPWNXBg7KPhEqt83QDqu3RswRHyqoWU3ox2YZpPAqcuP3relgPq0AocWlWPkJGTl
         w6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DX5ZKB9f4dwcj9Cdy6Hzvwc/BA4Io4VFjHj9xGpv0PY=;
        fh=/JkYBjgzVR4BgWQR/WYKkI8HIBSmymYCjT01Ixbyanc=;
        b=IgrSqmUvXbxt8hMvTYSE4DzufSh5FcgKvXvcEDJIafVr9vVE/WfvL4fm/0xgj/yRFZ
         ELEHk9Wb2hreYTSp+3lyfSRP4Ptjb/HYe4T4VCioOw9Rv7671oef/zA1JOwSl5XtzqsX
         BuWCEKG7idit3kMkyMQNLjhYs1WgmX+SOxWxopbFp/+bS++iC/N8wA0q3t78qrz1hYtj
         D1FSYMSY1OZTaLqKu9E9CGsZnBgpkJRV9wBHilxd1mFR1F8QWUT6u5bDs2LzDhVjS6OV
         8fGj4AM6H0y0GiFiwuQEni6MltlTQJOiWwK1M9pY00IwdOHLoW3VsayCfXD/y0jGmqAh
         24Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855715; x=1779460515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX5ZKB9f4dwcj9Cdy6Hzvwc/BA4Io4VFjHj9xGpv0PY=;
        b=NhqRS7YHej6hz+do3ie2uR/Kwh+aWXj0RzSOI1zR1xj7GnQO4a78UIleSJOfZO/aLT
         T0npTjqG1A23r2HDo+IGaX44/dIjG5bVvSXWTdqHbV6DOEUQp16dQyFrBsG2ScSLX6PZ
         34++LgzxPvYY5OJqX2Fb7trstkMcuBYDskAIRaQERl0NJg+k5/DPsR/T3Jq2++Qg6l9J
         ypPhVzQQ5lFx5mEAKRDoWim1YnNxF6JvTO6lqXHFIA9XRehSMWd0uEnf+wbaK1MtsQHr
         Hq7tgMrrNNxuhUZ6L87DcPskb01CCklX3yHBLD+maQnFoet1QrhNpEWlUiNi0doDkH9c
         N9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855715; x=1779460515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DX5ZKB9f4dwcj9Cdy6Hzvwc/BA4Io4VFjHj9xGpv0PY=;
        b=LsGmafgXNUgrlGOKA7qdWSw+ZTYAylkDolM5ezbYXLd7eNG60ayN8Serna5f4jjqX2
         NRZRbgNKBtSVcNqIgggN+X/SZydkCov93LGzFjk29LMatVHU9qv7cRQOnNseqNsKLoMF
         9Lshz/wa1JjsPW4Hqn3svcy+NmD6QInPOgZFMH0eZr7OEidH6MAyK+NQ//Tk1wBEaMq1
         ZVYzSv6RAhB9xLVvnsS7vJosjs9xpAW0z3vjctcZbES4LQ4t90608Rjcir33j3MVlkcW
         bbI51pSKMYprrrmW7dI8gCPe9BODg4cy0LcsmeTjzSF6EvAV1RYsvHzu8WAcUsmoL0lK
         +LWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MN4Zc1CrbNmqFZIR5CKfb7+5c+53MNhp3Zo+lpwj6vM2oBnTMgX9SObstkMlSy3An+ISF67ULx2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKENPHJI7ongPdhB/4QDQHPVXkD07csBgYEK3LD+YwaCNVlgS
	qj/XQmscrtkAVErfersLW2GDi0wspk8Dsp/TylcBybB+y5LBmJLXgEvMXolgN1yvHM0Sr5wRE26
	Ph6tS6DpPcGDPonihQ5XO7hVCbbIk154+9OgLkfY=
X-Gm-Gg: Acq92OEpRcCdAFux3XpUo0pmLkv7p1oHvA75kBpRDObzCsatI5rnyAT6Wu3e4aqvxox
	FPcRCy2yrp98fu8PHdgEkOKwmF6EMAeA4MmAc7Cd6HE37FFUFCq1i48bbsGtrrgNbe3KOiAtNUh
	0irBlcF5iDcF1gaZlPpYQEPBW3XoubHRJoDib57WHYyymJ7DBtkd0eF+QqiLUSXfU9nNUNg6sXH
	TkMKGlPxTzLEuBvv5Ce9yVTe8SpFwp0We2VOkyu2EoEThBa41ksqwU0mAI4lNtfOD+AbiFo1bgB
	R3ckWnNCzShslDCJokXS
X-Received: by 2002:a05:690c:8d0c:b0:7bd:69b8:f2e5 with SMTP id
 00721157ae682-7c95a56f98fmr39785677b3.3.1778855714645; Fri, 15 May 2026
 07:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515031343.56039-1-m32285159@gmail.com> <20260515151840.48a42705@jic23-huawei>
In-Reply-To: <20260515151840.48a42705@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 15 May 2026 09:35:03 -0500
X-Gm-Features: AVHnY4KptTzsLcEKAGM5ihlL_7QTTdPjXg48kurju3Hxuqeoyryw8u4tBBEd5m0
Message-ID: <CAKqfh0Fi3+jDP_UeKuTvdc2QkB3jttgRa=mjhgPPppc9sMkc4A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: chemical: sps30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 9:18=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 14 May 2026 22:13:42 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Replace manual mutex_lock() and mutex_unlock() calls with the much newe=
r
> > guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> > modernize the driver, and to increase readability.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> > v2:
> >  - Switch over some scoped_guard()s to guard(mutex)() per David's
> >    suggestion.
> >  - Remove redundant whitespace per Andy's suggestion.
> >  - Add new wrapper sps30_do_meas() per Andy's suggestion (see commit
> >    message).
> >  - Add Joshua's RB
> >    (link: https://lore.kernel.org/linux-iio/CAKqfh0FWig8mRR-xhvnfcFeSin=
R6RySyPaf9Gbpb6WU+diiiUQ@mail.gmail.com/T/#t)
> >
> > v3:
> >  - Remove sps30_do_meas() wrapper per Andy's suggestion.
> I think this wasn't what Andy meant. I think he meant just
> push the guard into the the function you were wrapping.
>

TBH I'm fairly confused on what Andy wanted in terms of "what do I
wrap". If he wants me to put the guard()() into the function call
itself I can do that but see the (ps) in my other email.

> >  - Remove Joshua's RB (major changes).
> >
> >  drivers/iio/chemical/sps30.c | 29 +++++++++++++----------------
> >  1 file changed, 13 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.=
c
> > index a934bf0298dd..9cb201cf0f15 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/crc8.h>
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > @@ -111,9 +112,8 @@ static irqreturn_t sps30_trigger_handler(int irq, v=
oid *p)
> >               aligned_s64 ts;
> >       } scan;
> >
> > -     mutex_lock(&state->lock);
> > -     ret =3D sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> > -     mutex_unlock(&state->lock);
> > +     scoped_guard(mutex, &state->lock)
> > +             ret =3D sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.d=
ata));
> Every call to sps30_do_meas() is done with the lock held just over that c=
all.
>
> So just move the lock (as a guard) into sps30_do_meas().
>
> I think that's what Andy was suggesting in v2 review, but maybe not!
>

Perhaps, we'll see I suppose.

best regards,
max


>
> >       if (ret)
> >               goto err;
> >
