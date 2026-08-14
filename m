Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8803BCD3C
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737919; cv=none; b=dKlwFEHkRj/zwmrH1fv1OEokrsl/Ca7Ry+1xqD/lggcNdye7nl+/NtTeMUBl4QYSLwTuVLbFwlpjXt8qqVgHf7cg0AEkZpbtJsDYahgKW/9rSbwFuWk5QDT6vYpvmYSdQkVdBemkjvpSU7Z55kx/S1ZgVNEeNYhW6c9MS/72MNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737919; c=relaxed/simple;
	bh=+sXoUIZzNFqKh3QMf4oz3LAeZ4KsfHpXs7jv+EioM9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ihp5zaAs55KWnrRocCKSzWvVEorB7F8cQdWZT1YyWtbFCwnDMbo2bT95wk9yvyMkKc7zMQa82/8VK5lrE20YzK//NzbXlwXa1ZpT+ofqFJ/pFw4IwXe8sPyw6Rcqpn1JiEGP2MKRrpyAi0ArxB6svO3bGPJHqpzrXuuGfuqMjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY6a24cj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY6a24cj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1421F00A3A
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737916;
	bh=+sXoUIZzNFqKh3QMf4oz3LAeZ4KsfHpXs7jv+EioM9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZY6a24cjkAR+Wm1kKa34Sr1L/LJMHWTbfLf9Dj2GQ1IuSz3IG/FpF+9KTDLUnNDui
	 3GACMFahxS4gaGTyf/uIDc5K0jGQgXz4pPK5rqyScrIEW5ZbXELqVkg8l0cdiChtkw
	 5UKkj0yLvzJ4F/Peq7CT+KkkryltnoJIJtkDiZS/D++xHdiJga+5Wv8xxICXdTYDpL
	 kzxPRyzPiOTLD/TuQAl2rfblek4/VjA3k8t8jrRC5CzpSbbHglVlH8vg+HTmwDut3l
	 X509alsn0UJ+czEWR43hG9D/uN5+9Mm9fV6op+HRPSQ1KPQLR+JWKWy2YsZyLh3G2k
	 7qfBk2DiPmJqg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so1224197e87.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 13:05:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpr0Mx1p++vTnFQ6v2FdHH/Y0QzAM3k1fPlavbni3EItphxGxkM8/+SY9nW3iNP1p4fZ6q006VFr0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YeByK0CiJfCKI7t9WtDWmXKT+Ag3eIlvo6wSe9CkeHH6bKcO
	rlfvlrLBVCLkPQWIs0GK9/ALVLQdXdILPE8HN4mCJHjqDxquokqsC5f7mw4gX5xjy8VECtH/7mr
	zaFOxn6we91RX/cprojS/m0YEbzj2h3o=
X-Received: by 2002:a05:6512:1310:b0:5b0:eda:de26 with SMTP id
 2adb3069b0e04-5b45915e3e6mr1235244e87.16.1786737915353; Fri, 14 Aug 2026
 13:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814134111.1387580-1-ruoyuw560@gmail.com>
In-Reply-To: <20260814134111.1387580-1-ruoyuw560@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 22:05:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLn9pTJKsSHWE0BEh0xMkck2L4+fRn1+MrXoF5nWsK=cSg@mail.gmail.com>
X-Gm-Features: AcwNN1VrxUNRpejM3Pi57Wr_Nc2Iy1jjIR8wysbR-sZhiC4yY_vkFh-Dfvryn14
Message-ID: <CAD++jLn9pTJKsSHWE0BEh0xMkck2L4+fRn1+MrXoF5nWsK=cSg@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak on trigger errors
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:41=E2=80=AFPM Ruoyu Wang <ruoyuw560@gmail.com> wr=
ote:

> The first user of the MPU-3050 data-ready trigger takes a runtime PM
> reference before configuring the FIFO, sample engine and interrupt. If
> any of those operations fails, iio_trigger_attach_poll_func() tears down
> its IRQ resources without calling set_trigger_state(false). The buffer
> error path then releases only its preenable reference, leaving the
> trigger's reference held and preventing runtime suspend.
>
> Use pm_runtime_resume_and_get() so a resume failure does not leave a
> usage count behind. Route later setup failures through a common unwind
> that clears hw_irq_trigger and drops the trigger's reference. Successful
> enable and disable behavior is unchanged.
>
> This issue was found by a static analysis checker and confirmed by
> manual source review.
>
> Fixes: f11d59d87b8622 ("iio: Move attach/detach of the poll func to the c=
ore")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
