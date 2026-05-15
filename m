Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4534B1B4
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855127; cv=pass; b=V1X35N2xAOuCGom9pOKJDyC+iH3f3mPFE6SCMjNRWBdopauFOpA052LkDQAwuf+dglhIJ1QEmTC80sIU3vsGv5gtNuySZ8S4ihdrLXkJCBFlYRwG4EpqqefRqdDWXbA9r+LUw7Sne4OiqszmieAxGX0HNDdzL69AgyJ0gddP4Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855127; c=relaxed/simple;
	bh=lbWnwQ2Qyd6o+Xnd4FsmHt+uzsvAQ/FLP49yqV57zmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4HXLk72YtYtVWD3K2pHf1hf7RDWp824GVjfA/dadJ+gPVp1i0WlKQfaOefI66aR9Wp5Ib/HBJFdQ40CUy0b9A+gxvzE0F63NFSvPA+TlO8CUK4wIM6M67NlSHNeyRgVR0OCRXzadIZlaIMrWmYrZ1psPVsyDbyFWM2Z6HvosPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULuPKJFB; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULuPKJFB"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so11568005d50.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855125; cv=none;
        d=google.com; s=arc-20240605;
        b=KqmsCDzLnVpDVl8HK15w/oNiTJ6e6rD7kwYOb6o4BZBcJlMoe+X+gKoehV3tBlK08+
         Ge2mUhubFpr/jg2Bt4/iKZIv5cDSAzZiIDOO5QGYOzVw0lvCxD1WPnTJO5/3QuluBsy2
         F0czVEwwj0/bbMcUqcxOpkCResAzcjjg4QMlNlHbJGIWkOP6JqKmwHhjq2e1SX5Xsuu3
         h+H5mwvB/d30GHrQDXbwrFGM0lA00dL+7C0DXvO9bb6LtTAHgj7nykaEpo1THfGfyz4p
         +ZeNn1bBDEXN/TL2svEupX/xFAXpHYcZoA9yNZVdEdZV08vp1dU1ELvnlrWPgjuO71Ic
         qM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xArMhBSjQUGB7ITu0ejRSAMxw1RYApkW4yIB8qTLk4U=;
        fh=ZgrUbNyFlPRI/+A2Cu/yX7sV4EnO55ub27w7N3s2TAU=;
        b=QVLNiF6XAZpR5Kb/G7+oVZt2D/powkfry0yXc3n8okWnpVOT61q7dva17oguvPMnH1
         jF02c7tQTtuqVx4AcKwgAP8i2W7kLC+DDmjd2wbY8TX22AQ/ZR61pBD+5h5+oXBcvHnh
         NYE1zCI2tPBPQoI3FShGkINpIlP0zQP6zmhIDEmG9XFRa5f2kPVxxgcFGjv2jz8YLCDg
         vhWY1Bp0Bxc60REHnANup4kZSaQpoe+ZERQ4N8izJxtKACoUA6F5vrfndpa5duUy9GWs
         UmfHFNdy/tYktjAFGZDKeNiYaizdMLrZmiAQJ8g3uHiQ9knRaFgEbmCY8+PQaO3wlWTY
         GyMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855125; x=1779459925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xArMhBSjQUGB7ITu0ejRSAMxw1RYApkW4yIB8qTLk4U=;
        b=ULuPKJFBX4eDFoCBxXgShyp5SOQ2bvh0t02SLCH11HeWzSG3hc7+DF8VEuy6sc3iL6
         59+jByJAMaXI35OyTw51vhB00KQ2K4sLShZqNkB2y7UgYc85taMyZ+vH8royIASJlYRf
         X3v1/BJwtgLnQkfCiqKF9psQ+MDf3KWoX7fYve3DQOQcnaskqH0wiHBvcJ/ymt51XbNX
         Q1MI7i3aPbno6n4588wFv6QcuEkdhGmw0QpfjXfrZ7t4p8aNU5wJkobB4EPZCAQLb1yW
         keyeD9ReHzZxwtjC1MOxEpdoKjCDMSfqclbdUNC7CnBeBVU1hRnmwY+0tDtjKJp49tTb
         wcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855125; x=1779459925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xArMhBSjQUGB7ITu0ejRSAMxw1RYApkW4yIB8qTLk4U=;
        b=hIAQH8Mk6ANj0xbUMvxTl23Arp51f0tfvVq4i+Ia5vXo8sOJG3Qd22wTC4ktN9phaF
         pa9YD3elZs2fbgBa43qMlxm+0lidtpQ9anMIgp8fPpd0ymtfVkbaFRg486Bj6wy1uCa/
         Z3rn9ypGGoIVcdvlyTfq/1ir7piMVgpFCfyt3qmjGe66LeGRN4AqE5UYY7DraQBk7srN
         d65Ygl0biA4po0c0jb/nQlraxV28puejVKmuuuiTLlarpFk/wHXYAWv/eB6OSChZwnhY
         +GHb52vRo9flqjd1S+xu/OBdVcBi3qBT+9COflgokQnCdQyAD/01Ham8IfqosvSDGYcW
         It2w==
