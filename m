Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF43D1715;
	Mon, 12 Oct 2026 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831505; cv=none; b=gOMhTbA3XPfJ3yMPi6++rzsLk+j+cfB8ovK3AUIB+ki/9SRvsaEN15bhF9I0FnisW7EjIO6pAZCiHX0H3FnFtJDsADycNRHYxgqexWp/Hfh1Bn2nZPiksEfks5ldIcLIKocu/wdn7yJ7OC6oLwuN825p2gqHbClYu1JwAa6ljQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831505; c=relaxed/simple;
	bh=qUn3dqMXeuCcdHvrU3d4MMg12b0IzSgMZ0GOs6zl61s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrXK2U21aXKs/0brCo+fFk8WIvsvQsK7tor3w+LmSdlHNqIjbBbfDomeVT3gAPf2JUB+/jRnQtq0Yosvi7e0B1XBSCEnpudB/vlzSXgiinGlzzCDnLWeL6fWytUC60XeY2dHX9QrTQ5LFT/qCO7kpGgIUaE0869tV8WEmBanNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV+O0PFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV+O0PFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94D11F008A1;
	Mon, 12 Oct 2026 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831504;
	bh=Qzu193N468xxnmwl2NtJftgGddGezwo/AZtwZYbf5HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JV+O0PFBvyU8WNLIckxJeFRB1bPWp/48Y/u19c5TPGv/uEiTEVkQFR65B3nA6AKaL
	 KFFPSkhAByZZNrsqwmjcu8bOSEZGwylKKIDNcHraCCJvnASmPQkly+uyn8TH/gPxAV
	 6c2Bb6pL+aIEVurTbkTbAdejZGmuQfD8dNuv1QvSb4cv4OoIhQ+FUbmOBAJadTZftO
	 yl3rC/o0qFPjsiM+ZPTYsf7+EneQTR1wPMdgdSdRIT/HidCyCgY3+4gPqAOJwrYWy2
	 KatwezWTv2xMLpxgvfdEQbvZxfac5L23fPV74GtjbZ4o/WQj/sjg781kphMHKGU/Yr
	 sUuKehKjAa/xQ==
Date: Mon, 12 Oct 2026 19:58:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: vendor-prefixes: Add ZillTek Technology
Message-ID: <20261012-darkened-tiptoeing-cb4134b1e49e@spud>
References: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
 <20261012114550.1680054-3-paulius.zaleckas@ui.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/qvXvItVcoDcbgvE"
Content-Disposition: inline
In-Reply-To: <20261012114550.1680054-3-paulius.zaleckas@ui.com>

--/qvXvItVcoDcbgvE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 02:45:48PM +0300, Paulius Zaleckas wrote:
> From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
>=20
> ZillTek Technology Corp. (Hsinchu, Taiwan) makes MEMS microphones and
> barometric pressure sensors such as the ZTS8032.
>=20
> Link: https://www.zilltek.com/

Great, love to see a link to the website, saves me googling them.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> Assisted-by: LLM
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index ba2002969373..255dc56edc36 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1977,6 +1977,8 @@ patternProperties:
>      description: Shenzhen Zidoo Technology Co., Ltd.
>    "^zii,.*":
>      description: Zodiac Inflight Innovations
> +  "^zilltek,.*":
> +    description: ZillTek Technology Corp.
>    "^zinitix,.*":
>      description: Zinitix Co., Ltd
>    "^zkmagic,.*":
> --=20
> 2.55.0
>=20

--/qvXvItVcoDcbgvE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0tywAKCRB4tDGHoIJi
0vMoAQCwW7ICm10/sVzNLrH9amQgr+smlrRbqwGJ00ZzLviplAEArg+yWkxIJEjC
EcqxTpQICuL8MfjvKeaEhCh774J+ogI=
=JKz9
-----END PGP SIGNATURE-----

--/qvXvItVcoDcbgvE--
