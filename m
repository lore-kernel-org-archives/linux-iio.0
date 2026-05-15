Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E953BB131
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857765; cv=pass; b=eQPhzXtsf1InN6LqS7owMhyalA9EmM/E4/V6RHHtiKaNaycizFb1HR996WJKvCuAky/Yd0NECXQBxFtYrbBZSGv5+J+tRq7TPFt4bgxyx78LDwjQnNjUubssGA6GJRrxEKADZY2TUlZPwIjmFU4I04t4+O6IVMoLzJ3uwA/SfTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857765; c=relaxed/simple;
	bh=tka5Jm5Ky1CuobGp0pwxj+nlpjb1zjny4c2a9FfYotE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0XseRkcYb4fo3t7FIWPe+tpQzSqqNiZfh1xRZXVGHjw+81P4vA8vLheSPY8UwT5JnAQEatHP+v3/7e/76pRgnsRPBpVQUo2m40vFY/icA4Y8zKwwsrOw1yFvmPhvsfBpFdeDnJvobV3ByafZbckGdaa4ZAyYnbQyZPNf9llp9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj+NqYVr; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+NqYVr"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651d6347a69so1964206d50.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 08:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778857763; cv=none;
        d=google.com; s=arc-20240605;
        b=iPoEsZPbEH3D/KGpBR9UtrNaTvbx89/kV27+IRxBOEQIoRZbrtzP7ofY1U4mY9LUbt
         Rw5Itxo9Uw77vXfbobzRAXNH9PDeQQ8mqbi4tzZ4NqYeRc/44VWN9Jet5M/Xynwb0YuD
         4T+PdkG6HE2adtVhArsyT9gmr8sEbSLK99KXxrZJALfFiqPbZJZ7/qB8PHFNqbHA94oJ
         U8dnPwFjwYxrJuuMnm4/YnR5WyJwGqNyK/XngBnDOQeovil+IFfCJV56j+V9eBouBZ0d
         uaHR6ORQCV4F+SUsVl/IaqZjaLN4kV6t7m4UYzqRch4Vl7FgFEOrJmcTmANLyIbeJNSc
         dOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ioAnZK9O0bo5L59691VsE3WqhEi1rcz1Unfgh3sVlTA=;
        fh=/tofJjsyHQu0Tx8clMhPiEzwOV+canT7i64XeTy/xCQ=;
        b=Q34BwTqcABxtw2R3RWXhXI4L8hoLxiVAHseVwAVAGmKUAcWYZp2ZIFC2z78z+vZzYX
         o/oQ03jPnMPnqaU/l1i8xBrijNwl5YEn8KJLxC3N4lKc7NYOWFshDDKJ8WN7zx6CuHK6
         R2t0aPxlHZryqTAFMmtLQ1i817eCHMV7jQF1bn2KHsN15CykGJH3fcI06/ao0n/IU0Io
         BAWoYdgDa0cPKQYyowJkPXc3rf+dvUXmZ5xsQGTQ2lp2MPt6f8ooGX2H15U9ls23rgAV
         RFRUO5YBpSDYaE2bRkgENujZcnO/iCVppa4EAkIu7LJP9Mm42JcmJSv1T2FhW+Ig1KNd
         f7FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857763; x=1779462563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioAnZK9O0bo5L59691VsE3WqhEi1rcz1Unfgh3sVlTA=;
        b=Gj+NqYVrwtSYD929NiYxwXjqQ3COmtkijAYARxEc7lRi4bHOTHOJh2aGAV+uqi6piI
         MLXDHxmKxFoSEbA+M4t2ClEbsb8ki5HlvAyWI2BpzkUv5AITw62dbHsaIGEWyO+uPknA
         UMdU5oZyUYeuKKJBbEcmcfOVlpny5bYFysaKBcCFWaYeGR3qrtcRd8w8QSzGPeh32HP9
         iVOLyHfd1yMePP6bafyGalM9BKzi39U1+P4YSrRtFZG8fo0ByNwhOHnmhFGZmxXjNCoR
         Ln0I5eyqL9plGv1lRI1t9nRqjiRNPktTgPxSwPvz68S3sRkLm07Lp80o2lmoY8oi2D1o
         MbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857763; x=1779462563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ioAnZK9O0bo5L59691VsE3WqhEi1rcz1Unfgh3sVlTA=;
        b=mEb36Bva5BcQ3Oa9r0cny+FQd6ed3PHt5Qsd29kiHfKVEUUehN37Q88/EhELd9Gwfb
         YjBvPaFXJZjUHcfenqChxLrZUbIVcQAriMWGjT4hkAe9qc5cPx5Olnm4e3u4d1xmhRJ8
         0TGlklxmHRNWzRBwubAgSzpSIvXYq4X+jtIt7HkAoaRQEUo8oUgQzKW5+H+8OMcHIe7p
         e6o9ThnDpyHksu4odGrvdy9M/5N2G8cmzQGv7uAd20oVc+57k7dx8cgHCjRguPvhaHLE
         x4C0xTwzjiUCh08KO+17jvThAb1SsABQA08Sh0ySDlE3rZteEjPxUxil7XQXOGJPtEwI
         T5sQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oE2tMUIcuPzGxmMpBfCvRpv7pdtru7TrLrwDlmeNhENwNYGQKVyrmPZRqFxy4KuEQK8YQtPOoPIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWeSrAMaK428SDEaWsuGy6jTe2UinIsnjS0K4d+XxyhMN953Y
	UYPC9golQuWZO6uWcAEqWE9PFELFHs/C6DHoyOYo9ItYYkb+6TlF5ECWm3OR90tzSqIHrEczOGa
	Uo/f06O19NjX3AvoeDP9AyutgAuG6DOQ=
