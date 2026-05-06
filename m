Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC3370D45
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051631; cv=pass; b=jqoNO8aRNZ54PYVlbfOGGfLPxe81SWDMCIiwgoXNT2tjJ31iMVosPf0bcfz+Ap54/8J3iuanxg1KmfICGaxwGyI5z+so2W9MHAmMmz2J8GVkGZPUlgOGI1vbk9BCDmtN5ra9GH3ZettfYh5JUkFOYoKBap6v+9G9C5O6907oV4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051631; c=relaxed/simple;
	bh=vzpMjib+ca2ApQ4jnTJxehRherCsU/Kz1L0DxuEyr4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAex60uf9km5HNwmkZqKffXVn8xJDOxllBopeKDRgwrl1C798CUHGPekkFA/iS/rTsy3NranUGT3VtZgYHAHwtALkn3W46xzAkYabzAVo/6FrlBxGVGMMMMm+s618hYjMmUtTbEpWP/o7w/CZdLaiQvJYH+ZEVM4VLu41IKOWpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYc7kaRK; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYc7kaRK"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a46260385so72391007b3.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051629; cv=none;
        d=google.com; s=arc-20240605;
        b=Ka2YfvwI0vFRU1Ne1/o0baPJNV3Rb8EwepZMMyayezOmc9lq5HIHpUI23BA6qkDQY3
         OchHvZP32Qa+0rVv6RqpHm75aRbFZdS5UP/OwydJdM/1u44Kx7UcPYEic+/TpJhsR+Gf
         XcNqgD19VqfRpX5UidTj44wT3e2yyFyWT5ZlBMd25iMWE5QsleTEVvlIIwr5G/uMcXk9
         ezoJ20r9Hm3iykmlF5RO+E2a4V1NzHQoowbyEZRM2UH/PUZrjcUckUqXz+pRoOe//VtA
         Y51h5K0b/LbhmXkkh/bzqaBY0B3Wukb+yLPlEO/pz2pw3aaHiXFOVLfPc1FMZ+HSbK8w
         EpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzpMjib+ca2ApQ4jnTJxehRherCsU/Kz1L0DxuEyr4U=;
        fh=f/E6I7vx9NWwgyFnumHtVNk+rJxCEV7rEe9MftGzSEQ=;
        b=NXaEjVyuSP1Gw8Bsdn+Dl+3LIkgJHYEOXeHaP8BbKicCvkHemLgHjR/N5sVDuQY09n
         9e6ptVVHvjZG+n+6l5BgiiyHULxQSNRAswFoLKdH5Bgfegmu6eri71uNZV7dRpnOuSIV
         rDG87U2Sw0CxexH3urDc3ctsZPN1/v5Arfn31qo+fih0o8kG6lZay6vBsAmkfAJzh2F5
         56RWtDymdNfilnx+63tv6JOGFrnrgYOhIRHpzJjEfwSpJRGz4tSyniw00jJd9+9gbojD
         bLbtxsLQAvEL46N4SsLttnZL4BJSDRzuQY+j1A4P5z609qugAa3+X+wNJOByH6Ex2qds
         EvHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051629; x=1778656429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzpMjib+ca2ApQ4jnTJxehRherCsU/Kz1L0DxuEyr4U=;
        b=DYc7kaRKHmWiOEoSormOStWuL4X/D2NY3y0Y3M99GA/t4LpqxBTY96+ziQqixp6P2G
         BdOEvwW1NLYWexNtPjMYAvZ1cEDTuG+y1jzBG9OWYeVHObFuH3/0t/emVw3Ixr6iVNXH
         r/jHZr4xozBTChtcVdznu91oVRRyl4qc6Dk15y/sPxnwoaEDDwP/D1CP2RNB427/j9N4
         7DbKqEDoTKG/OWr9IzQy4KXWjjtwPnbPRQSONHvNI/2du5R3pPMmyBhOz50rakejalqB
         /IQq89PqmndRAYfUQ6StAnUZ+EUc9cDMT3iItggKPIUxWaNsua/EE00NQgtA2C2abn4I
         shUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051629; x=1778656429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzpMjib+ca2ApQ4jnTJxehRherCsU/Kz1L0DxuEyr4U=;
        b=H0YqRRYhUgJLWhYKweFwpPEpE8dk+AOtOkjbkXGjg1NV1MCFaQRtNVxW/YtgMhmLXm
         WSziWCyNen6PPkMgUS+r7jGWrIsgMJYi5yKdQBEJEWY0UxCeCekJkAbsYBA7GKZ5/Zcc
         1roEcGt/1hRgscEJaFcaV7XY71TkYfT84PWYPHbG9hMFfdT0Mqmvv1p+5pKqxh751XkY
         jUvPKv79r0Fo5FDyAQIQKyI6A0M15uqC15MwVXggGXF/MdPNEMtZFJicRg+QkNFtmYmU
         ohgvHO2vdoG7i4EZoHvKEFR3cPqupt7ilJJswci2SgV2n0VCXhhl7Lc51Yc0nbeplujx
         jkTg==
