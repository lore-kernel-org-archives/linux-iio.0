Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193E3D0BED
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004593; cv=pass; b=Z1WyW5CGyOw00Tijl2xIJLXX1bt8HrlGeJl+XZC4si9wSznYZ8LAErwopKsDvPtdP6TPRz76Gi6X/VTXyWqaSYsyS0RQhHBN1jkOVsDX0vUXnRcVnQ29w2fPec5ojI6V7GkHdTGcRUuTXxoXJUJwLlIQclaVISV2HQWmtHyq0qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004593; c=relaxed/simple;
	bh=LsU8FXn8Sh1ONFMFFVsc1tCmKSU/+iheTQ+b1gpFBpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbdRkl8FCjJ9i74Qr+CDzlFCLE+bFD5kPeI64Trv+mzVCa1EEYKHlQVFw6l1W2XXMAqUK/vByJOEy0w6VtPBFVFDq+R1WqET2cnR6fUEfbIvqhqEWBaZty7biYH+Q+DkL9hrvgyxHReHSo6ojh6PL5kg2S+IhzA1id/miZbBijQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoAMG7sy; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoAMG7sy"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so24207006d6.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 15:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787004590; cv=none;
        d=google.com; s=arc-20260327;
        b=FUTEe84E/UWCK+ywGVXNESCxafrm7/fC69zxHiVBMpr+aElEUg+BTvrdfdUp1u6qSr
         1MDKQ2+wObGAh7glCWnQj+HB6fogA8uf8+3osdfJOfs8F2c6kMHl0MBvanzpT9lHgL96
         CCxNkYsBrV7WciKTmB6FN2avYmc9/1IBJfI+ZpBDqx8J2b3HkDm7p3fEWhigQy2/7dWj
         6GCoDraG9Wgh7VJ2pkjBuCybVCxvI5w2oGVQqBCUYSEzWhVQcgS6pynqjdnbqFqyisrh
         umXKiA2XQgZ0ypEijh6T37LhzPCC0RD5NdSWfB8cy9RT/FgQAh8W5B/noSwlbG8mCGao
         asnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqJ/AaCaQofv+XhWcx6RjOb2KUh+9qiVQjO9GYdH4tA=;
        fh=1s99EcY64a9OcDr0h3h6TEwQqSKjjNYOrfwfNLE5rCo=;
        b=WNPsbqYeNpsowO8oBrNnDQiYfW3wXFICI7ceMvIjb1iJvmFHFrWMk/JVubuemnGsYB
         SCa0FH1rA6GK209KhoAOmupGN8GcP65eKw57QAr5LshjRKiK5xT0GDBqLYvtqSYbHKAv
         zp8CAf1PioBuT3sBrhKgDIg0t1UPNOSrvlf1/32N8Fy3q8W7UZfppFXhpy3QIVYeGSWu
         grmbpnwZEDpORnofy9nMw8LDFHSr7SluxXoarFtKnEL+K3LyYPoGRLcbPuo76TJEB0Tk
         sfAC8zV4Q4G3Q4NDbrSODlYCcQxE8TXtSZak9tUOH6txtXmttfvGDMS76DR9QPo04Nmg
         CHAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787004590; x=1787609390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqJ/AaCaQofv+XhWcx6RjOb2KUh+9qiVQjO9GYdH4tA=;
        b=SoAMG7syyEI+V1pm4DgAgiceqed3DAkxR8fKpURPlIR26Ih77/R07hLP4CEqMKLw+i
         r8/dhq3BFreiknSwr0bUi/WGZhqjF0vtIsXKei9zRHtjZsc3nOqL/cA3GGJyX2r8/o7j
         idSfh360qU8fh5jFkw+z49umXK2opillZlxMSyKLwHAXoAWkgyaMa9ZBNR77ryZp7hqn
         92uDNN2ghDeKVLCpC7We6ORtVLpvqvciL+kpjfYI1JuygnEipNM1lDRmZCw+vivobvrG
         x7kejMfge/kQcWtALwaPm9+8bXtlY1VSBXdhoOc3fpaTbaJC7odVJoZyq+y1Ws7gt56M
         ji1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004590; x=1787609390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqJ/AaCaQofv+XhWcx6RjOb2KUh+9qiVQjO9GYdH4tA=;
        b=lL8f6UPEAdUYJXAGj0+hzJLBVqJeZ+E9k6MDTztUWS+l+JgxLv1jL74iTFX/dQfqG6
         NYSyFKJ5MvAhKuiaPxOkY2i84GQFtE3MnyX36oebp2FF8nc5wEf8nJE4dIL5kLZFghMZ
         ONTloL/aj7hAL2Mmg1zDWoDhuJ5Nx5q6aLcJsAgjKUI8LMl2f5qUQ17LenU8MgKfBnEj
         ITsyFpilwLDz+ywA9vsyAlrevL1FYI0yFn8ioAmY12lkFnLK6d0vvROUR5KZPqXeVGOr
         Cucey+gGWyM+jq4B7bKD7WCcVk59eSCdelnO3I0/LsyV0jEeobD7F8sQpZBbWJs7mGum
         ludA==
