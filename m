Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900379DA
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782086771; cv=pass; b=bOUIxHVhexzzsX+WGGgC4m5SWvxsN/a7ykhG+t/pQ81xfarbGE5r/IVzSmSpphddLAcKDaKxXaBF3LxyXCO8EFW6r0K+/HpZe2Qv3MigYoTOTcElyQ2zIWQXAPZNbJxydIngTPvhHMOdEZn0SEwpV80dK6ShVG2PDJDFvVv2Y14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782086771; c=relaxed/simple;
	bh=ErQ4AksUVGb6gjv5g0n/ymeD2WyZRJFl5+vFM5Os5cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu2TFzSBbt1VgxbyarTdQydLc5SojKpW8/lA5SX1hebruc+QkbI1OctEBNeOFnFkgcP3cA8MZmhR/FPh8k6b6MLA54YtDNP/tOakeWvZrPQhhmBuyBcAv969Upq0YaQ2EVo9+NGxFTrhy0OAW59MEFryCFeFtupNr3Upcia2Enw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC+BebHm; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC+BebHm"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ff0645d1d0so32206517b3.0
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 17:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782086770; cv=none;
        d=google.com; s=arc-20240605;
        b=iscci7JSyikR5oujXvM92WW3v2E5cCFj8UVIalIDGpvG2tBaWfKlz8YuQhy9dmJcRR
         r0Qh2RXnUOzjC+FRhvyMBrgNqYSzrylKjECIL0/OUMivnPtm1Ls2bJdyNSL6tQY6qHOH
         v1WxoxEJl664WWSrzaDJela6U1tQTbl5yK3BAvKVoWB+Kw+492qHg0I3WxC0+p7mfOSy
         EBjfQkOT548CoVA3bBs+dXTLg1HbG9MIKO4UKUAjAsQuFNjQkWIYct9jhqlLYJ27Icxi
         8Po0G1rXZbSL/+KOS6QnbG2wSsiH1l3YT4GJeH7b39UKnYgjUYBO8UUlHZxZldBhyUsX
         wa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ErQ4AksUVGb6gjv5g0n/ymeD2WyZRJFl5+vFM5Os5cc=;
        fh=KtYNmc1eVi5km/k55He+DDvjZiLd0ozv25KeBmw1e8Y=;
        b=jgvsal32RQG7bFdu+MDE7o5Vvntag+lTU8pog8+6TPq3JGQEA+vI+PnGu01V5MlB/O
         ii977yyrleGtT/Tzh+J0pkzoZWgnLIOtxmMDiNFU7CcPBKb8e+PmbdtVW/0Bix+fihAc
         GoHXG5O+M4d/EGT4ToAUz7GsQRgS+QdMdFr/3IAsRy7QsXgxRa6kAw3i6ihyt7h5QdyX
         PkLDcStCO+H+dt1UbtUCuWC8BzyQ4oEDiqAk2jM3LSQfZk4wk9JRL2N8m1KhXyffvc2K
         MOkpCKtYG0kygWd89nd5M5Q3xiCkZLLLfZXvXYouLvzi51BkZYoJpGZXHBZOxlvMbKh3
         rmkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782086770; x=1782691570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErQ4AksUVGb6gjv5g0n/ymeD2WyZRJFl5+vFM5Os5cc=;
        b=AC+BebHmg1S1wOnsAx3mrauXA4vyK6jqtemjwxloIAsaeIzl1UfLFTTCwJNZ4zbrVu
         avewA8M8Y7tTJLi8sfwW+76LRh4NU1t3xcREVpnehUPZEdj/FLP48SOBO3nmEx1W6apg
         wlCb8lhjEj8l05Euul0xvF7TrGhrnkh7Y8ctzpyHaeHo+JxxCo0ZFitijFVDBvrySFJH
         U5CtjUeDpH8IoqTN2QjLZ2K4yYHGfBNid9OkHUKgpG4tNueau1cK9vSaADiXatHdtGAR
         GJfOIT0ueZxNvjR+uUp8iRAo2nkHnh8u7PST1YcxUo6qw/BOy8jkkABi+WiimaCmSNjD
         tmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782086770; x=1782691570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ErQ4AksUVGb6gjv5g0n/ymeD2WyZRJFl5+vFM5Os5cc=;
        b=eUrfu0fE/FfoRGesdEuREX+yjlIv8Zy2P4AT6e4ZiKq0PiwkFEQAd9WGlKzZUoD5Vb
         66A+1amB5UAjShCEAaRXkh7uUOscB9m5eZDeQiz1FmQAwwLbq07PQOnNY8uenaFhrQuE
         SBUPQspEWLgd8j5GtEMJriVjqGrXmBa2ESfIABY11KfcIyeuf4jmygbzJVcv6g5vAhI1
         vzf040YKnmChcrm0gEbCFH605veL3W/LElYfYKXiHjt7AeJ783UWid6VBhDtGOVq0kyU
         7NVBlbU0KMgbqDmKBRUhvYrzqe8G3PpOpwU/K8ENMiyRRl8PmzoC6tqev0uTTttAaPj9
         a4Pg==
X-Forwarded-Encrypted: i=1; AHgh+RoLpT4j02bddKSB84J16X1YdcEqsMGeAUT+hwrpv+JKCH47mHuIojLclNTUISqX9yXQn5m6UHvWuPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHCXoVBnAROnWAVdaHs3ujmEdaloaW4YlbOpKXYvljKfYtRPf
	jThVdFPkYJ4zOD+erZpeIMfXsc72N5Vxn+m67QWZb/IlGU/MkyDs47P5HWPWYbhofuo9AzK7Ymg
	nYtpeowwJzFE+bAAnuYTQibPtwXLqq/E=
X-Gm-Gg: AfdE7cniIUtD7LMiz6xB7gecYjueNM/YPCr/L0E6zf5eMqEZsV8PqUApkQe831h9i3q
	kYw3A2gv+Wb1tLxrrJIsMZdhgnrlmXihNKjB93cm7M41uEa+RJ7zuU3j5/djmVgoQopZmgT13fU
	OHFlDmgME56SaMoy7fJMwH57N6fs8j/6Pgfe7BoM5cyfxHEiFyT3cgJOrM/Ukp7A8fh1R4D2YQf
	r8uwqjYfdclPfqOmLl5Hc6PDAp7HTD374ORCSQl6D933u9l0wFnpIKl4Dlxoo6VThDw+Ij70ZcC
	PTam
X-Received: by 2002:a05:690c:e0c:b0:7ff:5d6:201d with SMTP id
 00721157ae682-80134c779a5mr119196487b3.28.1782086769621; Sun, 21 Jun 2026
 17:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621004626.66629-1-m32285159@gmail.com> <20260621004626.66629-3-m32285159@gmail.com>
 <20260621203303.0f8c5d08@systembl0wer>
In-Reply-To: <20260621203303.0f8c5d08@systembl0wer>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 21 Jun 2026 19:05:58 -0500
X-Gm-Features: AVVi8CeRhaBHZabaiTeL0-n8AlAEkTYDZRkLcdAkn06lqtsN7fSD7b_D7f6hllI
Message-ID: <CAKqfh0HUih0q9PEh+5pwwMuBBkm6nsaZP9e2yPjHO3+Yccuvgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor driver
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 1:33=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
>
> On Sat, 20 Jun 2026 19:46:24 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/i2c.h>
>
> I am a numpty as I also forgot to mention a missing
> mod_devicetable.h header.
>

D'oh, I ought to look at my includes a lot more closely as well.
