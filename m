Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0663C4175
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054729; cv=pass; b=tazmQEmN+LDhm0CLGVhGh/TCzMcy6xkDWnh7qgp7MUCd+R4zYCgMi0tyz0N8OLRRSnipJ95xV5n1FKkI2wWi7Xz+eWuRornlzCDVBaPyFfbsCl6SbFdN7efPTAUEwY8/f077vYqbwY6D362+ElmzQnRwjP6a+GYTi2bZYFeR2tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054729; c=relaxed/simple;
	bh=Z4QMZniHToK74o4jDI6elJWh/DlPHnbkmaY0N1t23BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssN92qLCrq+Tn+d0100RW8yhpuekQk8mGEGoe4R50PWvS8JFxRT5xdwhsPdNtEH9BC4u6okQlxiW/ZuPnTmnm9MpZB8aNjkbm5kQ0SP0scqP2uQzISENwiUFg311RPh0pfwrCGXTmMbdgj7dZpeuKJgQlWtD6XoRd/8V3KPOyTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anHVvC0Y; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anHVvC0Y"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65dead17c24so13043854d50.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780054727; cv=none;
        d=google.com; s=arc-20240605;
        b=VIWf7SqBvvUst/cpqZNDiYUGNt2UcrxNvKKV9O7ChjPR/AZjmpxvWnsokK6UaySL8W
         esB+J5i9uzI9DKhIhMr6XUjp45+sjOccydvfHceCqvtrctCQINPnfUuzIprlTXot5uFg
         1QEhXzgnhub3Hq4+EettGn0GN58jkOVc4r4TlfTlDlWdiHGxj4YMmU6uM5bbxs+xIi+N
         RaFVB5nV2FLlip71kGVSoP3wqJmlTN6XncEeXgDslrGhEcb9X+sZlNoa5zjOeFdi0/1R
         0r+WO8JDcIoHKzrOx7urobQNRquEPNq7xCiRZmTKbrhnMQmMguJRL6I1YRSyYKVx9Auh
         Oz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=390AfR7GJml5riJqeG6VG9I6cbaClxHU3Sgq3MtEtZA=;
        fh=UKqfEi2gQFzw3OQH5qVVYqxWp/qYcBYkW1gM3fhO88U=;
        b=hqNR/YFm18+SQ6Vp4YFvtUblMG50nQ+zHW6huUXWlYMdLzw2XKn2DQdHRjt6hzkEGw
         pfxFPNoSd3LCqclqBAIoAqAeE/yCX7brn60g1LLoC5gz5plUPPia0bAuWQrtRzPdfOOo
         +ewq5Chg298L+QkVpzfbfhTrSKEb9X6y0lRiG5yhrkvzoGGfoe6HQA9VSS/np0mKjCVd
         2t0F/5w/+oDv9VDTtGU7uQ6uv7AesXgJ/q32+Jd1KmFKRywgifia/uXteszkxvF2FxKa
         pX7CRlSgtq66ZbfDjhD+4Ba8XAQXEzjOPZvPyRaupsvPglBDa3PQGSK5M/82SmjozbNT
         bkWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780054727; x=1780659527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=390AfR7GJml5riJqeG6VG9I6cbaClxHU3Sgq3MtEtZA=;
        b=anHVvC0YVGSg64+vHV0g1ZZjUC2bU5+Mq6R43E1WqpUi7DltBWYpaLW0At6lSyhmT0
         rOJYfSpKNJ63jYza++WC5rgQE/KuGG9Y8Kl9U0rM10kwi16bWZwrXHaCSOr6ntl06fQD
         5JVFk+pMRAzJp1nxjnTtZ0XxmMhS1s7niQAERkqKnOfzN16IopD8RaWYh/QVKyquQq+H
         2FyB5ELLaC64plGCvUhY9xnOqutr1uKYs0p7l7ErPshBQ5Y2gHR772buEr/8JEkqtAP6
         BnC0EUhDdrA1a2+Qh5K4242+rWSf4QeMPNPd3IRz1EdxUTp9MVG3Hrv2NvFzK5xbcF22
         QXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054727; x=1780659527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=390AfR7GJml5riJqeG6VG9I6cbaClxHU3Sgq3MtEtZA=;
        b=kxaEXxML463rqOynvlHAddkAjdrEokat6WOj6s+nEq6tws9AC2Ql10ngKKTeOVVsL4
         DCdsNmQnQd/Zm/sTtXBhL0iQ0e71seF5dozUKt3G6RVJnmB7WormrkiGuUlKK+OAu7Ix
         3e44SksOxsf+ECzOBHt/aEGYR4qrv0raYdylWfdZ8X1r2JzICubG0DNRP4lGmQAmWBnw
         MVw1yKChoUJA7rKyNTDdX38+EBNqWbKfHrar4ONtJmVR6sCScbS/BGi9c55aG37jhdNx
         RoglaLg6XOgfGs6jrKec2SwyIkFT2iC/ZvHri1BdAs7rNuoveXPo4yo5igNwydvOkrjo
         s0BA==
