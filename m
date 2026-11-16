Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823984;
	b=vT3Q6irR8MqwtvKJ8A+k0EqswEdqbAj1rFQyqhXB0cvXVRejlA2YVVbWLSHXfwjQeACH
	 AsWP6KuXI/VFqX7XWNc3E5Rmwab23Q6Mvdp/y2pM1FH5CSo2ZhYx+PfAxn4vOrtGz/diH
	 S06QT0hE5aEZ1W4n+BmonoNRaaA0MNODVxbVTXPFEe275G5i3dkb+ksdOQBqYg0Tj6aso
	 rgdZQ3xi1ZPvLIfRELnWjT/cao7jegzzMyZYWRDFzbyt7BBRRtUwqc9QQQY1N/YcXYonB
	 4GXGYZKOiUGsm3mCairvMZjGgiYstRqJD4MH9HicFablIN1RzPncjzoHDmj2CxljnIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823984;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=YSdYiyUlnvFWz8iXQcw0X7fJk/Cp2zi+hAjZsocDatk=;
	b=LHOGTjnDswtPK+K6Lk/2tA85SrfJQgPV1NAlBzmAQnrOjTD4zDErvk73CXQbfQGVe1AU
	 iGP87ETznormA2RYgiq5y+DWqIXKDUBGK9hoVX1QC4eQ+EyKnk7lmgmAEMj/ZGT0xa5QP
	 E+yiRLu419jbydQUEMokuMaLuLiDHy5TZToxWFLW0sBDY7jpU40Deznq6be4wRsldM4kx
	 OaI+200wmeGtcjIV+Ky+eD6WLOowmwDMOySDTrRSfDCHs/o+iE2a3y8kmrfCEiYkXnal2
	 mlQRzWRhJkePX8FgFxDITkqhqOICCvWFLBvbzM7c6Q36Xr2r7uV0g7DhCrgqIkfvACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmQNe7Yp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E75606A331
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmQNe7Yp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C631F00925
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823984;
	bh=YSdYiyUlnvFWz8iXQcw0X7fJk/Cp2zi+hAjZsocDatk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FmQNe7YpB8jS2dI5tt39gzE4HeTglXC+cKcAuS9svkqaCpPF4CDFtDgedFu/RtbRS
	 BlrA3WsB9d0H+euYkbeCgjqB4qE9WIV6+uiHQP/eIxs70yiYltbni9/QMspsqylrC0
	 Tm33I0T5N6gigsm3TAP3ILpjhdX5UaNbEMdlGtRldTdCxGyS1dsEA2H80pApzAhbKu
	 GvKam8xPbMWialCAgmqUZlKELBmsa3WvzVmm9J8eOrR7XXDXzfe4nw6tjwRxD6i215
	 46bZha0sYMm13aN3Gd/BSuW2Y/rR2BjWe3JmBhONwy3IZAOXJ6s9T4kUaJyIEDN1MJ
	 yBa8JIcUKPySA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c14470729eso2710927e87.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 02:13:04 -0800 (PST)
X-Gm-Message-State: APuU4Z9ZccbthwKSucNhXgSft/3vzAhxq6AYWf5uc3ocU/Vtn/4ytUA+
	mQY8/LORu+1QAHzMO7I/P3nPTX8ILW4kY4ICVHUl5hPNMKRRcc9WG2az2HYPmQcEAJ1qy3uK07H
	lSSmWi0V4jY7rasL9V5o1FOvP4FUVQ1w=
X-Received: by 2002:a05:6512:3182:b0:5c1:5bcc:bf0e with SMTP id
 2adb3069b0e04-5c170b1c308mr3696720e87.14.1794823983027; Mon, 16 Nov 2026
 02:13:03 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116014823.3132576-1-jic23@kernel.org> <20261116014823.3132576-19-jic23@kernel.org>
In-Reply-To: <20261116014823.3132576-19-jic23@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:12:50 +0100
X-Gmail-Original-Message-ID: <CAD++jLnKz41LeMGJjGtsuzB69TfZQhDy0grFKxd3vPh-tsz3Aw@mail.gmail.com>
X-Gm-Features: Aa3M54qobcsJYrMCzCZfCjAScyuFW8KV_4L3-AZSbH3okAaKcNbd9qDJaNqjzTY
Message-ID: <CAD++jLnKz41LeMGJjGtsuzB69TfZQhDy0grFKxd3vPh-tsz3Aw@mail.gmail.com>
Subject: Re: [PATCH 18/35] iio: accel: bma180: use default_trigger
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	Gustavo Silva <gustavograzs@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Tomislav Denis <tomislav.denis@avl.com>, 
	Jorge Marques <jorge.marques@analog.com>, Petre Rodan <petre.rodan@subdimension.ro>, 
	Dan Robertson <dan@dlrobertson.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, 
	Gwendal Grignou <gwendal@chromium.org>, Maxwell Doose <maxwell@maxwelld.cc>, 
	Tomasz Duszynski <tduszyns@gmail.com>, Esben Haabendal <esben@geanix.com>, 
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Vasileios Amoiridis <vassilisamir@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Nishant Malpani <nish.malpani25@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:50=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Set indio_dev->default_trigger rather than taking a reference to the
> trigger in probe(). The IIO core now takes the reference during
> iio_device_register(), so it is not leaked if probe() fails after
> the trigger is set up. As well as closing that leak, this also makes
> the ordering a lot less fragile.
>
> Fixes: 0668a4e4d297 ("iio: accel: bma180: Fix indio_dev->trig assignment"=
)
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
