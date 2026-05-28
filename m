Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345EDDCD;
	Thu, 28 May 2026 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987362; cv=none; b=JDeoV/zJlLnDqxszqWwyeHOPriFgmWu/ThYE1i+vH3k60+mftSF/KGT9yMS1eUbbi//EsPs7V6VrWbMSND87cO9fDmkXfx9766FoH1pK/Fr1HUMA7uw8aqqdM9wskff0DApPZNuSopeoMnIPlXqC3LaA1i+gW22luji7IyUfB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987362; c=relaxed/simple;
	bh=hJ1n5xHzLhhjEFMWyc0czU8zgGQTD/DqQsMamSkzaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ3NPGi6TRHuqTQWAfGvlM/9Fn+OAXkw5u+c54uYvW03Rg+SR7X00E01EXoeSFr53UU1lkK2gCAk65XeSyrQAEmjkfQm3jc8UwB32quF5gr+OdmJ7Da2ccLonXDBozZCSsSCOvLBlukV2f4gspWmlGxlH9SY8bPdk+OXBinXAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S94GI6w8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S94GI6w8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF91F000E9;
	Thu, 28 May 2026 16:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779987361;
	bh=hJ1n5xHzLhhjEFMWyc0czU8zgGQTD/DqQsMamSkzaLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S94GI6w8Ip5AhptrodQ668xnBOl6b7Sh7f5hjcCRdNAq6fRRAsst9ZCWaM7Yptr7s
	 23UNC7KfhhCXNdetpUP1cWzJ+q/nOVgwoHpP1yPdwA30AskV0f5UcF/YMzUPiBVvTR
	 YTfKJpN0d3pbUuRJC79ffM7tcii7/csrTC9prHdNzShte5+nEBPwTyVvlcMkqe7EpC
	 7sawq5yE1QquDNic3RVUqxQuWbh+XyrxKJZ0LX+reR9baGSTju0VNOUMCoJBGTUTsM
	 CekYRkoV79sIEInCQPl6macDXdywgdQgpTBNpiLBcbZaMNW7RcyTv3KoZWfpiv8ZZ/
	 S+0Lw0t6DyOiA==
Date: Thu, 28 May 2026 17:55:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pop.ioan-daniel@analog.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: Add ltc2378
Message-ID: <20260528-paycheck-prowling-9d7745222ae7@spud>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
 <23971c3bb56d8635abe9cd36fd245412f672772a.1779976379.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GblWo1Um3hnwZ3yC"
Content-Disposition: inline
In-Reply-To: <23971c3bb56d8635abe9cd36fd245412f672772a.1779976379.git.marcelo.schmitt@analog.com>


--GblWo1Um3hnwZ3yC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:03:16PM -0300, Marcelo Schmitt wrote:
> Document how to describe LTC2378-20 and similar ADCs in device tree.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v1 -> v2:
> - Use unevaluatedProperties:false with spi-peripheral-props.yaml referenc=
e/include.

> - Use unique compatibles (no fallbacks).

Please note why these do not use fallbacks in your commit message.
With that explanation,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: changes-requested

--GblWo1Um3hnwZ3yC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahhznAAKCRB4tDGHoIJi
0j2BAP0U0STmvht8yI2Nh6bXJUuJRqpQpYoMz3apIBbstOnjOQD+PaLJDy4K55k+
IMOip65wa5Jvg695ffUsGpq426H3JAU=
=nNs1
-----END PGP SIGNATURE-----

--GblWo1Um3hnwZ3yC--
