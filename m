Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA933BB9FA
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363073; cv=pass; b=XYhY7yo3eUibtDgAEu10+sckQyNudyhFH4aun7QQrKtC+WbctX0gfuSCDABNlnn7NW+jvR7FdfCzPuJQln22L/65cdXwwknVl9TjUw/cXPLm68XJVzdbPA29l05nmnRzQK4jeFqtBe/PhDDbIPNOd9JP8oxQRdu1yO2nfuIHmWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363073; c=relaxed/simple;
	bh=YMA05EvwLGCoIwKIDQxSBx+VpzD+H1hw/RURcz9lhuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1+VFwK4q+vLO3wfdrU8eWqOSrd4ErZtJG7pjAjbZkUipA4dE8qdEnnnnpjna+A5LFZr01+zDLM/7POLitfiEgH23rU1PAAy7w5V4q8G4FrUdJB5qkRXh4sH79M+j6dEfkoILKkhKMNlMJ7eHyXnV4b3Hq5B/89/WnKky5CXj2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+ZYrJgE; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+ZYrJgE"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a535e7c00so36554677b3.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778363063; cv=none;
        d=google.com; s=arc-20240605;
        b=fQdRGE06FAjzKWLan5040hFbyX2dGnjs8QnM6ZROTkBK2iVxl4gkzI2nne8XpMs5uT
         JF5jbHcsFhlxYtG/lOvHPKjAthjQXiH/qGNoP/AhVxqD0EhL9auTLuIXhomvIEh794Ih
         qT1cQ+i/mXTPIorRa3uIVhe70wkJRPRjRGH5NtNrEK0LxvBmZuK3Jc5O3n/+9MawLuuj
         geRv0P9q+t4skveVultEal/UfKRVF5y/XuXkmEesCRNLkA5FeP38+0HiiHQA56ITG0Cl
         fMuoVqQ0AM8OZMXO0AZp7pJ/Ca7H2BOtEVaZ6GGOPqxTPqThdcRHokM1/9PjO8hveN/v
         jJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJRpEv0QBiS4+K0R499A0YTpQVZuZ/tYwYC5hCJKrs0=;
        fh=07GvXUBpwgKfXlFpkEv0uUxmpt8y7smEbHLmngY4Xks=;
        b=bQpSe/jco7W6GwVCNpvwzALgJgG19wnZDpoLEr2L/RYv1NzWQI+jexZ/4A0hu/7yly
         52xlxFaI/1YEF344FR7Ua2qDswkRnmldcBquZVTMQGLCohV4Spx/YCh9pBrlPdSTQr6d
         phswq/X+qnXVbk/sRV+qIAN10h4t1NY3TQ2PgLbxxVgAaLvL5MLIJMTZqTJkWoMbG0T7
         cP/fbzuWKCTCULwGiNpc/auKSU3qQYvbwYfxXd4QcMIQaI/pIrP5lSR+aVoWBQEcJuS0
         HBLQn0YiMPr6WTG/Yv1o3JBrO6o1nkQU74H4xcq2MqON6Jwb5OMWcHlXdKqLERZcz/c0
         XWUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778363063; x=1778967863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJRpEv0QBiS4+K0R499A0YTpQVZuZ/tYwYC5hCJKrs0=;
        b=H+ZYrJgESpGswtOZwHUD+zDoUL2WoB90PMHDBH/WqYgoICDCvR53NMI9LSG9qfOg50
         qLjo5XVsh0Kh28AOjL9vmk/Z/TL2ON2UmrGqby9BavDOo85m5i8qZFIPJbaTPsKDTaoR
         oBcj92KTq+c5evr83URtg3ZsAkMFybaJKulgiPx9QR0avizIR7NuGx3fZpXQAfEnGDUe
         J2KiuOiWMmumkPHzuDEhhCVQ/riRWfcX4PmlKn5KFheHw9epE7Z2jOLeQlQy6J3mqhCV
         Yc9dP3hVFvrFDK/rPJnzLzpWUMmgNyAyA11WDIEJzTxQWr1MpJkRylYgE7DLa1JrCTRC
         iZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363063; x=1778967863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJRpEv0QBiS4+K0R499A0YTpQVZuZ/tYwYC5hCJKrs0=;
        b=BvLgx7FcH2rEQPOHgy2YIXtcCbACvtkDk35DWotznec2NHu5I3yDGL6yRKitiUzaKg
         PQHkLknKFYXW4+V46vWzXma6bCDTR5J/pPMioF0bTFs/aXv99nShtdZliFW9Q/WTkMzm
         t+0Z76UVqksSt1EUw3/YvTnv/W0vGNQF5FlMUXaN1VBZsmcOQ7lGiWlseDCjLXwtDu50
         SLcZw+O523ZlNhhlOQdzVJtHvOeVO0nMTJ8czUR3giwSHUCpnnJ0GvVv09GH7nciafiI
         LI7Dyymbk6sWLIQcUnN5uLOPft65HnNXp3daBmN3HMdbFD5I1mq7Q+f585mv5l7RpHKg
         9A/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Rf/jnpFlR6gZKcCwNbXWOf1pJ/nXc3P7K1Wp7N5RSfEHnny0c8reKKJR5NK5iznWRR311d1nG8X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aP5jmmzvOsHobWmLxiHhWSuGvvLHUG6+sHF56Fs+Y1NuVasC
	eFKlekqoKcIwkGYS0e7EeKCjp0Rp2SlDLZm3/4193/ledcjAOXWra0bT24Wz99lVP0ecfwHIamm
	irToRsoOniP5cpQxvPDq3Bsk4sWpksXo=
