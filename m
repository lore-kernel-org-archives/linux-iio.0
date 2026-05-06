Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C348C8B0
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086580; cv=pass; b=BCHrnexGfYdS/l9zJ7bwgbFx4gOkGqiUtNmM+Ye/cF1Nad1eICL0Wc79PDVAtxjpgqIg6sr23sfXaOJvU3FXIe9HE/cUaGZyjh+wwLWdcnf1TqbIg7Z4OvntqOe9FbGVF0wzCWj97JH5ICDpOpqPYRJkeoctyC+Bdlvw3+3IS0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086580; c=relaxed/simple;
	bh=VXhrXgVpD34ILmvRMRMmtJlEizsJXvOK4gNTfoh4m3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UT1NgmrAZfOAF62nsVvCYTJoESIdz0O5hAc+mzKTDF1Mxc3K3dcJMsbi9kMJiq66zjGcso1UqJDl4qbLfdZQosDnslWlT6NK+/sVzldH/+0Z+bd09uI/YjkEjzPT08nWMB0qQ2o1N6vRksf7ICePPayEeHlRD6dWeST3SK+6MHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWwvpK8F; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWwvpK8F"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7982c3b7dfcso68430617b3.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 09:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778086578; cv=none;
        d=google.com; s=arc-20240605;
        b=g5a1hbqtpZ0pfzmg5+4F77Ce7e2sWKkw2QXqrSPShB8oNakQj741HUovJOaxNWHJ96
         b4YGeW/jnPHbG27CPHKX1WgIwTEpEaa5Xay+Hb8w3K/KZ6837mJp2UG+MH5SyPbsj3JJ
         GmB5DUUDvdRm0VCtNV56vFoN3W2bfytEA8tWr3le1wLau1/1PTxSsaSP3wWvZByj5ZU3
         2ff5DlV21qstFJ4odUqwHu+YOMC3Dar5GczypNoXShyiqguHhZfG+KbkwEJJhYiJNI1N
         WyFSzxIvqb/E/awuBBmwlDDUHOjC6Burbk7fXz8SOgJPt8SOmQyhkBPe0jJB+CaTLOWK
         YrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKQSvA8cFf8oqBOCTJmnJl6wnA6r0rR16FL14nJ7ouk=;
        fh=5sr6KF/VeR9WtBktTd57NX9haSET6z7BnnKzwiNvIhM=;
        b=jX34tZ16pb+wGpaYlw63hnmnqgNea+7pGNzZR6/YzKOtw2krbuJUkA5C+IFgGrAIRG
         s/VOMI6bLF5CV2SgoFqwIUgbvrc7yT2FMH6F/M8nfGfS+4n2sb3rL6IzSwjvFQrXRQ6N
         gp+s3FRFCeRPdmYNffAqJ9qKolPrqm/ba98ZpSGzmQ2lhipinqsIqzlR2Yk/c6pihpYu
         zJsyjN8hjjyFDvSeXSALFhlt8Br4xsVmbIF01/jBeW+p9eV8mwH7VoRoVy7IUAanMRM0
         /34vseZF2SZded1SONgyPy69Ckp5LNoCx8zOErLIhb4j//AEZPCJFoGZliJ7nrLnI5ww
         zDyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086578; x=1778691378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKQSvA8cFf8oqBOCTJmnJl6wnA6r0rR16FL14nJ7ouk=;
        b=YWwvpK8F8uTU1LVIqz4zuuy67iymd3yDzCEiXMAtUlmnOiowv5rT2oBzLno6b/r0Ef
         s4MbDVAgPziP5YtHFrVGaaPfZueP828uzqVeTgzwUB2tLfM5lqkbYUR5hPecvU5eY4XV
         3BO0ZtkA/w1TOHMQhWD/YAJN78I2xosxLG/4W1t0z1p9IhJN1oEXcYGNDs4fscXylsog
         FH1aNPuANKcrkfm9q3IYbFzastaQmfcIq5AOUcENxZFiQ/RHusrDZ1+Pgu71zlR7TVAX
         cLTYkeM15G198G0r3Nd/P9nsI8hXrqj3OuGr+75AHtrws5ZzSvP/vXFUgesAA3ZRTBHZ
         Lw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086578; x=1778691378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKQSvA8cFf8oqBOCTJmnJl6wnA6r0rR16FL14nJ7ouk=;
        b=I1UC1YqmnLcgeEdAGqgDhebXnqrhjpC2U2H/ZbbpsxOQvYIqtkPg7BkRZHMdZ44Q5S
         63S0QJ3pfQuIKVZrg227EuCKrrIEMh+PCy7jiWCPkpPwXO+0y3HVo2lBt6KkGj5GJ/kd
         HvFq5xT9Ztmw+FxfLNoMuATOk6XJtEtS3pmO+K3YroSrxF3PKSOHDXyaG4AVVndJ9cO/
         zQ1Ty89VUmlkHFIw0SvoOQFPj9EJark9ycd190Zl0hHg2FjoVNFl/DBLk2Q5wKtabqUE
         S0ZzQnfyRaazZVuYsuZwQIN45DGdgbwRb6iz1kUEJf8yvydEgvr+nxLyFd1L83Sn+qWZ
         Rutg==
