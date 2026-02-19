Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979429BDAD
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525534; cv=none; b=ZjwxDxMnhgDdRv9JHS6XjHDRqy+viPApVqB/neyNdlAL7sdFrXA505DReWqfxgXvUiwqedZhOMpVhL4RPgGTCMMRK9xalBJzDPUgwCdgF4pqU5+NJXsqoP9Wbq/VecJH2XKCttxUu/NcZSFfh+tq+QQGi7SDNqUxyABn/V7lFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525534; c=relaxed/simple;
	bh=TsjuKfaQRPaSwSOD7XSNnbjmMMLNKdF4ppbtMrwwvvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5wYw8oxK1TUiYIPdxOm9NzNIWV64i08kdpm3SGNGHqCXkTaZP9Cgxlo7jHZ+3XgSZMj/V5/2Aa3B/9hTuhbYIrUQ8mOaZKRY3ERI1+15841TymuF248a+j93mIMCe3LcGcAAHd26jRN9oRfwmdgW3IH8Qcm9PM8zmgE2yLK8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfMeXEoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfMeXEoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD5C4CEF7
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771525534;
	bh=TsjuKfaQRPaSwSOD7XSNnbjmMMLNKdF4ppbtMrwwvvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZfMeXEoj8qvTNvMV0CjZUClr7Hb04jXpimaviWOmwMIn0xTI2319GGS2BJIlcAWph
	 7S6O1L0NwYrFjymnDZjGRDQE52AW6oeLhTSg0ueP1bSuxCxW8+KQdtvoDmsshX0K1P
	 wPmWLKAdD4Q3PJNngqSKiMGMnhsqJZM2dEKsgQsQNNVhqa7V65Ji490kSRCSl9PVdM
	 0WDnjdftKlRsjuWb4oWWC3eNsUJt/rktDnp5Y5L97Xk0OVxJEC9FGagpY8UsNWUa2D
	 Wp4ertGrCB6fnyuxOD/oELm10+CpF+0ZRhGkDDxlamTFdlHzJ2EGmKKnym485F7Wjh
	 wlwYDTOtVMMfw==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79088484065so11682557b3.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 10:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOzg+dzLz5o6NiLMvXWLJ3Azn5jngK2jzDwOO/HxU0Rn2aE17EpWfjo647zxfUqDY1EJ9kDIjcBok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iaktkS40ZYWRuTBM+0IUknExpD5aw5ZnVMQ3VMrj9Yt7fR4r
	UBrWT/Rp2+GnC2v6vXFyUihme8WzUlybW9HjIN6j0sACaw1d3Rn2zxRWCTIFE6QDU+dYWjBwRmy
	huEngIvCBFQjoHF4fAy89kOfCpRxQ9Nc=
X-Received: by 2002:a05:690c:c4c2:b0:796:3f2f:a33b with SMTP id
 00721157ae682-797f71d21c1mr56003667b3.18.1771525533891; Thu, 19 Feb 2026
 10:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com> <20260219022929.3558081-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20260219022929.3558081-2-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 19:25:23 +0100
X-Gmail-Original-Message-ID: <CAD++jLmDnTPcPs4pAYgZ97Q-MWQJqLaRAxZpSqN0+GpGumudCA@mail.gmail.com>
X-Gm-Features: AaiRm52CJHUgUjK6uYiryIzkuKLd6Te7G3LP5cqRsOT1HFhEjf1wPoYa412LqTM
Message-ID: <CAD++jLmDnTPcPs4pAYgZ97Q-MWQJqLaRAxZpSqN0+GpGumudCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: adc: ti-ads7950: normalize return value of gpio_get
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 3:29=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The GPIO get callback is expected to return 0 or 1 (or a negative error
> code). Ensure that the value returned by ti_ads7950_get() for output
> pins is normalized to the [0, 1] range.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
