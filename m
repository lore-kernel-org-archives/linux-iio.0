Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5A369D59
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674110; cv=none; b=XNQyIBQa48r/LAH09ZY7N3ZGJFfg8H0OHf6kWMGb8wSBsIHkqXVGh9f7N8n0luLB5+/b7m1TcZv8dKJkH/9OWijY0JyXN0IqKPJve+S5D119kvW+gni6AmzGCXoHcUwtsVxFbUEuOovee5Sz0mGY+uWv8btRFM71spzaLwUcHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674110; c=relaxed/simple;
	bh=mTSWQMdtUPJ8quoBNc3vQhj+rEBKzchn63KyQA+oHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar+qduQbeecKkG1eFPJp/4d1YOrKSaPJszsjV4loa9gO7URJw0PAaGeVQBkYIfqGbpqo/MAPF+F3i0+I99LjXSlYk9EeGo0ZvnLrQgu/vJR/+TTFnDe6XlLVB+DdNFGfC3yiQJ2O9Ah77Jgm6Z3n2BpeuXSR6gFxZOl36H1cePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oawRuPNr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oawRuPNr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f71156e1aso1255039f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785674102; x=1786278902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+iJPyyVAhWuwgDbr/jcy9trWNUYfGjBz+o8zO7olgWo=;
        b=oawRuPNrPle1o+E7Kx+wjlbMFQlclXAojBPA/VpvQXDH03Uvy5YmYfcH9GocSTd0Bs
         7iA0abpGz1DQCCFl+ntsgecbM+Lm6ZjWUnQd9x/1FYFqdW4CKAWHsI9120Z4pKmAphfc
         AY69H1CufSLA3DRRSJRqYKKo8yRIBpEH3h3mLGZBDnOSughgLVMTm4BHjR9zQUivjEDV
         agACyGopVWhGZrCgV7LztJARBJo2bvparqLZqu0EyFt8wOos/++VD6RVwgF30QznJvVg
         musSIATWsashJ6MkT1wAetSHjSBJwAtTTLNErIHtpI0aTt5UX7qB2jByW+yEIwBCTVEC
         /yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785674102; x=1786278902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iJPyyVAhWuwgDbr/jcy9trWNUYfGjBz+o8zO7olgWo=;
        b=HTEk2DX+3YlKkPKuWTmuWL15ourG+63LFkNdfSQ60x4DssgTmdnbzutdGsbkaDs48M
         6E/h62GaujSKcxBh8XKRwkIJ/m7dxeO9ek6eHPVGZrM5+2r5qwgRoOIxnGFi1ew6/qqQ
         aoCQcNGe/v/eojWyTwa3Ebe5XTF69uFQL2L+kwPfAOJYVKluZWecslZHdMo2i/Lw/X8S
         GjIUb1QHKUvnj6JjFfY2axd+Q5zmldk/3o/2akNuJzr7+lqzTzHwIf3AXq+Lf9UEcwIc
         R0s5lsL9OViiJwfWfilWpRG/ABElLcwgMzoXLWJt8DAR8u95p6vMuQYsW5uKfVRFaEkI
         CtlQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZvL7AblhT9vSt9zuK30X66rAaHC4evnYyrVwW90QP0jo/mYtwhbfLFhDcWZ7lt2I361STt2ZQTTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZXYwf0MVnyVA1kAogeHdBVgu3C8FGD9WHVIvGO03CWVq6+Vw
	v879wJABcekwhPidJqfSui5Xctb0j6jeSPbWnXC7UrD7S03Xg5u0cAmPMKRj3Wc0bO8=
