Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861563E0C47;
	Mon, 31 Aug 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178344; cv=none; b=VOVmCx8WTiTwSLAokEnCNlN5qCXbzGO4n16++DP/GPpT7M6qyA1ohOXA3AtNaNi/z5osgW3dMzAETyTq2MsY2Ol3FxKwN46TNqyMrP0A0IYBy1DlllxinaenYPIQszDQwezN1NrWpiwzV8QHWc8Axj3Jwfw3fBAS8CsBuX4qZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178344; c=relaxed/simple;
	bh=CD5OwstgpMzIDB3nnm8lm8+2h5M23PSx6Nv2d5oaTxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieC8w1g1FCRig9EA4Ll+dihCf3JIbsAz92Q6KIm3tafPwp6m42D9GncDu4lUa0+DGmc9c0ZXqmkIDXKfj6Ws/h136D39nYq6F1deiF20oM0t0+EL3d6xptM7Kf46wCzrT04qgqoWgjGtRjdLo003WomIqSFPO7t43iuSwObaDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdU8CmXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdU8CmXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6AC1F00A3D;
	Mon, 31 Aug 2026 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178343;
	bh=CD5OwstgpMzIDB3nnm8lm8+2h5M23PSx6Nv2d5oaTxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZdU8CmXVJuFSlUO5l1upNskR7bhYgWDGj/pOcPzrorpWb+1NP7Nc2/2fxfwwISBkI
	 hzV19TwFueXpWVwYcgchB6ri4oy39dqJ9ZDeSYwfeL5VpZvqO4pe75s24s8om1YwWw
	 TlbtmxbXbAc6e36avHg+ZxVGawsu/5p1qh/NWBLY7f4YkQye/M0jqEhPs9g197vgpy
	 nd4+hFZU4acblvqUXuZagYq0dJNPmgF+dqX5d+K0qj+EjlrY8OttzKdFc308W3yxc8
	 2hpTxS5Y955lPr060lcCKED5r/HhpGUBRO09j4S4nGNZIhwxAk+7n9zigf+DCk3e4w
	 sWF1/PgE0D64Q==
Date: Mon, 31 Aug 2026 13:12:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 8/9] spi: dw: Use dma_slave_caps bus width helpers
Message-ID: <820f9317-8457-4041-8f94-5f5f75e7afc8@sirena.org.uk>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-8-507d97496f2d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+AhjCYXbI1r3nDs8"
Content-Disposition: inline
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-8-507d97496f2d@analog.com>
X-Cookie: Sell by date stamped on bottom.


--+AhjCYXbI1r3nDs8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:46:45PM +0100, Nuno S=E1 wrote:
> Store the common TX destination and RX source bus widths in a
> driver-owned DMA bus width bitmap and populate it through the
> dma_slave_caps helper.
>=20
> This avoids depending on the legacy src_addr_widths and dst_addr_widths
> masks returned by dma_get_slave_caps().

Acked-by: Mark Brown <broonie@kernel.org>

--+AhjCYXbI1r3nDs8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqVb6AACgkQJNaLcl1U
h9ClLgf/VHBuWh4bKapW/V9pta/hHFd6AdEC3fSQe3piNqlsxij13907eXkDp5vK
49rYbjuUKofwlFtkL1iqWkbfwMLiZKB3Svg1aZIZ2vCmEHLNiYsn7aOZBr9QfbPZ
Xa0b0gL7qDlbjlnI/aVxdeNrG+lJPCOdXXbw2lyTU02JrFe616Kvw13M3X/oRZgc
1ApUKhWS+cNbymddHSiRqg+Xp7FZqsB/XqeoxI0jI6QTa0y9HN7YDaIb0mjk1nEF
rJd9cfabjSWy1n1SfBsKQpaOWn4AfHNdpI31RPjauLbRJPei3NokTkAWsfYmW/92
w0ChV1u7IFXxu0o9ZglrW9zt8VbrJA==
=qaNr
-----END PGP SIGNATURE-----

--+AhjCYXbI1r3nDs8--
