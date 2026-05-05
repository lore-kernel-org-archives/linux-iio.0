Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43234EF1C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967321; cv=pass; b=IBcyg7NboSxy6Jo2v8XcPpjKWvfERV5bKDSGkK/K1QZRnpQZarM0pGTVUmrNcmY5lq7TFs903EHE3qgI3tiKyVLrWZfaVAd3N4fMJ1Nj1/XLw8fToy9yGhf37wSr7KuqP9B/BAWjBfeIsUiTbVEB2qzmR2pTZlw64gR/Bzo7kUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967321; c=relaxed/simple;
	bh=rRHwFA5RYQLuKw+lmSPwbNmSV3JVD+xVtBbzqeiKKBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p20t7ox+DLEH92Wla9YBwWMrptS7gfmR7BFaCGK+g9d+u2K4cbLbLoUNNL4ch2URTp7T+nI7jiV7PZj/gRk7rqP3BMaj7MFU+PaY0jdifcY0X7dAM0H922Zuh5GBBnKeWx4sMkkWXATSYR2XC1zTwMm4bU8aXJ1fzITiw8W4+X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=rEaWtQmY; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="rEaWtQmY"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d4f78fc9f6so541654585a.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 00:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777967318; cv=none;
        d=google.com; s=arc-20240605;
        b=DNd3h2dAQgKj6vRUkM5YpgPLLIVo8R6oepfVQqPUtVHuBpnTSXVnyvVfRRzOufa6zh
         q+x3DAiQvuks0/jyUWXgFWCl9pL7xv2Yq7k4U+YFGFC7C2NdxOkeR5sOVRoTP5ODoZp6
         8IcAEFIy9iA1FVrx9AwV52AcEhzG5gAsU/WTIu9q5ICUJkGDyQyca8s0vnVzHtwgU7/8
         saNKlBYw6UNV1MJEKTFs/FD0J5iu4uyTmvuDxF9SXuWXRJ1DmSYeezTb7kR2JDzBxgkb
         HgW3Qkxy4vVCp4pbcB945jPqc3jii2HW4k+XA4GiRjhXcaK0HJVvTbXc4bseHgGtXlq1
         gfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q2C0vijfzvV5Lp8tCfHLSU5dQmFv/k33+BTXi5ftR9U=;
        fh=TPXU3aF1EL53xS3q0lY1/lNRC3uGX/sh5S4LpK+lRBM=;
        b=Vq8yNevyLzYWkQmTo7fBDm4P3nDsdnkCDYyuxbK/0VEXzLKyGkWeWkCYGEEjV89H3x
         2N/NRcTkR/808QXsYn9ciFUvlhzdMZC5UU6z46GDFbqYvGk8VLTD08jlbGAM38ZncRVU
         4UWwK4G7mkJ3PkNHMe/8YIZkb3r/jX8Z9axq52iVJWQkPPoI0m2VNu9NQJa8EkEYTso8
         rVIinvUEQqWK3MXnnvbIQ6iZ1AYVvRA701UnsYQF+82EmiNt4UZfAx5j7fX2//qUe2O1
         N3GGh2ndWIfWgW1GVS8NdSo4WrzdEmv7gG2Fnkxr6cbD5J0K91qmFhKefr9bOGscmd4i
         ksqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1777967318; x=1778572118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2C0vijfzvV5Lp8tCfHLSU5dQmFv/k33+BTXi5ftR9U=;
        b=rEaWtQmYiK6LBAUlcb3JShr8cNszB+ZheNVlwuDdubBrgZaPmeF4Oj/lSE3Niu9uzt
         XwdUMfVFIeHWZop1o6PqrtZC2lV1ypPv1+Vk/oqRZydwZjliB6WDwjPZrWLGuX9ZKPh5
         wRTMkaoFXFmkAYfVyh1sCXTboW9uqGn1MP6O6VzFFw9lteOrZsrDZ6QRgdy7MiITobOX
         AMjtfdf0ki++L6Ip4ybap2Im3nxnWekhYBpxgUSS3lHWdmaurKOgtTjurR2ecV4EP8se
         mECpay2oROo1euVhx6qhbOIW9kB2B1O1EnLt1eQzbFKUa0DSOlL3FZ4xGxTBuIlQDZGv
         KyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967318; x=1778572118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2C0vijfzvV5Lp8tCfHLSU5dQmFv/k33+BTXi5ftR9U=;
        b=ZympVsnEENi+OKpWQoGA1k9RV5V2kHUFi3oXGHNo3Gc7Kobrmq85q6KtfvswgTd4oT
         ArlkGD/T//vI+ROLzYQ357CcOTyCQoAtkCq6Ed5sBgiDVfAnRUjgeaJvgT9U3L/j5HY8
         PLZtZoczdke+elN0+FVp7KZCvc4tmHi7xOdTfADEKdgar3hXnLOVBj5VQiuURDLRZGVF
         AHgK55aIgivOsTi0pOYUCK9ppyHFIc0qYfmC+KaPjW5GeAiXPqNx7K369CZT6ccjFWR3
         0lGGbh3XSduhtAXcMqRJsckfNJPOlcbWqXvHrx1G1/9YUma77DB4DZ2qSpIc/lpS+VYT
         le0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9/I8O7LxDcR33atf/BDhh9tHDxaV5cq5mNYQ57UqM5dZRRolPF2a9wozXizc76LQUog4nqubsnUxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+Z5V3BIkWdX36cSWHKbK88sRE1FFVtv3I34ZYz5SCHNYUdAG
	Dy8Lwt7fCt4rB9eaSLcTcB3DkqHf0iIQtIwTmDvsHwemOEEt+IWhJ+ncJI4DpPoFL6WOR5TFid9
	kjEKxNhZOoG7b4EnDxqw7vJa3bdlcqBFS36CPAtUlc+cdws+9hFzC1tt1
