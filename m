Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8653C5855
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615581; cv=none; b=RSJfp2EDvAEmy6HD0kfnqu+jucqErUHbfCBJogPE75+v9flh2XhS0wy9DsO3XUtPRnkiBFnz4p3Wh5PQ2I5s8qTJ4rTWvfeJCKef2tpZ9xM5N7sMqGGylYEn6qAD8tfhGSfrHwx3jPle6w82HOpk7UTlnfEDTgLEFdHdS8WID5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615581; c=relaxed/simple;
	bh=ufJhGf4bzE78fJteVY/YmfmjF2gWypbQ0412ziJnxxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfjP9LCUehla3YAOpS9pBEpOWQ9/r2GKO4id3m9vX3ytWpYw8QwimY83w4VP5p2ZFkaDu49TRUnnyzxjaXAzkt+Tda2OEhj9Rst5A4N9toqvERtCOzo8A67+7TJB0TLk3rOHg7i+eThsf5C1nd4w2aSYpRWW6VtVacDLMf01cXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=O8llACol; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="O8llACol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ufJh
	Gf4bzE78fJteVY/YmfmjF2gWypbQ0412ziJnxxo=; b=O8llAColra+iJTI+CBs3
	qcDf8OoXqMCI3cts+Ijv4amcbMn2VwRg67UjgqZB4JtZE5X1nDHhCw72rj4MGVLH
	uhxOZBuY8qvpu0YJOHARaefVSwpR/ae4D1JNmVnPzpvJfUrWMWjBMMEUYSbnqZfz
	bg3ZzraOmYPgLdFY3pxWnjVyTqfnkG9Hba3lKl6w4yiVVx+2GiIwNAkRfNRiGtlL
	7XSjTqXAezeqLi0aWkfK0N3CIZC7vAW0KoLaOKESpMAClJx/Uzgl/MMiV1q9FIJB
	GN6Qdd3ytRT1Q6oTCGnoEkA1Y3bq4XS+VzVpmL2T1kdjJ+U9wRRJZp9RuxwW25mR
	Rw==
Received: (qmail 2488103 invoked from network); 1 Aug 2026 22:19:28 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Aug 2026 22:19:28 +0200
X-UD-Smtp-Session: l3s3148p1@cmmdBQJYoJYujnt8
Date: Sat, 1 Aug 2026 22:19:27 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH 7/9] iio: adc: rcar-gyroadc: remove
 rcar_gyroadc_set_power() helper
Message-ID: <am5Uz3RS_EEoqDIC@ninjato>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
 <20260727184755.2055414-8-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53BZ5I70pynewSYY"
Content-Disposition: inline
In-Reply-To: <20260727184755.2055414-8-ekffu200098@gmail.com>


--53BZ5I70pynewSYY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 03:47:44AM +0900, Sang-Heon Jeon wrote:
> rcar_gyroadc_set_power() just calls pm_runtime_resume_and_get() or
> pm_runtime_put_autosuspend() depending on its bool argument. Call them
> directly and remove the helper.
>=20
> No functional change.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--53BZ5I70pynewSYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpuVMsACgkQFA3kzBSg
KbYhBg//dlFffYypLTPLVX5lgNtJxYOn9LOe/Asj9fxF19DBBvPXJYh30aXPF3SW
v8Mn0mQLwb3eFIDex86VTjIRgNm+xU9Mi4ZjPrY5VzHBTecHdgoaGYoipCVl7fNw
h0ct9nTv28xtEEPMBCDrVe5fLvf2tclicyhx0HbWZZrClA4jkFfjIG9E4spQjjo2
uVvySF5VbH9mb6zmf1VU7vcYlfYCd+JzYxxNDDioHQWcuO49XhHPWReU6J8C7ycP
28O8d9Eh8vubQBYZRl94Rxti5oy7Om2Id6A4DlbJh5h0ZNYU8282N7UzNHkTBEOP
WfzlLQ1QNh5sWkR8/zwFIpkQJQTRaxlov45r07kkkIUkO8g/Gz9Av7uWfFAXeWxC
cHuo6pCyvPBI+jgrrlM2sdvu6w3k+Kiuq5042hJte7gGKRu5vKx8ovOXG8wyf6Tc
No/7TRMeGfTjFMU91e6/McHHdt5ouPBINWKe1hQU3ePDdV5BrC611gk6cfreY8Ld
59KGZ+XaISEA2PMm9gF5fbteaRBBvaPF+iin3V0IiOKkDiHQkCNM8iWozywxMSkE
l7wkqP2GawjXy3e6iUWAQqKjCIdUinWTnO0wTfwozroZy7h9HhOb9Japk9K6mM8Z
OwGsIU5dyyQI92zvoC+P2ISmAph/5O6MKQ7DIabcZQo3Jr2E9UI=
=h90p
-----END PGP SIGNATURE-----

--53BZ5I70pynewSYY--
