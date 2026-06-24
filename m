Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C434A3A5;
	Wed, 24 Jun 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323046; cv=none; b=lzK3SEqVh67wCuprC6EZy/qYq8rt1bGjlhGyl/HZdJNeopYq06n8bQT1Gl6/Z8C7yO8+4sU8ufz4WSm9xW4NoOnGw0fn2XMluSI74RIcMw7Ci0/AagWFmatvAOAOF3St+/3EPwkLlMsWEkfak63TMf0xMfIWwXDcZLQMg2bxmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323046; c=relaxed/simple;
	bh=C709w00j4aaaNc2AYLcHLZdTwBtFLYynDAzqoJsvRQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un/GWtlqIEk13ZaC3wz8qCaQAcOZbBB2OfvzMVL3lJP3DxKlcdCQDAnAAsmZTp/HJoS1k88jwQrags+tR0XvXtlTrFH2rE8eKpAwW3+UsS4HONa29WL8vfPBn+V9XBZYN9XoY05eyDltoMTtOfJ120ZMlFS7wjTYEt7bXeahycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdXvlv5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdXvlv5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0417D1F000E9;
	Wed, 24 Jun 2026 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323045;
	bh=MSDaTJAlcrVaYg+zNAEzh01NunoWqYbg05RRuY4f9LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GdXvlv5tgsiIajv8Wtptrl2HfG75uUzlSppZaWiKnDKX1FyUpkmioUt53spkzmLJy
	 q3/X7K/78uy/rvJkvvfu1W+WvbZZOzCQv6VAHp6j1aPuBs0Dnfgs7T9JNeBQPA6WNJ
	 rm0yUzwiLTsviC2HK+JTv+QmJSnJYRZc0z5jDPkRQNyPi4pqJypv/x4769EktmmiKO
	 r9uAVziWI6tI950lnlqAUsxAs9qFzep/xmWhWrIi0hOIi5liRO46ankD6f9z5CWPBo
	 cYjPSbbL3Z6ivIoTQ6KLkLU2d6rCmSVQS7VHAm61IvK9/Yli05nd7Ihwqu0vdKt+R4
	 jLHAqUhOulCxA==
Date: Wed, 24 Jun 2026 18:43:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/13] iio: frequency: ad9523: Simplify driver a bit
Message-ID: <20260624184356.01c4fce4@jic23-huawei>
In-Reply-To: <620a617c03cc084a260c3441b8c9c6eed33efe0e.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<620a617c03cc084a260c3441b8c9c6eed33efe0e.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:34 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> spi driver data is only set but never used, so the assignment can be
> dropped. Also the spi id_table's .driver_data is unused and can be
> dropped.
>=20
> While touching the spi id_table modify it to use a named initializer.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Whilst you are here I think it makes sense to at least set the
appropriate leg of:
	indio_dev->name =3D (pdata->name[0] !=3D 0) ? pdata->name :
			  spi_get_device_id(spi)->name;
to the name string directly rather than via the spi_device_id.

Maybe that's a job for someone who is ripping out the all the pdata in favo=
ur of
a device tree binding.   Ok I've argued myself into picking this up as it s=
tands
on basis that change probably fits better in a separate rather more complex
series.

ADI people, is this one on your list to either modernize, or potentially dr=
op?

In mean time I've applied this.

Thanks,

Jonathan


> ---
>  drivers/iio/frequency/ad9523.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad952=
3.c
> index ea4d2763564a..1e393f40a8c8 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -990,7 +990,6 @@ static int ad9523_probe(struct spi_device *spi)
>  	if (IS_ERR(st->sync_gpio))
>  		return PTR_ERR(st->sync_gpio);
> =20
> -	spi_set_drvdata(spi, indio_dev);
>  	st->spi =3D spi;
>  	st->pdata =3D pdata;
> =20
> @@ -1009,7 +1008,7 @@ static int ad9523_probe(struct spi_device *spi)
>  }
> =20
>  static const struct spi_device_id ad9523_id[] =3D {
> -	{"ad9523-1", 9523},
> +	{ .name =3D "ad9523-1" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad9523_id);

