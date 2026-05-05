Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A52BE026
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013033; cv=pass; b=ColCK8nzadOn8ZrUn5XvhK9IgNzozS5dCQyf2mXJ/QWcaEI7+bmyHgiwz8q1/b1mGinFy42BuRIi0MemWgJyRoafD4GXjgsNy2cc53MgGbLyDMtuhrTM/BU/hXlmmkCOLbs/jlU86z0qPeRuPhZdagzZr3jlCbhvUApU0mvr9io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013033; c=relaxed/simple;
	bh=U4r3cUQVWnRI6NqMIURgCaA48nQvwHk6s7D1LwZN5ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5HfdfMHEmIxXvWD24obcMUnrW+ey5dPinmKFBqSv7fwTX9SyvbY+DjCtemJZ0OkvDsV4fX5vliMJmm9J8mBUUSShaQBPFe+nZEt7KiHuyJJGZZ5cm9KjTiqjXCTNWTI4odQO3d05OdomiL0suzKoLFasy5qpE1MnJIJsPZfkOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOBhX0Wf; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOBhX0Wf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdf83185bbso20167b3.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 13:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778013031; cv=none;
        d=google.com; s=arc-20240605;
        b=OXreySFqrwGjnBN2MZrJeDxUoUQ/JVXAfnmEArZ4q9/q+4n5UJ2r4UA6S/VCvafQ0d
         dwoKHeiigKOIiVHdNL63tnYMlYZfAdmCpzG4U1mUZ23SYQlvszzwvNHyEdRzxZRBwiqO
         gZBscSBRDSI7wVknqCgQR2hG/jPzF4tmze77IKu9DE/dGjaO+kKslg3VZKyuQA2iiIAY
         7pnc3wW+fnw1WVfmII/DbC1T4VkS2SiSQgrcSNd7d6BrKltNQ/DMRcx2F9mne6+AGSct
         TwXPJG26in1ItHpzCrBJeCO+Q0PTJESM3thF00n+OOfvkgG0Klcbj3fqA3T+BM2i5e2E
         SVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ybH7IIm51JpYb9pPTHWyJhP+mKIOzja0BbiDk2w0Ec=;
        fh=OgLkWhqTI12WnRkYW/wHyi5NCYa+KJy1+sRB0PBEkT4=;
        b=joVD8CFmiYUlD7r8rbmlxXsq41ClwMa+55UgMsFt7Y1YrpnqIPQBSAn9WaVexctdra
         uOOHE4/SffFvnfzjy/gG9otoFrd+moKhvyESSF1RhQGwm8K5TEVHIQa3/hEpwfWouBU3
         FWIhTkdIkZBip+nZ5tJcHVxAx2XnaYtz+PNzEa/YzlPjrrheHpJdJ+/FnKcsmysuBSV2
         n+Xoi4yGRjcTyNDDP8uul+6VGQ2MX0pgH62e6WYgduRnMgMHIdT8n2+THymg2R4mc8ju
         2i+u3IimWK+/Mzn2Q2121286o3AdL+iAkwqgAms46/pTdLp/dco4w9Z7Vp2t0DxkdlWl
         Enxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778013031; x=1778617831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ybH7IIm51JpYb9pPTHWyJhP+mKIOzja0BbiDk2w0Ec=;
        b=OOBhX0WfPJAcw+ld3UT6DwU7CvzfhXyVGPZCLSmJCMD3Vga/i5iAtsrw6Vm5wSyi8b
         a+MvikcgDnLva8VYFMODYa5c/z/xdBXCa/k/NMgXJ1LCv9qOcxtpaioWCXGv10S/KoRA
         OQvX6juM9F+/Kl9bjutIq29OKxEXs0xOAQJWgj1/HF76mi1Ww9P+RbumFW7IihJWlHJG
         GC8xJRR1fPrj+99XHYaNXfrA7YKQnyReNutkDqPNlZjGq/SDMs3q38dVXroDccxC7it4
         QhTt1M4fOBrG+oUeyO19+FOJ/BWAMUxO+6aSlXEYLgsyYPkKJNPnmBxqJGff+sad/uO1
         13SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778013031; x=1778617831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ybH7IIm51JpYb9pPTHWyJhP+mKIOzja0BbiDk2w0Ec=;
        b=pFwljmIPSJ3EEY2esQZqRhMRnr6B4m77nGjW4kFHusBiJGBR13caUFRWBq96hpfLT+
         t2cLSgUgyh11xqlNeJaKFr8ekYea/PXLSh1IFNprJdAhYebdQlE0MtWlaIkH69NoESMd
         m8G+6QEZGSBOqS4cvffeSMcrA7wO3wLtD0owk0of6UCOEN8y3igcGw7yRGeMICNu+jji
         /h/jG9LDTWx3+Vf6MQpHEs9V1uk89/9k01LDGWGYiN+VjOfRLj9vKOp5IwzXYUY1TLD+
         8UN++7slS7G5pzpApVm1oxSLl2ql7WLpGs9Ubi+uxnJlEo9ckaifCCq3IzuNGtpYaAkw
         pO3g==
