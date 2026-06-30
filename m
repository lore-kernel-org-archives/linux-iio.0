Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FD46AEFA
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835287; cv=none; b=K+OVDNlZf/pXOO5auX3FZVe9P+kmfAe3ew8Tb0pbVUXRFWeFEVeu82C6Q9XVMyQCwWFePs19bJT2HxU9Q2FVeukr9urIeH96fzcbYfaBFbryl82/UQ4zjd64TGIDHwcJf9X+IH2FqCVGMYlQu5ALboYEEV24t9CMI6MODKDbauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835287; c=relaxed/simple;
	bh=y9uuZkEeJae++MbeR+TNLsbet2X1rPdv40pKLNu47dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwDBgMAFGNKe4RBFI2cxy46ZJ8iFMjmQClqNXi11Cx4yjAmEDd90zvZL9j8vG6Uo1Y4dL93Ys0v2wlcxK47etlqC66hXwbO/4GumRgSjBLjzjkj5OhBq0qR/xtGzi6M1xq7n3R3bNI3bCnRlja/u/lqjTUo27hgcmNssYafAqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bdd0779366so37862e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 09:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835283; x=1783440083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
        b=D3NLmzPaOTx2wQLy63s/kxluLW730ag98y2QhFkPF3V/XHhUlXjIfCtcbQg3tu0TxX
         w/9X/eX5OR85WmiWsUHqVl4ZSziRtuSjN+Ap1omwmrXEwAkwv0cWNg+Xbm3zchud0CUF
         UQJAeji2UB634fzcM9dLvKdkDOn5mQEoDN5bKFYCNHiGWDEyLRoBR+yX9PoxrkGCFq1+
         4pYQsEEeBbFW+9F9L1NpNkfKSyt70C4BlmrW5+tugl0XJU5lEpUZappk2vLIyt2F3tqT
         n5NWvOYxbKlLJ1rLpq5FCoQduhfctHBzxUq+fj9f5UsJhrIqKJxbMpy1fVteG3/AJTFk
         gtOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp01ZUg8g1IsruNqEdWOBU/msFZo1UMr9sO3DCtSP1a9OYut57FyXk0QsL/lNdi2MVrLHqLCU1TuTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIxhGV2PGUhQxrnkDFGB6gd8qLfAvW7jZlWBWdhO7EvzNV6IO
	0+5rf+3TFAUMo5OvF/+IxcKHDkVHQWyN/ndndI6D0k3edfrhRYZcwb2lyB/7DI8l5cY=
X-Gm-Gg: AfdE7cn+zjgxq+whOujOYwu5XTJYZO/0qtOXqdAj0HQGudRwtyN1zDN5LgmlbhyuQ/K
	b2MXqz8QMwzgxQ5cirkTgbkdGxb72JBTGjcObvaMSoH4aPNHbY7z0UkXolV5ERC/hXcCw9uUQhW
	4qbfG1zW9vWNRjD3PkGoMq576Iymi7AeNtZIVQF8wWexAMe40LP2uslIGaep67AW3LmTqYLzcDJ
	15oDJMAgTGM2mAPgT3JSsCr8VcC34y8kjfZwQLkTyQ1filG7+vOSUBEtNQ8kaJEo51peFlxt3Sp
	cpiRO3Vq97Kby9kDJnTBOUuWVEtKY4u1t5BzPRhniw0MZZ2OEuKFn1eWlg9j8ziRpbYjLYFrpLL
	+jSXGRo+RtWa55TNn4xXjnaf2jYPC6wtiD+ylcgd2vessEx8hOYNQAvhitiB3rluueOlCVYiUMG
	jLN22T5cGtl1Yk0xj9rEo74xzeczfwnOflnOYrmbebtBPAw78/yQ==
X-Received: by 2002:a05:6122:134d:b0:5bb:c529:5f2c with SMTP id 71dfb90a1353d-5bdbecf0e2emr1679117e0c.6.1782835281119;
        Tue, 30 Jun 2026 09:01:21 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdc189131bsm1683300e0c.6.2026.06.30.09.01.20
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:01:21 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9690c99c917so929884241.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoVOvx5PBJOUoBV85sdh9ZJ9sETztRe1lnODZqB0yubznzgv+xvBF+2r8QAB/qn2eZm++RvbTAjJjk=@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org> <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