X-Gm-Gg: Acq92OE7eTMo5EhYqxngZlF1z449g7rwc5djEsgxq4w/2lTAaxQy+G1kkRKtbWBeR40
	eyrLIMLkkIlHaafVv5DGbmJHTwNySNb1Dua4xvyLePxvaiJissy3j1XSxpkdWG4FkrcSOOLp1Z0
	eAqS03C/rYSQ842dg0iuRyklwUZ21GU9R+3ruufawoDbpRHoNQFDpEzPQlxnk7YAH5vWCcaRLiV
	LkG3baiE94w9Pr/uiPyVbpVbMfbnOks/0K9tNf/zd6vXrqgu++0OlWvOOEHg/Qo0kqRPkdvOg3w
	HPSPh3MLrgGq0VJ/cA==
X-Received: by 2002:a05:690c:e0b:b0:7b1:9036:a23a with SMTP id
 00721157ae682-7c7e6684f90mr84224427b3.14.1778857763096; Fri, 15 May 2026
 08:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
 <agb5hiF6GhNwGa6c@ashevche-desk.local> <20260515152005.355fffaf@jic23-huawei>
 <CAEk1YH7jYFHPJFEZrsW9Nuzy0RAiYa_HdQfx3nbv=Wnp=2-qxw@mail.gmail.com> <20260515155508.4c606a23@jic23-huawei>
In-Reply-To: <20260515155508.4c606a23@jic23-huawei>
From: Damjan Georgievski <gdamjan@gmail.com>
Date: Fri, 15 May 2026 17:09:10 +0200
X-Gm-Features: AVHnY4Kidg18MmsbStM_8XruXScUQv_1MlZr6NzSbLAKUP1RcX3EDRqC_McsPdA
Message-ID: <CAEk1YH4-AAVJtO+22x4vC-f-8UVYQKaAvEJxskrUQ7gKMBNsPQ@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler is provided
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 at 16:55, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 15 May 2026 16:47:50 +0200
> Damjan Georgievski <gdamjan@gmail.com> wrote:
>
> > On Fri, 15 May 2026 at 16:20, Jonathan Cameron <jic23@kernel.org> wrote=
:
> > >
> > > On Fri, 15 May 2026 13:46:30 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > >
> > > > On Fri, May 15, 2026 at 12:46:00AM +0200, =D0=94=D0=B0=D0=BC=D1=98=
=D0=B0=D0=BD =D0=93=D0=B5=D0=BE =D1=80=D0=B3=D0=B8=D0=B5=D0=B2=D1=81=D0=BA=
=D0=B8 wrote:
> > > > > iio_triggered_buffer_setup_ext() unconditionally passes IRQF_ONES=
HOT to
> > > > > iio_alloc_pollfunc(), even when the caller provides no thread fun=
ction.
> > > > > This causes a warning in __setup_irq() when the trigger is later
> > > > > attached:
> > > > >
> > > > >   WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4ee/0x700
> > > > >
> > > > > IRQF_ONESHOT keeps the IRQ masked until the threaded handler comp=
letes,
> > > > > but with no threaded handler this is semantically wrong. Only set=
 the
> > > > > flag when a thread function is actually provided.
> > > >
> > > > Yes, please read the mailing list archive and find the previous att=
empt to fix
> > > > this and the associated discussions.
> > > >
> > >
> > >
> > > Just to check - what is the driver in use?  The fixes so far all belo=
ng in the
> > > drivers, not papering over it in the core (note this is maybe the 3rd=
 time
> > > this same patch has been posted and rejected!)
> >
> >
> > good to know,
> > that's what I get for using AI :D
> >
> > this started happening after
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D043251b2dd1c2b0cd23f67830748493fd3d3ed0f
> > was merged and that made "intel_ish_hid" successfully enable the
> > ambient light sensor on the Thinkpad X9-14.
> >
> > Not sure which exactly driver ended up triggering the warning, is it
> > possible it is " hid_sensor_prox"?
>
> I believe hid should already be fixed.
>
> c47ac75f5f24020cc0c8b835457a7637ad450939 iio: hid-sensors: Use software t=
rigger
>
> Maybe something is missing however. Can you check if you have that commit=
?
> I think due to it coming in late last cycle and me travelling it went in
> during the last merge window.

I'll test again on top of v7.1-rc3 (which I self-compile for other
reasons) and on 7.0.7.arch1-1
I did keep this patch since some of the 7.0-rc1 when it first broke.


--=20
damjan
