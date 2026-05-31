Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48B348C65
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224524; cv=pass; b=RYMBHYx+u32gI39WPL5JHs+vUNDbxXhld8ICgd7poaeRvcWd2NW0L/DYa45LQGMRITuE+9DXxJm9wRx/W8rAe0qpK49fbiEFo+z5wuBCksFlglVU5qColEef78sm1chOHtse2TmzdRipoWVt2yGZ5uRMd+I9SEcx/zAO/UlEJcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224524; c=relaxed/simple;
	bh=080ZLtbxkb/6KxdXJXEEqRAXXjDuug6lWGxwBc3QAbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePuZM/d4QSde7bJHwx9MHpMgAaxpgg6ZP5m3rrMdlWzlTQwzuX9CNcD0huD0le3cBdsA3mgFsSajGiT9UiCnlx8c5TbwMIHAj3cNj8KTuSIupV1ho0Hc/T0x7bxllg3I+FCSWbyLZk3uT9oku7HFkmrol1CehY4pSZIwha23B/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqq7RIr5; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqq7RIr5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eea3448f2so1756851f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 03:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780224522; cv=none;
        d=google.com; s=arc-20240605;
        b=ebamzJZ9mTwU1V7WzW2sELxjVLp981C1b/6Vn83NVPTV/TDnCGRkiF1MHEOUu0DAI2
         4VWH05Lz3ODmTnfPl1TSvaUhJDMqbTj6JGFmK8MXy3nfDH5LAM9w+4eRGPa4m27nvROJ
         PYpU+4OWCAJn4ODBJj24+F1DHp4L/uSlcCVbe+LOsFwOXuJrqXF28EOajunxvU0SuY0h
         r+NjKfJH/tr8vIVZYtzVxzB7p2nbtCOD5CVH1F25s1TpLFsLZWy/YGgNQItJZJTSLeCV
         PTjdfWfJVM2UbqnSOhGgS30po+7zxj5GXKm5RIBjDJJtmxPCIAb8AeJ+KmKnSI/lx2C0
         YUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EeBfqAYEvuPA0edsleUHqYap2vw0ye+zziBVQyVCO0s=;
        fh=CDQ+SoC9O/0TfeCDVKO+Y91BkdCC6N8A7NvjUWqAVak=;
        b=iDhGiW2bIqtRP/cQiWX4Xn7IQqBCo91YXduhxlQm/gW8IrGyKvEQSdf6rGuHoXP5Tp
         w2zCyUn5lpkUVMSxF0Hw68DVpyT96crW7tfzTZn7dgaMA3UQzDbxhC9FyP80nd8KnfNz
         Qz6CvHYgmDuj2asLs+gzn+hIvL6mn9NUfAIVKAjZ0kvbWR4dIzLOoO9cQEODE7IU/maB
         amFQN6XcCW8dKjPm1Ix/IaNt+Lqf05z+Rr+p9SZX4CNg5uZ80ldCf84+4TPlX/TQHbBw
         fHZm23UHRCc+PsNLfxh/KbMunGs6bcCgJxyOhW6Vv2bcmX+T+ug8Yrz7fPZG37/yii5z
         Lfow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780224522; x=1780829322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeBfqAYEvuPA0edsleUHqYap2vw0ye+zziBVQyVCO0s=;
        b=Hqq7RIr5FpfAkwUeWVV2n/Qw+/uTRe9rSAtRgyJYjlR106RZvP4E/mBLr9HBq7Vhms
         jnm76ji30CejskZ+MPEAI/w55qwncOwBsppcNYrVm45Xa6ujMWjZsTyXM975s3U39t47
         gJiBhTkk97KEVtcSQpVjqbRjocAYiQhLMGKZ6nAtp2n1OSuujwdPVVX0fTfNtRZR+R5W
         xDswb2y7jE2xbmVoEy/08szDFAOR8uvZ8l24Kt32EmiSsuxb6XiaeauBtmxxtHAgaU5B
         BsVZtlfOMI3NZF136B31m25zOL60ZFAJ6qVQZPip2icJ1k+eeXhtNyQaGV+LqHGr234P
         1TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780224522; x=1780829322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeBfqAYEvuPA0edsleUHqYap2vw0ye+zziBVQyVCO0s=;
        b=ekfFc87onQL2V/h9kUuHTMQPinXU/ryfyq1oq56a1M1FgI76VjvewElnR2GDIyCeGy
         yzFx1ms12ctpIXuGMIWtlDSgFkpxwZyh1PwioKynymSA8WTwJOvGrcE+50ia6CspsUDJ
         jj4BnwOGfGCAY2y3MYjTSa2T8Fy7JFm25cyVYF4AVnuG7QvHJtFiSnhEuibLWNmLdQoq
         iRfcBovkrh50AmylAc6Uaabh3cheWyuYMPy1szweCvxxWtdrd2iH6NqU6IEC1iTuJRvt
         ehzZCOSxI3pHjp227LHDXHK0OAGquR9STX+FrvEA601bf0h584iJvY5JJQZjLRSnCF0X
         tJDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QHJmQu7jJrOK8Nj+4hTNtSClEAHGK+WIyT5twGy0XZ4zO4s0JrmeUPaQKgmiLfenQ1db60hdwadI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxct59+3IdWgaxP7TRkaAqFvufLld5ex2MMqLNWoiYgR+BFGpkI
	1g/eTp2JXYexuCTmbNuFjcB9ehri6ZP4SF43xiM0hFRPbqCkOTuDgmFKDjTD+s21by/u/qLMLc0
	RsdcEoQ7vOIg22BP5R1GPd5rMUn0yV5M=
