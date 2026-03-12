Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A493DC4AB
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337061; cv=none; b=iR/NAthZFfzSrp6qt7+sv+DyIMyMeCmSFd8tgLBt6cN/n5YjPmnh9hRzZQJZmOQmunBc6IroJ+9qNsxyC4hOdfc0mCaCtaGG2SKeTJNWrEXK4ZzwcyLJh45qmY+leWdeJfQB0e9/QxNOtjkRszVdk82JZMnUO//wPkNINts+aj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337061; c=relaxed/simple;
	bh=RsnSHv78qpaLqwvgdzM6cPidFSNlfTQ2Kmz1fO7Ie7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaU2u/DjHBbQyC/Fng5FoZEr1KmZWk5rqOPKuqkzjC3ri05lzjeyjGSVkwCgzlWSeCytHkzgcXOnyM4r4VMYUBgNkyeVfnNvqzO3DXk/7SUCLSKzMop3AyKFONJmZ2R/KbymgBkUTVO+VD+aqLDpzHKeWWUuKm+TqIxzjK7mdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79907171da2so12877657b3.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 10:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773337059; x=1773941859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+0AhCYVaWd9XEdWYnJomiFHtpEOu8tGpu+mSNsVNTfo=;
        b=EkovMZHIUuDTw7wHE1CXYb+7LRAkoy/48saewvHzTJjTcdY4hWbX5OqbBX1ACRubU6
         c/Ftmkw1v5utC/X6ckVArWsxRfEcBvedktZ5hjPtfeBD4ptRGRYchxdtylR/7VbaouhL
         ae1BcU7n7pwJ5vglibqH+gQp2f0osD572fE7S0jXrZY8WNcSgaWrmKiNCTOV+tID5+IM
         NFoOA6kyC3n9zwu9/FrAnlLmuvmors8cYiYS8yqseYGmSB7D1oUbJxDpy3bGCUrNp7ni
         XSgmWSybP4H0HMwSZu7eIpdJzaZo3virb68MjstA0HwrSQ4p07sL4zLqQDjQXNj915Qb
         gvdA==
X-Gm-Message-State: AOJu0YxHXAjMHtk2vDvrayuVZO9t2nXBdh2/EJT20MdwVJTtjYt0uApm
	3YjSVLHvi679Je/ccgw7s4wnJdn8v1mwTkLU5OizW6teC3X2lx9gU61bVdTWW0gZa8VeSg==
X-Gm-Gg: ATEYQzz5so1z6NT8aWdo1T0oMfS5l3xXFnBQOrXo2hmO5xUQAPlP4vbb47poKvM2fbO
	1RyrXqLO8djv3to2bit0NMXUw4ypdKOrwPteV85Ccc5t3dwRFRi15fHxKLMPEdegEmhIfgurLZr
	TzKeP2U0WHVeu5amTyYTl4sNKsi9QXIpb1L/sgh2aiPb4QXcfQ85M9EYwx+OKjZ7WdPXnaRBZEh
	wYXnponWmAUyDszS8YLMAbcHuVTd56wI72W4vEjk6NGBh7niJxBngi4zUGAe/mAO+WspdzQQAhK
	J6mZzbDAGjbBFjg9bLWHGgqI88qoZ8owylXrdc+FlWK32zDpH1u0tGmHOXAi/c1wLv9rVlsFOuw
	qbUfJx/bWYNlq32S9asHpSYm1DXJCjMXxqDaz1+ywPim8aVT1MFaxbfvD/7R9K43WnZMocLQwtw
	OfO1jMgGXrK7KgkihQMN2Ai9uCtmyL8S3lMxev7+iJOio579wCOszo11DUagFo
X-Received: by 2002:a05:690c:5c11:b0:796:6784:82cb with SMTP id 00721157ae682-79a1c08a8e2mr4062297b3.2.1773337058548;
        Thu, 12 Mar 2026 10:37:38 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7991ad51ee0sm28539217b3.8.2026.03.12.10.37.38
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 10:37:38 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79907171da2so12877417b3.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 10:37:38 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:798:da13:7141 with SMTP id
 00721157ae682-79a1c2182b8mr4592247b3.63.1773337057869; Thu, 12 Mar 2026
 10:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311224044.21480-1-email@sirat.me> <20260311224044.21480-3-email@sirat.me>
 <abLUgxivQnz2ISeY@ashevche-desk.local>
In-Reply-To: <abLUgxivQnz2ISeY@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Thu, 12 Mar 2026 23:37:26 +0600
X-Gmail-Original-Message-ID: <CANn+LW+mg9Ridm3aMrVhy7cgvmJO0JNV_s_myfRCW8gPv7Ggkg@mail.gmail.com>
X-Gm-Features: AaiRm53b54paoY7bohUQnhAoqD1uMqiR4vU46Vf3xd6gKJBBdHGtUpnfKfsDxCc
Message-ID: <CANn+LW+mg9Ridm3aMrVhy7cgvmJO0JNV_s_myfRCW8gPv7Ggkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 12, 2026 at 04:40:37AM +0600, Siratul Islam wrote:
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
> ...
>
> > +static const struct regmap_config vl53l1x_regmap_config =3D {
> > +     .reg_bits =3D 16,
> > +     .val_bits =3D 8,
>
> No cache?
>
The result registers change on every measurement, so caching doesn't
apply well here.
Will add .cache_type =3D REGCACHE_NONE  with a comment to clarify.
> > +};
>
> ...
> > +
> > +     reinit_completion(&data->completion);
>
> > +     wait_for_completion_timeout(&data->completion, HZ / 10);
>
> No error condition check?
>
This is only a short drain to make sure any pending IRQ has been
handled before we stop
the device and clear the interrupt line. A timeout here is not treated
as a failure and the device
is being shut down anyway, so I intentionally do not check the return value=
.
>
> ...
>
> > +     data->xshut_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
OUT_HIGH);
> > +     if (IS_ERR(data->xshut_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(data->xshut_gpio),
> > +                                  "Cannot get reset GPIO\n");
>
> If it's a reset (semantically), use reset-gpio driver and reset APIs here=
.
>
The XSHUT pin is a shutdown/enable pin rather than a true reset line,
and the existing shared st,vl53l0x.yaml
binding already defines it as reset-gpios. So I am keeping the GPIO
consumer API here.
>
>

Sending v4 with all other fixes from your review, shortly.

Thanks,
Sirat
