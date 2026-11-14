Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698671;
	b=Rn/qrNlSjHBPC/VQD34iGBekmQIjtIFHZ53GmCXhKaWIpy0H8qKnF3nMk/wgG5soaU7/
	 5OkivzhZLyX2v7/CmjipdokDBIY+WbT8H526ruV5V5y3NU7cEmos2Q0J3/r22LhBU8Q3V
	 6/yBYOUUJpK9UgDHalk+BwSMO+rQI0N2ymIfQYgTKS1Oii6VgsvxP0pIpxB21pQSTCkpF
	 lokUviFtqc0N41j4oSGXmM1VGEudQ9ORq7YUX6CEce0d77KU6SdCGf74wL0BUCa9HxJ+g
	 7fDfkNSJuOXznY4jn5LgeE11lHi1mN8l+EoVxHOlXp5ZO3sX5GE1NgSS7xfcGoPrsaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698671;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=I0wJjj9r39DtPR6oPEdznuLKIbFuyJ86uQKq+osTTvA=;
	b=y6K4i02PWD0U1SfOzc6DBblabdbQ1KRNlbWc9YfcaWPM74p3x3lf7n0B7PWLUklx/wzh
	 xgDwjZOoO3jJ4PqTK6+xNKOtxm7GdAkE6pXXYeKkXljM48Dhakdjp5hiqEmGMY3D7MQlS
	 TdF/GmOfGl0oODDehhifXVj4di5+PhnJ5/fGY3hm7ARopXu2Bejoetzvx+RUa9VtgElOE
	 QscZUcz4J/zU5j3Mafy0lTOxJ4W8jVeRznASdlsA+3B+1fhL4EvJmdWtkuUqJyOfETHsf
	 Que2N+1gbb21sPtVeLCY5/r+klWw50fTz7flGexxE4uExLn8fprLgZ99l2BanN/o0jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1hklzuC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317A606A327;
	Sat, 14 Nov 2026 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1hklzuC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998441F000C4;
	Sat, 14 Nov 2026 23:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698670;
	bh=I0wJjj9r39DtPR6oPEdznuLKIbFuyJ86uQKq+osTTvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X1hklzuCP05K/fIBd03AXrrcvXzV8pPQjNoxtKADw0/s1jrDhUxMHSPYp0xfLeYMH
	 p7yPuXR9zICmT03DgWzeq34vwhQZ/dWyJrZDYxB16JVf/op71X1YGywmNUOMS0RmZ3
	 k3N1IL7Yf2q2BTOmz6swwHQYZ/6sHPXVXrdwH8SsjLwZJSfR7e5YjWqGXltpqSpc+c
	 rkSIuFXHpabhkN2LgF3Nl/0MvFeiXxWMhbviTutRLAEvu+50nk5PaxnK0YYJPPlTcH
	 P0E88S66pR2X1Wc/QJqACCel9p7LhFxGlqjDADm92i0oL2LNU1ioIY96EEXuEi0o/r
	 Qxmg/yyU7Ytxg==
Date: Sat, 14 Nov 2026 23:24:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kyungmin Park
 <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: gp2ap020a00f: Add GP2AP030A00F
 support
Message-ID: <20261114232423.4a3e8a20@jic23-hlaptop>
In-Reply-To: <20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
	<20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>  
> +static const struct iio_chan_spec gp2ap030a00f_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,

Shift = 0 is fine to consider as an 'obvious' default.

Though does make me wonder, why are these 16 bit values being
stored in 32 bit space with no shifts?

Upshot of taking a look. I'm not sure they are are 16 bit unless
the value prior to the potential * 16 has top few bits empty.

If it does then the dance of putting this in a 32 bit store makes
limited sense.

Please take a look the data with and without
GP2AP020A00F_FLAG_LUX_MODE_HI being set.




> +			.storagebits = 32,
> +			.endianness = IIO_LE,
> +		},
> +		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
> +		.address = GP2AP020A00F_D0_L_REG,
> +		.event_spec = gp2ap020a00f_event_spec_light,
> +		.num_event_specs = ARRAY_SIZE(gp2ap020a00f_event_spec_light),
> +	},


