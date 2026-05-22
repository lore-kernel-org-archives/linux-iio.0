Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914143655D8
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471293; cv=pass; b=Pn2yYPVjUoOVbmIf60/xmTvV6fFGYgMDIxTo5J2O/Rl90PLrSVTIOcODGxh0qFv44g5D4czeIUo/HHOBpy4xCUTXGAM5SjD0V299lIuFUI/qOPcegcCPi+ks7yE4Y/wz0YSGN54/xYEBEIsah3eMg/zUPGNskUImPCV/7IrVJh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471293; c=relaxed/simple;
	bh=zFXY25QA5u+SvD2B5VDqUO9RBd848SsKUBG8Jm/G1i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1M/5J3dJrStyolGGQPLliRcPRak9+jb9YgB2+e5ZZUTJwg5plPwsOJ9Qyxzu9PMFFoNCSrZM6offd20xsjZXfjbr4aD7/UbdStYaJAM3+jCI65ROGaVCheLo9uT5yT7hw27vmBeMq84MAuCb4cCXxTqzLQB9qKy/c4bZnv8L60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h95KvUtz; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h95KvUtz"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7b41fdf9de2so56012077b3.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 10:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779471290; cv=none;
        d=google.com; s=arc-20240605;
        b=Jyd3pvTshuKksNOMCz8yO1CJ0kBN/w8MF4tsKk4v++QnN7czqZJqVZChlMWzjLeCAB
         X4D/GTjv23W7a0VyblpQHfau8S3eEpCOS6QXlEM3woq18y15sw+Ztd7snkH3wL9CZejg
         kYGj0GftRxyFX1kspwXXO/jlxoMKvwJhM3qO6YfNi1ubhosqlF2RwrSfq3tl7Ne7HHzv
         oCR7FKZpCg9Etv8UclRHXOVnpDz0dgV/eOgkoIBFqt9tcBBIGdpEXhCP8HHUAN+b3c3l
         lQid5M0dd2q2j9IK8imThOy+n3LGcAcdIG80+3QOyigzgP5bcU+6OnV+Xh5VQOLv/W3r
         Y3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQDCoB4jEnSRG6MW2zUisTJUR6QZjZC1GNMmefmfeWg=;
        fh=sHX47pzxxhfGFJUt1cDKU8PcjnPy13R+JW0IlaWSUvs=;
        b=Y8pfn+8jtbvtWrlUMms/3Q1dGRU70vNWOi/mStkm8FwZW6fgV/ccHz9PK0LU9lqCTW
         Gz0WPv7SnyalTL/+xkkpUpfie5ErddUzqpzukkQAfNOo3YwwZHaXU+7B/wS+6vh74PPd
         oxQz8ugth6eGt0ck36VC6HwzE+N4TKXaIPopPw7JT88eKyZp425JR/zw9WlnWkI8AQDq
         JNLPURW8/YMsQzhQ+tf7YMo0lYIbvrgEKwtOKA7f6Us4uhj8p9Sig8eP6ywWW+UEHCYN
         stVu0I3PkCw9fCkhEdBu6OdD7PJVdsCD9ScmoIxzfCGjGTtxypwDmHO2RLRUQEE4XpyW
         dJzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779471290; x=1780076090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQDCoB4jEnSRG6MW2zUisTJUR6QZjZC1GNMmefmfeWg=;
        b=h95KvUtz5xx5B10PrqRQ1aKsfuoST7CaHbayC65tbTsxpobqPgizxi5c9rHNEgUg6S
         oYA9QvKhCkrue0OmORVvFmjv+DS3flGLRLzqmnGaFzkxJ1TTPMQWI2Wv7X0aCEg615SV
         nV4JMjq6FqwHc4PRadY5RMfNy17sogINkbzRRlEY+LiDnLszSNgViYiArEzqSrJ7tUux
         aRJD8eqt+bVO0ZmqXXpvJUbH5TjuQiUBj/0ueRDZ5TRNcs6VqnuPMWC1tDsBFh/5YErx
         JV63rTGYZgC5O5yfOymORfSNqmZbgx38ibhuh3tt8h2ewJlzJdP1dak+rVkiAjDzlqN8
         7J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471290; x=1780076090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQDCoB4jEnSRG6MW2zUisTJUR6QZjZC1GNMmefmfeWg=;
        b=RPhoRcrZE8/1VSZgZaTIC8FZNt16e3Zkk/qz+VqU9oCHKpNZEtXqCO0fk7JLiBT2mp
         6H1rD+NWkbDSY9xb8fBdV6axg2SIgws6XIPk88l90xz9E4NTy4/uQ3xhwE31dVk/pKKI
         cU5sc3m5spI3rgzjBTEWu9fEWNyjrM0T4uDVCFTpAEirJFI13gtbfwIvu/Y/f4fAUjxG
         +/+EWqeAy5LmaHOU3iL/yq09bOtEICu88T7YrZujymMLA56HMNcdPDWo9jYSoB4x9iUn
         lZU2KR4N1P8uP5SwRT8VwfqUSloRMfMULTVBNHIhTf5QNVkTF9v1BVYHM5EclLnz92xn
         k3Qg==