X-Gm-Gg: AeBDies116ylSL5ornHmurusO12khAF3LiHWR4qCNGpe7HBWDPCbJqkygS5Buuwg3Q4
	QDYA4qvHvtm4YwWwnzR6JGfceiKsNR+A++Lx9H7piRiKmiW9UGbrmoEoxVipYa+H9SC+UP7YhQS
	f7/PYrXMxlX/uIcRkX+CksFucA8jOb4M6yTx+42Qs6AfQ/KuPyrHrZP7blOd1n08dC2syuXw+0a
	Uakrv3Kn8VGnOOBW0CK156S1jloZ2LOmiAgPd0RZ6UNRMJ3syGXsqmV/z+4WGmMN6+aJCpDJf2j
	hJMMvXYbU3Oq6sm0A+7rd3lVGFhc9MX4/vtOUXha1YZFANMcmzA=
X-Received: by 2002:a05:620a:2681:b0:8ef:dcb7:59a5 with SMTP id
 af79cd13be357-902e4c7e2c8mr309455285a.30.1777967318406; Tue, 05 May 2026
 00:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427215800.28082-1-salah.triki@gmail.com> <afBpBNLucHg25So0@ashevche-desk.local>
 <afByF-0BV1szTbzE@pc> <20260428170412.41791bdb@jic23-huawei>
 <CAKv63ute7h3vdZMjK5FbQLGH66O=VBk-+04e2p0FNWZBL-Co=g@mail.gmail.com> <afmc3xTW4H2oPMuQ@pc>
