Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84133F595
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394025; cv=pass; b=WA97+CxhUusBGsBJJyfkdjaqNWiAdbG22ihUA0R1ZR8cwo8G/Wt2O6OQ/KVP4yncWmiI4SSByhXHXNAVzw3ZxLF+IH1RxZNQKRfyV9+2qIHIE8kiNuqc8SnAfoYoc4crvRK2XLUTjv8NXUlKAfUdAK+g+p9HvYFH927Bjb3JbaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394025; c=relaxed/simple;
	bh=86vZna4HySOZd7kzlEoKOS3EiV37blal8TnFgCnxAKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zapo7lgTAgBWW/6JsrHvLVpNfK8zWa5IlWtbOuwXZOzcT2ce9l00zQZG1I6lGbC8qkFXqN5oz3qElf6CFV+Rejhnbd3V+QkMirbsXGyM6MnhG0WOT0/yBLDArVplAJAmjB9KGSjg3DbbmkF94eehXDoK/maKHyWj501CWgZqF1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=sk6tuDlf; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="sk6tuDlf"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso112756d6.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777394023; cv=none;
        d=google.com; s=arc-20240605;
        b=a9t4YbRY0kKf4B8lpYBmVgPA6D1shu6CaeYZBvcrZpq1D4P/JFkq2aiB42Q8boyJao
         qKC/ISjiM5/0IEdCgEnkZY5HvIe5EljFKb4q4AFY3j8QCzM0sMuwD6yojyAQJrgJFUJg
         x/N0c6LFiALUvEkVUUrSLjzrM29YL2+4Y2KpmEHaFTCmPzwaYXiDBBV5FC87z9VBBaBY
         GphpyGyiWLuS4lmKKnWrXzei6fkymEhxm6BHs2HrhaAEep7vlBKNjmTXj+3T9G4R1h/k
         RvPk3n0yXcZeqLGA9J6JehKmKYpYmiFoFvAzGN+uK5ebnstEw6GzxoCMf/nJycFNIc0x
         tPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gSK+MQBt6cRt/VUGlsHOAZTSUYJSLwJzWsGWmh9wYuc=;
        fh=CVbPlbQhbH6p1lXGqte/9Puzu5puoEMF+D+dkEFt8oQ=;
        b=cFM+N9Xgue+B700Rs6tswGvA+0GYvYyLORmDPs5IbiSizXifUmC8zhBb9UAZLcgYzE
         +luE0UXGwrAmy+RaYhPDn4FwQFMkGzNIjxKE8A4LiwvT097NZjiWcBX1SwTcWM4AwUsi
         kc+6VCxdv0kH/rHCNCqIFThTmXACfUXMpYQ2QbHmpclDIY81UsrgTeFd3rW3LM3TqlFz
         Y+ZtnF2KxEfYaekGxOorbgACWBRjIv4WmHC0P/2V8HTGTCZBD1yhtU8cInpWwBEPbUq4
         TwL9MWCUuMGkdU48mtpRYgotkqyKgXIeJy/zuewA9DRtBAB5g0aofA+QQVGEreQE4YuQ
         I3/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1777394023; x=1777998823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gSK+MQBt6cRt/VUGlsHOAZTSUYJSLwJzWsGWmh9wYuc=;
        b=sk6tuDlfF8KOXuzNKNb9LJQxh/f4MVjI6xyi++2ihptG0v54V2jQmdwrskZTDX696e
         RZQOR9R+pJWn7NDOFq0hP+z45+WIJ9HdSZ6UPriNepOVPWnxNG7OXfWaGRc+tbFzTRo7
         BV1G9kZ6Kb+4K134twYWMyUiCWfrNzb7a/fNwfwk3CUeYbzJhlcjAkJJoUOyaJ81X033
         0aKyOoU7KZpi25+/BejhHm1qhk0hTxAHkoXvgLXuiMz5M1lKnxo3oJhOzRwTK4ykyLZU
         xAxW5U6bvmv36KAKOOEVwv9NZVY0+GM3/OIPP66z8JDoY7eqf48E+L/rksT6TYCZsNwu
         Ee9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394023; x=1777998823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSK+MQBt6cRt/VUGlsHOAZTSUYJSLwJzWsGWmh9wYuc=;
        b=oFCdFbBQjGf7dwUfC4Mwr0AhGTLad1c8U0Yv5YZhAJ4K8OgmLqfhhK9SER48sLzMzY
         Wpt42RudtKC0+TYEw7nvrs/hr5CveEOCFtobuWTCrxEGMEXiGuUpZm3Zk92mbi4NuEce
         pSmpxZ3u71ozq90sIxwGI/4jrO2ecSAUWt948klVijfwXNUlQx9s4kitvnBLyf+E45Hi
         n5h/InODFSie5Ynx5pmT+bA/ZSZPvjo1oImFFkTj03XhvQIA8vk/SyzPQ466eHdXlCDE
         B72pxs6C7kzDjI3MrtqXti1lM9QushOuVMYhb1sJZkAsb8khXU3Ztf2GctNTdknQFx4l
         pFQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SUcYTKcP5jw5qSBLh5OxerwO+WmhAgrmrLUIPUQ1mjlrfKtyfFLCL/Dt7yLaLqBx3CTqnZaAnpe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzVBm869VoJspjjLnzQyIqFnN6dU51W+LUHiWualDcFilHClb
	23pcCRPCUqtXxP19xLYOlwTiGeKxfFsI3nlmIvrguwFcpCI5FHh6PEWw07D99eDDF4lTkGKF3w5
	upDezmZMjEQGUJk+D67/4LCHsPwFbHw1Y4ZOeeW+3