X-Gm-Gg: Acq92OGYo4liIj0oe9pgsWMCRatZv+rDD1r4zlkyTMUV+DMcPuvo/TKLQQQ+KpXA8Pr
	vvJVxD4DQeX1Pga0vPt/3tvNy5oRqYxsX3mWNKA+LDAk8NYIZDK8wlMcPapErB5VZQ1a2exHicK
	rHKNqY7tsxnj1pWPRNJlWDcU6PJAEloVtVKwIQj1ty4YMaVl7tLGeWGxqDUk0nJ8D+ZN5G9xRHV
	/InWEGgQk2Vup/HbQM+ob1F8bPGiRgJxIGpZOVbuLg3E08XPqqrkjAihp0iFMz143loUseDgUdR
	727C
X-Received: by 2002:a05:690c:ed5:b0:7ba:f677:8c32 with SMTP id
 00721157ae682-7bdf5db6381mr203420267b3.15.1778363062713; Sat, 09 May 2026
 14:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509125201.29872-1-m32285159@gmail.com> <f9c1a25b-456f-4ba9-b1c4-7958f2fd2aa8@baylibre.com>
In-Reply-To: <f9c1a25b-456f-4ba9-b1c4-7958f2fd2aa8@baylibre.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 16:44:12 -0500
X-Gm-Features: AVHnY4LMwQLxw-3rG-9m5sNFbGOH_ouXw7YIocJxYzOkV8kcwzYvgK5-o44_DIc
Message-ID: <CAKqfh0Go9T=UK68QZgiNdHn7ewkhFUGH+d_+5TVZ0oTM1S37=Q@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII locking
To: David Lechner <dlechner@baylibre.com>
Cc: tduszyns@gmail.com, jic23@kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:22=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
[snip]
> Doesn't need to be scoped. there is just return after this.
>
> > +             ret =3D state->ops->clean_fan(state);
> > +
> >       if (ret)
> >               return ret;
> >

Ah. Idea was to keep lengths of critical sections as close as possible
to what they were before just to be safe. Will change all of those
over for v2.

best regards,
max

> > @@ -215,9 +216,9 @@ static ssize_t cleaning_period_show(struct device *=
dev,
> >       __be32 val;
> >       int ret;
> >
> > -     mutex_lock(&state->lock);
> > -     ret =3D state->ops->read_cleaning_period(state, &val);
> > -     mutex_unlock(&state->lock);
> > +     scoped_guard(mutex, &state->lock)
> > +             ret =3D state->ops->read_cleaning_period(state, &val);
> > +
>
> IMHO, this one just make the code uglier, not really an improvement.
>
> >       if (ret)
> >               return ret;
> >