X-Forwarded-Encrypted: i=1; AFNElJ+mOwZzozRpiBkmMBpSmM5Ey07xyti9A1CAc7kYbB6n2e2HpiY5VxXy/LWCEKy5nPFx+JH6BWnOm6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6nfCv32SzdOWnuJHTfdwr12fTlbw+gLnYBCe71yUydBCNyx0
	kc6wERFI8mN8RtU5Ep8j/XY5L5a9746uKljWgbBcp+lZ8M8DatzbejILf0MPtlMc4FBIUAatc95
	R6iR+CtHgm4qAelMKZPEVJ6T9KfVTAYw=
X-Gm-Gg: Acq92OGCLK9zZrjqijg/5HIkCx9ONnt+0VhCcG2OinsQjT//Tp0O7MwCjDiT232KWwg
	/PpBO4HAUy9lM+dDL/dv534NPK+Biovm07YC/AqFG4CN4Ag03iS0WFvwQOTY9L835TqbhB99Ndd
	piwYPY+SIQvqdYQ54t0d0+TZh6xf7rwQK//LVyo86A0VLt1u8hDwk5C7d09QEiIfW2kTJWhuh0U
	swsjrd6cBwGT2ElQPOtwXyuEsdgndElnTPYEsC7ADClJR5nYmCwkZRKKxKZzkyoOwzCjlLkm521
	mRnfegBTJQ==
X-Received: by 2002:a05:690c:3690:b0:7bd:4a12:f7ff with SMTP id
 00721157ae682-7d33a95c241mr49876497b3.38.1779471290489; Fri, 22 May 2026
 10:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521223044.61410-1-m32285159@gmail.com> <20260522134603.07d31cbd@jic23-huawei>
 <CAKqfh0FE+gvh+Mfn=f-9c2XVYg8uekru908ye6fzQoFoXrpGVA@mail.gmail.com> <20260522182948.7b2e3fff@jic23-huawei>
In-Reply-To: <20260522182948.7b2e3fff@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 22 May 2026 12:34:39 -0500
X-Gm-Features: AVHnY4Jn9LnTG6mkR3vxEGeHcBnj2xkeEyCnUa1D73QRbNQDOo_-3WYdOeUyoGA
Message-ID: <CAKqfh0FuZWb-0L1hSb-TFXWMNP1ZNsg30JQvAz1dw6_8-i_uLw@mail.gmail.com>
Subject: Re: [PATCH v7] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 12:29=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 22 May 2026 10:38:09 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > On Fri, May 22, 2026 at 7:46=E2=80=AFAM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Thu, 21 May 2026 17:30:43 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote:
[snip]
> > > > @@ -834,41 +831,40 @@ static int kmx61_read_raw(struct iio_dev *ind=
io_dev,
> > > >               if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_=
MAGN)
> > > >                       return -EINVAL;
> > > >
> > > > -             mutex_lock(&data->lock);
> > > > -             ret =3D kmx61_get_odr(data, val, val2, chan->address)=
;
> > > > -             mutex_unlock(&data->lock);
> > > > +             scoped_guard(mutex, &data->lock)
> > > > +                     ret =3D kmx61_get_odr(data, val, val2, chan->=
address);
> > >
> > > Why is this one a scoped_guard()?  Seems like it would be more consis=
tent
> > > if it was done like the one above with {} and guard()
> > >
> >
> > I'm guessing you're talking about the {} in the switch-case. I guess
> > it's likely because the guard()() in that specific case goes for the
> > whole scope of the case, whereas we only need to hold the lock for
> > this call (I tend to keep section length as close as possible when
> > doing these things, and typically I'd use scoped_guard() for a single
> > call).
>
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MAGN=
)
>                         return -EINVAL;
>
>                 mutex_lock(&data->lock);
>                 ret =3D kmx61_get_odr(data, val, val2, chan->address);
>                 mutex_unlock(&data->lock);
>                 if (ret)
>                         return -EINVAL;
>                 return IIO_VAL_INT_PLUS_MICRO;
>
> Is the block in question.  Given nothing else happens after this point,
> other than returning.  I'd always favour guard as it keeps the error
> check at same level as the source of the error.
>

Sorry if I wasn't clear, I meant that. I see now that it just returns
right after, haha, that's my bad :/

best regards,
max