X-Forwarded-Encrypted: i=1; AFNElJ+EuODBBLXpXNeEd3T986pK++tuMOx3nvYvSbwpwV7Gl/axUDwEnK2LTyJv++EWoE1ddmOJpHULAR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGRFiaEjodEMaHnznS3oRn7Xvp6WKYOSZxdcKq1mhdQVn4PT/
	E4NLqmEUjKRL373eM4215AP9mTr7DD/jsR9vdZNN32PwLL5Yq/o3VFuq3iwA+svpRk54kbLIUlm
	0pS9jeS2lUAt+Cg3wd/209FEozYUlLog=
X-Gm-Gg: Acq92OGnkIRuWG8Q1GVqdBdBzDIz1V777cYSmbGR4uSwV2FiOlniBo/cGSjcMJ4xAFo
	czwe393BNiqhGD6Zy2ayT1GyO+QaFl5mtWZf8hx1O9YAByaq7JmtvccjXDiNBlJetaWM0Nc6QXX
	9+GQnTGqmL8Ie1VfP8DrJx0aA2sMbtUi1EgJbesFqj5ssz4AtuMPE4UBYQpfPeWw2C7m7yJfM16
	+MiwDbMvnxU8B6vxLZZ9YvazQqcqQJlsYx76NwVuDb34MHPMffvFRN4sfnQvzooiVPTiX3vR4Bk
	q0LtNDrU3ATEM+ic365M
X-Received: by 2002:a05:690e:1551:10b0:65d:b511:3aaa with SMTP id
 956f58d0204a3-65e227048c1mr3670445d50.18.1778855124552; Fri, 15 May 2026
 07:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515002603.19240-1-m32285159@gmail.com> <20260515151338.74a1ce81@jic23-huawei>
In-Reply-To: <20260515151338.74a1ce81@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 15 May 2026 09:25:13 -0500
X-Gm-Features: AVHnY4KzdT-bQm9gWbI22EZyhG7ex5Eab6PKCD_sYld-1Pp3sFB96qORmrzwLMs
Message-ID: <CAKqfh0HCpX1HWLa6Eodq=GMDtzkitw75sBYjUtpuU158Mzv9Eg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 9:13=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 14 May 2026 19:26:03 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > patterns and to improve maintainability.
> >
> > In addition, minor refactors in control logic to remove gotos where the
> > guard(mutex)() calls would be used, and replace the "?:" operator with
> > regular if/else returns.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> https://sashiko.dev/#/patchset/20260515002603.19240-1-m32285159%40gmail.c=
om
>
> It caught the main issue. Given that is a fairly common bad pattern
> I might have noticed it. But then maybe not. Another win to the bot ;)

Gah, (of course its the callbacks!) will fix for v2. At least it's a
pattern that I can recognize now (I still need to take a deep deep
dive into the IIO API).

> > ---
> >  drivers/iio/chemical/scd30_core.c | 53 +++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/s=
cd30_core.c
> > index a665fcb78806..a24c95874fd3 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
>
> >
> >  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > @@ -590,19 +598,16 @@ static irqreturn_t scd30_trigger_handler(int irq,=
 void *p)
> >       } scan =3D { };
> >       int ret;
> >
> > -     mutex_lock(&state->lock);
> > +     guard(mutex)(&state->lock);
>
> I agree with sashiko here (I might have noticed) that it is in appropriat=
e
> to extend the lock scope so far. In particular over the iio_trigger_notif=
y_done().
> Depending on exactly what happens in there we might end up with a deadloc=
k.
>
> For this one I'd factor out the reading code and memcpy + lock into a hel=
per
> - you can use guard() in that safely without expanding the scope and keep
> to the goto pattern for the outer function.
>

Will get that helper in for the v2. TBH would've used scoped_guard()
but in my opinion indentation would get screwed up at that point so
I'll go with the helper.

>
> Or just leave this one alone as too complex.
>
> > +
> >       if (!iio_trigger_using_own(indio_dev))
> >               ret =3D scd30_read_poll(state);
> >       else
> >               ret =3D scd30_read_meas(state);
> >       memcpy(scan.data, state->meas, sizeof(state->meas));
> > -     mutex_unlock(&state->lock);
> > -     if (ret)
> > -             goto out;
> > -
> > -     iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > -                                 iio_get_time_ns(indio_dev));
> > -out:
> > +     if (!ret)
> Very rarely will I be happy with a change that flips from having the
> error path out of line to one where the good path is out of line.
> If you do decide to change this one via a helper, keep the goto pattern
> for this error handling.
>

Alrighty, sounds good.

best regards,
max

(ps, will be away for weekend so unfortunately I won't be able to
respond to email, as I won't have access to my computer, and my
phone's email client is crap :( )

>
> > +             iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan=
),
> > +                                         iio_get_time_ns(indio_dev));
> >       iio_trigger_notify_done(indio_dev->trig);
> >       return IRQ_HANDLED;
> >  }
>
