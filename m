Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDD30EF95
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132755; cv=none; b=FJfr0WUNbkOkZDRbEbOocgy7lIqT++Ycnu621R6oI2mMg7aMuQ5Sy78VoY9S1D7t44Q8LgfN++XYc28dDLemtuS3sCGEr462zbM/0i3eJqaq15qpbjYZ+hYhkNzsHMrSzSwh6X66SEhW82RoOIonQYluCUF/NA8DEu7MO9v2sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132755; c=relaxed/simple;
	bh=tCOkiwP3pijnaqh15oBnF1Bom8SOKIZWDzHWvDC7Iuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZfaG4m1IuZaCXBo6r2TOuOVqObDzbcYeEn2TSCiE4tEBtzQIxaTO0TDcAY1V7ImXimD8ZhMDqNtW5R6mcye23z97jx5P+meaqpEC296v0jWnSm5xHt/49i+Nn+Iz95XzaJnV6XFs49LEjteeTkTcwC6RYm1LaWrFzOsARR/uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad8435f46so1883069d50.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 15:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774132753; x=1774737553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dwPIAwzmIqLH6UY5qG7+Exq5GeZYYmIywMuNQZPZybY=;
        b=XpoTXAAvBU0+rYu4zB5UYgMvH3HRQgVufIOovPAXUz+zw5fP6wGT4KzVDttK9LQoae
         zj+nxeqTh/YuShX6KLuZulBzH06CRC+3Hh4vnpVVdQyk2/CEk+118sKTclMqR6U7hRGx
         Ivy3yE5Mt9WEjzkECpL+UN5ne8zqmC6Dc0j02jnvX3L0bi9WxmNu3dzAW9dbn0ok1EKY
         vga+LwuCaCfD0iAN0d+XHsyejYn9Ucb/nqLw6lQo3nigT6lH3v1IJLvL7Np3vd/S8AII
         Jt+kZJf/OanLnUg2CQK8hWavjdzgPhMdnNhaAwZVaKFRW0nBIngB/jKH5nMhVLhVe/jg
         9xwQ==
X-Gm-Message-State: AOJu0YzUYBvKfztsTQHaYJ+NKgVbFNA39nGQrk99W3CgpJUFxnAxdaVO
	wcUzMbbW7aHulV63Wvc/FkQUHXAGN2pvF+QoQxgsCXGFd1Ro8jIJVPt08MDZNj7W
X-Gm-Gg: ATEYQzyBc2PWe7ZZ5+voMVkAXjlp+vmNdLK8sxYi7DWVrx73G398VOWkUkb5aowz/2C
	yEcDU8qndJy0GiVfWlXb7q7ipK8fPXnfxN1/u691KpXGmo+4sCD/Mm8c84WzUlCv8CYVXPbqWL8
	wN86RYFKflq+sIezfYY+ZG4KiJlmBMNK0IMmVpAI9t1AZPNzaiY32KaizJs7TNTjdvZ0t+8QHda
	ND1rjFtG7GIbZR091pezX6DBjqsL7/R8gt/6Yyl5i/fI7UsJzaSY+/qrpu/qZR0ygb96qgT/kCs
	wfb8jpSl7pgou9KehdYIRaK/5/0I3NRnR0baW6c0blMUxCzDvJersLj5oqYDog+V7cSwT2quOM8
	ZPrRTjKyYcB0wnkTUeKAgVbmiNpNi/YCSU5384Dal2U1SgvKP4WNk71HvtUysjyn2KooaTyFLKv
	Ufau356eqa6pz/4DWCc0kHZ6oaJq1UJctv6qQaOY1QxziNBQPLrIkoSlWeg9SJEnOI0OKbi4ben
	paZBNv/G5ANr0zj2HeRc4CFdYzjvq2E89nPFLJwgMONVA==
X-Received: by 2002:a05:690e:134e:b0:64e:a530:e4b8 with SMTP id 956f58d0204a3-64eaa71bfa7mr8173568d50.35.1774132753340;
        Sat, 21 Mar 2026 15:39:13 -0700 (PDT)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com. [74.125.224.54])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabd6a005sm3838379d50.5.2026.03.21.15.39.12
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 15:39:12 -0700 (PDT)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9707fc11so1077609d50.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 15:39:12 -0700 (PDT)
X-Received: by 2002:a05:690e:e86:b0:64a:fe95:2ba7 with SMTP id
 956f58d0204a3-64eaa712f35mr8023751d50.31.1774132752611; Sat, 21 Mar 2026
 15:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-3-email@sirat.me>
 <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com>
In-Reply-To: <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com>
From: Sirat <email@sirat.me>
Date: Sun, 22 Mar 2026 04:39:00 +0600
X-Gmail-Original-Message-ID: <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
X-Gm-Features: AQROBzCOkEeiyGM_hVf24EiN9zU8IMOKL2dZN-mIO8VzxzXIw8q8QwSGY8OpiL8
Message-ID: <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 11:09=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 3/19/26 2:07 PM, Siratul Islam wrote:
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
> >
...
>
> > +     ret =3D vl53l1x_set_inter_measurement_ms(data, 50);
> > +     if (ret)
> > +             return ret;
>
> Could make sense to move these into vl53l1x_chip_init() so that probe isn=
't so long.
>
These are kept out of chip_init() to match the ST Ultra Lite Driver
init sequence.
Init only covers hardware init and VHV calibration, distance mode and
timing config
are separate user-facing calls made after it.
>
> > +
> > +     ret =3D vl53l1x_start_ranging(data);
> > +     if (ret)
> > +             return ret;
>
> Why start ranging here? It looks like this is controlled during buffer
> enable/disable.
>
The VL53L1X (unlike L0X) does not have a single-shot mode. So every
measurement requires the device
to be running (Autonomous mode according to the datasheet). Starting
ranging once
in probe allows the direct read path to work without any additional
start/stop logic inside read_raw().
This keeps that path simple and low-latency. The buffered/triggered
path independently controls
ranging via postenable/predisable, so there is no conflict.
>
>
I will address the rest of your review in the next version.

Thanks,
Sirat
