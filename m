Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A43A380C;
	Sat, 17 Oct 2026 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260796; cv=none; b=ibXO68EbG22hUb+dqS1K0Wu6VysiFVZuqmQr2zHcj1q4BcopdGCEu4bN5Erx+2Q8DxyKba5wFlhYKpNuwICnTZLhRPiy6NXx5lXGLZtOKKGQSm9GFdKyzbgMHjVvjoDdnsg8JGF9B2vv4LAshV/CYucUmLtzgsDulKGaMtLHbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260796; c=relaxed/simple;
	bh=lEvwS9mkI2v/PAmLohs0Mq6mhXOkMv2OZ2obiGLEcl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV8oAWFhITRpXKtG9MAy0tfdY9K1CjTPqG7HejSF6rCUzRbCOfqp/rM6mcZuWVvT2VKuWXyVmAPbxDpspoiPzf/4J49B/GCCjj01NQ0+0J8dW0ixpTjdKIVZpwOqL9/piJvOfe+uL13jX7QZ3ZTqEv4eLVP4hoFbKyh6nXCR43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okdnk2Dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okdnk2Dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6421F000C6;
	Sat, 17 Oct 2026 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260794;
	bh=oOam57k32MmF+7eBtrlBPpXcG+2QiRF6NSnFxaoB2rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=okdnk2DqYKZ6uZCvATNhoTHC5Cpd4CdxEBVS6uuq032VAsxf7m1/KuIjs2QBNAC+j
	 IPv29LgTrOK7WteG49oFwP1OU2cWZ/yswq+FfdGpc4iEUATnj+M29NNM4KESMuLM2A
	 tJr+d8lZ6sphT8ef0n4Y4NYklbUKCDUp7VTrW0/Zs5rU5UUIaz90jKNm+CXiN7x2za
	 YcQDXXFkyTkrofKYfHxSa4yAj0q/P+C0+waIRzH/YUiWtLC2M1G6RezDMk5kss0E8+
	 9B8MqbNuEuT31hDErZOJcaMit1AmdpcDwt8zSZF2LbJfRDkhH46GaAzQ80UXmhz7n9
	 s7pxFumHh71nA==
Date: Sat, 17 Oct 2026 19:13:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>, Joshua
 Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: accel: adxl345: propagate errors when
 reading event configuration
Message-ID: <20261017191310.3164205f@jic23-hlaptop>
In-Reply-To: <CAF2O-sO3OJH1sNnm0TkDXkEwWPKM21+s0_iNgU-VAmF+kMWtLw@mail.gmail.com>
References: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
	<CAF2O-sO3OJH1sNnm0TkDXkEwWPKM21+s0_iNgU-VAmF+kMWtLw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 19:39:08 -0700
=E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com> wrote:

> adxl345_is_act_inact_en() returns either a boolean state or a negative

Returning true or false to a function that reports to return integers
is rather nasty and is probably what lead to this bug in the first
place!  Would you mind also changing that as part of this fix?

Cleanest solution is probably to pass a bool * in as a parameter and
use that to 'return' the boolean rather than mixing up bool and error
codes as it currently does.  That will keep the return value for whether
the query succeeded or not.

Thanks,

Jonathan


> regmap error. Applying !! in adxl345_read_mag_config() converts every
> negative error to 1, so a failed register read is reported to userspace
> as an enabled activity or inactivity event.
>=20
> Return the helper result directly. Its successful paths already return
> 0 or 1, and the IIO event attribute read path propagates negative errors.
> This also covers the adaptive magnitude events using the same helper.
>=20
> Fixes: 66a1af6d8a63 ("iio: accel: adxl345: add activity event feature")
> Assisted-by: LLM
> Signed-off-by: =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com>

> ---
> Validation on macOS ARM64 with Apple clang 17:
> - Compiled the three relevant driver functions verbatim with the driver
>   header, using a host regmap stub for deterministic read failures.
> - The original code failed 36 error cases; the patch passed all 53 cases.
> - Covered activity/inactivity and DC/AC coupling, each of three regmap
>   reads failing with -EIO, -ETIMEDOUT and -EREMOTEIO, enabled/disabled
>   states, mismatched coupling and an unsupported direction.
> - Checked read order, early exit and unchanged register state.
> - Used -Wall -Wextra -Werror, AddressSanitizer and UndefinedBehaviorSanit=
izer.
> - git diff --check and checkpatch.pl --no-tree --no-signoff --strict
>   on the code diff passed with no errors, warnings or checks.
> - The full patch draft also passed checkpatch with no errors, warnings
>   or checks after fetching the introducing commit for Fixes validation.
>=20
> Also compiled adxl345_core.o, adxl345_spi.o and adxl345_i2c.o as
> x86_64 ELF relocatable objects using clang and unpacked Debian Linux 6.1
> headers supplemented by upstream IIO/regmap headers. This checks syntax
> and types; it is not a full Kbuild/modpost build.
>=20
> No in-kernel KUnit execution or hardware sensor test was performed.
> The checkout is sparse; --no-tree disables checkpatch's tree layout
> check. Initial draft checks used --no-signoff before human review.
> The final signed email also passed checkpatch without --no-signoff.
>=20
> AI assistance: Codex reviewed the event-read path, identified the errno
> conversion, drafted this two-line fix, the reproducer and changelog.
> The request was to prepare a driver/BSP/kernel contribution related to an
> ADXL345 SPI/IIO vibration-monitoring project, with reproduction and check=
s.
>=20
>  drivers/iio/accel/adxl345_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345=
_core.c
> index 6c9080d..5983fc7 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -1176,9 +1176,9 @@ static int adxl345_read_mag_config(struct
> adxl345_state *st,
>  {
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> -		return !!adxl345_is_act_inact_en(st, type_act);
> +		return adxl345_is_act_inact_en(st, type_act);
>  	case IIO_EV_DIR_FALLING:
> -		return !!adxl345_is_act_inact_en(st, type_inact);
> +		return adxl345_is_act_inact_en(st, type_inact);
>  	default:
>  		return -EINVAL;
>  	}
>=20
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83

