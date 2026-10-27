Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081720;
	b=f7JGMzNKj/VlQWyARq4patp7EFj4LvYhxgVtHF2oZwntLrhNN2d941C9fce252QoLk9y
	 rkhLA9hJI1Bc7GQlnokrVqw4LAtMdf9arSyewX790yNNIVCIqyyjLhSyHK6YNt3GIRptV
	 zgitLGO7OLl6biyi2tbFHCHQ16J3lgfyWrZtxQFFjW525bOrs7IYPAXg0UNqTjGL6gZxo
	 QZcC7MoPMR3iiYPYNJ7CYbX6EniEG27heKzxmX/GV9xnunnZoOQYgqhvWoOZB73fPz+rR
	 7kOBF8LHmjy+al/m61mlWCwvJX4OacvwoGCBXNd/Lj26Ud4gd/nNkL5V9oYiovlkhkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Organization:Content-Type:User-Agent:MIME-Version;
	bh=5e0h7T7HaRLbNM8jmqahM3uk9cm6JmxSdxwNNb0AIGs=;
	b=pjEv0Lw6T3JIE+tN3oZZkqLYuO8tEyC5mks/b1qJ1oYb7x5elVKBUS2hIKlWgoXDalu6
	 vhyVtjA1HvlW65e2/1ZCieem2a+SgKyf1MSDkWSnuzBE+RrshYj9kAU8y5twi/8xF0sPQ
	 NcnZJpir+ZrtDZDuAo6e9utbJFbYNRFpWRPtGg83zjpPwO5KDEHL8ZE4za2dBGXKTQxJF
	 n/UUiHiFAdN8VBoDfyPwGUyUhbfsOiNOFPizVWYtdYWkrLIcNUi7U4kzHjxBx1s2ZVEq8
	 bI0zxgpFOjfKmVj0C10WHRsbtVQS2QYRGbKqjRbPIaN6ABuAJhV/OPAOUGRvE77lsLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="Y/HXAYfH";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4D606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 06:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D4D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Y/HXAYfH
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so25608705e9.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793081717; x=1793686517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5e0h7T7HaRLbNM8jmqahM3uk9cm6JmxSdxwNNb0AIGs=;
        b=Y/HXAYfHUhq6eR+5T+B8NOmt4MvptNuVWnk3h0gm3IWxdP/2TQELqnA46DMv+b6iTP
         mrf0n+hf4w8m9BTvhrxtT4CEzFsJrP94Vlkjpv4Erfohcg2sqkEHwT5f1IrJ5cidBlOS
         uw91sECLQySJeiifRIC6Zx8CuGABZDX7dfqNu2ZMvlAnkJckBmN8t4CxczM+jMzpTIIp
         RNjOiNXexuQSM6xWRFzZ9N+KcCfstze/wvDrOVZMWwkZP4x9UFt3aoNPIY6SmNg/eDk8
         lz1bfhuammj50XD2q5bN8DDIPEYS7b+JzSWb8AR2PeqGYlHtAoUJFaXXp+VEclCiTwM2
         VM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081717; x=1793686517;
        h=mime-version:user-agent:content-type:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5e0h7T7HaRLbNM8jmqahM3uk9cm6JmxSdxwNNb0AIGs=;
        b=cXG+0QTUdMLQH8xOQUu0FUIhc1nC/HRzaWcQJt/jtASg6y58Z/ZGAu2ZC7JccYx5TT
         Fh77lE0kOEXQq5Qp8FFhd3Qo6DZLsaUwMBjLDJ9KEndi5DoXkTEHiVc/TxdXriYt1EZA
         5uxz1kX4tVV2MJ1sMx+PwKjHg6+BXdKEvxZ07zkTyfA7XDw/Fnll5sjMznHc2pRRAvgQ
         z0Qc4HDEd51iOEMClt23M1AwsnKALPLRduMRB3++h1EH2cQziyTDBO38T6XKwRY/47ZJ
         Wv/UoVamlgm1QXvWOKhwO7X47B5QHI+X1wu4Owz08IcwJrBQCYTV7Ef/2w9bBg9EqI1S
         6nMw==
X-Forwarded-Encrypted: i=1; AKwUvByIOgD5UUXrzBoLqMNqrsvfsU/8aatbH+WuU1q+Er1j6oIhd74hfEyQRnsdRgiubb+/HCu+5WC1Uew=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbz7LXQQHKR4Dmzz26Co4d4ihy2n8FkFoUDSgyVVgDE/OdNCI9
	pMHmCuMQMUGMQcpn8vIwScNTeza86LvXjeA8fMHJ0iiQ1Bt8Y/Q9vKj/Rb4kn88UCIo=