X-Gm-Gg: AeBDies/pA4IWlAyUQU1rjPa64coocXIZOCnIfS9my7kfDxNeVp+b5/l5BJFTWDfNGL
	kmaslpVREfcMXw4rsbFhH1/ZoovUT+5SuPvSRuBouCUZ8tKlWaJg65zsmNWWcIU6usmSHmY8puW
	Ac1UwBKJPrwewO8bE6rtIW/0OpJ/IFh0vocRRQrtAXM5uVcGdcCwqsiT2VzM4zuZX62uFrn8yKG
	m4EvKDF0mxLGKHVuWNaJYL8fUvvM/8lh3OSBNaO0sK4U7mvD9Id5eU93Zm1jeSVotLaqBwCxfZ8
	jOjT1wxHMTmgZMBDlwkeNluQfD3AVkFeer0rL/CDTZJph2UeuQs8
X-Received: by 2002:a05:6214:2aaf:b0:8ae:7124:cd86 with SMTP id
 6a1803df08f44-8b3e320ad90mr54751096d6.0.1777394023037; Tue, 28 Apr 2026
 09:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427215800.28082-1-salah.triki@gmail.com> <afBpBNLucHg25So0@ashevche-desk.local>
 <afByF-0BV1szTbzE@pc> <20260428170412.41791bdb@jic23-huawei>
In-Reply-To: <20260428170412.41791bdb@jic23-huawei>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 28 Apr 2026 18:33:05 +0200
X-Gm-Features: AVHnY4ID7nrHV8VXK3YzFQyoSWAWuch4e1q6-KH1wp3ximNedtiRLT5zlJQ1PPg
Message-ID: <CAKv63ute7h3vdZMjK5FbQLGH66O=VBk-+04e2p0FNWZBL-Co=g@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value checks
To: Jonathan Cameron <jic23@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:04, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 28 Apr 2026 09:38:47 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
>
> > On Tue, Apr 28, 2026 at 11:00:04AM +0300, Andy Shevchenko wrote:
> > > On Mon, Apr 27, 2026 at 10:58:00PM +0100, Salah Triki wrote:
> > > > The functions gpiod_direction_output() and gpiod_direction_input() can
> > > > fail, but their return values were previously ignored.
> > > >
> > > > If an error occurs during the GPIO configuration, the function should
> > > > abort the wake-up sequence and return the error code. More importantly,
> > > > failing to check these values could lead to the I2C bus remaining
> > > > locked if an error occurs after i2c_lock_bus() is called.
> > > >
> > > > Add return value checks and ensure the I2C bus is properly unlocked
> > > > via a goto label in case of failure.
> > >
> > > ...
> > >
> > > > - gpiod_direction_output(data->wakeup_gpio, 0);
> > > > +
> > > > + ret = gpiod_direction_output(data->wakeup_gpio, 0);
> > > > + if (ret)
> > > > +         goto out_unlock;
> > > > +
> > > >   msleep(chip_info->wakeup_delay_ms);
> > > > - gpiod_direction_input(data->wakeup_gpio);
> > > > +
> > > > + ret = gpiod_direction_input(data->wakeup_gpio);
> > > > + if (ret)
> > > > +         goto out_unlock;
> > >
> > > While technically it sounds correct, the potential problem here is that you may
> > > fail this in case CONFIG_GPIOLIB=n. Is this GPIO optional?
> > > What may happen if GPIO is not optional, but for some reason setting it fails?
> > >
> > > TL;DR:
> > > I am not sure about this patch. At least I'm not comfortable to take it without
> > > testing on real HW.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> >
> > Thank you for your feedback. Since I don't have the physical hardware to
> > perform the necessary tests and ensure there are no regressions, I agree
> > that it is safer to drop this patch. I don't want to risk breaking the
> > driver for a minor cleanup.
> >
> Maybe Crt has the hardware to test. For now I'll assume this is not
> going anywhere wrt to tracking in patchwork.
>
I will dig the hardware to test as it was off my desk for some time
now. It seems like backwards compatible, but I am wondering why would
we want to be informed of this failing? The problem is that sensor
uses wakeup line (same as for i2c) to receive wakeup pulse, so in
theory this is already a workaround. @Salah did you see any issues in
the wild?

> > Best regards,
> > --
> > Salah Triki
>