X-Gm-Gg: Acq92OHb7xtEg9nRidcD9azf2AM1soWHjwx8t6QciZh6+seeHfw9ki9z4OaQhXd4lBn
	WAtgH9a1+fnF1rQj2ZTBvbJ45IJ2HJ/9oHNRhVqol2Cp13nS5tUIsUUQs1oxSz7T7OesPb6Nj9v
	y9nprtjWsFFwbMCHdFiGFYXiqMTaxJbrh951Gz/BwSbjvBusSRRXJUQUbERD33zO8vETky7ScdS
	OlNM+BZ5JruIJHin5IaIestswtKMAJI0FsjJOe9BDSkIPv6TILlqlwLghJMOhPNlzV1NMstDwhb
	SMKjBHBcIfkiD4v2jT+pSur7nF3AezxrIyfDjAGHC/Xn1hwzM5gXz0FGlUAHIDPC0YYC/djrzb2
	hI8u8QrBtov4JFqykiQOFodzqFezVEW2NTvnRiqHbfiOVDqDUv4y9koQiyPDI3mjlwbWoMBC4u9
	4G1sdSbIIqxKkk5i2nsBToPIkjVUhM6jZEaCksbmNy9z8TiO4rCg==
X-Received: by 2002:adf:f14e:0:b0:45e:e44b:3136 with SMTP id
 ffacd0b85a97d-45ef6b4edffmr9361355f8f.19.1780224521696; Sun, 31 May 2026
 03:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
 <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com> <20260531101940.037d1d7a@jic23-huawei>
In-Reply-To: <20260531101940.037d1d7a@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 31 May 2026 12:48:29 +0200
X-Gm-Features: AVHnY4JbFdUG64a6zbzX1CpKaQDF0eO1aAPLasW8LWr4MB3wrNFNwt60d-CHFpA
Message-ID: <CALoEA-xLB4Yak82iTdgPgK9riKgLhpN=b3h6CchxUj=B=KRSLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 May 2026 at 11:19, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 30 May 2026 19:06:47 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> > Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> > via I2C (SMBus compatible).
> >
> > Also add a new entry for said driver into Kconfig and Makefile.
> >
> > Assisted-by: Gemini:3.1-Pro
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Hi Joshua,
>
> I didn't find anything extras so this is just some more explanation for
> the Sashiko comments.
>
> Give we are approaching the end of the cycle, feel free to do a new version
> quicker than normal if you are sure on what needs changing.

Considering these are relatively simple fixes, I'll probably send a v4 today
(and hope that it will be the final iteration).

> > +     case IIO_CHAN_INFO_SCALE:
>
> Under the hood, like all the cleanup.h magic, this instantiates a local
> variable - the cleanup scope is tided to that and scope for switch statements
> is a funny thing - it's not per case, but rather the whole switch.
> Hence need to add {} to define the scope for this case block.
>
> Otherwise you enter this switch via another path and the local variable
> is unassigned, but the __free() that cleans it up is set. Hence you get
> a use of undefined variable.

Okay, thanks for the clarification.

> > +     case IIO_CHAN_INFO_SCALE:
> > +             ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
>
> Hmm. The comment made by sashiko on this is also possibly correct.
> The write to INT_TIME can race with the write to INFO_SCALE.  Whilst that's
> not a normal use model (one thread would typically set up all the parameters)
> you could end up with picking a scale based on an int time that isn't the current
> one. I'd just throw a guard(mutex)(&data->lock) above this whole switch so we don't have
> to think about it. (and a mutex in data, plus initialization etc).

Heh, my first iteration used guard, so we've come full circle :)

> > +
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_set_autosuspend_delay(dev, 2000);
> > +     pm_runtime_use_autosuspend(dev);
>
> As per other thread check this results in power down.
> If it doesn't, try moving autosupend calls after devm_pm_runtime_enable()
> and see if that is enough.  Otherwise, you can either manipulate the counters
> or I think just call pm_runtime_idle() to force it off immediately.

Sure, that seems reasonable. Testing pm_runtime stuff on a Pi 4 is a bit more
painful though, as the LTS kernel doesn't support the PM_RUNTIME_ACQUIRE
macros - they were introduced in kernel version 6.19 (which I found out the hard
way!)

Thanks

-- 
Kind regards

CJD