X-Forwarded-Encrypted: i=1; AFNElJ+InWWPVuWvCxi1rhqf/jntWYiSzkqfxKC9asM1VkkUjivkWNsG7StyS3lPMhcUgDEwvAcaQoaUt6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnpGtP/TEYP5KAhxErtTYvHY90KTPBJuoES1la/gC3BZZLSBF
	l/7zju42JnCKcRrlZvpAlmGM5xD/mg7pQwWO65mc+UfARUoJajtPC+EjsqfunGt6QD4Uwmao1VK
	Jvd2AI/4SruvQzY3ikoNPBVpeLMs683w=
X-Gm-Gg: Acq92OEJKBNzQhc6pa2xMNPEUAEQeIjXn+KTBRTrX29lTQGJZaRFNclqbQTNypIbTVQ
	vHt7DtH4BAM07funiA1Ayxs4hJqP+QED01wyh2LwBIgYuJIZza1Mlv99r5JFh14QoKOKmUwGmC+
	/h/xfHnrvS9l6hQPbyw/C3TCZCBfBurdkG4XSwCeX4Zq53g2tw/B0Y43CsBy1uq77t7BlJOZLTd
	HkNwixP7MMilB7JvuXch1up1KDgLJ2cyEewX1z7NQNy7fGPkJO0tD5AaX+2BBTq4YXH2XUFxGga
	Ay4jWsjD4BwaUKo=
X-Received: by 2002:a05:690e:4191:b0:653:1921:7199 with SMTP id
 956f58d0204a3-66052f25c9cmr1299916d50.46.1780054726682; Fri, 29 May 2026
 04:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528222906.61561-1-m32285159@gmail.com> <20260529114201.4025eeb2@jic23-huawei>
In-Reply-To: <20260529114201.4025eeb2@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 29 May 2026 06:36:56 -0500
X-Gm-Features: AVHnY4LplhjvdHbuUk5VcZrpGFV7dhpejlGH28bnji3hBP88Aqb3qGiIzhQJeBc
Message-ID: <CAKqfh0FSKN7CxN2uzJPmNreePU1bCoOz=v830s1jC=X1rx_9eA@mail.gmail.com>
Subject: Re: [PATCH v5] iio: chemical: scd30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 5:42=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 28 May 2026 17:29:06 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > patterns and to improve maintainability.
> >
> > Add new helper function scd30_trigger_handler_helper() containing
> > the critical section for scd30_trigger_handler().
> >
> > In addition, small refactor to replace "?:" operator with regular
> > if/else returns.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>
> Looks like you sent a version that won't build.
> > +static int scd30_trigger_handler_helper(struct iio_dev *indio_dev, int=
 *scan_data,
> > +                                     size_t scan_data_size)
> > +{
> > +     struct scd30_state *state =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     guard(mutex)(&state->lock);
> > +
> > +     if (!iio_trigger_using_own(indio_dev))
> > +             ret =3D scd30_read_poll(state);
> > +     else
> > +             ret =3D scd30_read_meas(state);
> > +     memcpy(scan_data, state->meas, scan_data_size);
> > +
> > +     return ret;
> > +}
> > +
> >  static irqreturn_t scd30_trigger_handler(int irq, void *p)
> >  {
> >       struct iio_poll_func *pf =3D p;
> >       struct iio_dev *indio_dev =3D pf->indio_dev;
> > -     struct scd30_state *state =3D iio_priv(indio_dev);
> >       struct {
> >               int data[SCD30_MEAS_COUNT];
> >               aligned_s64 ts;
> >       } scan =3D { };
> >       int ret;
> >
> > -     mutex_lock(&state->lock);
> > -     if (!iio_trigger_using_own(indio_dev))
> > -             ret =3D scd30_read_poll(state);
> > -     else
> > -             ret =3D scd30_read_meas(state);
> > -     memcpy(scan.data, state->meas, sizeof(state->meas));
> > -     mutex_unlock(&state->lock);
> > +     ret =3D scd30_trigger_handler_helper_locked(indio_dev, scan.data,=
 sizeof(scan.data));
> The call needs an update t the new naming.
>

Gah, I don't know how I missed that :/ Will update for v6.

>
> >       if (ret)
> >               goto out;
> >
>
