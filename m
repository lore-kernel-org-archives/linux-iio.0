Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F2429803
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746985; cv=none; b=ts/wg4JmyFFQGFi/A2OC4+el6TXeJPBZtZY9l+LwzF+FJAumF8WhT77PLzfZ6htcNYJDPZXhBh/WjWLU65oAqoxoQfQabCh7VT0A+aiUkteH4VDa3L4q+T8qt9lrEZ/ghxCXR+Vymt5UQIKHpVwv3PAT8JU9VL8VqqX+0ylydLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746985; c=relaxed/simple;
	bh=BODU8nH72xA0ScZ+HzwpHMr8UOUoOL0Z1xiarATGzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmKYgsTfBltbOZJWBQXLT5D1cZc08jAcG//m6oE1qglg+kCXFJWmwa2X8Tylnyue01XIr62qUQZAkGN/cmdw/ZBWnR6/mJHUJ/JJMd3oU/aRgwuZ39Ohr/VueUq5hwmaO6CTRcNtSs/hd1aBeQNzNHR2ZudavRbqAuR0QRPrtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69857dc1d5eso2727049a12.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 08:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746981; x=1783351781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
        b=Ys0VrIMYWtk0+kjCzVG9BzHrz6NwcyfQc+7mW0YAiXAhAbR0e9b1++lVzCGqtg02I4
         iqlHvif7DCdSDZ54XuSjyu+Zq+iuFLTNCidz/oEx9/RiCotaQRb9cMbGWRgXsaH/tMKu
         kZAsPC/g6TM3XpDU6iybesldBCxl9F15PUKEcHQucf3eiPKFVFeZesxc/HxN/5pDj9dc
         nkUm3DMphJxlU5XlOytqy65BnjAaU7Fm5PLpuRgtVeU1IQQUHsAah+gC/dNAHYN+qqUb
         OCwdtcbWCEqRbPYQlekNtyRUpX1aOE3ZqgSSceTMWFVWr491vPZLQKMQyCVPAKgexUt4
         jw0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrJXqiouq7C6MDlFfJMW0F2lGZM6LDEjKZOB/7y+/lGoT2sp74FM3k4HRb033nCGPCjyZzUF8n8OtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47kGSQ8zXnXifZOVwHa847vmYI1d9qNK+NTAg52i6Q5Bce1hW
	93PYzguSsb83oQ3sca3LnErpRupUzLeYJ6tfcRaKTdsAlIJzuH5GN+bqQBtv1nKD7sc=
X-Gm-Gg: AfdE7cmWY1HV4IybreAD7zSNmnvTLHy1SqX7HixwY/unragmhddV6wZ3ARUOKf/wSZQ
	0C01e6S9mjXAM6lc2alqTGSGtRdQxvdspth/jCBhioHK1+7ABtVv0Qe1iXfavRMNvzu1LNwhIf3
	E82PXrM3/RILDLWExdIiHZ0X5w58SNplCqRHWVXjeTgo+Djku7DoA5hKsUS5v/bnpWZctg6zl+t
	u2XA86qXkxeaYGxWelj80pl5HM/2ZJSwN5jYClVbCrPSRfjfe7PPAcbO+mVXrzpGG0PhGP72P5o
	Z49sQZDMywIpV6vIn++s9DrYaPIwCImgfl0ZtZ9OgRIcFYepQt1yjyeSC01uZrmhUwPbD82xISi
	HXOe6pu2sPB76OzglWxwtQy/lccAfW0Lm0SR+RQ9Tw2yaK3CueFnNj4FFPTTNXGE9BHHzEEps5x
	LtmvYYYVLyrJMaG2dScasbY5uKZWosh2kXo2V7tNNWSu7sr1YgqDx8zjIMU82B
X-Received: by 2002:a17:907:d106:b0:c0f:cbe8:7832 with SMTP id a640c23a62f3a-c12061e2680mr962166966b.48.1782746980962;
        Mon, 29 Jun 2026 08:29:40 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbec37dfsm801535966b.56.2026.06.29.08.29.38
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:29:39 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6671330a12.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 08:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqu2dSDv6EFAoH1BCJDh8joBmPJ9MmEnMTFOLtGv2BmSjygKyi8tFBYOXyc1/QWZPsJ+MPi2aIwuJY=@vger.kernel.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