X-Forwarded-Encrypted: i=1; AFNElJ/18TPpMQRVRaGYWX0epvf+vowRSpwQuHoTjG+ZOuZ8YGYyxzHBTetAsg1Z4lTjixvlEYCft0+quEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHx1NOPVdY0/sVgyCkhSQqCjsN4yng4wLAVy5xkLgJRRbKFhdO
	yw3KGwsjnlFlQlpXQduBTNHfoEEoHUqYDS9bMnVSNs5mTFtOTD3omBxcR+NYkkZ3V1RLhZVjF2H
	YX2QWLUDsMqg797642L87uuwo15c3B50=
X-Gm-Gg: AeBDieuojIwZ8B80XeIUNscru0UWD3GxIBfeMxeql+97ZjT9BjglRMuoqt1dwyr6gLn
	v3UaqSS2hpl0jPY5V1Q01e+A582aVp9RpfU4hLJ92d8a3In2VZXHnBP1iHTE5KGa5f2EZTvgV8B
	hWhAErgUwsrOLs8VHaKIWemV7L178a+fr0pq83OMU5krpjdbs12XKeRnYR+GLRcmbs68BIZJ5CF
	CyFpViU19ZYMUrR/92N3397tRP04H7eh38yaw4yLUIaPD0gIeP4FCIBUEN+wFnOJ5QL2cq46jDK
	9eeLKYtoX/OG9F6xW4fN1o9FvsDbnIGUryfKH2ZQd0IC+Ncdmddzsrb4oq+OJO0=
X-Received: by 2002:a05:690c:39c:b0:7bd:8cd8:de2e with SMTP id
 00721157ae682-7bdf5efb334mr8410077b3.46.1778013030868; Tue, 05 May 2026
 13:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com> <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 15:30:19 -0500
X-Gm-Features: AVHnY4IX5XEsZ-StSJ4cCsYqEZZUSt7EDZRRIwm0ShY257u47c3cn7U9vaqTw9Q
Message-ID: <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Tue, May 5, 2026 at 6:53=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Replace usleep_range() calls with fsleep(), passing the minimum value
> required by the sensor for hardware delays.
>
> fsleep() automatically selects the optimal sleep mechanism, simplifying
> driver code and time management.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
[snip]

Looks fine overall but has this been tested on actual hardware? Just
want to double check since this touches the set_mode and power_on
logic. Also I will say it may be better to keep usleep_range() since
it's more explicit, which will likely be better for the future to make
it obvious. Also, I was taking a look at the docs for fsleep() and it
provides "maximum 25% slack", which means we're stripping away almost
375us on one of these calls. And besides, it would eventually just
call usleep_range() anyways.

best regards,
max
