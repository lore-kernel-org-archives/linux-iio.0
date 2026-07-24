Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFA280335;
	Fri, 24 Jul 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897151; cv=none; b=LtSfnaWERGjX3m2KbaOHsltFf9AKg/OzBf9v0AsE6WR/l2tFEyAcZTJL+VPyTKMIJgsfzpiBpg56JCauShRdVmMdQeVRuBNRnVnRfVUIQ5EdmKPVlpQD26BIfwLXJ/KZ+uyIM1stQKFC3m/zjqe7+YcHd9Jr9Nznz1w7rBdRXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897151; c=relaxed/simple;
	bh=5gWu1etmGQzpc+vJtn73eRzN6InGTYFK7N+DVx5BuKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdPeW1uiRuqOsZsPsJ9g/Efx1Oa8lz8YwmH79K6GXHYPTMrBGxKitpTRkNJQnrytmRvXVcsHs6u2pCuyzwkIwu6N5EHc9BIxyS7KMSrwOllzgqMWmUcONYzXFsXt83lzimafygnfC3DguHTzl5N0Dt2V0B7tz5C1Sw73ojaRtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KvghDC5K; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KvghDC5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784897150; x=1816433150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5gWu1etmGQzpc+vJtn73eRzN6InGTYFK7N+DVx5BuKY=;
  b=KvghDC5KzPeDZ013i69SzGcSYQkHfb0SPibCeEzsgpWnbb195jDhQNAr
   3xl1DH/QHSux+is3ClyyY04hIXttAwe9/qTz79m9gL4Z1IUGyzPStBuhL
   erlgr7mCw9J9RPrazPe0/UWQYeYa2DUMeIisCftQJ2P7YgwpTmwDy5Mug
   K+0NcQKMzIXQcqBXqZ3uR7Ry6FXetaYwCGtSmaaC0oVQ+pbFhm3r/ohRX
   uHJU8re2UQVWN9lQ8eU9mmXARpUZcwf2XCRw1ylypgtRYbF2yDi7t9MXS
   l8fcoXF3tfTR59rqMGOTZCzfktXoCuFTf1SdkwMXnpGyEda7xUIsd97Yk
   Q==;
X-CSE-ConnectionGUID: j8P26unpR3qSDDrHoA/YGg==
X-CSE-MsgGUID: X8FcsQ38ThK0MtMz5sEZnw==
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="asc'?scan'208";a="292499516"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2026 05:45:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Jul 2026 05:45:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Jul 2026 05:45:45 -0700
Date: Fri, 24 Jul 2026 13:44:46 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: <Ariana.Lazar@microchip.com>
CC: <conor@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add support for MCP48FEB02 SPI
Message-ID: <20260724-jailhouse-cherub-7a27b62bc8a6@wendy>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
 <20260723-mcp47feb02_refactor-v1-2-ee59e63672bc@microchip.com>
 <20260723-festive-genetics-3645c8e0b318@spud>
 <7e121a7afaaa5aa72e39a4a70de2b0edff796def.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FSLcchgfNrSvT+e1"
Content-Disposition: inline
In-Reply-To: <7e121a7afaaa5aa72e39a4a70de2b0edff796def.camel@microchip.com>

--FSLcchgfNrSvT+e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:30:31PM +0000, Ariana.Lazar@microchip.com wrote:
> Hi Conor,
>=20
> > This is actually a v2, right? This was submitted before using a bit
> > of a
> > different approach IIRC?
>=20
> This is the first version combining both the refactoring and the SPI
> support into a single series. Originally I have sent the refactoring
> patches separately and in order to avoid confusion (cannot do a diff
> with old patches) and to be tracked easily I have decided to make this
> series as version 1.
>=20
> If you think it is a good idea to mark it as version 2, I can resend
> the series as version 2 and point to the old patches as version 1.

Yeah, if you submit something and then do a big rework or consolidation
of series you should treat it as being a new version of whichever you
consider to be a new version rather than a new series.

Cheers,
Conor.

--FSLcchgfNrSvT+e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamNePgAKCRB4tDGHoIJi
0l8IAQC8KK+RzW8Y7t+567swcy4oZO4DXKFNrSOpQ5VDjtVJ7AD/c/fv/Kz02tD5
9GqHfF3TxAnRipbPhVD0so4sxX8tWgQ=
=JOTt
-----END PGP SIGNATURE-----

--FSLcchgfNrSvT+e1--
