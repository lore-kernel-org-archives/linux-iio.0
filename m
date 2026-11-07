Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090604;
	b=roKNEILLa66Yscj8dwxbDNsNZOkbuOCjY5GDw5D99vT1D3fpPUdq53Z2WJYorbB6qd8P
	 //Fkn7eemYgMlp9uTNkb8N+xhVn3On2FWgegKBCkqbjC2hcFuokgE9g7gXtOYwbEXlI3l
	 Ddhbezksf9bpHMGoXGLBCKatEgxzHDN3cexcifClZV9KUlnuHrlbGScCHEMjKAhwSx2vh
	 pBSIsdkvZKPBCSPAqZq6ywS1uf0/6TyEhzfPFAyh4l9Bvf888+o9HGgNQLwaYyoA2hn2j
	 1yTYRAFa83i8pdVSsaAKZx5IWdDgG/R9uA35tcPscJ7g05pOI46q9LxvTgH4tRsOFAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090604;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=avppe/pzkXSHluZel5dJ8NQ+YEt4WNPu27v4dAsJ3dM=;
	b=Im4zadt529yDu+5nTD75or8MBPPhAB9TKKaG4nV69o1nJCGuVPLpT3LYk415JqiA9+MT
	 y+CQk+Vwr/2d2LEABIAq5gPQL7tfeNFsgr11dVPllJq3U1tYKdF9zR0niWfDXRYr4nSRZ
	 uIseWS8zooMUmvcLGwqz6+PkMUipGyp1crNF6Kfy0u+SNAj0qujv0TBwYyaM2xO5fGeiP
	 NspqBnt8dDngRTUqMsvChhdjgU1gGb7P+1REa321aj2H8wJwlb5Cl+XgLz3YoGq1MBTE1
	 NRj0qjkuuY7U6poyTlYmDZui9hxlvw+RzJzzOvks4on6/KwSun5HFkNUg1gHey6gn9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVUanBvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65198606A326;
	Sat,  7 Nov 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVUanBvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6047E1F0089F;
	Sat,  7 Nov 2026 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090604;
	bh=avppe/pzkXSHluZel5dJ8NQ+YEt4WNPu27v4dAsJ3dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NVUanBvg5JWmPcHGRcYjgp2K8xB64fIhZIat449xjQJnX/N7WWrj/c25DJlPRSyEH
	 58CU2Y9ht62Hk+QCFLG4xl0fqN0ckX2VTwCZiVmMi5lVKLnAjOvp/93NX43A5qF8Im
	 Ini0QKxOx9dduJBbUfEJC33r6sTfR81s8BXErHdGwzM5pmQLfpPFurTQnq6Udg5P2G
	 5p98Dt3cB+sGAe70uAmpWo4M21MHb7lwGIDKAF5wJv+sfCivvZzyhoM6z2+wg7QfAh
	 t8TLRlzdLSPaAgoAYNrZwV4ARZjYL4Pb5Zl+zwgloXjCsZdYlSILw+AwljkSCACa9d
	 RKf0UfiRROjvw==
Date: Sat, 7 Nov 2026 22:29:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: adux1020: harden sampling frequency table
 lookup
Message-ID: <20261107222957.5332237b@jic23-hlaptop>
In-Reply-To: <20261104-adux1020-rate-bounds-v1-1-2db71ad2cc21@gmail.com>
References: <20261104-adux1020-rate-bounds-v1-1-2db71ad2cc21@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Nov 2026 10:28:22 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@ker=
nel.org> wrote:

> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
>=20
> The proximity frequency field read from the FREQUENCY register is four
> bits wide, so it can hold values from 0 to 15, but adux1020_rates[] only
> has 14 entries. The driver never programs values 14 or 15, but if a
> misbehaving device reports one of them, reading the sampling frequency
> indexes past the end of the table and returns garbage.
>=20
> Reject such values with -EINVAL instead of indexing past the end of
> the table.
>=20
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Hi Raffaele

Change looks fine, but I'll not this code would benefit from use
of guard() to handle the locks if anyone wants to do that as a follow up.
=46rom a quick glance, looks like it is a very straight forward change
for that type of modernization patch.

Applied this to the testing branch of iio.git.

thanks,

Jonathan

> ---
> Found with LLM-assisted static analysis of drivers/iio, looking for
> table lookups indexed by unchecked register fields; the fix was drafted
> with the same assistant and reviewed and tested by me.
>=20
> Tested on arm64 QEMU with i2c-stub and CONFIG_UBSAN_BOUNDS=3Dy. After
> setting the frequency field in FREQUENCY (0x40) to 14, reading
> in_proximity_sampling_frequency:
> - before: two array-index-out-of-bounds reports, and the attribute
>   reads 0.025000
> - after: the read fails with -EINVAL and no report is printed
> ---
>  drivers/iio/light/adux1020.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 0ea282ecc99a..d4281b9754c3 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -414,6 +414,10 @@ static int adux1020_read_raw(struct iio_dev *indio_d=
ev,
>  				goto fail;
> =20
>  			regval =3D FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
> +			if (regval >=3D ARRAY_SIZE(adux1020_rates)) {
> +				ret =3D -EINVAL;
> +				goto fail;
> +			}
> =20
>  			*val =3D adux1020_rates[regval][0];
>  			*val2 =3D adux1020_rates[regval][1];
>=20
> ---
> base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
> change-id: 20261104-adux1020-rate-bounds-61e3ff96e0f3
>=20
> Best regards,
> -- =20
> Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
>=20
>=20

