Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FA388863
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388113; cv=pass; b=UPqjU/DnKap3xa0pcwcw6UjYu2qc0ViKQDcu6BG64X0bFLIeb2X8ynGZln3E0mc9RSEQDvyiFErBPx39Ji0QwMQLXjzrr2H1d975Wq/NuOguG4qybuxblMkqsR6K2tCrBySpKkba6fepwKiYcn+p+owdKPkeGBwTicPtO+EnIFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388113; c=relaxed/simple;
	bh=SlCJhBylOzlkOPgNxa4vipn9yPxx3vthybfgaVRd4sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7lO8r46Tj11mWqSSlrVu1NX4hPEO3249cJDe1A83q3+fqQD0HCguIWV7CBmkmM1IY5N8ijdllvZIS4y4MUNSlbsQ3FjmF0G8MVemgKD5MZntkHKeeDNJ6b6N9shNC5mCxv9L+dEUChKc0dFRHCKhd7hENz0MjmLfy2lQZ5evgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcrCovYn; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcrCovYn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46015dc517aso1115265f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 01:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780388111; cv=none;
        d=google.com; s=arc-20240605;
        b=KsNQna22t9ntX4TUhjUvLNpow3Yebi0SHwc+mIBY/OoHwNMaQaE8ZxujFqVQsCCBZ+
         EFyGUpCuLqn1FyhLkBfbm64SYiQ58jR/IJE8PuEbsK28DYvhzQ4K42uI8HZehWaeuuvi
         M5OlIAiA7Nhm2WF7R54zwSnKn4wp9Rl0inX40NXSuqOczmTnPYCJ4ynz/uwA6VtIL+Qm
         0VXHVRXqVRAeTjLguu1RY7RXU0a2hyYBxnFZ8G5afmFh5NSMhArskmcrebljtl4edeeu
         mW3SXtBXfn95uf1/DTRgZKZkC7EXiGhYbKi68BL6hmiiw8DDiPir7S+8Xo2jdPsanO8M
         pr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dViNr93X/dYoXRtlltH7nsrecEamX34qdglxK6qZs60=;
        fh=YqcbJWJdsL+6dtxwkc8zf+FIzumqX3gjP4MtY3b3Y0w=;
        b=PBgxCWH8v0FKa3CaaSoP8/x5ViFUsaAMAcB6seYvgDi/aJpxRc+Ye+r3aRyWX3gdZF
         rn0C1qrpxVmwWaLgM8vNN2Em789NZsXkHDeUXSZP49GTxhZB41yyqsm3DtMJyi5Vwaz+
         Bs30pDHeGJEyNGGrmfoiTg0ggCmfwFkLnIN/wgvDepn4ptSaS9rcr2q/k9TAjpe86hQ+
         Mp0NNrZMPw95Zp9EAAffGk1c/+Crtw42RpnrfZGrFOE/CjT9XqeZ+jxgh6mTgIVix4hc
         IinXVypaPHvotkZYeAL289UAX5ASSTWWvw+gNlX4lMaFhXn9BNChhCzY4HEwtl6IQ9Nj
         WalA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780388111; x=1780992911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dViNr93X/dYoXRtlltH7nsrecEamX34qdglxK6qZs60=;
        b=JcrCovYn50G1LvKq0dVbeymKfPpOUC1b84sETUS+hEOAhWMOPrf4wm++U3oIvBxKtb
         aXkqwTJlXsxx7hXigcpWdcOLkGnhzHAwVerSyqyE2OI7rukze49lM5uAI5oGMFg5UXZE
         pMuWCyAeaMDPzRLWjml6jgyRywrpkmzpfdIVgRwox/pGZwX7qeANa8FYCN3uREtz67Ho
         e4LGFplOQti8k7d/UfzL96Mc7H9iqsYCc3AllDE/QLc0/S7h1zrMWCDD2Q/Fm0MUetvZ
         x9tq4FfIkcAc27ugsZmFUPFbScktSSlFmoDNPstO9nw0Mg9Mb+egHKtSwgsMfTni2ziW
         vBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780388111; x=1780992911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dViNr93X/dYoXRtlltH7nsrecEamX34qdglxK6qZs60=;
        b=VU8sjHCtvuuy3XfenHREMYBKz4WcFJEwAg9QftciuavkCREw1Q+yZ+jftjgYt9pb7g
         6lAQuHTm5fKbP7qXiPoYV1rLuiyRu0aBILbvA0LnYdoKrCh83hzLG038UM8zDBhvJnWj
         k8EpWg48ypbR7ItQxQdby0+SUH0WhqbAc086MT3rlS/wDYgvoIriQxKAMX3e+77F3IF4
         yn0NtbtHqBk68MxWRCizZs/N9KmSX5fQyB9OcWO3EYPe5NirYN8AyN1DpzmwSMm06RkU
         7BsKFeW366GTyvSyewV5ZwQPGA5XEZsv3mzDBgbDCeMMIutqOJqW1hTLRYivjAADa2K0
         FB9w==
