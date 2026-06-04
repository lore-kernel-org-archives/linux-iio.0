Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34233A6E9
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780547894; cv=pass; b=IzaNwtCtLhashRTN4Uytlv5PE0qYz68/aWgWfI81blvy3SUIl8/NZQsb/EI/G9NaUFxtUMqKozpXriXX9MlE2VcRdEek13kb+avJJUhAzt4nY+A2U66Klz7C/GNzx82FxczEB3AAJxOjATJI2MkWTLZaT+kJgm7GO/yIQu4mrCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780547894; c=relaxed/simple;
	bh=cSJqbqeQQoCctdJKwU9ufUpFY+CsJwsZRsyI/ueOMT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4rJcKFu/cZ57WKbWm+UfJ3TyGvfJCJJHnfO23C49XuTiIWuPpakffyw7KDvwBc7dZwlDVlUt9A5tddtbtKawNbn1C+tW4tHWkNU+YlLff+7tAGuny896gJEmI5GLtPEZMz2nP0sq1W40D4ypt6A5nvHQw/CzhQdoJA1dcfFDEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dThghJBI; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dThghJBI"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66058b880e9so317180d50.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 21:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780547893; cv=none;
        d=google.com; s=arc-20240605;
        b=g1wpZ7m8BrhjhQwJAV4uxgnFUTTwN2P8mRkK/jgdBmXCeEFkAtP6se/BR+hU6gtRRg
         t355GzyzaM4+NK+n44Q4IU/BOgmT5S9+1WlSVe1ARA7M6quV3Zl3u0PrkXmKY5/M+hI/
         JlmDEOxl3SOSNUbG7fbRkHLTyo8AldbHkgiJqsW1LZRMwlIL+SzvjtrHrDuA352yD5Ly
         dSE0tXumcDBTP7rWImvpkKS8XgbwqjN3966pyej0xaEe8bS7d+BMhSa8gF9q6XVl0m4q
         9svwgUcAZiNn9NDRbPtILTEv3WJtPgAYcPIoNZMTqTmNIlvgzT32aerJpNsU2/+iFQ72
         ZH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wg264YkE5pyKyst5Jn6pATRjlK2A9ozZfnSop0+Fjt8=;
        fh=gs3TppPTzDTWDq3cS+OPl2ekT5wAkY1QEV9KgKj2P48=;
        b=VY/o69AhkC9igYbAIZ3DoFOjaV00egng5Z9O+qpR4+mXbkSgD/lXbNCYG+oCfqo9VY
         ZGSGJ400puHEWV/U06wZrbYB77jUadDblBpJLFOixg4PwVgk+uuSh3SGxoUHT0b9LwyO
         kbs8n57tziMr4YOlLaT0K2VpPo4d+xe0GZaPG+QE0DH2lo5MwcQqsM7Uxd52PN6oXMD4
         BK8mvvx5atO92f/ra4+rWVDyW4Idsp3BZ1u8VbXqaoQX7GiV+wjIt5M4CR7A3D3SKd/c
         6qw7oZT87DXDvWV5j1ChAx+13jgnSnzKNIWNRVuRzgoCoVvv/rt9PY1rEHvH874XXuGe
         8eiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780547893; x=1781152693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg264YkE5pyKyst5Jn6pATRjlK2A9ozZfnSop0+Fjt8=;
        b=dThghJBITptZFKHTVkhAip5+Z4O5TMeTbapCHTArHSMTpTn8nm96b0DagEcsWkAeV+
         PcvV83TGB3LAHta4sCcUV2q0AiA0YioZqwgfF99tkSS3X63eY1gqDGj4gtDe0iFVnIDW
         ujdXBaANDD3kfeRTB3NoVzYtak8FnN8kO2dSjgyTofsC+feMeIybDqhbtydnS2DiLmNx
         6DeL0mDU9ovmacLmKM9GX6n+643SbRyr+D2bMM9v9WWpYfRPbf7PANohoTfGdUwagfqD
         p9/kiMTBdJko3/CFKuuiqDy4GkqhERkpbl+VNq8Uac0n9kfS0DZL+xsBxwPrhJgmeCjf
         ef7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780547893; x=1781152693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg264YkE5pyKyst5Jn6pATRjlK2A9ozZfnSop0+Fjt8=;
        b=H03v2cxN5tA+Lmm1ShUaQBWGoaqgaYO3D5VZXmSj0gpdH050v5l2G4Mzx/3CUUKwEt
         FoXcbMSuP2EH9IP2vcbnUZqnYA46pwEGfzgp9HeY4vd4vUCHGR2z1GQ9bZZDrf2zyegR
         5o1pJ5rnNjwcH34UP55to8cpuL/lJCgVdZy2NC8PQHjY1B21hEeOWGcGAiUwf0efc0vB
         JxLYJPkiRlOoflUiuhaiAqydeuIUMMHBuvCu5ZUbw96xQS/a/d2iW1tLfv+dy4kTmeTI
         Z3vNqp67U1wKgxvBmvUjweCpMFyvMKM4WU0lJXfs+eeC1Sb245fSpFTVfl9f/ShHnGoU
         Z6Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/L/xgGXUly1KBxRMosqwHx9osjgsOsaS0DA5bbAxCI96kgyNY+LYsrF9oPpwVJf+GMdwS2ksIFfAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywajpz2+P/G5ktKj4eTFD3ZtKhB0GFThgfPAcotRDpIVGR2wMSl
	SBGh8jjLzpDvTiXzja4JbuX9cpyn/9fBSQcmS0ZNiWw8rKR8eRXasflq6YT9s2laWo8qSxBQIC4
	AMbfb5RjS/o7wi4DoaEouhyNhxBnHOIA=
