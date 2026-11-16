Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823883;
	b=rkGmY8Fpvg6yfoGC373R9jFhvQOi8BnZz6JElQG6TaOOlJPgO8Kq9TAJP7Sw9XTnFFer
	 N+4c4q05TEo1WCGscY/FmeBDe4P/zdxtI0wkj5K5Vu+mTQ7Ze86wg6Bwd+dYtwT21PXRv
	 EDzj9WdHfhQ2hez6T07R40EFz6A4qzdRq/HxoXnQz4kz4pQOBlrwJaTRgiqaszwRQdzi7
	 /VdhLoj0WYYceIhO6HuHIiGeny2fVTZwqBZU/d7YDTXZTM3eckIEE/VcDmRQ2fe5DOYAs
	 kM5rFXoZyLsL9DvsrNUadzMXLM0ZT/u5T3pRjKbA7r0B/XYq6P5lyB5MhQqGEqwPR4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823883;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VDdgEqnnBqULx4MMS3GYki2TX5m8ZiMkZgjITNIXXPk=;
	b=hrD//qb+8pkonbf97I6wvB9Op5FfULWiPgt39WLKImXRzKZWIQ9ivlfnJNiJtZ8rNzTI
	 RsIWOqQelyTOpn8JMPOUt2xZ2YiuuWo657ATZkQQDTlSttgNI5j6ifek4uDMeySmHyvzq
	 gr/RGnQkaWn9vDaKX7lWo9GVALPfhDBEMFlLN84y84v/rxe7F+ztf1NL4mvQLN2+KCgq2
	 NvrVYa9GADyTQH5998j92+8Di1h1ReMOgvcU+QAeoHxEZ0Aj52IVSKRzSYZCIu2Ri21Xq
	 C2IKx1ybSLQiadr7Ui1cbPvT/IUmDOEmJcCmnv4rYwP1puWVQj/F/IrkYeC7FGraCHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCaYX8wD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D3606A881
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCaYX8wD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3481F000CC
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823882;
	bh=VDdgEqnnBqULx4MMS3GYki2TX5m8ZiMkZgjITNIXXPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UCaYX8wDkoG/uPWL4VuP+5qxOf2y6Bh6MtWUnVkZXfp0lYL1cA2TAAZEWexa9q+2m
	 lrFRfpUrpm5SPDSxqPhh5NllKtttj0wMRQouDrDnHIlohwfhSkH42DpfUwOeZS8+k/
	 OzV0DHUTvUJaNE7vX8GL5r0a5VTp1ciH+f+Vw8rD6m51kKw7fcuQiNuTI5AewYiRXd
	 ciNKrMW9BEmJfLFdWkuWNTznhsfmcTC9Hk1EDU8HMQZ0Gxh7FGotgfhiKjRWjOb4QF
	 WE8QMyU2kxWOBA71kZyJoyWUHQuqE843UvQREwm4MiDCe1Zscvoj7AfBT2+8f9GNzC
	 AnLPNWC0lhAXg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c151178f0cso3097125e87.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 02:11:22 -0800 (PST)
X-Gm-Message-State: APuU4Z/HF+7/Qz+vsStXuKmeiktEfIoZcRR2qWneHExlRS9zrD5L2+y7
	R5AU23UpDukmT6NBwOa8NP8LQ3s67HC4ETR4OQbFK1TWV+/55EiY8DvQT64yekktuAEtT9tR7Ws
	/7hAXxERY+2saxTx5Uii1kkLlFktyreA=
X-Received: by 2002:a05:6512:618a:b0:5c1:5278:f9b7 with SMTP id
 2adb3069b0e04-5c170b1c7d2mr3708890e87.20.1794823881151; Mon, 16 Nov 2026
 02:11:21 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116014823.3132576-1-jic23@kernel.org> <20261116014823.3132576-36-jic23@kernel.org>
In-Reply-To: <20261116014823.3132576-36-jic23@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:11:07 +0100
X-Gmail-Original-Message-ID: <CAD++jLn0gq0FL_5L1QnviPw51tRSzc7Kr59BftRrmZi2RkqNZg@mail.gmail.com>
X-Gm-Features: Aa3M54pHeJxrP1Fk6URaiwULFWhJUnkhNel8D9qfG2FXtEuyt-fcPVVKRf0PUWc
Message-ID: <CAD++jLn0gq0FL_5L1QnviPw51tRSzc7Kr59BftRrmZi2RkqNZg@mail.gmail.com>
Subject: Re: [PATCH 35/35] iio: gyro: mpu3050: use default_trigger
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
> the trigger is set up. Whilst the ordering is such that there is
> no leak in here today, this will make the ordering less fragile
> going forwards.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
