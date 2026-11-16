Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824059;
	b=0OlhTBj4N1gLdJskxW1Rbwt2LpQnvXjl7e0dta24UllNFViZVVpu2/d3eajJsXeEcaus
	 7OCOGfCc8wvmjltesj3YZceqrnNOkRVsq82w1nLiTsaGKB3h5JcXCHStDZ4dsbHbuiJr7
	 SYFlFHX/Ki6XL4jfi6ddIJslkloqhPYDIwiNMKeuiEo392hFDbWByItUS2C5LTsCZcHPt
	 eDdF/igjXbGUhfUt9WwSSe+Gpxgrp72v89bLtgDKrbsCzZwyvO8qr+gDywdP89dJK5fe2
	 86d5QzwiK679FW9RwszlD5V6r7e+D3F7APvnDy+GB+Z1UOkt94ilekYOb5FD1CPOwgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824059;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BZzHsumxcgOWtim9VqzUNbgAn5hXsFY8z0Dp1dc6OzQ=;
	b=LPGNC0b+lCjsQUIcqVqmYcHuXPUlKNiXCSqVdnXkx5fG8Ew8j0kBYrxSqZXoLQrzXi/8
	 KqVvI5VoU3RGniMslrPPdMiPPL28IAmDpb2/GwydQCp6T6Tp3Rzp3PdFrbmKT7nhqpM84
	 zqx+lf1j4hC6oknLkh9u7ntj5NrnBrj2n4CqsOL2VsX2bfpm67UQxqXkFxsNgD3H/Jelt
	 TD+A4uCQ4lBMMe/EiuEd/M8A0fOYgPbTi0SQbEAXXv712cVGi8k2BG3GrbyD49X+DXNQE
	 7tC51A84Yo/g7ywfJQ1i0lIsZ8efTGDtjwvE7BxMoAPJjPCYIhb+064hUHlosc/bjhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oezlQ5JP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B801606A323
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oezlQ5JP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767DB1F00930
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824059;
	bh=BZzHsumxcgOWtim9VqzUNbgAn5hXsFY8z0Dp1dc6OzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oezlQ5JPj4CYiV6ain908larzCb/hez4Awd0ILTk49jaVy/RMRZtx+AaF0cbGt0Dx
	 4wAnOMH+Tb8WjCzjUOoLKo6mxsMg+VdPm2nXDBXfZgJDk7zGoTKXeaqTCxWyy53g+y
	 eYSH02Mjz9rqwg5rqdHPOqUgWRGXPW+d2xmfnofgowFMFXTONIM66CAzOGCJr1h6j3
	 +hiT6Bi5ryi7rUNrRvY1TTa4ETy7eKiU7fUWATcS+PXMWuhGUAMhsAT/ZofEm4LObf
	 2KSa0E/JTgcPP9mPJK2vXt7NDeanTt1NVibXyAMLkz/x9gYtqEP389b8wBbyMg0C2Z
	 i7x3aZ6TKNL7w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c14e307f29so3768938e87.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 02:14:19 -0800 (PST)
X-Gm-Message-State: APuU4Z/tLNcw+TfoelG5jieYAEPBJsjsxBH06n4WdP/DCzYZc/XSgFwA
	HF6FD8Y8jmgF/k94/XZY7H8fvqPnKUUp1pNkUZnRUCNYda1F2ASxH6cXXuX0lJJEFmf3A0sKJgG
	FPC9glR6r+5m2GE+0sThl7074EtC28QM=
X-Received: by 2002:ac2:568d:0:b0:5c1:597d:aa93 with SMTP id
 2adb3069b0e04-5c1709f4d9fmr3837170e87.24.1794824058184; Mon, 16 Nov 2026
 02:14:18 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116014823.3132576-1-jic23@kernel.org> <20261116014823.3132576-2-jic23@kernel.org>
In-Reply-To: <20261116014823.3132576-2-jic23@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:14:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLka6iViPZetASEx-P1EUM2o+rK7qf6hi5gMV1mowGGArw@mail.gmail.com>
X-Gm-Features: Aa3M54rZ0ybcg4V5aKB01QbjbOok1gJ1DSyW-SPRyEtOWR9BL0YJ1PmZWar8GsY
Message-ID: <CAD++jLka6iViPZetASEx-P1EUM2o+rK7qf6hi5gMV1mowGGArw@mail.gmail.com>
Subject: Re: [PATCH 01/35] iio: core: add default_trigger and take reference
 in iio_device_register()
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

On Mon, Nov 16, 2026 at 2:48=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Some drivers choose to set a default trigger in probe() via
> indio_dev->trig =3D iio_trigger_get(trig). The matching iio_trigger_put()
> is in iio_device_unregister_trigger_consumer(), called from
> iio_dev_release() only if indio_dev->modes includes one of the triggered
> modes. If probe() fails after the reference is taken but before
> INDIO_BUFFER_TRIGGERED is set (e.g. by iio_triggered_buffer_setup()),
> the reference is leaked. In devm managed flows there is no simple way
> for the driver to drop the reference on error.  Whilst it is possible
> to have enforce strict registration order so that the reference is
> only taken once conditions for tear down are met, the requirements are
> not intuitive. So move the point of reference acquire later in sequence
> to a point where cleanup will always happen.
>
> Add struct iio_dev::default_trigger. Drivers then set this without taking
> a reference. The reference is instead taken in
> iio_device_register_trigger_consumer(), which pairs with the existing put
> under the same modes check, so they always balance.
>
> Also check the return value of iio_device_register_trigger_consumer(),
> add an error_unreg_trigger_consumer unwind path for failures that occur
> later in registration, and clear indio_dev->trig after the put so the
> subsequent call from iio_dev_release() does not drop it again.
>
> Immutable triggers are a little more complex and left for a follow
> on patch.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

I like the concept and reasoning here, and code looks good so a clear:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
