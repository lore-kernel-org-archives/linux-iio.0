Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EF1990C7
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437654; cv=pass; b=HzwHQxgTo+HGVYRkeIzWM0ZmOF4BAh2AvwOe35l2aPHJ6XSUpaEEMZb2FXdfEoVsX3FSDteILFDy8O6o0uKQTuattsO9flOT76IccWgPjwRESodVfLS8VJ+X+kuPYZv9LU0wOWR/xirfqNvWrTBU0Jo8QvL27aS4c3r2uGhoceQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437654; c=relaxed/simple;
	bh=JUAn2KimmN/o/eHfXlDSULICtgG62oPP2Hyu94+omBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtxZ0jrE1C+oS1oFfajzp0+rmNAVt0zHceTssTEF+vviYwUgHrbEEcw87FRzN+zF/1faAt5jdoiaKwXeKDROr5icLT6yBjBv+YL9mrm5/nLaOY9zj8ylc0zE/QWuaeAbdrWHrJmgXDEetqfIYwLihwKWw5kZA97D0soNjEG53w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4da9KfI; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4da9KfI"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2284607a91.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 15:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787437652; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7Uxv1PeugSGkBVe06n3tYZglEDxPRXfEciAkfxmu3qsRRqrUINe6xAsC6wuVyi5QY
         4hIjZKDYnIsKd5zjfly4S3XyBBliP1HdvvxHGIhJ2wG/lrRWQ2I3zJDezsGrDeiqhAy7
         mtqI8TWSw1WNrLKj35uAhAo04FeeHLbuE2shw4alxTxLn99BUGbWEc3ZBnnoFfM/lmCx
         P+nVmokVbcjykb2iMgmOM7tq79FVek4+RK0s1dg8ARifO8+RwIQhu/1ZCx1wAXeCe6IV
         3x5N/9+GEGfmZOPu83E7JuTk4DCRkLevACvGFBIjgHVR+WrjKlfhIHMNW53GvnvsfIrP
         qj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h2KBP7bJOZESyKVN512DplqH6zyDbmVZ0g4qOVUEItw=;
        fh=3VRvI8Ld/SoOIJcgFzX1OX6Sv1sFtpcnCjvk6F3vDVM=;
        b=ImfneFVrfkl73gNkoypK6A+dr3KFsjwTfC1/qA0ZCNCrpIIkOZdnAdy3r3zPCzaNBo
         FGFLWlLXkVcfBDRD/kJvhz0cIQ+kv/THxg51Zvc/k6dVeiOUcEvy0cdqD1MqRxyMhZp2
         M9QUu1BhdVY+HsmkcXmmNlV5EADAw7oYpzr7nTRTOOk6wsacXxCnlZBRCbVJ3Iib0NOA
         gbfSiTwplfxfcivWvTwoR2LI8FlicL6R/4Vdsh3qaKdCuEuQj8X3FppoIxeWyI2aqFnV
         rlBc2BCVqRyquDbV9NiSGOUDvLbJXrk5Np3nEXc1SadFNHP2R3cFr/NzpZ6p8s3XK1Lm
         GHwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787437652; x=1788042452; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2KBP7bJOZESyKVN512DplqH6zyDbmVZ0g4qOVUEItw=;
        b=b4da9KfIMwuE9NvIqB/reFO4t9BqpF9A96QKR4vWsLT0nZxnrB77k7DDf7lj0eUgSJ
         x/gtGzH3ZBvKo9Uu9ZFeGzEdqiBpPWvT5IA6TzsYkdS7x0hPM4Fp4wfjHztY8l7xmlbU
         wadtbyCC6M0C2FY/dXw8LFmUYdU5HzApXUovrdjdd2zLQYdfz0t/5j2POAF8ExwqnsRp
         YlUUnAe4GG4YYk8rjDi/8SnFnPz4fajbQMKhE5+WHJTjGA75NGmAT0ond2sO8ugqryLS
         dVISoOsk+B0VpLuMPysJWTSsdjx54uTfeXJsxbrKKaWZaJuX7+5eSTzaKRgvToLl18cy
         HXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787437652; x=1788042452;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h2KBP7bJOZESyKVN512DplqH6zyDbmVZ0g4qOVUEItw=;
        b=rnN9lClLulMp6buiDHhSnVqrNb0ll8YYeimbYpA4d5teNTu+48f7d6zoDNHVYZemYB
         x5EooM9QhwpU28QlcmgOcCtAHnTWGfm8RaUCI1mrWz1FF4xTTKKV/3vn0z7xEodfU1sc
         o7N6YnNzozJHWeaumSEGPR0vtquijZRw1ZLSBVh4oblWp2PgPrCK3gfVUpSqUqjT40is
         lL5YcrGXkmhQBi178VxJykH0ASRwNzDbII796Yzfr7RoSFejm9DroBSUU6aPgwC8MjfA
         L208c2tfNjp8BWp0XXAzLCodkQKcGxqBiDEHwuQVPF5rk9fJoKz/ZwcfoEg38ccjCoah
         Jdog==
