Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404452459E1;
	Fri, 21 Aug 2026 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272379; cv=none; b=iN4rCoiZaSmuj0OKQFnHQlf6De4sR3oNHzdedlyAtabc16aa7x216waPGppoq3++l187J/Cm2xOyTDe4Y/fC810kHPm040LnSWZzD7wAOX5ZwwPguNsu9TmF8ZzUglHHmKGRZ9P0rTMs69iSzgUOhr5EVB9AxkwylHqnZnu5BLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272379; c=relaxed/simple;
	bh=AsuP0tdjtF/OpVJlFzB04+bbqaeTc1ZIOr72+Q0lFPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGGRIli1fGL+CAT6U9OlinX6sOYC1W9REEUSWn3qfe1GdupMwTmmRwRjVqaTUs0jhWdv31Lcpp8KBa38077QIK31dmkZzEjApfXo2dC/NUZbHCDu6WgNpBLal0cw6mvw81/UjzxpHYv8M6ATDnu9AgGzYEI57TEzvgRlVnHIU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLittfi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLittfi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB0F1F000E9;
	Fri, 21 Aug 2026 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272377;
	bh=zg9oINipA4FX3wa+zkJJwtEkBHtkeUWyF4E8ozdOFpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aLittfi1ZZnayZQ2odyVRvdUx10klVJuBXRhTZcRUPCf4V+hBYHsHSNV6yK5YYWuI
	 8oHpmFP+oyM3/qddponpPTZBsyqns89NJXGhRRuTEItTizhnloQhoiClb6cFtSjMsj
	 1kvR8n2H3BDOb1U6ZtM5IjAAW/lCvCcnWePJK2EQPaV7fLkdLBjrni3u2ltPstqJ1w
	 D6gybWaKNa3Zb88dzcmw0OcclRTdiqKo6zD1SgfvFdtTqu8n0Vp8aUfI2dODF/qIAp
	 5YGlHVHp6KyRy9X1FJitf9MAbn1lKt3XvCj+H22wewVq24iXLyB+CVTNAeUOKXMpZl
	 H3qqbD9tfDKxg==
Date: Fri, 21 Aug 2026 01:32:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Tmljb2zDoXM=?= Antinori <nico.antinori.7@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Brigham Campbell
 <me@brighamcampbell.com>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4 0/2] add support for Aosong AM2320
Message-ID: <20260821013251.74a96b46@jic23-huawei>
In-Reply-To: <cover.1786973355.git.nico.antinori.7@gmail.com>
References: <cover.1786973355.git.nico.antinori.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 11:31:08 -0300
Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com> wrote:

> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
>=20
> This patch series adds am2320 to the i2c_device_id table, creates
> of_device_id table and adds both am2315 and am2320 to
> trivial-devices.yml dt bindings.

Hi Nicol=C3=A1s,

Applied to the testing branch of iio.git.  I'll rebase that on rc1 once that
is available and push out as the togreg branch that linux-next picks up.


>=20
> v4:
> - Addressed minor styling issues in driver's C code pointed by Andy Shevc=
henko
>   (carried "Reviewed-by: Andy Shevchenko <...> from v3)
> - Adapted commit message pointed by Marcelo Schmitt (carried
>   "Reviewed-by: Marcelo Schmitt <...>" from v3)
> - Carried Acked-by: "Krzysztof Kozlowski <...>: from v3 dt-bindings patch
>   since bindings patch did not change.
>=20
> Note: I carried tags from v3 because reviewers declared the tag after
> pointing things that were resolved in v4 (and the dt-bindings one
> because the patch did not change from v3 to v4). If this is a mistake
> please let me know.
You got it right.

Thanks

Jonathan

>=20
> v3: [3]
> - Added "aosong,am2315" and "aosong,am2320" to trivial-devices.yml.
> - Added of_device_id table.
> - Replaced using a constant for driver's name with chip_info struct.
> - Separated code changes and dt-bindings changes in two commits.
>=20
> v2: [2]
>  - Generalized KConfig description text.
>=20
> v1: [1]
>=20
> [1] https://lore.kernel.org/all/20260805183733.1000550-1-nico.antinori.7@=
gmail.com/T/#u
> [2] https://lore.kernel.org/all/20260810183337.451812-1-nico.antinori.7@g=
mail.com/T/#u
> [3] https://lore.kernel.org/all/cover.1786725567.git.nico.antinori.7@gmai=
l.com/
>=20
> Nicol=C3=A1s Antinori (2):
>   dt-bindings: trivial-devices: add Aosong AM2315 and AM2320 chips
>   iio: humidity: am2315: add support for am2320
>=20
>  .../devicetree/bindings/trivial-devices.yaml  |  2 ++
>  drivers/iio/humidity/Kconfig                  |  8 +++--
>  drivers/iio/humidity/am2315.c                 | 34 ++++++++++++++++---
>  3 files changed, 36 insertions(+), 8 deletions(-)
>=20
> --
> 2.47.3
>=20

