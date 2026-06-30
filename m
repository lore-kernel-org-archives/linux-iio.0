Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D729C327;
	Tue, 30 Jun 2026 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863622; cv=none; b=pos7tgppLmx2FhzRoKygdo95oCu937LNMWil2MeT9XOPK51N813/fCX2QeXGRU2NEP5NBjB9ROsd1MD3yaZ7lwEQwbE/6ZajLZr2PTGH1VGEGacH0WdLYA8vcZYxn8wSpDmKWNloExtFGZ5QxTIbuV4Ql6DYnV/xXEfRFVT5ueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863622; c=relaxed/simple;
	bh=7gKbmnGIpQ9WuAylnoMNyOY2DitDJcQ+W2YkiF2Dbpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJC6qH2e0ehuSlccA6ThRDkLjY/2wrqxsDJT85Faz6Xi0fHTloF0+bUbjR616y+lpbD+H3O7tCz8cjB/TSYVqKnlmek0+IIgHmun3PCJ3X1fAi09X3Wot53+4KqiAg740rkNos1NUccZYHN9G0x06m1oCvNMzgbUJMo6d8ysuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3i3NcY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3i3NcY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E1C1F000E9;
	Tue, 30 Jun 2026 23:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863621;
	bh=Eny//YK+BUDo7G1QB+ebHjNj3/Azc6sGf0bjX95n1Wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a3i3NcY66MuleE9iW034KQAGJ1ATWM664H5d2qNODUNYJGbDZXQiXb0VCHB3fB/lW
	 wgVPKozYTMlslXPOS0xvca40AAOd+Ff7hN08oGm8zqrx9uXevxq5g4XLVt0UJSdW4Y
	 7WP4o7MR2f7V2f8qn/L4USiNdCSFnYXPiK4HcO5ZG5hcTb9q9Hn19GS+t6esEygoGM
	 TzEmftd06c5fSzgHue10Yf4t5tTcNSgJN3eX2cXnmm8Cq9A/jvRG5bYXDt4blp/rpt
	 LbONqwGSIikXVDy2lsCEmRpqolE9DP8SUYPUODF/L0tjJ2PJhUv4MmUpcmn/uRBiyd
	 lXAAIZhAy+nVA==
Date: Wed, 1 Jul 2026 00:53:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Wil Stark
 <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: temperature: tmp117: Support the TMP119
 sensor
Message-ID: <20260701005336.33b1ed7d@jic23-huawei>
In-Reply-To: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
References: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2026 11:26:33 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Hello everyone,
>=20
> This is version three of my series which adds support for the TMP119, whi=
ch
> has an identical programming model to the TMP117, but slightly different
> specs and electrical characteristics.
>=20
> Best Regards,
>=20
> Romain
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Applied to the testing branch of iio.git. I'll push it out as togreg
for linux-next to pick up once I've caught up with my rather large
review backlog and anything applied has been through a bit of bot
testing!

Thanks,

Jonathan

> ---
> Changes in v3:
> - Corrected indentation in device tree bindings
> - Added an explicit inclusion of array_size.h
> - Made sure the correct IIO device name was exposed to userspace
> - Link to v2: https://patch.msgid.link/20260608-tmp119-v2-0-30c3537d5097@=
bootlin.com
>=20
> Changes in v2:
> - Used ti,tmp117 as a fallback compatible
> - Made sure the correct IIO device name was exposed to userspace
> - Link to v1: https://patch.msgid.link/20260605-tmp119-v1-0-349f45f17d12@=
bootlin.com
>=20
> To: Puranjay Mohan <puranjay@kernel.org>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> ---
> Romain Gantois (1):
>       dt-bindings: iio: ti,tmp117: add binding for the TMP119
>=20
> Wil Stark (1):
>       iio: temperature: tmp117: add TI TMP119 support
>=20
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml   | 16 ++++++++++=
+-----
>  drivers/iio/temperature/tmp117.c                         | 13 ++++++++++=
+++
>  2 files changed, 24 insertions(+), 5 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260605-tmp119-662d21e4d317
>=20
> Best regards,
> -- =20
> Romain Gantois <romain.gantois@bootlin.com>
>=20
>=20