In-Reply-To: <afmc3xTW4H2oPMuQ@pc>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 5 May 2026 09:48:00 +0200
X-Gm-Features: AVHnY4JvFXyTWZ797tnkx5LqWXrqpj0Aae-wstSc2VFFTIOv8hBg3YPKEMuhvbI
Message-ID: <CAKv63us2nZdHoCoB+GsWmz6UMZhZs3c=v51jTCxwiwKVqVe6eQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value checks
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 09:31, Salah Triki <salah.triki@gmail.com> wrote:
>
> On Tue, Apr 28, 2026 at 06:33:05PM +0200, Crt Mori wrote:
> > On Tue, 28 Apr 2026 at 18:04, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Tue, 28 Apr 2026 09:38:47 +0100
> > > Salah Triki <salah.triki@gmail.com> wrote:
> > >
> > > > On Tue, Apr 28, 2026 at 11:00:04AM +0300, Andy Shevchenko wrote:
> > > > > On Mon, Apr 27, 2026 at 10:58:00PM +0100, Salah Triki wrote:
> > > > > > The functions gpiod_direction_output() and gpiod_direction_input() can
> > > > > > fail, but their return values were previously ignored.
> > > > > >
> > > > > > If an error occurs during the GPIO configuration, the function should
> > > > > > abort the wake-up sequence and return the error code. More importantly,
> > > > > > failing to check these values could lead to the I2C bus remaining
> > > > > > locked if an error occurs after i2c_lock_bus() is called.
> > > > > >
> > > > > > Add return value checks and ensure the I2C bus is properly unlocked
> > > > > > via a goto label in case of failure.
> > > > >
> > > > > ...
> > > > >
> > > > > > - gpiod_direction_output(data->wakeup_gpio, 0);
> > > > > > +
> > > > > > + ret = gpiod_direction_output(data->wakeup_gpio, 0);
> > > > > > + if (ret)
> > > > > > +         goto out_unlock;
> > > > > > +
> > > > > >   msleep(chip_info->wakeup_delay_ms);
> > > > > > - gpiod_direction_input(data->wakeup_gpio);
> > > > > > +
> > > > > > + ret = gpiod_direction_input(data->wakeup_gpio);
> > > > > > + if (ret)
> > > > > > +         goto out_unlock;
> > > > >
> > > > > While technically it sounds correct, the potential problem here is that you may
> > > > > fail this in case CONFIG_GPIOLIB=n. Is this GPIO optional?
> > > > > What may happen if GPIO is not optional, but for some reason setting it fails?
> > > > >
> > > > > TL;DR:
> > > > > I am not sure about this patch. At least I'm not comfortable to take it without
> > > > > testing on real HW.
> > > > >
> > > > > --
> > > > > With Best Regards,
> > > > > Andy Shevchenko
> > > > >
> > > > >
> > > >
> > > > Thank you for your feedback. Since I don't have the physical hardware to
> > > > perform the necessary tests and ensure there are no regressions, I agree
> > > > that it is safer to drop this patch. I don't want to risk breaking the
> > > > driver for a minor cleanup.
> > > >
> > > Maybe Crt has the hardware to test. For now I'll assume this is not
> > > going anywhere wrt to tracking in patchwork.
> > >
> > I will dig the hardware to test as it was off my desk for some time
> > now. It seems like backwards compatible, but I am wondering why would
> > we want to be informed of this failing? The problem is that sensor
> > uses wakeup line (same as for i2c) to receive wakeup pulse, so in
> > theory this is already a workaround. @Salah did you see any issues in
> > the wild?
> >
>
> Thanks for digging out the hardware to test this!
>
> To answer your question: I haven't observed this failing in the wild on
> this specific sensor. The patch was initially motivated by a static
> analysis and general robustness cleanup, ensuring that we don't ignore
> errors from gpiod_* functions (especially in the context of keeping the
> I2C bus locked).
>
> However, as Andy pointed out, turning this into a fatal error might not
> be desirable if the GPIO is optional or if the failure is transient on some
> platforms. The goal was simply to improve visibility if the GPIO
> configuration fails.

This GPIO in this case is basically used for generating wakeup pulse
(so when sensor is sleeping) and I doubt there is usefulness of the
GPIO error failure for this case from user perspective - there is a
use case when debugging.

At the moment I am fairly busy. I have found the sensor, but I need to
dig out the some board to port the latest kernel to.  I hope I get a
reminder from Jonathan as the window gets closed, but I also have
trouble

>
> Best Regards,
> --
> Salah Triki