X-Forwarded-Encrypted: i=1; AFNElJ9aLnYHYf9xqALBkf2a89nqD2qty2E6NYN6KwJCHMskdP8fXTGlws/TIATJ1V9WqyzrOJ5cOURJoeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPF1f6VtQfLH1kh00yryyuJMOTRGPgrgpx+dXryVLimC2CXUrw
	GA6FyKkl3Kwg3bOL2gUL5y5LHJzC1js0T9ounLHH+3NLW55rEUvi/zD45UeBzmjHLWKBBFhhp7h
	0EKkILMBCaO9K1/zlq5pfsH822mBQmGQ=
X-Gm-Gg: AeBDievOaTmdE3TpJ9YxF9W2EHLihDSp8m0dMOeOYpbp6RPEV01JMucO1/svd/8zDq+
	savBLHJagM2De51MLsUPTeX0SIEDVhAc1U6TsxieYRGYvnU7ispcoIX4SGxzoIjIk40R+QDCkLi
	olRch5sX923vPhQOeWOLgUb379/Un/FKl2//JdeF3NYXUL/or6Tk2Hh3GzZ0qmK8uVsqGDBJaDh
	v/R64f+XZoqyy/3TW3E3PAXPoz0npEQ8fs6pvzaHFzQ70y/NfFH/DiUvPAT00EsABc3nmfO/Erc
	wV68YtfdpCnUfZ59XikHJApWBA==
X-Received: by 2002:a05:690c:11:b0:798:4f55:2c5e with SMTP id
 00721157ae682-7bdf5ea2150mr24919427b3.30.1778051629010; Wed, 06 May 2026
 00:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com> <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
 <CAKqfh0FhpVMtoRyBPjmv5JHn9ad4fPgn5wiyYpEnSYf73Wd-rw@mail.gmail.com> <afrplquQwS2hmjEM@ashevche-desk.local>
In-Reply-To: <afrplquQwS2hmjEM@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 02:13:37 -0500
X-Gm-Features: AVHnY4IP9lt-URW20YZ-wmEbvPC0uZpVsyLr4rFd3H18ut9A5hCj3f3Aad2WMB4
Message-ID: <CAKqfh0H1Cc1tizgYKFatEAVvyVMTsCAu1mb1XdSTqB4ecMvqPQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: joshua.crofts1@gmail.com, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:11=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 08:42:12PM -0500, Maxwell Doose wrote:
> > On Tue, May 5, 2026 at 8:09=E2=80=AFPM Maxwell Doose <m32285159@gmail.c=
om> wrote:
> > > On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:
>
> ...
>
> > Actually, timeout. Sashiko had a good potential catch here:
> >
> > https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5=
550fc%40gmail.com
> >
> > "Does this new error path leak the pm runtime reference?
> > In ak8975_read_axis(), a pm runtime reference is acquired via
> > pm_runtime_get_sync(&data->client->dev). If this new error path returns
> > val back up the call chain through ak8975_start_read_axis() to
> > ak8975_read_axis(), the code jumps to the exit label.
> > The exit block unlocks the mutex and returns the error code, but it ski=
ps
> > calling pm_runtime_put_autosuspend()."
>
> While it seems like a valid concern, it doesn't relate to this change.
>
> > I'm going to withdraw my reviewed-by until I can confirm that this
> > isn't a problem, sorry about that.
>
> Why?
>

I just wanted to make sure this wouldn't cause some crazy regression,
I think it's valid to be somewhat concerned. If you want you can
reapply my tag.

best regards,
max



> --
> With Best Regards,
> Andy Shevchenko
>
>
