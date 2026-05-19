Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8331F99D;
	Tue, 19 May 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217575; cv=none; b=oeoH67OYLJT6qo2rL3Gt7woBWFEiSxZvbK/xgAw7LwFb+9k8emAOGD8iXvcUywOCwVnqcLYIxpdN10XDm3EGI/loDP7KIPN3LCEkBBrza4ZhJDgy2QEx/SVPyT1nj/AR60tfat5UY9xQMD/CnrsidIoc7sTKSdBiTj/AFnbETgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217575; c=relaxed/simple;
	bh=Co1t4yypDIpilMqAroRElR6MJsBfOczNK90YTlEFXIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwdLyYQDuBnHZDN3LXBm2ihhyM8OUCpaglGVjHIAPYIJz7eWmrqhNrN3XZOm1M6P5gRCpUhiSbVgKgqdKDMcUUyDcyR5GU8+JE18vFiil6sc12YyJnCS6ZpB+s3RjvSuchTKSL9JwYE2WJnOuZZde3/3aoRwW/Ml048G6bSxpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZKl+rAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZKl+rAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31B61F000E9;
	Tue, 19 May 2026 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217574;
	bh=6G+kZZw0eW5XEaaxmyvN4Wf4CqGt1FsRFkzITZbgLmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RZKl+rADMreF1pZDdj9z4W6kXttJIRozY7stMNoWfsEuBogijMv9XkUdFt4d4sZTr
	 KprS+DLdL3yd3u/WFsHu33STZbNL4XlpLcG0PaBJR1SRhyQt0UMP4AVvuCAA/0z1K6
	 t0KJqplNczfQHX8QebQu1qAIXfF5azI4QwHeJdeHVwHUddmJDvDrYmqkDkucQjxzpT
	 MQQy5KlJQsx6ztnFvD6Y92zH5ZpxihfMurLBIL16y7BJKSwtSAzbk/+tVp3cOaelkF
	 wIojvTWd1o0Ha+/UVBk+p7p4yLOFzp7NUJq/ug9X/7Vjs6PkbA8vWwCTzABz9qyjP6
	 pbEgS9JW51SYA==
Date: Tue, 19 May 2026 20:06:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: dac: max5821: Drop unused i2c driver data
Message-ID: <20260519200608.4ffb0d2a@jic23-huawei>
In-Reply-To: <5feaecf87460a13d389f7b524a12f908e410143e.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<5feaecf87460a13d389f7b524a12f908e410143e.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 10:13:06 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The .driver_data member of the single i2c_device_id array entry is
> unused in the driver. Drop it and also the then unused definition.
>=20
> While at it, convert the i2c_device_id array to a better readable named
> initializer.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.=20
> ---
>  drivers/iio/dac/max5821.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index e7e29359f8fe..f3ebbdff5487 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -26,10 +26,6 @@
>  #define MAX5821_EXTENDED_DAC_A			0x04
>  #define MAX5821_EXTENDED_DAC_B			0x08
> =20
> -enum max5821_device_ids {
> -	ID_MAX5821,
> -};
> -
>  struct max5821_data {
>  	struct i2c_client	*client;
>  	unsigned short		vref_mv;
> @@ -332,7 +328,7 @@ static int max5821_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id max5821_id[] =3D {
> -	{ "max5821", ID_MAX5821 },
> +	{ .name =3D "max5821" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max5821_id);