X-Forwarded-Encrypted: i=1; AHgh+Rq8NfYS4OKyBL+c4Ao3gGImyNPUMcGDiThs+6jyKfbNRGnFM1hKTL0E8NW11iVOzt4dPp/bpFkqTlk=@vger.kernel.org
X-Gm-Message-State: AFuF++lulLgpIEvvbJD9D6LFW2rTusFzb7obvenp5m4mIfet9vhb5I9Q
	BIQtpPl8ckY2omio/iuaxqE5Th8ueHPyjqOzdThVXWXqcVzw6B9AVFDIgjO1MuVX8ISI2G9gywp
	YkYwxzTPiuOmzMK94z5NLVyVILbVlSY0=
X-Gm-Gg: AR+sD11ytgv3Vg3UjnWj2gB4roZ1/Bj/tEOtxjZpY2uy1Qp8doEkk4Jt+L7UkR2Zh2P
	FLp6t+TepSDyFB7irpUSLB6kZKn6sUI3tVmBALy2GyaDIVu+CEGuwFwpSFictGFkLW7x0VjGLXY
	KlgahOr5jtGsyb/ph28/veYkQRYiZ/BC4oDhTISZszYjiFGjCXDpbAwqEAGDjnTKECQVn0u057O
	pf6/FXrGV/KYVX+CSqVT0yN/9XpIafC8cICUodg8ArmKaETBXgddJyYmHe5Lgeci/+pC0S8M1be
	DbjqOhK6LH/CKmyuck3DI37Luj6MtIv6NQDyPp46bpNTFuCJfvYgTl92TWhS98pHiNhx/KRCPXF
	WoVuVXZ+iQefyc59tgaN1QcIJtGVjs81O+EKziVCW6ZY6uGfUV697qXhjKAUlL21K3gbNL0i5AH
	atD8ChwJg5p9VrhT0=
X-Received: by 2002:a17:90b:3b4d:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-395c39b1750mr25888560a91.10.1787437652530; Sat, 22 Aug 2026
 15:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813074810.27574-1-phucduc.bui@gmail.com> <20260822023959.4319f0c3@jic23-huawei>
In-Reply-To: <20260822023959.4319f0c3@jic23-huawei>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sun, 23 Aug 2026 05:27:21 +0700
X-Gm-Features: AcwNN1XUh84KX3jaBPa7kHJp99hE9mYWPs2QfVJIdkLloGc_YiaGMghuVA1RL-I
Message-ID: <CAABR9nFdnFH-gspxEZffAb13_vvrs+x4Ksznq5JFO1gMEmw4_Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: sophgo-saradc: Handle errors from optional IRQ lookup
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>, u.kleine-koenig@baylibre.com, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-iio@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you for your feedback.

> >
> > platform_get_irq_optional() returns a positive IRQ number on success or
> > a negative error code on failure. For an optional IRQ, -ENXIO indicates
> > that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
> > and -EINVAL, should be propagated so that the caller can handle them
> > appropriately.
>
> That function is very much undocumented other than not printing a
> message when it returns an error.  However I think you analysis is
> correct.
>

Yes, I agree. The documentation for this function may not be clear enough,
which could have led to error handling being implemented incorrectly
in some places.

There is also an inconsistency in this driver: if devm_request_irq() fails,
the error is returned and the probe fails. But if platform_get_irq_optional()
fails, the error is ignored.
I'm not sure whether the author misunderstood and assumed that any
negative return value simply means that there is no IRQ.

> I'm not going to rush this is because it is not known to have
> been a problem in the wild (only odd loading orders should have
> caused deferal).
>

I understand your point. However, in this case the error can be
completely hidden:
There is no error message or log, the error is not returned, and the
driver falls back
to polling:
-----------------------------------
if (saradc->irq < 0) {
        u32 reg;

        return readl_poll_timeout(saradc->regs + CV1800B_ADC_STATUS_REG,
                                                 reg, !(reg & CV1800B_ADC_BUSY),
                                                 500, CV1800B_READ_TIMEOUT_US);
}
------------------------------------

So there may never be an obvious failure for a user to report.

Best regards,
Phuc
