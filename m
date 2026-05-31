Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD943191D0
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224400; cv=pass; b=oBtKpKa2VvSpZnUyTdo0TVTwLsmgS9QIzDROYNKwSNLFf2fxIdS8iVtc2/dr+jsM3J3s05wVA6i1LdItcl38zpyHyS21R/v7qonK8mlRtup9d+CYjjWVrKyGVtk2/lFET+W5Vrm9u4aDZA7/pplp2myPkAsafFiqPoX3mgN0zIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224400; c=relaxed/simple;
	bh=Go0Wray01QJG4fXsOf2i6hb7EfbTw0dJcBKjWRowB/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqbNnz8Oc2TWeutIo2rQ8yYKBThDTK8qoSEBR93vaJhjvbE6jlwJhnH0Cy3NfW1sfT/74HFwYNXd8pMD+ojCR1Dpc4YnoBmmOhKkl6ZCyNIlq6UKYF4bCJnGoVFWOTmyx233G2uRGFBPB8s+IBaeebZXZpmEnhyLutCjzaWgc/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTOreBH9; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTOreBH9"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa4b131940so4308892e87.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 03:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780224397; cv=none;
        d=google.com; s=arc-20240605;
        b=auvaqwXQ+70j7BrArE0Rk1+BJzHCx9KnjfPw8qCtt1RCY7GlxU0xy+O3KlNjLz58uq
         ctC5S53vkpdXXSQlCzqoHhZsuBwlzmQNVP1qy/zQUAYt6C49Hbpv2aBYbB6JENFHdOlb
         qM3Z4iWER93De7SU2qQsvBOr263erdb+jhgA67uYRd58bNfbZXRdrkKRUAtumi/gREHu
         1yKK3jKzE8ClRJTcsC1vr+2jUclhnxpN1LTuVQUoraSqJjPywrarMaiAwYsv7kkDcHsJ
         9VWEmZdiuqTnGGByRxz0OJVnAjwpKkUIA8guOFl1yXva0/U/RgYUxVawhbyOumy3kDJF
         tYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zzjjOuAVGRSB9pPF5P8gmF7NJS6WDL3M8H+3GgurXfA=;
        fh=Y9RiP2o5zVaXwom1lwSE5DbPANiIKL1Hw6ykvw+3x2U=;
        b=lZ3ahFeW9xJUO2j4ek9hFITJOOzgURyXeq1MQAnCpoXT3t6j2rjXvoMMdlhyTgB3ZU
         USm1zXd2A/Sh1Vm1EONOlA8VmBLNrTMDEw7CmJZUVa1W3WiIsQARrHmEQeyhIq+FaPa8
         kZ5q5Qb+4xuBOEWdjtGL+8OHe9reIfQkI/Z7T2Ap8bSjMTBOdpA5ggRFIqGYLlBFY8zx
         Jgnx0PIQ9ePI+he/8BQwubSQmlxRRehKWpDgwtLenkN3ANcTx+nv8msYYdPuTlRrapwC
         yDWlEFv6HltqQTXoeX78IRuHtlD1xqFp87GcT7iMW6njt9K78vcJ9wSITcmf0fnxu0uI
         vVuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780224397; x=1780829197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzjjOuAVGRSB9pPF5P8gmF7NJS6WDL3M8H+3GgurXfA=;
        b=LTOreBH9/1FBbfd/rYqiKUV5xAKkN5dAyoqNe3z8ldxtXV4X58V5+e5U61y3c/D7MH
         I4sMw9StUzAEcYyiIJ7peX02NfbHAwq2R8O1ACDxMH8Yu0v660Qfo3cLS+b3R6dwtGIT
         wFcrFiyWdCAh1whwzBiP3PpnehE7brbcGmr/3a1IBapniNlTceqdDD/m7uuHrO0+NaYA
         KT8SKyTYKwhqOO6BSsBMoulEKiAYQtalnS1wsw83YJovxlLhHaLsXwwxp2NHDMwnu3Rv
         io4OXgRPw2diTBhbQhmA4eEQ9WHA6nWThdhWvOIqv92023mHCWUp0BLH6kPQNmbXwTiz
         P89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780224397; x=1780829197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzjjOuAVGRSB9pPF5P8gmF7NJS6WDL3M8H+3GgurXfA=;
        b=PT2FDagoV5FHUYG5QjP8Pq7ZuU5msh7GFMWNgwbKwxBOJ+QrQ1Ir16EdJ8KU1ufyK9
         IeLpluMKxOzU/08AoRjVH5FvH4tUzchB4C0ldbfSkHI2xIQ8b0luU+Yh+azvCWGhIKoS
         RRyX25evLZNYwnLQnD6mh9O4LXE4jV9/JDu0TVEseX5A+W8qqAVU4fgg46rsENE8dcZX
         ROGGq4ZHJSA8fNw4Ni4FQ6mSECGZGyyYxodDdtl5OQzPn+nZ8Uz6KBSR/ZEbnyIvxqmP
         W9eIL+b+cDkVBE8xGPmI3oqNUsdJghZZ14CICulWsg25y0xSdHfoiP5mXXArVWvKenPC
         y3SA==
