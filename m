Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F103F4845
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921619; cv=pass; b=RcD5T8b4q4qEZvYostAil7Xfdv8AS+zLcpSRAx1ZSVcE/ySHWOBsC6Zg05EY1fzoGYhrmZy1axWn8oHB6Ms/C8VsmzZecMvwRJcWxho/leavokzebBqsIL8erANRvohqydiQV9OBpuV6NWfHABKbkVVGrCdQp69vyO3Iiomvtj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921619; c=relaxed/simple;
	bh=axlEM3fgX5sf6tpDr6oDm62vYzzd5lG+OjtCYy4uiGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0hc903QWTyGDVyjYk3nGQgioKvWySLJACq4sEicKX7jBmLpg3wNoHrQ3+qv9lFqr7JLAnMvxeLnh8h7lpXe3W11wylF4P3/vCx4QelA8/eh5e2hemZucQILezyp5xXK7BLtEtfERkCnCczfpbQwHQLYB3o6B2JLDZQfBxoeKfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Dw0dn2; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Dw0dn2"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15dd4b9132so131771066b.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 02:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785921614; cv=none;
        d=google.com; s=arc-20260327;
        b=ruSmsqLHuGQL2reLNd/vVeYAZIVylUZ7kaLHIA+Cb5Z4mZNyC4MhB2RUQd9Xvk1VgJ
         jBHS+P7GduTbqoZHn5Qa13KhAyrR5XTQokTeuEHlFavzeCzdLT4BYL3NhxGpYNgTfBad
         V79MfJYfPEedbJCy01GhoGKq5IUKvuQlMIXEZwrBvwlyiJcwWxWHuAFS2dqH+bIQm5MY
         gTiW/ZACOfKzznD+PHidIQkt0dKAsv5KNCkxUafx4MsilehyZ05dggfSRybd7Lcac14v
         19yMieyZxLOV15iEcech9nv7RNN4a/JCQu//MMefhef2xZZbWmBS+Iux1kfrz4LcPucV
         2uBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlwkeDo6yXakPtOLdepmMmrxJfsb1eamCAvds4wEgrE=;
        fh=eNcwtrjURPM0Sbl367Uy0zWUAsLVTOPmI6iwYWqjSvE=;
        b=X84ibySwAybBNNpHa/daK96T0lIYiIdxzGbnAsOu8laf7n/MV8mlIPgNDvJxxt00Fp
         OzmTzIjRpSYmbQlkuhwMGyQm4hUoHykdMAgcRjc51FXL0dSJVDk9ch6+/3SRaC0WlmSs
         JLyp81j3GFxAND1EmOfQM10X/YLUCu1i4E998efrOk69j8SfDrTzbTRsiRBlWzdULm3p
         N9GxYHN5FRaT55w0RtW06U8juzEz+KgZ1nU67asnZ4gnraTjntZsonaFQBkXKwQqj+oZ
         XYS4eoLKxFuwhDOioMTaUgx8YviaRGGKKBbdX0dCXIMBkz3Fo4UyqWKzUp+PUD8saFtA
         dIMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921614; x=1786526414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dlwkeDo6yXakPtOLdepmMmrxJfsb1eamCAvds4wEgrE=;
        b=a4Dw0dn2SXCv/uMK/WYFUf/BgcE4Jki1bsz7mAHMKhOX6a7jIV7GdfF2L4t2mQhoFQ
         3m0w8UV7qadraxoTPv256Hlkdn+qr1yAiiL5glZyQ2mlciFJHbhzDx3wXrIOgUnte2Ss
         QEYobHz0wSz59Cb3/UdC/RHdZjTcYltnccXAftVgIpfwmeg7cw6KTIlyRUoK0ITz3RLw
         vN6uwhPqZNXoQUDMUGskKuwtguynuJRlxF7F1vkyey3WpTpt7LodPUqRcdWFI3qMDka1
         7GzDMRZW+61HXCUoA3Ijb/W1OwXaGZCoSU+BpIvXIDTzwZP900na6xdorEoznEuVPYwa
         Z96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921614; x=1786526414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlwkeDo6yXakPtOLdepmMmrxJfsb1eamCAvds4wEgrE=;
        b=GyR6GnK9xkVCBFl4Irp08gg6vx/zkejVItbBHwIYD3kAo2/vWjBT6ElKfcDwBIDVn+
         +EiaEdB+mJeNd115E1PKBes34HRQp7bfLWpRl7GzbKFt0VaE4J1IIjWmNR900Vb98A61
         o9hs/cGiUexmSk6NeD7yG7hYl1v+aNoloqrXwpHcQaslAJMtP6R6ihzDWumpC+LJApuC
         Cg8uAVhmG88Xzpc3VQBxEqOxGvYsH2BB8nrXGIa+5eMtS7IiDU3LLsG5tchg+tufLU52
         6Bk02gYaPxElccip6Ptl/daNtNV1bFK8nJGZLdTJgOUDQtEQE/nSLGhOtt79H1H2CPpF
         fOOw==
