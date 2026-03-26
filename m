Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE613A5444;
	Thu, 26 Mar 2026 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547199; cv=none; b=IUwrKZFx9qmDRC4OzS7X2keW02aCa033XjOcH7L3np0vZXDI987W1SOkJX+U04L3xsrTiVxaoIvYRnRH9iMtsa6uBmNYPToCNsqU9F3tOSLIIVBTGJShVOMEmHmpLRLNGFNBKDxQs3WyUf5n4gsB9NmDkbo46QCmNJic3lvSrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547199; c=relaxed/simple;
	bh=CVwfAmH5u+DO6xJAeimWSSYi2LBO8JE7ZmqRYhQRusw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Ah2wQm64umJT03ueODLj+pIzaDeHeA/8NMdCLaP4LyTbiKYFl3s665XcmdbcL+hMIIjpnt3pdEaUTeLG25odtvvfzFpcvDrXSjtgeCRAUGk9y1MscCRa5GW7okk9+z201ZOwNbDIQC2amDMSP9PWvJwBDFeltgxcliO6JukJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ1w7PZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ1w7PZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77D1C2BCB1;
	Thu, 26 Mar 2026 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547198;
	bh=CVwfAmH5u+DO6xJAeimWSSYi2LBO8JE7ZmqRYhQRusw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQ1w7PZYNZh8Sx6kO9Iba1IUYQFPP8rxiobY3yDsSYyHVKpZmMnCIV1xPMgJkEUGE
	 2HZtbh7eq33c/qG1EejSJ1VciKx3AwVdhcV3F1U04MfOzy9faEe3q7dLqhjO2pLX2F
	 Gh30xCiPDoW2lYdp2aZmQFwKKpedIVY/ZgRPEeBsKw+I8IDIHKZJ2Cz9hSIvp/CLtH
	 68h8TwZY925iXNNIsc4EhtaYhYSU9rp/eL3VI3z325Yntjlwrvd7XLFntveHZlCSJe
	 YPrcNoKEHhDEdWctJfrZLUMbsWMMOfIPSNWWG70Kt3A5AfIG/I2LrS7cdopoQ+mQfh
	 YglkJdmXnJt1Q==
Date: Thu, 26 Mar 2026 17:46:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: amplifiers: ad8366: add adrf5702/3
 support
Message-ID: <20260326-swimwear-thrash-dc6668850621@spud>
References: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
 <20260325-adrf570x-iio-support-v1-1-9a2685eb2e55@analog.com>
 <20260325124627.00006828@huawei.com>
 <20260325-possibly-deploy-3ff69076a6e9@spud>
 <20260325191953.290a204f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NpFQbEmKAM2pTwcr"
Content-Disposition: inline
In-Reply-To: <20260325191953.290a204f@jic23-huawei>


--NpFQbEmKAM2pTwcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 07:19:53PM +0000, Jonathan Cameron wrote:
> On Wed, 25 Mar 2026 18:13:45 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Mar 25, 2026 at 12:46:27PM +0000, Jonathan Cameron wrote:
> > > On Wed, 25 Mar 2026 11:12:02 +0000
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kern=
el.org> wrote:
> > >  =20
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > >=20
> > > > Add compatible entries for ADRF5702 and ADRF5703 Digital Attenuator=
s. =20
> > >=20
> > > Explain how they are different from the existing supported devices.
> > >=20
> > > Something simple like the "Each device has its own gain range and ste=
p,
> > > hence no fallback compatibles are used." that you had in the original=
 patch
> > > is what we need here. =20
> >=20
> > Which means that this is a v2 that doesn't say it is a v2, or explain
> > what has changed?
>=20
> I meant the original driver - which only landed recently and answered
> the question of difference nicely.

Ah I see. Wording confused me!

--NpFQbEmKAM2pTwcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacVw+QAKCRB4tDGHoIJi
0gBsAP0QnDgQfS0TqUCIclAilJpw2cqxQmeObA99EigK7X/wZgEA498b9J7Vy5zA
CQspXNTjWiFMfu6AqMcgdEFwk3UvrgQ=
=T+DN
-----END PGP SIGNATURE-----

--NpFQbEmKAM2pTwcr--
