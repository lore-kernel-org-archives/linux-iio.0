Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2003E1D02
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966310; cv=none; b=lLfAH6o8XSC3zhFtAjpFlq/TLb+5dKdYXpzUH8bYfYt7uaaHBBeGdowwXB9pWaAWKpu7N9jJ25U9GaOpsU14/dQ5SLL852iBBIUGTYaYqhCRU+wfBkQiUvY2v9mJJ48mf+wVGZApj6UrU9JKkfNFrRatt+wt/eXTmsQtaF22NvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966310; c=relaxed/simple;
	bh=TraXVe+N/S65fWQbItJa+1pkQNne+jqlvIwTlL7GSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY7aXPtCir0RstwWDuT++7epWaHnz8jab8LOPGS8fHMiAPnOcl4i/X3loM0Z3BNcOB1yfJWmRM+mqoHgSiIhn1vKdqwODjkTyvX4lGN+groMi2omwoKWJGuqUs+OXkVlmD8Jx0BhGwiTm9KmPkW/ymAM2iXnPOYpHfgq60GBQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp9tqr8W; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp9tqr8W"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso6998567a12.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777966307; x=1778571107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMh3yQZ+wRAzQ9zOOPwqvnWFjCf8rVBZ0ULEtjFxlWM=;
        b=Lp9tqr8WsabAdd29mNB8AoIdYZgJTCbwzdhiKrnGWglykp3hwCahaYuz1IORGH/+dB
         5ZeXpkZCv+I5j/yYvsaCri+0JKj1NyioM8Yd6mejdPNXGKyjcVXtnH48DXkxJyodxu9X
         C8NKxMd9bi2h2hnS2/CJ4mEjJGf8ozu1ph2Fslbgg5niipnonRqsfYhAc1a1gKVu0Ol0
         +Y1iVf3wf2lwf7Uje4LErQRBVOJur9oK0PLvFojn6AHgA2i6k0Bt2Z0Pr4UGMWkJHn2/
         fmisJVbhHoghV49WYGnQwgiQzB1B/uXmeDSaVZ0E4nT7EtNi9p//UymieO9bLvFljGN0
         n8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777966307; x=1778571107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMh3yQZ+wRAzQ9zOOPwqvnWFjCf8rVBZ0ULEtjFxlWM=;
        b=gvDYvq3KX3ad48B/J6XlLETSkZiBz+SkQc5Ibz7xfQxC3XKdGqLZYpj8uFHJAaAxOQ
         MH8hUISz1yrpXSh/Rv+syR6i6G6Yts8sIDf+U+JcOv+RS+7IE8je27v+X7fib56r42DR
         Ub1PDi3k+8mQSviExckqj3zyolW9WXoJLVGTYtyHcw/CFUzGCXlkg8IRXw3GMh4UeeE3
         0jbrwExTSiggPtceN+EI0gIE8YAJN+JgSdqjRLLfHfc+rsVqlvLtEJcS9SLRYXW5zYuW
         Lv/+c9vAnx1l9dhis5jD4U81t8AhCWYLbv62CUwnfP94T3w+oWsRuCQPEX4TKX900DpB
         clUA==
X-Forwarded-Encrypted: i=1; AFNElJ/kTgqYliUR3sjTuN+BSDUtZoqL7abZzdV0HPgQazNDSOKlI0OEJS/T+h5zU6eqMTRZ3uGH+LJ8Two=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBMPDNLGxZnnlBjaXWOvRK7vnFkIoRVJiT+ibNB6jsb43Wh+3
	wH74GJvj0mbKHTH7Eub0GWkXFWT/YBaVkxGuF6CUAyqCgcBMblNgAVAg
X-Gm-Gg: AeBDievRkfqKDHuFdiTKJXSiCUC3Zkpd/HuMqiek2qnR7g9HL9+1A14aRjzr/65v0+4
	Sc5GjzlDuzqa96/UAAT218rhBi8HOqaHyTQrJgeaQdTFXyY7S/txD0eU35V7YpPRK58poeOQ0X7
	bzaugYAAmsm6Nv/5yV5QwXlMK8kbfRMgA5gfysMHOEjGzbR06/BCibjJmkeh5A4hWYfIdqU7XBy
	41z+QVCPZGFTK1Y2mfE2YSbjxDkNwgkLP3myp9kk9MFxv92JJM3WjFZUibtupVX0QhIairNaagf
	R2fwLJJbOI9zCCR7NLSF7rF16gp0LrS3oT9lwvie+BB/atqwU9Tw1dYSeYSjtXXbZRTifsmqRhL
	JoYMX3Z4MX3uE++KJX3exJpDWZl3BpPNne2knK0mv0ZwhUed6Q2Wl6uxBb9yuyjBQW8tr75tNKS
	bIwae1JPbwCnQ2Ygz5qyS77qs=