X-Gm-Gg: AYBFou3waDdKyWYEfHSTIrMVN89CL+qM0ziSbZHzJ6ZOtqBRF09b9ONk8i3UnpkAjU9
	kmwXDfd6BGCIBq5Ea4ddEztomudRb4Wnrw+/zsWIDgia5wWnX+uLdpPw/id333u0J3iTuqxmw8X
	TvA4VF7j/1BDDKwNjNazBW12CbJdi5fgXALs8B1e59B/caMT6o3r+PoGpjO4KaLJeCp1wa0EL/+
	L/gkFNC6wIGdcn9goSj/j4/FoDYrtVN93gGU2GMkqX5D7G6U/pQIPadrBCNulaj7aaO8WvS3kiC
	jCu1KJm9f1f5YdnKEBowqYG9CAyiN4TRfyiIniPbZ8sg2WJ5Hk3V+gYM6GLByBRDAE+Pzo3O8U6
	yXNYcjJuj3InQMx+YdZCN2B7qg4mXUhkz6bMqGS/0hvD425+QGGFKeDF9YKJ2nSTCrxsiBZ3zht
	IsHyZ4/7Wdz1jqLjjUOWNBBktK94PnuKIETVgEy/++aG3/odbTypRjnE9fY8lMUUvRQKNJu7j4V
	UOs+787MzclvJwdvbDCCmvY/hT/9cBFE7lakfIf4W0dtod9r91TjYmoq4rFrlvrH5E9Tm/6eoZ1
	21Yu3axIE1FgDssHhIE=
X-Received: by 2002:a05:600c:530f:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4a35ac8b2a7mr183411715e9.10.1793081716634;
        Mon, 26 Oct 2026 23:15:16 -0700 (PDT)
Received: from ?IPv6:2a0e:439:5fcc:0:749f:a935:de20:5fbf? ([2a0e:439:5fcc:0:749f:a935:de20:5fbf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm20972186f8f.21.2026.10.26.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 23:15:16 -0700 (PDT)
Message-ID: <1ed4d5674135a24c19aac86265daa904affd8e61.camel@baylibre.com>
Subject: Re: [PATCH 38/39] iio: imu: st_lsm6dsx: use
 iio_push_to_buffers_with_ts()
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lorenzo Bianconi
	 <lorenzo@kernel.org>
Date: Tue, 27 Oct 2026 07:15:08 +0100
In-Reply-To: <20261026-iio-v1-38-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	 <20261026-iio-v1-38-8b136778eedf@oss.qualcomm.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-yYNsgkeE5rK6qfl1zfX1"
User-Agent: Evolution 3.46.4-2 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-yYNsgkeE5rK6qfl1zfX1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-26 at 16:05 -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
>=20
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Francesco Lavra <flavra@baylibre.com>


--=-yYNsgkeE5rK6qfl1zfX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmrgQWwACgkQ7fE7c86U
Nl/uIgwArq0E7nG45126NRKlK8IuaASyFQx6gUWGwC49CgAteKF/jcU4SV8Y1Rdc
Xuc/aogF6ZQpOe4ASc7gSDx3S0+qNRpZzgDfYi3MMSmJJWbiRi4+isL7jEWil+23
1E/WIgn7BEMRYGE7NuvaQPCTZut2ikv/KTrh8cP5jSP9tHLbcemu7f95iRTncUQ0
I+kEiviOJpFFh1JPeV+2VmnzfFmQn6i4SwIlq4xjtOZajeSIAow6SqLLk5dLb0Rs
RoU8Syg0cEwUBIq0tJcDoYH19zsDImdddk+V/SipsREV3kZR9GIVlVrrdPca1C0p
bssO6lRjQh4ApkLdebzKJ3+driNAgU3YruOG1joFzmSDTpDgEdjW8d3vx1PSH+ZY
TCo17xRU7bUMdARBxrpAo5o1HL/EQFpSwXjw288VQ4pt4kK7blZbM+Zow1KjfpPQ
4ztND28/9ZIJrv5x1vkHqcBl0eMWToMURXf08WrAFtTvRUiIB/5oozPG1LqM73ov
NkWkS5Z4
=Dbzl
-----END PGP SIGNATURE-----

--=-yYNsgkeE5rK6qfl1zfX1--