X-Forwarded-Encrypted: i=1; AFNElJ8xxe5cLhbDrWjA3Mq8rxVygnJM8IQae75gSUACF1jlrPxEcMt964NwGJnzEO8aSc6fNNjQXWX785I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIXU8GC/BVMhis2RpxsQ6b2gH+afntZ+kfDRbgn35KCoF2GyO
	ENSgvAOziecdkgIR8lp2Zij4o3kOc9MuCCA6REq3Zp4YIh89DqpFMTKinC0xPupllWbVDiJFnZe
	72nTk/SSQKz8YfzPmeY9aiP9KfvKCTmQ=
X-Gm-Gg: AeBDieuR/vwe619hn1/3bKty/3XNzlFafCc2ZgBqGTVq/cak+esn8VTkDNNyHkfXhVe
	hVHlFXaaK1gJABMw2JjjRhhdoyHDWVGmpycsp6bAk+xtQBFAXzDkk0IQ36XEqD+1HHIESqXgGMr
	sbuNU8guT+7G0MF6S98UPeyVSwlz9yNk7bVc/IAz9AfrH3haxG0jrM6/Tli3q2Xj9y8VN3e2EKn
	SmvgCWb3pPTq2kstQRbY2Dza0D8s9iJzzZMKRHuEDH2Biz7hheGv/yo1M/Bz5NQS5M4SXivD9aa
	46qjb1qhlnzKNgJEbWex5OiQoYnsuC0=
X-Received: by 2002:a05:690c:ed5:b0:7bd:8d1b:b2d8 with SMTP id
 00721157ae682-7bdf5d651c9mr48512497b3.10.1778086577506; Wed, 06 May 2026
 09:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505220719.44646-1-m32285159@gmail.com> <20260506170546.66d4d5e7@jic23-huawei>
In-Reply-To: <20260506170546.66d4d5e7@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 11:56:05 -0500
X-Gm-Features: AVHnY4IedB8yUXfgjLw-ryTB1bfdm7FAxil2nPjy5BE5lvWoiqI0DGlwvLCWnms
Message-ID: <CAKqfh0HVzYnWJaQ3KqJ+RymiVSJ32xjqW_fr61M6HSPYy=t2jA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Wed, May 6, 2026 at 11:05=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue,  5 May 2026 17:07:19 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Include linux/cleanup.h to take advantage of new macros.
> >
> > Replace manual mutex_lock() and mutex_unlock() calls across the file
> > with guard(mutex)() and scoped_guard() where appropriate. This will hel=
p
> > modernize the driver with up-to-date functions/macros.
> >
> > Remove now redundant gotos and ret variables, as the new RAII macros
> > make them unneeded.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> Hi Maxwell
>
> I'd slow down a bit to give more time for reviews.
> I'd imagine some of the below was true in earlier versions.
>

Yeah...sorry about that. I tend to want to get my latest fixes out
fast so patches can be merged faster and we all waste less time. I can
wait until tomorrow evening to send this out if you'd like.