X-Forwarded-Encrypted: i=1; AHgh+RpLmML2lR7Wo1Uxi9WqC74UTUs1gwh5qWQGZlJCOGt/u4XGybMLca7udR96w4sPhRVZ/wgS6T9rLUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJmNfv4pzefkLDIzxnSA2J4EeHr1m535VhO/FA25DJL5PJgR0
	ASGTKWeQKl6E/erW8LDbmf8bl67VA9SQV5kHiJ4iLxHmNOFc29AluZ68KU3HUwGUXgxBjTffHot
	e6t8cYX8lztEm7fTqqeYyAQW0vMGnL7IcOc4rDEM=
X-Gm-Gg: AR+sD11865AvaiADhkPuow7FQ8eRvGIBDrKUh5jAnyPE8FQqIAUw+rM8VdWJe3kzpCc
	fmp+AhyHR8J5gdDVZ5dVW5D5cZWpu74zmWEUF8cAV+4hRyDPxNe6L/to1LuZprswgPUu5goeKbp
	JYUZnWHwZ1eYCxBg/pzbCWdGcMS2sMUlgtEL7AppYfx00fa3teK2r5nStnKWIL0LbAPbUri3GXM
	1FadHQvtGvLMfWKnJ5yvi9X10TqYxXv84jG+WmQQ9DBgGkmgu6GVIJ+k3M+pWD3mObNj7esET9c
	Xxc8GEHBOo4Q99Z/Jj/AUl/rfGXExqL8NfD17+nWeGivDvVV1jBUPxw5FWSizFeFcoeGc0RqtTW
	g2A==
X-Received: by 2002:ad4:5c82:0:b0:908:6080:5da1 with SMTP id
 6a1803df08f44-90c4b31366cmr45630156d6.14.1787004590451; Mon, 17 Aug 2026
 15:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817170725.1074078-1-zoone.rupert@gmail.com> <aoNXMdpsUPvaGwFR@ashevche-desk.local>
In-Reply-To: <aoNXMdpsUPvaGwFR@ashevche-desk.local>
From: Rupert Zoone <zoone.rupert@gmail.com>
Date: Tue, 18 Aug 2026 01:09:39 +0300
X-Gm-Features: AcwNN1WgZngMC1tWtntsQ-MI0q5LZHHC5VwQdUiucbwPnE0pV6d3OY2UatVuEJM
Message-ID: <CABpb+S6M6-NY40UhWMLo2Uz+mMN2st=M5Dijv7KP2AULoPS02A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iio: pressure: dps310: FIFO and triggered buffer support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 09:47 PM +0300, Andy Shevchenko wrote:
> Are the commit messages are written with AI? Please, do it yourself.

Yes, with AI help. I should have tagged it Assisted-by, and v6 will.

> They are way too overloaded with unneeded noise and details. Make them
> to be straight to the point.

Agreed. I have cut them down.

The testing is my own. I wired a DPS310 to a BeagleBone Black,
reproduced the -ERANGE at oversampling 16, 32 and 64 by swapping the
buggy and fixed defines on the same kernel, and exercised the FIFO and
trigger paths on that board.

I will wait for more review before sending v6.

Thanks,
Rupesh


