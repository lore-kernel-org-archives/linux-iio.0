Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2052EDD78;
	Mon,  8 Jun 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939461; cv=none; b=JDuW+C6gxEqfJuUNMW4YbO+GyTWWTDZN7RbQVctnPNyldiVsNi4z/Oho3xaAizRvF57LU9OylHahmrL6Ig/LiStymmPLWx3k202KxBrddAwlzzEP+8GeIfgVwkLtn5X6pIBeGUSKzd1nIdS9eev5s1pOyPOY56J5QZD1WwpJQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939461; c=relaxed/simple;
	bh=WNmVS5VawhaahrzvqG0aiXJb4F21D6lnmTSldRQsX6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELC3irLYCLYYUbnkEjEAbmyYwXybEAvs6bB2VM4sG9dOKLfeE6msYX/iIUVIfiHmOVIAPt/692PZtV6toE83DaqPQGTsAhSR3HM86tvoJ1DA68PLVpOox4AUkAE7+yZgRwGihuMx/aQigJccoVZxhAFAj8o1axX4ruTWocv0p90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdCktzIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdCktzIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4BE1F00893;
	Mon,  8 Jun 2026 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939460;
	bh=Zoy9HQ8zG0P47Kaa+inqOVSs8dqOxrs5w7lg2m/ljlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hdCktzIQlomEnH98Bre1Wl7wmEc+vO/Ju0hkgq/CrukBC4QzagWz3u2lCry0CsTqn
	 7ruBm+GNDy9QVXVFGiQ4j8JXLmxlW78A0rt4qOW9WDw+2rUNiEkplk3CO+7mfkmChl
	 dMJqn5Im9RGhgaDubUiGZcgRH88oV4g7WeJeGo1XCS1O69lLV32hDrnLeDkhur4yE0
	 nhrFggpKaRfN4RgO7adTzcoFvmSwNga/v5cY9LLSho6RYmkk7rr5nTx1M6OxMULDS8
	 uGBqwWQvBwiWLo3L6OPcfdjpPNECXHVgxt4pJF5cFOzWTWAJV/5fh3BYrVnNFAox2G
	 BYTXoewD9TjMA==
Date: Mon, 8 Jun 2026 18:24:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Wil Stark
 <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: temperature: tmp117: Support the TMP119
 sensor
Message-ID: <20260608182412.4738f1d4@jic23-huawei>
In-Reply-To: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
References: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Jun 2026 18:00:23 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Hello everyone,
>=20
> This is version two of my series which adds support for the TMP119, which=
 has
> an identical programming model to the TMP117, but slightly different spec=
s and
> electrical characteristics.
>=20
> Best Regards,
>=20
> Romain
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
Hi Romain

Other than the DT indent thing Conor calls out this looks fine to me.
However, unless the cycle is extended IIO is effectively closed for this
kernel cycle. Anything I queue up now will be targeting 7.3 now.
On the plus side no rush for v3!

Thanks,

Jonathan

> ---
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
>  drivers/iio/temperature/tmp117.c                         | 10 ++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
> ---
> base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
> change-id: 20260605-tmp119-662d21e4d317
>=20
> Best regards,
> -- =20
> Romain Gantois <romain.gantois@bootlin.com>
>=20

