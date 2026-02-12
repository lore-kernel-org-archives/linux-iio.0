Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315272770A;
	Thu, 12 Feb 2026 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919138; cv=none; b=i6USJlB9tKCVCpIWh/S6aNYbMZN8RKC7M/KCVylI8HL1VBhTFT8dK/Z3gfWS771Pi8D1pC1Ger2DfCkqKNP9RTGp8uiib4dd8qysKxkJB9lJmhp7Sv8rrL3NpH7o2g72AjnPunqgftHBMVJhf1fga40xee+vsSvljdByw9oaa/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919138; c=relaxed/simple;
	bh=Jps9SxdcCU01OkuORDlU7vNThHZAOBjftasAsoRZC9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygvk4Z3wwISGRo9KYoVk2hW6Jjitdr6LRScmn12NRCgVDS1F8WbDv0v0qdOOIhZVOt6AgfxRN5c+XAcOZOcPdUKvbTFWY5MXm1/U3jmrJPQ6tfWImcXg5HreXdMkDQL2U1OPriz1Fu4nCcPjSXZNgxsWSrAUaTZXpYcCwe0k1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+UXr/xI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+UXr/xI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C88C4CEF7;
	Thu, 12 Feb 2026 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770919137;
	bh=Jps9SxdcCU01OkuORDlU7vNThHZAOBjftasAsoRZC9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+UXr/xIC+0aYFV9qsulYBjdTw4vCcE7kpQfBYUU3LMel+3rOXMkuxhNLcbE/H7I0
	 laF8JwE7UDCOlJ9Wj85zuEDS6m8D5GxgKf9Bbnn/RvJLXMW27r2SS6VHxnoa5TTDMB
	 edA8cE/EelVEWO9NzTbpzTj3t+lN2Ac1+/T3Lt+8nXMgJfrXhl52Hqz02pP06h0Tky
	 SSAfvGakAdTzqT12DEYhRaAw6hZJbFmDuoaYW8EMpMAM5jDTn92tokOtmXjIUkb7d/
	 TB8DBB9q/lBrln8DUCJSNorWyqeeQyK0dTHpHYi5VJfTIO2tgScV1xFWqV2yi+9i7u
	 IfGSZiNEusXYA==
Date: Thu, 12 Feb 2026 17:58:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for Microchip MCP48FxBy1/2/4/8 DAC with
 an SPI Interface
Message-ID: <20260212-spyglass-synergy-e8400af05f9d@spud>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <aY3YB1MyNnSUszJN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YZ7sj5lcutg0Scsv"
Content-Disposition: inline
In-Reply-To: <aY3YB1MyNnSUszJN@smile.fi.intel.com>


--YZ7sj5lcutg0Scsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 03:39:19PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 12, 2026 at 02:48:33PM +0200, Ariana Lazar wrote:
> > Add support for Microchip MCP48FxBy1/2/4/8 series of buffered voltage
> > output Digital-to-Analog converters with an SPI Interface. This driver
> > covers the following part numbers:=20
> > - With nonvolatile memory:
> >    - MCP48FEB01, MCP48FEB02, MCP48FEB04, MCP48FEB08,
> >      MCP48FEB11, MCP48FEB12, MCP48FEB14, MCP48FEB18,
> >      MCP48FEB21, MCP48FEB22, MCP48FEB24, MCP48FEB28
> >  - With volatile memory:
> >    - MCP48FVB01, MCP48FVB02, MCP48FVB04, MCP48FVB08,
> >      MCP48FVB11, MCP48FVB12, MCP48FVB14, MCP48FVB18,
> >      MCP48FVB21, MCP48FVB22, MCP48FVB24, MCP48FVB28
> >=20
> > The families support up to 8 output channels. The devices can be 8-bit,
> > 10-bit and 12-bit resolution.
>=20
> Is it really v1? I am under impression that I have seen this patch already
> several times...

Me too but I think it's a subtle difference between mcp47febxx and
mcp48febxx that's probably lost in very similar looking part names.

--YZ7sj5lcutg0Scsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaY4U3QAKCRB4tDGHoIJi
0jhTAP0YLxfZJSvZ6lB/jdJSC8wcNY6fhcSNLbtXdAl9vK5N5gEA23k/cKd3GkyA
qtON0DsX7MAdiGa1317wL8H7jqPjgQ8=
=E5SE
-----END PGP SIGNATURE-----

--YZ7sj5lcutg0Scsv--
