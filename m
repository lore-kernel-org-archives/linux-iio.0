Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3353806D5;
	Fri,  8 May 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248436; cv=none; b=cizGYHuknHrfjY7BDDZhhCZ7F7v86Crd48w4ARFSg9nmOImyPJ2UdRZFDBM0XElRFkrF8OMJObNbAMla8s0eURbDL0NVm1ZBkVcuM5sq7d+xc1XknYSBxPY9jjG1noGRK7pryPRciOISn64lZcEDhwOiNQePdW0voUpE1n7NwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248436; c=relaxed/simple;
	bh=ImULPTll6/DKw9MUjoqJ04IJ5i3jazrS0ThlE7j1Kv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdV2OBt5RiGn+l6WnEB6rsDc1vehJQrq91Gt/Lpojshm6E+Xdy2zjeGy1LE65+c3MOnYA4KBVRNbYLcGNWhZ6/qaezacYy65O3///GrsiKPpbgj9r89cxzhaVqjoMsYiay2JD4hRhnj2droocC5h1W32ToH6sIPnU9P/rmvb+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVjuE67T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVjuE67T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06129C2BCB0;
	Fri,  8 May 2026 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778248436;
	bh=ImULPTll6/DKw9MUjoqJ04IJ5i3jazrS0ThlE7j1Kv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVjuE67TEM7hshiU486fmDOitypmjxAFnEgskHtV+EGQtxmJcjFZ4VpFt+CGp7Mf7
	 52LGJ/MMdLdofHq+hC6PMsx0S64vXu24CcwIg8/OH/wC6SlTWGeoidSsgEK208T5El
	 jRqVqAAdTa9oUpvzUXlFXjpnSZZJ5iD5goJdeKB5P2ARMSkG+WWnrTOrlMiTN8bNa0
	 K2vzzIXkQMnVVDOX7xtMZL8387LwgJqNCflbk0CxgsiRHKe+4o7MmdcauKpS7H15Ch
	 7n63VUxhbpHGdkN37o6/A8FEv1Pb2WIMbO2qssxmUpg0XoUyorxuk8i62Dghjy4yd7
	 cdL1Csh8L1dSA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A43C31AC5896; Fri, 08 May 2026 14:53:51 +0100 (BST)
Date: Fri, 8 May 2026 22:53:51 +0900
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 2/4] spi: Support suppress_override_attrs flag
Message-ID: <af3q7yfFnVP1AcZG@sirena.co.uk>
References: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
 <20260508095224.1275645-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jv3ljE2IBBPcqet+"
Content-Disposition: inline
In-Reply-To: <20260508095224.1275645-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Truckers welcome.


--Jv3ljE2IBBPcqet+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 11:42:40AM +0200, Andy Shevchenko wrote:
> Some device driver may want to suppress the driver_override sysfs attribute
> by specifying a certain flag in their struct device_driver. Since SPI uses
> explicit attribute instantiation, add that support here.

Acked-by: Mark Brown <broonie@kernel.org>

--Jv3ljE2IBBPcqet+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn96u4ACgkQJNaLcl1U
h9BdGwf+OrXFUp18zrinWYIHAzkGcPws8ctEnTduqr1dE4uXXaSwaOTQccdK5Lco
lBteLIUSpiiu7T+OqTpoZCQ6W/1SYH7Mk0cHtkPmFCP/zu9PxYspSd/EQtgCHWyd
XB9NuM5PrHVGGmG2cEhe5Ls9M3KrKyFQvU3yVjuL8pLjxLwJF0gR56sCRqmCGfMN
sc3TExtDQmUyzfvKeqYPXqv64+XWSjRjLRVeHyT7spT1meAb7ibfqy2cDmw/fGht
SV1KRvFpNRf6pCuiv1Fe7NCaWMBEOpA1B2nJCilikUPaIxasnFFd2pltvz9h+gmA
bHPTnOZDZVoj8iA27aknR80+XkbgVg==
=TUzV
-----END PGP SIGNATURE-----

--Jv3ljE2IBBPcqet+--