X-Forwarded-Encrypted: i=1; AHgh+RqV1Jt3vyAUU9Ti26trDoJVd0bxxlQ+w5Vv4wKQg0M2BYSG865QuSN/lgzzlZhgAYQEQPshxtwinno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrA59jnsukhxBXq/0D8kM/4ahiiQvGYVQ6ibmdg9tPqeGaUiCs
	jmB512Ko0SS0+ty0XkPjU/Mz/9uy1SjipMngx4NCVsG8hkeK83AB06SCU82k7fSJ+4Fr/1YSUJn
	hGun1ucbfoh/UrzC2wjExbqd80VaemE4=
X-Gm-Gg: AR+sD10POOVfwoeQNIbKAkrHkgJVfhksc34i7wbDtgA9wwiOLSUteSfs+U2nRVCNwMY
	7AU02gE+M13GYiZqa937EL6wrmp+E51gQWkP4wliHb0TUfLXjjJ5Wh3qraCW7y37WXOauxOprBm
	G8reYUIEAz9troILoZqZ9EyjvT9I9xBts9rFXLdcdjKxIb1c6P0NnJCChYGP59f0xOuBAwAPVP8
	3xqlkeVgHRmZ6b4Xy4/OnB0IWtogWG1rnmQp3vDPsIWHdrCMhFbwf2vsGbDypKX8l4z98UtcJ2U
	XAbAmM/l4WfDfuKpV6kNl7qv02SdEfFenU6OQTT6iI6n1WRA41YS7hQE7FeN9u+++Y08Y/HJDKF
	bACH8Sdi3zV3eJDVMtqXFnEhI1kf0fV61K2cUL6YJc1DP7a9F6ZePssluRpdqvcXiTnyQ4J4Dfe
	5AzKcI5j4eVLRoUNh2hZL/7F9or+YpANSoaS3vw3/3ETzHvcC5RmGfjiYGkSJIsI0=
X-Received: by 2002:a17:907:3e22:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c203997b6e4mr292585966b.0.1785921614024; Wed, 05 Aug 2026
 02:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805040621.84843-1-marcochen.dev@gmail.com>
In-Reply-To: <20260805040621.84843-1-marcochen.dev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Aug 2026 12:19:36 +0300
X-Gm-Features: AUfX_myhIIB_JTz7NAD1bcLfDF1q2D1KmHo_OyYoZAD8hIxO2MH11qNDDtG7GMU
Message-ID: <CAHp75VdL+NarOfkY7mOB1U3Aud-TMjM8MPEsCapjYCoL0ikpbg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: health: max30102: fix NULL dereference in
 interrupt handler
To: Marco Chen <marcochen.dev@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, pmeerw@pmeerw.net, matt@ranostay.sg, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:06=E2=80=AFAM Marco Chen <marcochen.dev@gmail.com>=
 wrote:
>
> The interrupt is requested in max30102_probe() and stays enabled
> for the lifetime of the device, but indio_dev->active_scan_mask is only
> valid while a buffer is enabled. When an interrupt arrives while no
> buffer is enabled, the handler dereferences the NULL active_scan_mask:
>
>   Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000

>   pc : __bitmap_weight+0x64/0x98
>   lr : max30102_interrupt_handler+0x48/0x160 [max30102]

For these two lines see the below comment

>   Call trace:
>    __bitmap_weight+0x64/0x98 (P)
>    max30102_interrupt_handler+0x48/0x160 [max30102]

>    irq_thread_fn+0x28/0xa8
>    irq_thread+0x184/0x30c
>    kthread+0x118/0x124
>    ret_from_fork+0x10/0x20

As Submitting Patches documentation recommends these lines are not
significant in a traceback example and may be dropped. So altogether
drop 6 unneeded lines.

> Call max30102_fifo_count() at the top of the handler and return early
> unless it reports a FIFO sample is ready. Because FIFO_RDY is the only
> interrupt source enabled in max30102_chip_init(), an invocation of
> max30102_interrupt_handler() without the FIFO_RDY interrupt status bit
> set carries no data to read and can return before touching
> active_scan_mask. A negative return from max30102_fifo_count()
> indicates a failed interrupt status read and is treated the same way.

--=20
With Best Regards,
Andy Shevchenko
