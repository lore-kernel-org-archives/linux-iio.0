Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FB42B721
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590015; cv=pass; b=bem5lJBe732LldAYk4SpZUQDvMrzF+NkYHlJLH4fEmK8e0+7fzXuxpUhgh8hHhzaiU+pD3r81mhZahaTa5O0G9XqREKTR76AjfhrZNMXG7+same3ev4ZaB7JCH8NTl1DYYCmN4A4M3gcTUjmj+4/U7TBmFp9g4X7BgJvxNPN3Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590015; c=relaxed/simple;
	bh=vgUDMcsPZsrJmli8uHc2VZ/Xp8TkGo/abYUdfDLsuK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpMm8jSONpTmr1legf2Z9LENHW4rk/YK12kbo80PNFw+N5D1HoDbkChpO5XNx+VZodnk16x2SmwwiEzKhhPqlwzWexgYBE9oHbRuuprou3dOYc+4IvqFjxNWqLd6sGAAywdrghf2HzzsWxeq1uLx7nIrzFrTMNwTJJKUQGbrHPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=k2stAVs+; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="k2stAVs+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccf887de87so10271006d6.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 09:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590009; cv=none;
        d=google.com; s=arc-20240605;
        b=b5CIVh8k5q9sQQjfKMR3YQ2RIQNTluvvNB1uD6Nc3gUN13J+ufY1K6INhEVyPP2S4D
         YaiWmN3hMti2jRuHkqZVhVCWnn4BH9TfDfXnCFPYLz9Z+8KOYomljLeFw/gH7/JsjPXF
         n9TLX8uD3JiG4z6ySAtgarIXIkLEfJEV2njfdAaWGVcm3gniHSZ9/+/79Yt3boO8DTwD
         ED2tFVxRi2Z3psDh1901cyb/qQzU+T1SpNtIAPNBDuovqWrDnyFmziQb9GVl3lQEhS1p
         BcYK0Z4GkNOeI8cfHxWSgDoOnHFq+hSR7G91+guE+WQAi7pHg0YdPINJ0SCl/5Ax60hR
         U6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLrY5btFgsC61H05eMSN0G6u5fLvNhlwYmKjGwMO1nM=;
        fh=S7/1SdRtSH4UcTQnIWUkhn30ICZqK8kyqUJN3qkra+s=;
        b=c3Z5VV86nteQNiuLtcjQz/Y6yaFic6IKnU/NOitaLL7tJoR5brd9RUV0/44ZGgnBDe
         dXWNgB3k+YIJDh28VG5aB8Frr8w1e/QuPF4ogVNSIRuVdjUbKw/hfFlAUPAZMn0K9UwV
         Uy4AONvZaz8qkXWdxn2bPjYn783lmAygVZrfmk02S2I+8/x4GR6jQgnPnJUnvaecsza7
         3+nF+RFtC2GJn3xur36cLKRoTf55TWaXXAgBCZ/SjFR4GWd1zwXTc6yLnPsJHCgvYobL
         JhPNteLZufZ6NXW0+WvMIGOIxYhbHsNhmCcTDdrmqJJ3MqxMc90+IY7bsRIeSFb5NjJL
         o8mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780590009; x=1781194809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLrY5btFgsC61H05eMSN0G6u5fLvNhlwYmKjGwMO1nM=;
        b=k2stAVs+dP1fwpxE9oQ0QIrxI/TMiVRt/EUNknR6lSMdC1paG8Y/xUwYBCdfCsQYMD
         BLOiR9Wt1Fs8gK8nWx1gazJkd1HCVADsFn3eShnQrpZvjFtHhRlr3bO+afXrylFCWwSA
         jBKEH0Dgir5vrfm+Sb6RpXl3zTgqNUdZlCSMWj4yT863F8m9JlTkQMBE30k7++XqOcrv
         6RDDqFbS/xoZHy7PibST/4DfR9g7eQc4OHunAg7ZnINgtQirig2q3qeaGKBzLZcL5e2g
         NiN2GhDVSQSk7RzYB8fvKUWHTWmPr31dtP10oexr/0jtjQgElYaSYRsYJ2RsUHom8Fk0
         yj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590009; x=1781194809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLrY5btFgsC61H05eMSN0G6u5fLvNhlwYmKjGwMO1nM=;
        b=Jr2INrfjxmCwhUBYhB+baUQRLL1L7Lbr62CzhzYL1JH7+Zocj2u36HFv3Vk1pkB8SK
         B1diPjlEIjXjGd295JUdWvzNnSIoCVKYSzlWvQGM+GlSPQDo+weZ4/wv1kxv9rJVe77e
         wXdQAfTDPI+vhDU+9EqsEwsup2BU4/oL9+Y9eNv2Tcgtt4b7WeE+1AUcZ4+Wd64R8xek
         zkLuerHMIwbXGRWSSdb2dy0rgjqv13RP9jnrk7Iij+1vwEPdfSEc4mvwTbSF1qShuUhU
         fsNYP05oKMn3dsdc8fe4jm28O9eM/lZ75sYOEgfTYd1v1T6nfu3z6R6ZHl3y1sTrHWVj
         6e/g==
