Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618757;
	b=u6UvYDF0QDt3u5Gx8XLPg0DzpZvN8i/n54tYJb9g6Gm35w4OeockA7/ZD43VEIp1EtJa
	 +jMGRjIRtOiFFcA549qRB7nltGcwYF6KkTo6PmP7rexmIYc6e4Ju/p5r3b78M0yC1Y2Bk
	 OmPAQ47zsrg2vC1j8yhJx+1fS6UMBAW4XEHAeWP1KXaKFDst+jmNTMS/M/k8DdMcT3DyB
	 3LJ2c2Vzg9LmBaEHbVGriSWNZSijO3LUGR1VsHoztyVXWEGcphul4spHWPlNuLKwbLphs
	 G9VVhAI83RihEFfdOqboWSDuZCJvAwRnDEc4fzIhrmDudg1Q2n8uVcNNDivQDPIjNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618757;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0Oxx75uAGkOJmTuOKTkLBYX5y3HwHP5sSH5W3kbVG1Y=;
	b=4NPxUrJ61FWww+TlhrlBlTLgiliGvnXnj6BKLZyaMo1skDdXKf+FJO+aJHpEpE5R1sUu
	 zUrDav3Ixigny04X4AWNyBSNNjxUx5k5lEXt2r1NTVjYJ72rCNsw4Gge2RJOKpG53zrjT
	 BpL2+e5V425YTdT8xjPzw5P/GLtBgY+zTBDwro3XJag35YTzbfqs3Kl+rnPu4GEwOtwfr
	 Wiju/ZrZ4qYWyG8B66TMZkcS9Lwd4uM2bkGPfx8He/3ZffR4H8eEB22P4z2XDNkXL+yx5
	 ebHjIIPb/9XVxOdAwJbRfGPzn7HO1lwMkK4O5vRbGoUlJkn8SJBbHQRNjLpmdP+Lzbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7UDv8AL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77743606A327;
	Sat, 14 Nov 2026 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7UDv8AL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00801F000C4;
	Sat, 14 Nov 2026 01:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618757;
	bh=0Oxx75uAGkOJmTuOKTkLBYX5y3HwHP5sSH5W3kbVG1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J7UDv8ALVojfjXgDfxP4GD7l1NCCP4bT0OdfxrGpCIOMjjErpsY+ycyJR5YhT0Xsr
	 H9zjWwoVautAWNcNZefda7jrTdHsytisqz9kDjhP9UZBRX6De8H0H6O2WuI0+1JX49
	 xxvc3LHHlvAuA1VDpxsJY9b4Hhn7hVgZkjGrqOwVA7/I4qegxGQFssHkS4bnXaG5OE
	 SH7Y+SlaC3jXkrhuAq/p1TkFz3PTrJXZCCXkgCQdpIC4uaTHUEhNL7sAlm/Y1hjB/0
	 6+DOdF1brZiD2u3soFzuYPOoZFDVA/rLe9lABR8xOj9UCfaQkZsUgp+NJVstv5YZII
	 Xr8uAfpgRMV7w==
Date: Sat, 14 Nov 2026 01:12:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com
Subject: Re: [PATCH] iio: dac: adi-axi-dac: fix swapped arguments in
 axi_dac_set_sample_rate()
Message-ID: <20261114011229.59a52b91@jic23-hlaptop>
In-Reply-To: <20261113-iio-fix-axi-dac-v1-1-630da3648086@analog.com>
References: <20261113-iio-fix-axi-dac-v1-1-630da3648086@analog.com>
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

On Fri, 13 Nov 2026 14:47:51 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> When the interface sample rate changes, the DDS frequencies of both
> tones are read back and reprogrammed so they are preserved against the
> new rate. However, the tone index and the frequency were passed in the
> wrong order to __axi_dac_frequency_set().
>=20
> Pass the arguments in the order the function expects.
>=20
> Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
ouch. Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

J
> ---
> AI was used to generate the commit message which I looked at and removed
> the extra verbosity.
> ---
>  drivers/iio/dac/adi-axi-dac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index f4f3bc67c68e..1e2f7f27292d 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -596,7 +596,7 @@ static int axi_dac_set_sample_rate(struct iio_backend=
 *back, unsigned int chan,
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D __axi_dac_frequency_set(st, chan, sample_rate, tone, freq);
> +		ret =3D __axi_dac_frequency_set(st, chan, sample_rate, freq, tone);
>  		if (ret)
>  			return ret;
>  	}
>=20
> ---
> base-commit: b70566610b48ba49dec636019da4d696db64b085
> change-id: 20261113-iio-fix-axi-dac-b7b401cb06d4
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20