X-Forwarded-Encrypted: i=1; AFNElJ/LJsrV6ua32iawm/ncfLUMoWq8UyTmlplM/fUc7exBa249mkRKmjWK1eCKlxKPzebqmNGfhzD8JAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHUHQbOPsIwxjZEQXHAB0co0JmxTZjTOUhUv/KQ6Y0GtIwJFL
	5Qk41V8NEb+Ymw5+/HrqMLoy9R5qX2AdwbAUuwPgNSFziAb3SbytQG7GNeV6ihKsZcMP234YBfq
	PyV947JxE9iXwP++zzx9Jj+hWiBnb588=
X-Gm-Gg: Acq92OGpj+N3iu0Yp5ZrjUjRj4UmjvZIGvklJuLgy4cx1TK1qHTJkxRkurA84imzSTo
	7iHSkCCuwelt1wR7Ev1R6+PbGM2Ad1JF1W2oKyaHFfrbqDJCZqnmVPu5l9l1JAp0a/72YXUCUwN
	fjGYb9wxfnw5JJUCIIJhvspY1pay9IHpnBRViscxYbokpLZP5iLY4ZFIwrE9aZ/kySl3TCkjam/
	qvEDa67fjLY79z7HeoHox73WqfnhJcGcW8/1ozb/NSYXGTVoA/jxcY6ADACv7J0qqINa9P/1ctC
	hD4C/w/aRip2LygY9iNEj7vH0THYxnRuEaCcwe6MKZpqkzRR9A==
X-Received: by 2002:a05:6512:689:b0:5aa:265f:acd0 with SMTP id
 2adb3069b0e04-5aa6092a8a5mr2041343e87.39.1780224396614; Sun, 31 May 2026
 03:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-2-suunj1331@gmail.com>
 <CAHp75Vfd_eRRgnCpXsa0CVQ56f85YwQQRTj70MfmB4prVygYGg@mail.gmail.com>
In-Reply-To: <CAHp75Vfd_eRRgnCpXsa0CVQ56f85YwQQRTj70MfmB4prVygYGg@mail.gmail.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sun, 31 May 2026 19:46:25 +0900
X-Gm-Features: AVHnY4Lo0kRsNjuq_XRFqHod0O7PYpocpH7xfVx9ApYOJbPmYAyD43ZyivFanqI
Message-ID: <CAGwK=3qst8kdMmUeHvbB7omkEv7N+_+eqP04Bqcy4YyVpHpwLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: pressure: mpl3115: convert probe to fully devm managed
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Andy, thanks for the review.

On Sat, May 30, 2026 at 9:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> > +static int mpl3115_suspend(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>
> What's wrong with dev_get_drvdata() ?

Nothing, you're right. Will use dev_get_drvdata() in v2.

> Ditto.

Same, will fix.

> You forgot about mutex_init().

mutex_init(&data->lock) is already present in probe(), but I agree
that converting it to devm_mutex_init() fits better with the devm
conversion. I'll update this in v2.

> Add
>   struct device *dev = &client->dev;
> to the top of the function to make this shorter and easier to read.

Will do.

> Split moving of this function to a separate prerequisite patch.

Will split the function move into its own prerequisite patch in v2.

> > -static int mpl3115_suspend(struct device *dev)
> > -static int mpl3115_resume(struct device *dev)
>
> Why did you touch these two?

No good reason -- I only reworked them to flatten the nested
i2c_get_clientdata(to_i2c_client()) call. Since that's unrelated to
this patch, I'll leave them untouched here and do the minimal move
only, as Jonathan also suggested.

Thanks for the review.
