Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98717C211;
	Wed,  1 Jul 2026 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868283; cv=none; b=SzNEB+8G0wZ6KbNE/lfgNsFqNPRoofqJyzww/UBatDUzDfMIcfd2rYckZVZ7Ev5C+vgf63yWYRkjF+vpEbtdKo1XNa2p9I20ha/XEZn7fv3oz7OY6Tmyh+x0EHEezN3fd9yUDO48J+GeAPfTueJuoKP3X+60dq93CvbY9p7nGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868283; c=relaxed/simple;
	bh=YIlAoQZqeU/maXInsD55W90FknGU/+WI8SnAuDj/7hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT+37eUiGzcyUz72bc6yoYuQ/5p73Y0J7IpiugMAQzXEKDk5DrretTC6Z52JFTkaNPXEh3aBaOfVx/+LXTg/qXRJfF4cgpnl/MLDzzkdeK2B89I0aYMbv3P1HBHWDQ2TjqGDTZoJviYVmnu7rawXCz2qR4CUmM+aSAzf32NYBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUhnQX1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUhnQX1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC61F000E9;
	Wed,  1 Jul 2026 01:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782868282;
	bh=VD6ZEn7udPWPEGoXZ8OnMXC6geOuXL3HKeO1tWBhn30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZUhnQX1pfg9u4S4B0zLHX84vEbiY9MwfJiD9e7kh+D1RVGfveHK/CwsyWWj29Ba5w
	 r12ZQjlZNVH6XyE9boAOhRwRiXTx+nIJkTnWnPjivblNmkFHsNeFJq4+8JmSX70i7H
	 vo0EYjaBMlObge9tJs6pAAalehVmYtpI0sX6huVz4InhTfVJdfteQaaHJfZaaLmUoN
	 OygT9GZ+kpDd9kLF5lj+Qk+o4DUMf8MCjCHEY3vIsuuYb38mQ/p9wMnpqWOUBWlhxe
	 uEOhCqoc+lSFkOd7kMKVq1/VitLAThAefldHyAXe5oBukcpR1NQzQL20jbInpnRYC4
	 rjIzhlrE12RCQ==
Date: Wed, 1 Jul 2026 02:11:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <20260701021117.19e214ea@jic23-huawei>
In-Reply-To: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2026 21:38:07 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> This series adds REGMAP_I2C support to three AL3xxx ambient light
> sensors that were previously missing this dependency, causing build
> failures.
>=20
> To reproduce the build failure, run `make allnoconfig` and `make menuconf=
ig`
> in which you select IIO, I2C and any AL3xxx sensor and `make .` will
> fail with errors such as:
>=20
> drivers/iio/light/al3010.c: In function =E2=80=98al3010_probe=E2=80=99:
> drivers/iio/light/al3010.c:185:24: error: implicit declaration of functio=
n =E2=80=98devm_regmap_init_i2c=E2=80=99 [-Wimplicit-function-declaration]
>   185 |         data->regmap =3D devm_regmap_init_i2c(client, &al3010_reg=
map_config);
>       |                        ^~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/al3010.c:185:22: error: assignment to =E2=80=98struct r=
egmap *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer with=
out a cast [-Wint-conversion]
>   185 |         data->regmap =3D devm_regmap_init_i2c(client, &al3010_reg=
map_config);
>       |                      ^
> drivers/iio/light/al3010.c: At top level:
> drivers/iio/light/al3010.c:48:35: error: storage size of =E2=80=98al3010_=
regmap_config=E2=80=99 isn=E2=80=99t known
>    48 | static const struct regmap_config al3010_regmap_config =3D {
>       |                                   ^~~~~~~~~~~~~~~~~~~~
>=20
> I made a separate commit for each driver, to ensure a proper Fixes:
> tag is appended for easy backporting. Let me know if you prefer
> squashing!
>=20
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

thanks,

Jonathan

> ---
> Changes in v2:
> - Change select keyword in commit message to lowercase
> - Add example steps to reproduce build failure
> - Link to v1: https://lore.kernel.org/r/20260625-fix-al3xxx-kconfig-v1-0-=
d41cbc0c3cf4@gmail.com
>=20
> ---
> Joshua Crofts (3):
>       iio: light: al3000a: add missing REGMAP_I2C to Kconfig
>       iio: light: al3010: add missing REGMAP_I2C to Kconfig
>       iio: light: al3320a: add missing REGMAP_I2C to Kconfig
>=20
>  drivers/iio/light/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> ---
> base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
> change-id: 20260625-fix-al3xxx-kconfig-ddb1f00a2615
>=20
> Best regards,

