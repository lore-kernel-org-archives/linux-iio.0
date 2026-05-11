Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DE3D3318;
	Mon, 11 May 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515803; cv=none; b=VI9+0jyeC/FWDkHtCHG/CGi3QKRvWpc1TUThTGWaSwp8g8R1e08RMhUFiJxlAMmBdrpwHcc4hYBdO7D455DaZUXKjNn3MPL5mwtgEc5x4Tf/vLTJRYWngX1zgJW9vJMAKV3rycOQc/sp8AFHHMyJKoPcUoNdbIcDM61ib9psy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515803; c=relaxed/simple;
	bh=ZIVTaiQY15Qk217QlmofoDUyNKYn5F9r+/EJ2vqYhvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWy+be5vlP5IVm5VsSJrWqQPupSxawIn/tVC525RkEJ71C21e0cOCdbsdPJBejZiYnqt3QGykgXeeQsim5d6koKeveiX2hRBDp+tyY5jdrMofLdIiUY1k4ed7OwLjhZVCAFvUFQfoAt9iJHtlGAaL/bBiGq7uN0lthU2LhDR61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqiKCmDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqiKCmDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC759C2BCB0;
	Mon, 11 May 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515803;
	bh=ZIVTaiQY15Qk217QlmofoDUyNKYn5F9r+/EJ2vqYhvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqiKCmDaatgGiJNAa3NraNdQ67HvJJyuoVaFtljmEOtYauJ7jCg/gomRPDWRZfLME
	 0hHrTejZQequGTD/pO9cwP8b/Em+lhTNoEe7N4SyN/l7V0RE/QJWHeciQgYbA0dV1F
	 4ynNuxSH0Ar2STCeFk7OS6pl/wVYVxOyoFWrc7CepZtszYhxeIj4nefarM+vO6Bo0I
	 xejF26STJbfHvKrdWCGrrUVWh4vNZaeJZjxIovj6YITZAWrzPdiKfKHlD3V9TtwBEu
	 bMovNZGeyrqju9sWf4kj5x4y252vkwJ2o5gue7GNkVqCYBwT0dSYVqdjLsLhEGr0Qo
	 MIZ5JAvQsn1BA==
Date: Mon, 11 May 2026 17:09:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, andriy.shevchenko@intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Message-ID: <20260511-vacation-unscented-16435eb03dcd@spud>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510194947.31997-5-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EdDXGWrGks3RfHbm"
Content-Disposition: inline
In-Reply-To: <20260510194947.31997-5-piyushpatle228@gmail.com>


--EdDXGWrGks3RfHbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 01:19:26AM +0530, Piyush Patle wrote:
> Add the avia,hx710b compatible and document the HX710B-specific
> DVDD and VREF supplies.
>=20
> Add constraints that forbid HX711-only properties on HX710B nodes and
> require vref-supply for HX710B, then add a separate HX710B example.
>=20
> Keep the existing HX711-only binding extensions in earlier patches so
> this change is limited to the new variant.
>=20
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--EdDXGWrGks3RfHbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagH/VgAKCRB4tDGHoIJi
0lo7AQDVooTvAd4hw1BaKlcodJNBTryz6hZswDdhEXXai7z3rgD/T0QXDgJQZOS8
lH86fPkrQ2g5Q7FCKk3B78qakt046AE=
=a4pQ
-----END PGP SIGNATURE-----

--EdDXGWrGks3RfHbm--