X-Received: by 2002:a17:906:c104:b0:bc2:d403:bcb4 with SMTP id a640c23a62f3a-bc2d403bd4amr350623566b.19.1777966306972;
        Tue, 05 May 2026 00:31:46 -0700 (PDT)
Received: from pc ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe69f6b7f6sm462628266b.3.2026.05.05.00.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:31:46 -0700 (PDT)
Date: Tue, 5 May 2026 08:31:43 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value
 checks
Message-ID: <afmc3xTW4H2oPMuQ@pc>
References: <20260427215800.28082-1-salah.triki@gmail.com>
 <afBpBNLucHg25So0@ashevche-desk.local>
 <afByF-0BV1szTbzE@pc>
 <20260428170412.41791bdb@jic23-huawei>
 <CAKv63ute7h3vdZMjK5FbQLGH66O=VBk-+04e2p0FNWZBL-Co=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv63ute7h3vdZMjK5FbQLGH66O=VBk-+04e2p0FNWZBL-Co=g@mail.gmail.com>

On Tue, Apr 28, 2026 at 06:33:05PM +0200, Crt Mori wrote:
> On Tue, 28 Apr 2026 at 18:04, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 28 Apr 2026 09:38:47 +0100
> > Salah Triki <salah.triki@gmail.com> wrote:
> >
> > > On Tue, Apr 28, 2026 at 11:00:04AM +0300, Andy Shevchenko wrote:
> > > > On Mon, Apr 27, 2026 at 10:58:00PM +0100, Salah Triki wrote:
> > > > > The functions gpiod_direction_output() and gpiod_direction_input() can
> > > > > fail, but their return values were previously ignored.
> > > > >
> > > > > If an error occurs during the GPIO configuration, the function should
> > > > > abort the wake-up sequence and return the error code. More importantly,
> > > > > failing to check these values could lead to the I2C bus remaining
> > > > > locked if an error occurs after i2c_lock_bus() is called.
> > > > >
> > > > > Add return value checks and ensure the I2C bus is properly unlocked
> > > > > via a goto label in case of failure.
> > > >
> > > > ...
> > > >
> > > > > - gpiod_direction_output(data->wakeup_gpio, 0);
> > > > > +
> > > > > + ret = gpiod_direction_output(data->wakeup_gpio, 0);
> > > > > + if (ret)
> > > > > +         goto out_unlock;
> > > > > +
> > > > >   msleep(chip_info->wakeup_delay_ms);
> > > > > - gpiod_direction_input(data->wakeup_gpio);
> > > > > +
> > > > > + ret = gpiod_direction_input(data->wakeup_gpio);
> > > > > + if (ret)
> > > > > +         goto out_unlock;
> > > >
> > > > While technically it sounds correct, the potential problem here is that you may
> > > > fail this in case CONFIG_GPIOLIB=n. Is this GPIO optional?
> > > > What may happen if GPIO is not optional, but for some reason setting it fails?
> > > >
> > > > TL;DR:
> > > > I am not sure about this patch. At least I'm not comfortable to take it without
> > > > testing on real HW.
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >
> > > >
> > >
> > > Thank you for your feedback. Since I don't have the physical hardware to
> > > perform the necessary tests and ensure there are no regressions, I agree
> > > that it is safer to drop this patch. I don't want to risk breaking the
> > > driver for a minor cleanup.
> > >
> > Maybe Crt has the hardware to test. For now I'll assume this is not
> > going anywhere wrt to tracking in patchwork.
> >
> I will dig the hardware to test as it was off my desk for some time
> now. It seems like backwards compatible, but I am wondering why would
> we want to be informed of this failing? The problem is that sensor
> uses wakeup line (same as for i2c) to receive wakeup pulse, so in
> theory this is already a workaround. @Salah did you see any issues in
> the wild?
> 

Thanks for digging out the hardware to test this!

To answer your question: I haven't observed this failing in the wild on
this specific sensor. The patch was initially motivated by a static
analysis and general robustness cleanup, ensuring that we don't ignore
errors from gpiod_* functions (especially in the context of keeping the
I2C bus locked).

However, as Andy pointed out, turning this into a fatal error might not
be desirable if the GPIO is optional or if the failure is transient on some
platforms. The goal was simply to improve visibility if the GPIO
configuration fails.

Best Regards,
--
Salah Triki
