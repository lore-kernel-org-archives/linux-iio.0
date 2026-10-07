Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72B471CFE;
	Wed,  7 Oct 2026 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368658; cv=none; b=ahB5Lei3AgbWLxNDvVr1q8nMLE7CDeDSOXDr1QUP77LHOyX+cQAi7boWKS9J2YeoeIx1E4PhWNP+lSGrg4e0VMWNjXLHLBAQC9aUcWL6ftxdA2wdfW1h6/rXlLy8KbHL0V+1SgbO5v/3E42a8aPipUWqz7rbfe+JYEw5nuX5DDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368658; c=relaxed/simple;
	bh=qO4BEBggqoGkSmW3bx2qBelDYdIyptLl+t32Aj0EGXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwmOHjT2BybFk00tSuKWktR8R50YKEpMiEmzRSd8vYVHZh+MIHAGAMIM+9X8vzsvydkHjJU1Tz7XRQNpXPePVNlPyUOAzMEaOovIYbdQXFllRjdSEo9W9BtWAqChPCgsNG96HepvFsAH0HnSTOZ3AsUiXd9K3MGBm7zQfwCoOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5KPiEAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5KPiEAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93EF1F0089B;
	Wed,  7 Oct 2026 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368649;
	bh=qO4BEBggqoGkSmW3bx2qBelDYdIyptLl+t32Aj0EGXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O5KPiEAPcOjq98xdmkiXwwH9ESgjXEn8EJAR1D490u6TnWQ1iy+JhmP/c0mU5b3hj
	 BGgbpQve3HBK4dTEIDAD4R8xHL/pps9zZqSUnns/p9OnfgiX8Om0dRQeJ9BFkDiyqd
	 +7ry6LBO1+OSAaccm/3Sv04VhEaxCVoVdPvPM/vu+bei9dxLKVgpI634uQiaVIj1u9
	 WMSQ0ggntVnO7mCNEpq+BBWDLyhDuU6jodZ2RdBHrnEnd8uleiwPWq7jUqW6o155yb
	 B8F9/6JQh4HZ1680HJzHhRUU7PBxORdlV4SaJUx1SYZ+bbgs8EGr3JyHYL2shSsGNn
	 8DN1PACOt9MsA==
Date: Wed, 7 Oct 2026 11:24:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, arkamondalofficial@gmail.com
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA
 to 20 mA current range
Message-ID: <20261007-c2a36639123b707ac729eac8@squawk>
References: <20261006153210.364862-1-arka@arkamondal.net>
 <20261006153210.364862-2-arka@arkamondal.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aOmyBKYqHptosPO6"
Content-Disposition: inline
In-Reply-To: <20261006153210.364862-2-arka@arkamondal.net>

--aOmyBKYqHptosPO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aOmyBKYqHptosPO6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYdwwAKCRB4tDGHoIJi
0uyAAQDH7HjESHTgd9yCa7sIIcQ03wNRNw4d2rNmy9fr+oXDTQD/aNqTp6ZeXXgy
a7e/fBtf19TVnsy739prbVG8iUCZWgY=
=h+07
-----END PGP SIGNATURE-----

--aOmyBKYqHptosPO6--
