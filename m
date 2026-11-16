Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823969;
	b=EeVeRszEvimzzd6jRJRwUmE9SlxPqZ8ChrcKuWFDePoE3WIKQj4/J6+0tPz/d6OFwpVX
	 E0pGgj0HtiRj5EEdklzL+KwxujtJIBEB7uhCh6ilSIuB/Y1ER8CbYCDKiU5cONSGIXjH1
	 0YoYP7DfBHm2vC7yP6pL12FLvwsDSw5dIkNP9dVWkMA/jKOQ5FTq0ptuawvzB75Btg6B4
	 TL8bNQr4SfUkZf/8G2Cjh17Rl1xaklObz7JzmtbAvUlYbzdhVbapAqG3/WgEwlam+s5pE
	 5mlErcU9SRTEFw7j+5WCmCZMFz1SNohICGfNCxlWAwUBzYR8708WpfGy02kDD56i4Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823969;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IwTaEG8wRBKoK9MhpvFuHAkc/QJiMSw/2nRUmjR+2Dk=;
	b=O4/hg1bYaCEJcmt+MEWhDB/4a2S69/Y+205oeajQXdh6y8vwVYMaBUo/bhOE119Y6se3
	 S3nbCgzvo9SY8/o0w4LuDODDPvsHic6uYZnzVjQDUe8pbVWxrErrzjD50tELhhOfdla1Q
	 nxNd7BX6QRMyeUMCZlTyMJSK0gCQrp2+RFTh03XWJ7SuAj0768/BKIamDyUYiZbuN4y59
	 d6hBdnfAs7Fts48aa4qQVD5+XlA8pPI4FQSnN+SIGepSn9SgJe4MrpZkpUPqeeuEpmaQ9
	 Bp0gbb0+gwfV++of7DEv0dhG43KREwl1rPnSN3ajpSZ2F7KdOwh0xLkQY6lR328XniA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiwUfSzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C6606A33A
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiwUfSzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657BF1F0092B
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823969;
	bh=IwTaEG8wRBKoK9MhpvFuHAkc/QJiMSw/2nRUmjR+2Dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KiwUfSzPoIIzbkUvQDncL5MEXQebfjbfLOqPkXCHBk7rzG4Nc9Ro9ADE2c+bo1BIJ
	 mw0oaG0vTxzXljvZ8lC15T37PB9udSWS1Z85CO2WjF1SSPIGeJLk/X9CzdQX5UHPw9
	 nS+tZgb38kg4E3eIx36Pj4fOigrZTcUIw0lum3Ruk25xaWnZI6moXYrVnOM8WnTPvl
	 Zo1Finr8R1aLmlGu4ldqINfQ/+WwgS5yKKX8Jz8Ibni19VbumG1qzf45ATEOr+V5qW
	 wleHd1RaAUcbFL/iUnty22f+mONfhou9GPrR57qmbAwG21occ7fp588DDNxOZU/IvC
	 QD+ZaIeKdXypQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso2874463e87.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 02:12:49 -0800 (PST)
X-Gm-Message-State: APuU4Z9IDQexK6r7wBA2Yk8WuTSDvxKAVt+hVjb4Eig0YUp/czPiFnQE
	v11lDKSqENRsr2JLyPL7IuTkCnJ7dceFXizN/KUxUsaKz7I/3NuoSmT5xJroUKp7/JgPhmu2FKW
	1r75cSs5phU19OzG1AUZnL60Z7/GFAfc=
X-Received: by 2002:a05:6512:65c9:20b0:5c1:7c6a:ff03 with SMTP id
 2adb3069b0e04-5c17c6b044dmr1458650e87.29.1794823967992; Mon, 16 Nov 2026
 02:12:47 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116014823.3132576-1-jic23@kernel.org> <20261116014823.3132576-24-jic23@kernel.org>
In-Reply-To: <20261116014823.3132576-24-jic23@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:12:35 +0100
X-Gmail-Original-Message-ID: <CAD++jLkEDfGi3qRWW=3nVOj9jG8DfDYb4=oEu=c2S1WwVY=rvw@mail.gmail.com>
X-Gm-Features: Aa3M54pln9fm0V4dyCaKo4rrIvsBJ2lI-ed5cb5Y4DejM-X2frgFrQOHhJ3kCm0
Message-ID: <CAD++jLkEDfGi3qRWW=3nVOj9jG8DfDYb4=oEu=c2S1WwVY=rvw@mail.gmail.com>
Subject: Re: [PATCH 23/35] iio: common: st_sensors: use default_trigger
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
> trigger in st_sensors_allocate_trigger(). The IIO core now takes the
> reference during iio_device_register(), so it is not leaked if probe()
> fails after the trigger is set up.
>
> All users (st_accel, st_gyro, st_magn and st_pressure) allocate the
> triggered buffer and trigger before calling devm_iio_device_register()
> and do not access indio_dev->trig before that point. The interrupt
> handlers are passed the trigger directly.
>
> The ordering is such in here that their is no leak today, but in general
> this change will make things less fragile going forwards.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