X-Gm-Gg: Acq92OH2cK5yO5ef01+vjAOtulNesy8r71HtIgOc79PmRpyhd3yuOTE3339azPLJlVb
	5KS8wLSFW47eWKNKgSg1Ap2vW1NqDJ19eCMjp/M4Y8XXW5sHngMMV9cYNQ3LRo3NLlNbaVszMu5
	Z0/O7JguNKw2Gdu1QZhB3nSPKqw9K2AD+ZwBYmR+dwfvEO6ROxEMKORU5aqjq/90DzGLhDftAhz
	yQpJE5pHY1GtROFHxErrFXJCnwpmJ36cv+0RGUT0XdLPj5ymienEnpar2+qe1oAujmE1pwmRx0B
	u5ZGAZ6F91CxbJb4SLDr
X-Received: by 2002:a53:ef0d:0:b0:65d:c448:e5eb with SMTP id
 956f58d0204a3-660dc51dcbemr4865793d50.56.1780547892595; Wed, 03 Jun 2026
 21:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603141633.1398943-1-lgs201920130244@gmail.com> <20260603181846.7c3a36e8@jic23-huawei>
In-Reply-To: <20260603181846.7c3a36e8@jic23-huawei>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 4 Jun 2026 12:38:01 +0800
X-Gm-Features: AVHnY4L10wJ6AK0f1w1Z1v1M-ln3DX8hQ8TF8kqyu2mw7oZcy23CyJYU3U8S6FQ
Message-ID: <CANUHTR8KwE=FtxogHAuHY1UT=LrXOE8qjneewyhP84SoqwuY0Q@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: avoid double free_irq after trigger failure
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Ethan Tidmore <ethantidmore06@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you for pointing this out.

On Thu, 4 Jun 2026 at 01:18, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  3 Jun 2026 22:16:33 +0800
> Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> > commit 4216db1043a3b ("iio: gyro: mpu3050: Fix irq resource leak") made
> > mpu3050_trigger_probe() release the IRQ when iio_trigger_register() fails
> > after request_threaded_irq() succeeds.
> >
> > However, that failure is non-fatal to mpu3050_common_probe(). The caller
> > only logs the trigger setup failure and continues to register the IIO
> > device. Since mpu3050_trigger_probe() leaves mpu3050->irq set after
> > freeing the IRQ, later cleanup still believes the driver owns that IRQ.
> >
> > If iio_device_register() fails, the probe error path frees the IRQ again.
> > If probe succeeds, mpu3050_common_remove() frees it again during unbind.
> >
> > Clear mpu3050->irq after releasing the IRQ, and use mpu3050->irq rather
> > than the original irq argument to decide whether the probe error path
> > still has an IRQ to release.
> >
> > Fixes: 4216db1043a3b ("iio: gyro: mpu3050: Fix irq resource leak")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> Please check the list for similar fixes.
> https://lore.kernel.org/all/20260520152236.2308686-1-xinyuili@126.com/
> has a discussion of the right solution here being to just fail the probe
> if the trigger registration fails.
>
> The current attempt to paper over that is nasty and not something
> we normally do.
>
> Jonathan
>
> > ---
> >  drivers/iio/gyro/mpu3050-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > index d84e04e4b431..0fd881fdd1ad 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -1137,6 +1137,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
> >
> >  err_iio_trigger:
> >       free_irq(mpu3050->irq, mpu3050->trig);
> > +     mpu3050->irq = 0;
> >
> >       return ret;
> >  }
> > @@ -1260,7 +1261,7 @@ int mpu3050_common_probe(struct device *dev,
> >       pm_runtime_get_sync(dev);
> >       pm_runtime_put_noidle(dev);
> >       pm_runtime_disable(dev);
> > -     if (irq)
> > +     if (mpu3050->irq)
> >               free_irq(mpu3050->irq, mpu3050->trig);
> >       iio_triggered_buffer_cleanup(indio_dev);
> >  err_power_down:
>

I missed that previous discussion. The patch you mentioned already fixes
the issue I was trying to address.

Thanks,
Guangshuo