X-Forwarded-Encrypted: i=1; AFNElJ/l1d+Pnw1ybvnLzwqQ9QquqXd5DtErfDc+mDJoxTOrZtuR7FxDlrtni60jetCaKa6dwfHTFWTmlTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsccWveavHh4Yhfr1pXiRao6SWzzFoaa6rnm6FaENVOOZgmDH
	F6vWQCAftzhPQCXOJsEZNkcBNqIMqFIi2X9Krndg8j48AxgpExPXkZ2xd/UDiHah3QvU3y98Qfy
	nG/tNphL7ZEVSsO/Kti4BvB6Cl8DK7lo=
X-Gm-Gg: Acq92OHAobiKkky9U+o5MkvmLZr2ximkWVX9piQ9dcpbBY7JKPawPJbAHS6QT11VHs4
	Fy+XX8R7je0Whn6nMk/EQ2f4NybT3xO1iHEcIPBKSN9vJLk2uFVK+HENthKENbsxp9BnfNh/d5G
	zZgIYWKSdxNValfeMTFly9bbzzsK9K99EoAmJgiLg49TvJRiGlfr1ZXDLwPTQ+eseRxCaXpHw/P
	S+ZSFqp+YqaZItMBzTdgh/ZTM6HL/jhcDebQyoM5VM8zEvqNf199Ulhxztz5bsgj+CcaKcRmI9w
	/YkN7p8u56U3f0ZrdYGNzlu+cGJzNUZSOy3BQOdODP/NvA7qcTDDrIXoFr/SV3EvhRLh3JqJFtR
	govYDvuHkVTrUoAp2+08X0KL+gK8Gb48pnmILuPNBhHhLj43X3Y21pguu2xGgW02wI3K7e00oBr
	w+GMaMKOwEZaTTQyKn
X-Received: by 2002:a05:600c:6091:b0:490:6237:521b with SMTP id
 5b1f17b1804b1-490a2b6b21cmr270415925e9.27.1780388110635; Tue, 02 Jun 2026
 01:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
 <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com> <20260531101940.037d1d7a@jic23-huawei>
 <CALoEA-yEA5KcvXqZCCg76qFAgyNq8BQ5+gop442mju-9PiKaxg@mail.gmail.com>
 <20260601101726.203f56cd@jic23-huawei> <CALoEA-w8zX+bzpEfvGoafDaOr6Kd-USgsyZ6SRpV08Yw6MaVrg@mail.gmail.com>
In-Reply-To: <CALoEA-w8zX+bzpEfvGoafDaOr6Kd-USgsyZ6SRpV08Yw6MaVrg@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 2 Jun 2026 10:14:59 +0200
X-Gm-Features: AVHnY4JQOM4EWly35TPs2fbGJO-3-8pJdZj8RhArbOwKKDnqvspDzMSHGCRlGgQ
Message-ID: <CALoEA-xDSVOj0qkr6fYnQt0s1Xqh6acsVs7c7QKemWRaRh1i6A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 16:43, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> On Mon, 1 Jun 2026 at 11:17, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > If you have time to figure out the path that causes that, it would be excellent
> > to have it recorded. I spent a few minutes the other day on this and couldn't
> > find it.  Maybe ask AI to figure it out :)

Briefly analyzing this with AI (Gemini 3.1 Pro, just like Sashiko). I
noticed that
in drivers/base/dd.c the specific driver probe function is called and then
pm_request_idle() is called after it in _driver_probe_device(), which
is probably
the reason the sensor is suspended after probe even though I didn't
explicitly call
pm_runtime_put_autosuspend() (odd that this behaviour in the actual
driver base).

To err on the side of caution, I'd add a pm_runtime_get_noresume() call before
setting up autosuspend and a
pm_runtime_mark_last_busy()/pm_runtime_get_autosupend()
combo before registering the device. Technically Sashiko is correct, this isn't
explicitly done in the driver, nevertheless the driver base actually
handles this
if pm_runtime is correctly set up and callbacks are defined.

Jonathan - up to you if you want to fix up the driver since it's
already committed
or if I should send a patch (I guess it isn't that critical, but it
keeps Sashiko quiet
in future patches).

-- 
Kind regards

CJD
