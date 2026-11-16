Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824019;
	b=b1ji2yV4yZ8LqnGkbIho+usD4YjEE62/4jYPWCaE0JMcp7Jc1eKwHLV4h4o91yyE7V+a
	 x9cVz14dF/8BJqFYlktGb/5GryURd8iEogMippiQeEbUz8U1Z/HoajqakyxofeuY4v+FY
	 GnFBG9E1IVBaw6jtQTmEGmq4Vhaub/MHmqJkwc+yFABKE64Azz7t7BWZS7AU32XPdPX/k
	 e0synbYDdXWgJK/tbtE6KPHuIfiiYnVrJVq33u+IjfK7jkyMhhpOPViSeBdglJcrQ6Y53
	 dmsthXbZq2SjSi20d6P1Ny2ATUPZRM/X3u6xcPshM/VkdNgCpjml5NSq7X4SPaf85EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824019;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dvvN8xAjOZj2qJ3T0RWutZTar0lZaTKJFlwYsylUpC0=;
	b=DNlquxs8vigKzyiAHNTiLCE7cq2EDmeyld3jQIoxX+z6BR0Q3fev0XeUD9+ee9XyoP+2
	 OpzaDrvYu0bTFozbjuh8UO//v+Uk9jUhfp9qvFH1CHcGl50T79ruclBAxaC7GuLE5l9qv
	 7DcX94yJete17VJ/nS6pRdpY74kRaagxKdxsceF7yNk962PBpdiIlI1PEpLjTNH0yPU8q
	 pGwUnpaqsEz3FNdfzalWi7g0Ec0OdkL6EE92XLVJqyWPKs1t2vdOwp7mZu6d9oOyfkqWr
	 k7YaNnbHUZ8UsCmhOLagPvcVy2OTWktkSCAGz9a5jzA/vEJhqiIyyX01DAL6OrSm6yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHwg3Zwx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAB606A334
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHwg3Zwx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBB01F000CF
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824018;
	bh=dvvN8xAjOZj2qJ3T0RWutZTar0lZaTKJFlwYsylUpC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LHwg3ZwxbN02r6fIxteD1RvNA6Y9pOXEzqlzC3sUB8AKvy7RcUsl3uIzeTc/fD063
	 2P+KJVBQFEj+Uv2PFLCu04PqFi6/Q6oMHpn05+JBvjbV32bART7CHGqJnaX2tm+nBV
	 SPoqccwRAJ3Z2+3cAPz/RXYoENpQ7U103MANOoTLswJKtdn33JceG58bN0ha4Jjlvj
	 8VOYndx5KQnTeZdRcJkXfBjroGNaMQ/hrI7AidEfOFnFLtxApePDuAnfmVp+0Vr9mm
	 zupozQ/X0NirjLDtd+2jC9D56BkEqWPZxMdP0YkDpG0Fnl2SWSvuRjAomX3EHKVUI0
	 QCal6pu/6SgCg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14f3dab09so2027198e87.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 02:13:38 -0800 (PST)
X-Gm-Message-State: APuU4Z/E46WyihhHNjD3TKQjYxNvsLz9BLc7F367kDx2V0ik/Khxq4wr
	MM/hL3bUQdzjBFLOnzulIoycuFQrNLIQaXdkzXxSNrPaZi/t/Rtdo/0Co2CoK1t4cniZO6trhbv
	v9/0yGSqtJmDxpRIzjpoWgt5EskoTv44=
X-Received: by 2002:a05:6512:224e:b0:5bf:d000:bca3 with SMTP id
 2adb3069b0e04-5c170b20ec4mr3464665e87.49.1794824017275; Mon, 16 Nov 2026
 02:13:37 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116014823.3132576-1-jic23@kernel.org> <20261116014823.3132576-14-jic23@kernel.org>
In-Reply-To: <20261116014823.3132576-14-jic23@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:13:23 +0100
X-Gmail-Original-Message-ID: <CAD++jLmz=30ptZ12qZwP6_-3Xbv3nta_VBg1Zb1QA9an3bOfwA@mail.gmail.com>
X-Gm-Features: Aa3M54oi56LPPit1kNG3TyrHHkUySoftJp80E4lui0_LsVjTYMRYknwsXP58xFU
Message-ID: <CAD++jLmz=30ptZ12qZwP6_-3Xbv3nta_VBg1Zb1QA9an3bOfwA@mail.gmail.com>
Subject: Re: [PATCH 13/35] iio: accel: bma220: use default_trigger
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
> the trigger is set up.  Whilst this patch closes the specific
> bug, it also makes the ordering less fragile going forwards.
>
> Fixes: b7e17ca10793 ("iio: accel: bma220: add interrupt trigger")
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
