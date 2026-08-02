Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C023C2D
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706245; cv=none; b=G29aBfgSPJYcOUe+Bh6nBvt5QoIwrAgS95Gv609DRhivO8pF8tI9hY2JekarC/z/BnWMhr80KlM/zawoS45rVe4kJLcFT/vC6H8U3PpbVW/t6q22l+SwXvCtGkfs6r3ck9pP2D8opF1CdfVQl0eSe+hjw3ghK76wL/qPSzkZdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706245; c=relaxed/simple;
	bh=3ERM+5ebJ3QggCt+IqpXuH/xRriK3iW+E6J9HVJBiiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igOWELvn6rrBewIUDiszBP7K6u5+EOkvu2/JUvsE6+fJ9k561hjR6EQbx5FIURH+5MvnQ3C9OSETACyj27poAdRjeFXZXCTjHrGTHUzzUvdq84kuzTg9G9+7KhAAH3eD0OhqL8dpsVVn9xlMCLmiQ7s8RTC58fF3XnpsH7m7S3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OObSaILx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OObSaILx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835051F00A3D
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785706244;
	bh=JYejFk6oi270c2G7kYnJaTLzFCKL1TN6flHz+VLwlqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OObSaILxMLr0QNWT65IP15TS13s26vGXsE58kRV4XTq4XCfh5a/AqZZWc6r5WvnqB
	 WpPTveQYXGRVi6k7/qqfUCqo5ayEL7PUNHebRdIZU6j1vKm9jzxteIjH1NQ7q0nMly
	 V0x4a5jRAkY5yvXb31FmPjnwD2chVeJhbwrSDz8mNctK77nUiuAhYIdRGHpEFEbc5C
	 NjuQ2S8zAENTOs54rg2mFINvuHufwZg1zIfsDAa5kKlDoei/eLnKbNAxlNJ35oAukl
	 Q2dJ72cy3TAQEzNAIpkFmz/DpT4Idu0yvZoEsVeKuxbvHMfbmigtHEDXBS2y3C6eqc
	 1CzNqzK+glQ+w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aec6360133so2475688e87.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 14:30:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoiJFPbsD2aVOVSicJ4XitTFcEQ20FcWgmfyH06puqLSDOt0zIvH1CVOkaPmiTzRm8dAj0EavF20Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9T0b0Cuzn43VvmxOayvcUsM+L87IafDWbX7GHqClVWQkNSFaM
	mpERRFHYvMFgJWQJbmSVJNb3LvGWGbyUM3PXu5uKf39FKXsQcRu8FT5RtZvqp45CtID4gQm+B9Q
	9QDxw/8dA7OWK5lNorw2R9+YQkIUw4jE=
X-Received: by 2002:a05:6512:2553:b0:5b0:1ab1:263a with SMTP id
 2adb3069b0e04-5b2e4f9359bmr971692e87.55.1785706243330; Sun, 02 Aug 2026
 14:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802065540.8120-1-congnt264@gmail.com>
In-Reply-To: <20260802065540.8120-1-congnt264@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 2 Aug 2026 23:30:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLmdgtA=5z+83jFivgbDNnrh0f5C_YNnHdZw_FmTJc2ZgA@mail.gmail.com>
X-Gm-Features: AUfX_mwF3NePZgakiWKnSGGEGuccwmYZ-hE2GPaJv1BFI4VjtgXY8RH58kKFJq4
Message-ID: <CAD++jLmdgtA=5z+83jFivgbDNnrh0f5C_YNnHdZw_FmTJc2ZgA@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: fix sign of raw angular velocity readings
To: Cong Nguyen <congnt264@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:55=E2=80=AFAM Cong Nguyen <congnt264@gmail.com> wr=
ote:

> The MPU-3050 gyroscope output registers hold 16-bit two's complement
> values; the angular velocity channels are declared with .sign =3D 's'.
> When mpu3050_read_raw() handles IIO_CHAN_INFO_RAW it reads the register
> via a big-endian regmap_bulk_read() and assigns it with:
>
>         *val =3D be16_to_cpu(raw_val);
>
> be16_to_cpu() yields an unsigned 16-bit quantity, so negative rates
> (bit 15 set) are reported to userspace as large positive integers
> (e.g. -1 becomes 65535) instead of the correct negative value.
>
> Cast to s16 before the assignment, matching the temperature channel a
> few lines above which already handles the sign correctly.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
