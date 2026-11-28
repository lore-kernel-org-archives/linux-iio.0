Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795839831;
	b=LzY4SR+c+U9VOaLJYhBL5jLT/gaLqO4DkDzu8IMSvd94FNBbWVnrNjdUAWIWOalQ7Cgt
	 C7C28pfQ1sk8BsH3KdefutAcRwp0DLUtaVcFdR/IRoflsDsQt7jFC4KlpExC4dsvxM44o
	 r2e2cI6tHqr+FY907sB1z4yBtA/CLuYzeyXCRDUNpTG+Xh93aoC451bNGgJWcvSqGoPbU
	 v7T26IwanLNVJNw6a7aCNPYxzAZTl22E9TwVClN2uhNbXWHZ0prlF03Awupotw2N8y5CU
	 40pETLDZQP8hrs6nuPpHBvndjYAaDVPDMi+JJmYyo46w4yMgTpkk4a9/e78TU0zgLmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795839831;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZoHJQSosCyvIzVC9AlQobWPkr57eSEqy4IgYAS/z+IQ=;
	b=JXhGGUMQ5GXe+TeOjOjxdSe8oSvhnuHkBjDKtxF1P39913QFJiPJ1cy6P25E1Q2jxvlC
	 l5ieyKNDMVevinU1Dn3ik0OIOKUzQfcNOqj2IbGVNPXfot8iGkgKLDQnaZhHXwVt46Nyo
	 YEHFJ2ALzzkT93ECz5VKtEuEiHEzolbEMwGbzlSrtvtsmk4P1kXSBtTKHelrI1aLM5mtb
	 ySBVI04np9vtY1SvaantPhjZmx2CuAy6q0PdN/pGIipnyg0+uAT4sYLYShzNR2Yz15yRX
	 yzpezB18IU72DnOltOEA7mxl2/CZa+DlqCia0HW51GYXX0FPby7UaCK5arqxE2pSaag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1AlqW4e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A0606A31C;
	Sat, 28 Nov 2026 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1AlqW4e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CA81F000C1;
	Sat, 28 Nov 2026 04:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795839830;
	bh=ZoHJQSosCyvIzVC9AlQobWPkr57eSEqy4IgYAS/z+IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D1AlqW4eeDJW30Apa5/NHcVGCQXfSXCFz7glQ2ll6icKWlmKQtYIQK8V5NbIwegCW
	 s2OxLZgdcqeFkPBn89arIZanFBq0rffYJcDkznw5JT5wD/yiJeeGUPgl3gAO5BYgWn
	 c8UJuk2y+3VoN/lOilk9vLW6Cuah+Kzx5U1lUTF2mygrSDv1ilBN391+dT4l7O3wfc
	 D4Y/MifzfcPfCH6YVB5nyfXzhPbBeA/+HoKe0x09UcA7Nyygr1iWB1jiP+JsggDHrp
	 HPin99kQkiOSwZUVdBKZtMhtXnVF8b853oxeI4/3aSebSBz/1SJf+k+VrzaCgklEXa
	 yocE1TODeLuqQ==
Date: Sat, 28 Nov 2026 04:23:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Adil =?UTF-8?B?SMO8c3Jldg==?= Tepe <tadilhusrev@gmail.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <joe.skb7@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Exynos850 ADC support and soc thermistor
Message-ID: <20261128042345.42419711@jic23-hlaptop>
In-Reply-To: <20261127223213.2481987-2-tadilhusrev@gmail.com>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
	<DN5A4ZMSEDUO.FUSGQTLBRYFN@linaro.org>
	<20261127223213.2481987-2-tadilhusrev@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Nov 2026 01:32:14 +0300
Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com> wrote:

> On Thu, Nov 26, 2026 at 04:23:15PM +0000, Alexey Klimov wrote:
> > Regarding number of channels. The Exynos850 spec says that ADC has 10
> > channels and, looking at the registers, the ADC_CON2 register (offset 0=
x4)
> > lists 10 channels as acceptable ones.
> > ACH_SEL bits [3:0] field in this register wants to see numbers from 0b0=
000
> > to 0b1001 (from 0 to 9) and lists numbers 1010 to 1111 as "Reserved".
> >
> > So, I tend to say it is fine to have it set to 10 if it doesn't trigger
> > any hw issues. =20
>=20
> Thanks for checking the spec. Then 10 is right, and channels 8 and 9 are
> probably just not connected on the XCover5. Reading them caused no
> problems here, so no objection from me.
>=20
> Adil
>=20

Thanks. Applied patches 1-3 to the testing branch of iio.git so they
are lined up for the next merge window.

Jonathan