X-Forwarded-Encrypted: i=1; AFNElJ+g895I+CNJ5X5dxooLta91hGKpWWRa7/k0XHM8iBUusnLTKNvuFqF4ODDI1qM5GQww83HQ1r6qIpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeGCYmJ4JTn3EGAQjtyZWkHHkG4NqjUWjRdTAgWnGwCNuSw2R
	LjgYZMg6bXHLCesRfyXYFSuSCyl3xTO5hGSedrP5iIv+fT5U77FPY4t4hcE8GwVg0eYzHPU4TrG
	qTsfns0d3SVcoGcgUzHnKWOyo8G3dOufFMdL2kqogkg==
X-Gm-Gg: Acq92OEfAnnCxglPvntGqrOKZPFMqP5//dHzxFVy+wGmmc4V6nfrEiFk4+y6Xr5RAQO
	+UYe7qEleZ5OKkCJVRdmjgTAQ3CyePjBO6fwSOY2jvvs7NqZesFHnztVbHQ89GAmD0YcQ6M5fKc
	Fcq+douRYLpHw8YGbGdMlOecCCMSZ+DISnuOkbhV6djjjq7j85mT+33bLOAUb7sKK9jjyQRm7Lt
	3vxG1oQybSE0D6RBXay9V8uGKCVVyunyWJfguZcbG3JWDNi7Vh8jSKWaJu8rD2Llm306im7Ij9T
	4RxxXS8YKFXjvUogg0zD87VpwkGpUZ3CUvzoqWbIGW+zEbSK/1/w+ciFhFXD
X-Received: by 2002:a05:6214:412:b0:8cc:ed49:bdcc with SMTP id
 6a1803df08f44-8cece1655d1mr124325456d6.44.1780590008249; Thu, 04 Jun 2026
 09:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604131518.27323-2-m32285159@gmail.com>
In-Reply-To: <20260604131518.27323-2-m32285159@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 4 Jun 2026 18:19:55 +0200
X-Gm-Features: AVVi8Cdxjl1cmHAE031qH9pvjyzBKib5VzySpAY024FugOHM1d2O3jfPXo3IFUI
Message-ID: <CAMknhBGKHdUV10mLz3P_eH3mg9WU5kHw-pGqoRWfVGyvD2HwOA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:17=E2=80=AFPM Maxwell Doose <m32285159@gmail.com> =
wrote:
>
> The current code uses mutex_init() instead of devm_mutex_init(), which
> is incorrect as the rest of the file uses the devm automatic resource
> management API. Fix this so that the mutex is set up in the same way as
> the rest of the device data structure.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>  - Drop fixes tag per Jonathan's suggestion.
>  - Replace dev_err_probe() with return -ENOMEM per Jonathan and Andy's
>    suggestions.
>
>  drivers/iio/chemical/scd30_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd=
30_core.c
> index db5cc295aeab..198add58affd 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const c=
har *name, void *priv,
>         state->pressure_comp =3D SCD30_PRESSURE_COMP_DEFAULT;
>         state->meas_interval =3D SCD30_MEAS_INTERVAL_DEFAULT;
>         state->command =3D command;
> -       mutex_init(&state->lock);
> +       ret =3D devm_mutex_init(dev, &state->lock);
> +       if (ret)
> +               return -ENOMEM;

Why are we ignoring ret?

I would expect:

              return ret;

> +
>         init_completion(&state->meas_ready);
>
>         dev_set_drvdata(dev, indio_dev);
> --
> 2.54.0
>