On Mon, Aug 17, 2026 at 9:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Aug 17, 2026 at 08:07:22PM +0300, Rupesh Majhi wrote:
> > The dps310 has no buffer support today. This series adds it, with the
> > hardware FIFO used when no external trigger is attached and the FIFO
> > left disabled in favor of the trigger when one is, so the switch betwee=
n
> > the two modes can be reviewed together rather than in two submissions.
> >
> > Patch 1 fixes the CFG_REG bit definitions and replaces the standalone
> > fix I sent on 27 July, which Jonathan asked me to fold in here instead:
> >
> >   Link: https://lore.kernel.org/linux-iio/20260728223009.0cb86996@jic23=
-huawei/
> >
> > All three of those defines have been wrong since the driver was added,
> > but only P_SHIFT has a user and only that one misbehaves, so the patch
> > carries a Fixes tag for the original driver and one for the commit that
> > added the first user of P_SHIFT, along with Cc: stable. The FIFO enable
> > is needed by patch 3.
> >
> > The three INT_SEL interrupt enables at bits 6 to 4 are still not
> > defined. Nothing uses them, the driver has no interrupt path, and the
> > binding has no interrupts property, so adding unused defines to a fix
> > did not seem worth it. David also asked for the register defines to be
> > sorted low to high. That is a cleanup series of its own once this lands=
.
> >
> > Patch 2 adds the triggered buffer path.
> >
> > Patch 3 adds the hardware FIFO and the selection between it and an
> > attached trigger. Those started out as separate patches, but the branch
> > on iio_device_get_current_mode() is four lines and the FIFO patch is
> > wrong without it, since postenable would otherwise start the FIFO while
> > a trigger was driving the buffer. Splitting them would only have left a
> > broken commit in between, so they are one patch.
> >
> > Verified on an Infineon DPS310 breakout wired to a BeagleBone Black,
> > running this series on 7.2.0-rc2. Two modules built from the same tree,
> > differing only in the three CFG_REG defines corrected here, loaded
> > seconds apart. Three reads of in_pressure_input per oversampling ratio,
> > ambient 98.4 kPa and 27.2 degC:
> >
> >   OSR    before              after
> >     1    98.433  98.428      98.445  98.446
> >     8    98.460  98.460      98.477  98.479
> >    16    -ERANGE             98.566  98.564
> >    32    -ERANGE             98.428  98.427
> >    64    -ERANGE             98.464  98.463
> >   128    98.439  98.440      98.434  98.434
> >
> > Pressure oversampling 16, 32 and 64 return -ERANGE before the fix.
> > P_SHIFT is never enabled, so the result register no longer matches the
> > scale factor the compensation divides by, and
> > dps310_calculate_pressure() ends up negative. 128 is not affected in
> > practice. Temperature is unaffected throughout, since TMP_SHIFT_EN was
> > already defined correctly.
> >
> > Everything else was checked with checkpatch --strict and a W=3D1 build,
> > plus an arm build for aspeed_g5 and a boot under qemu-system-arm -M
> > rainier-bmc, which covers probe, the sysfs values, raw times scale
> > matching processed, EBUSY on sysfs reads while the buffer is enabled,
> > and all three scan mask combinations. QEMU's dps310 model implements
> > neither the FIFO nor the interrupt, so patch 3 was tested on the
> > BeagleBone Black above only.
> >
> > On hardware, patch 3 was checked with both channels enabled, temperatur=
e
> > only and pressure only, at 8 Hz and at 128 Hz. A blocking read returns
> > in every case, which is the part that needs the timer: with no
> > interrupt, hwfifo_flush_to_buffer alone would leave a reader asleep on
> > rb->pollq. At 128 Hz, 100 scans arrive in 0.81 s, so the batching is
> > real. Timestamps are monotonic throughout and land on the configured
> > period, 125.0000 ms at 8 Hz, except where a drain collected more than
> > the rate accounts for and the batch is compressed to stay ordered. With
> > a sysfs trigger attached the FIFO stays disabled and the trigger drives
> > the buffer, at the rate trigger_now is written.
>
> Are the commit messages are written with AI? Please, do it yourself.
> They are way too overloaded with unneeded noise and details. Make them
> to be straight to the point.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