X-Gm-Gg: AR+sD11c6vR2Gzbqxa67XwuaWUa2t2HViHh9BeUgt+Tvphk3ZK2iixtCSRFXFuLNCbZ
	ErcCEFIMYMvhhvUfOpXJZO1LkqosaeF5L8HtWVCbG4nbXJT0Fnruw3T04wkUFNPSDxy6qPH/I/Z
	XJ1fmitUf2QJgPr4VmV1pmKn0aHp1Tt5b95gL/bWnmmiO+TlbiMaZw55QCgfI8lvqhBcDThz4v6
	4bO8B5gktLj0CNHiTxI2QZkTwFWTQS2vB+IDLzgFPc7O5vXI9YqDIWa/D8+a17SpHB96I86c9iX
	SD8tCqyqfu0bw8D78MeLylQl+FOJLWzi/UCkQq0z++JuQ7zhSzJOVCkHrJnujbv87vgLdQcE/iS
	LuCbqU84yueDmxcbtyRQqeLES3hWylsOt15oSFu69EZCjyu8SIBohjWM+OhNVfZN/YTkkNCbQpd
	i6QDORXW3c5WLKJyY3qkGPz5hUx5ADLUI9/POiclt2ioqZoDuR4DtCs4j4141P+ecYPfnfTdUGk
	WTa
X-Received: by 2002:a5d:584a:0:b0:47f:9256:52c2 with SMTP id ffacd0b85a97d-47fd72fa2dcmr16555477f8f.30.1785674101692;
        Sun, 02 Aug 2026 05:35:01 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd458ab61sm23825757f8f.25.2026.08.02.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 05:35:00 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:34:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: joshua.crofts1@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, email@sirat.me, bhelgaas@google.com, 
	mazziesaccount@gmail.com, krzysztof.kozlowski@oss.qualcomm.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: chemical: sgp30: fix checkpatch warn to prefer
 __packed
Message-ID: <am84xDCfJC7c-21r@monoceros>
References: <20260723235542.152a6a25@systembl0wer>
 <20260802025134.25319-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iuutzrwryo4oodb7"
Content-Disposition: inline
In-Reply-To: <20260802025134.25319-1-adinata.softwareengineer@gmail.com>


--iuutzrwryo4oodb7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] iio: chemical: sgp30: fix checkpatch warn to prefer
 __packed
MIME-Version: 1.0

Hello,

Just a few nitpicks. These might not justify a v3, as Jonathan sometimes
fixes up such thing while applying.

On Sun, Aug 02, 2026 at 10:51:31AM +0800, Adi Nata wrote:
> Change instance of __attribute__((__packed__)) to __packed per checkpatch=
=2Epl warning
>=20
> Reported by checkpatch:
> FILE: drivers/iio/chemical/sgp30.c
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
>=20
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
>=20
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

No empty lines in the S-o-B block, and please put your S-o-b last.

> v2:
> - Rename commit title and message

the v2 changelog belongs after the tripple dash.

>=20
> ---
>  drivers/iio/chemical/sgp30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index f10bbebc29e4..c33592a1e0c9 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -82,7 +82,7 @@ struct sgp_version {
>  struct sgp_crc_word {
>  	__be16 value;
>  	u8 crc8;
> -} __attribute__((__packed__));
> +} __packed;

Otherwise looks fine.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--iuutzrwryo4oodb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpvOXAACgkQj4D7WH0S
/k5YpwgAl/E+S+82lzHQ1buNKpj92C7t4FN2ORPHv2CUxBCnjgUiDAg7aQWJEBEm
HHxz/flAmenUrr+lV7PLfgcLp+6Z6E84YMM2CsQzOHFsztq5hUmcbY7tCqODVFtL
27rWHNjLNtCYepmQG2Z977p9wDKdqOGiBrwft7jytd/f0qXlRhyy7SGiQWabB7zL
4eI7o4FsBxQYdeBSwI7vIsh6LOtprlKBT6oFPlJ/7okrfju2XZqCbU2GDSaqAAj5
gQjbpUUIDqmeumS0IbZrAMfw93Xyrtfe7kwLrD7Aqif69GTKdrCw1bg+smmp+YQy
NkMBPH7XI//6HPe8KOZxxyiznuImlA==
=cjtv
-----END PGP SIGNATURE-----

--iuutzrwryo4oodb7--