>
> Jonathan
>
> > @@ -830,17 +827,17 @@ static int kmx61_read_raw(struct iio_dev *indio_d=
ev,
> >               default:
> >                       return -EINVAL;
> >               }
> > -     case IIO_CHAN_INFO_SAMP_FREQ:
> > +     case IIO_CHAN_INFO_SAMP_FREQ: {
>
> Don't need {} in this case as no local variables added in this scope.
> scoped_guard() is a trick with a for loop so has it's own scope definitio=
n
> as part of the macro implementation.
>

Ah. See, I'm a bit skeptical of scoped_guard() nowadays because of the
hidden for. But I'll replace that {} with the scoped_guard().

>
> >               if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MAGN=
)
> >                       return -EINVAL;
> >
> > -             mutex_lock(&data->lock);
> > -             ret =3D kmx61_get_odr(data, val, val2, chan->address);
> > -             mutex_unlock(&data->lock);
> > +             scoped_guard(mutex, &data->lock)
> > +                     ret =3D kmx61_get_odr(data, val, val2, chan->addr=
ess);
> >               if (ret)
> >                       return -EINVAL;
> >               return IIO_VAL_INT_PLUS_MICRO;
> >       }
> > +     }
> >       return -EINVAL;
> >  }
>
> > @@ -945,28 +939,25 @@ static int kmx61_write_event_config(struct iio_de=
v *indio_dev,
> >       if (state && data->ev_enable_state)
> >               return 0;
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >
> >       if (!state && data->motion_trig_on) {
> >               data->ev_enable_state =3D false;
> > -             goto err_unlock;
> > +             return ret;
> >       }
> >
> >       ret =3D kmx61_set_power_state(data, state, KMX61_ACC);
> >       if (ret < 0)
> > -             goto err_unlock;
> > +             return ret;
> >
> >       ret =3D kmx61_setup_any_motion_interrupt(data, state);
> >       if (ret < 0) {
> >               kmx61_set_power_state(data, false, KMX61_ACC);
> > -             goto err_unlock;
> > +             return ret;
> >       }
> >
> >       data->ev_enable_state =3D state;
> >
> > -err_unlock:
> > -     mutex_unlock(&data->lock);
> > -
> >       return ret;
> If we know this is 0 (probably is) then return 0.
>

Will fix for v5.

>
> >  }
>
> > @@ -1195,19 +1184,18 @@ static irqreturn_t kmx61_trigger_handler(int ir=
q, void *p)
> >       else
> >               base =3D KMX61_MAG_XOUT_L;
> >
> > -     mutex_lock(&data->lock);
> > -     iio_for_each_active_channel(indio_dev, bit) {
> > -             ret =3D kmx61_read_measurement(data, base, bit);
> > -             if (ret < 0) {
> > -                     mutex_unlock(&data->lock);
> > -                     goto err;
> > +     scoped_guard(mutex, &data->lock) {
> > +             iio_for_each_active_channel(indio_dev, bit) {
> > +                     ret =3D kmx61_read_measurement(data, base, bit);
> > +                     if (ret < 0) {
> > +                             iio_trigger_notify_done(indio_dev->trig);
> > +                             return IRQ_HANDLED;
>
> The duplication is a bit ugly. I'd be tempted to use a helper to clean th=
is up
> Would be something like (not even compiled!)
>

Likely a good idea, I can do that, would probably be better to keep
the guard()() out of that scope.

>
> static int kmx61_read_all(struct iio_dev *indio_dev, s16 buffer[at_least =
8])
> {
>         struct kmx61_data *data =3D kmx61_get_data(indio_dev);
>         u8 base;
>         int ret, i, bit;
>
>         if (indio_dev =3D=3D data->acc_indio_dev)
>                 base =3D KMX61_ACC_XOUT_L;
>         else
>                 base =3D KMX61_MAG_XOUT_L;
>
>         guard(mutex)(&data->lock);
>
>         iio_for_each_active_channel(indio_dev, bit) {
>                 ret =3D kmx61_read_measurement(data, base, bit);
>                 if (ret < 0)
>                         return ret;
>                 buffer[i++] =3D ret;
>         }
>         return 0;
> }
>
> static irqreturn_t kmx61_trigger_handler(int irq, void *p)
> {
>         struct iio_poll_func *pf =3D p;
>         struct iio_dev *indio_dev =3D pf->indio_dev;
>         s16 buffer[8] =3D { };
>         u8 base;
>
>         if (kmx61_read_all(indio_dev, buffer))
>                 goto err;
>
>         iio_push_to_buffers(indio_dev, buffer);
> err:
>         iio_trigger_notify_done(indio_dev->trig);
>
>         return IRQ_HANDLED;
> }
>

I'll likely take the above and tune it up so that it will work as intended.

best regards,
max





> > +                     }
> > +                     buffer[i++] =3D ret;
> >               }
> > -             buffer[i++] =3D ret;
> >       }
> > -     mutex_unlock(&data->lock);
> >
> >       iio_push_to_buffers(indio_dev, buffer);
> > -err:
> >       iio_trigger_notify_done(indio_dev->trig);
> >
> >       return IRQ_HANDLED;
>
