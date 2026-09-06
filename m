Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CA3B14D4
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715752; cv=pass; b=OXrqPpj/Iq+C37lJor+Zl+IYeGhvvk3XFlKDJ4gxp64RI0iwLXiDOy0DrPFYi7H+Fn+uHMV57yto6d11qxOo56/xA2vlvWqGTV/CF9ai8vrSjD4he1Zd2KdbHw9f9WknJnwRhXXw9CCBV/mwC6QAroYigRABa7OTowEj/LgX3CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715752; c=relaxed/simple;
	bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCFp7j5iuN3plHOjDh8A4zUuH7ay6P4G8LDgiKdLYPGj9T0PYICoIg9yn08t4ddyd1dXuDWW0kSIXvHKU09pg0+b9afr83y3pApqqn7VOs8UlMWZH+nHBKapVLvx1pr6RNUOW5gM/xKmzwhaTxIl2X/Ylcib6wASF1cEjqG0SRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF8j2/e9; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF8j2/e9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so21627785ad.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 10:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788715750; cv=none;
        d=google.com; s=arc-20260327;
        b=JTBvqBaNPJ/Lav/JhWoKBKBdpvlv98mn1HjSzTd/5A01KhviQBoGOyQyAiIrwjzy9V
         KCD2GqYTCzabvwNTaaPiWUX+X+D25WoMC15OeEH5ibsLMZyjf5ARCh2z5rBCCUL3KdkF
         WDoAt53cO7+J19vJDkE3a5yTOGLYfWiGKmjN90LFWd1QVGDb2ie01/a+0/qYqU3DPICo
         Df3RCjYPlk5TQR/5j1cRGk4sg+x33osGUvfEZbjklJ9IuLOH4VaHYFEkrz93kuNgH9l4
         RSp1XQAPr+cnvwAvRJSrYYYzJKEPXaHPpX4htT2fCN3XOsDxr2GQmakPL1F6Uy9Ic0xq
         Ef0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
        fh=28O4XXdxaAIxVv0x5lz6rEDC6Wq36X5gZhtkHmjlCZc=;
        b=RvZvkBbg9ozAYiNwAMDdabSzTTkPLCuewT/oDmhDUhJXC5pZalPSNS3CdN4bxyGAk/
         0mkSDCuSARAg9US3cFJ2kj44vdEb3zMwq5sugMXN1j+gZanmnhCiAiBooE20IJ7bFfEL
         KzAHKx91Cd7QhIonBPjkViwrD+52J4nxWLpqrrQp6NFCkyRHUZX+8u1+URA2QErhO/3n
         QW5ragwXFzICoUOMPUOvJVwRIMgb6xYG3JKMOr9IcmDeAPzfAjg9Acw1FD0igPn/0eOn
         ZcbEuJfGA9L4QE2Mkv5FeExCEwqDI6j9vuYhlC1KQIMb/OK1gLh0oglw5lvL4gwmk0mM
         4xyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715750; x=1789320550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
        b=OF8j2/e9XaMRw5ga8VMjNKTjcE7mR8jmZcAz5h3CAi+h5rCxFnYnEfwtjWc3daAtRK
         wWR3rt+PNnSrR1dFm+5ceUKKbPr4kqSvRyCTz/LEFdlh9sh8dDoqIPNAsqZystl9Cnav
         h/mCpA3lAUX61QIRfNqgQASSNlTzGgBGgTW7NJkBEbG7kLNVL7WTiYZVgCutRYCZqfmg
         fon2Fm5XPPuRiy6UXv9I2qR0SiNCt/QmbKjqeCqDDbm/ZwXZP15ige2qp3w9gsZ561Qi
         bZ9IXQ9hJe0u3MpgmjeCLTpgaXSNYVxnC4DC2pc10S1zGMdMJ+4zTlsFdSmNuItXxe5+
         Hjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715750; x=1789320550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
        b=cAn+jpc/41jwtnGCz7FztxFl+PBJt3QHPwCjK+A2u72mAXdG70bHkEfOSHgb7/vXBO
         59EhrPAsLGKPun4ialgC1XWmvLgrUh+F1xkR/Ra56AVTMJbJMPg8tqZnf47O9MsBYxWP
         QYLTR5Z+Xanp4RHHIFF+eWSL0tbir/77vMYbAI0EzJOckT/QW17IQuh9ui46PE6AhtuS
         svCDStOt8wfxs3mTot6QK6tF7pnmS0do8h8SAxuyzsLUi0e6UCv5Adkrl/c9C+iUOtYJ
         1SycZdYfAp0vsyUj3abV1GyLiJW9J6Lb0qq/L6P1GwdJBcWfBlF0tDzs/hKgmbueAlJW
         2/mQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3QqZ2KLb7Ui38hN/kRWJluAYBH6v+kR08H1GaOBYRt0IbOz/ldAu18EdQx0eUMn/IRBuKCaKHLvg=@vger.kernel.org
X-Gm-Message-State: AFuF++mFJtb/4eiOk5QaWlGBH5Z3gDaIM45opCw8hmDP41RvvV/OCEM9
	B3AOchhAck1px5je/UKEoE2NfEgGIJlnYxbIpuEpHf9Jf/m07q9+xan+WTTAvFhLadC4BAnSYKG
	cPp30+uHEzvUAl9LY+NipHeP+cycBzmY=
X-Gm-Gg: AYBFou1ATVypqiOIi3A8GZXWpjiVsL4YTgyT4kp5joSGByomQD3q8F6gnfSQckJHl1/
	MGZkxpb8LRNniAr4nNTZDZFST+hploZhmky1PaSBUASfCSZCiDkCM3s3zsMjbBihP4aFWHTraGo
	w9pL3whbkMHhWSAAC48AExnJjXoVMYTTnzi1E/9+upyN0M6m5ix9cAxEfAJ0fH18167Jvc8WgaV
	N6S2h26uIc1F6mmjp5fY08kSP+HB0pVfbKuUlyj3dNZgcYj8B68VAl4UNMFwYib7BbWoNdmBSjU
	19KvDsYA8Kzft8TWZ02aV9QwL53CHqGMz7Bz6QFlt3MtdG2zJx8rzz9lajgpzFMYbeakGZzpry3
	W4A==
X-Received: by 2002:a17:902:8a8d:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2db122edd50mr199148445ad.5.1788715750074; Sun, 06 Sep 2026
 10:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260702161828.GB2108533@google.com>
In-Reply-To: <20260702161828.GB2108533@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 6 Sep 2026 20:28:58 +0300
X-Gm-Features: AcwNN1XWisbz2ascChHcLatRKYQPwdXAhH_U7ChBKnQiXROAqpt9L2vnmsacgR4
Message-ID: <CAPVz0n2fRs=q-1dAEt2k1FJpQVK9+PMSY0BSMB7Rs3F2xDyFvw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings, improve support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 19:18 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
>
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> >
> > ---
> > Changes in v2:
> >
> > schema
> > - maximum led sources for leds set to 4
> > - anyOf > oneOf in ALS
> > - improved ALS descriptions
> > - adjusted example
> > drivers
> > - dropped devm convertion of irq and mfd helpers
> > - all als configuration moved into lm3533_als_setup
> > - added regulator/consumer.h
> > - lm3533_bl_setup set before sysfs_create_group in backlight
> > - added check if LVLED is valid
> > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLE=
D5
>
> This set looks good to me now.
>
> Let me know when you have all of the Acks and I'll merge it via MFD.
>

Hello Lee! Is there any unresolved blockers for picking this patch set?

> --
> Lee Jones
