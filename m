Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354F223339;
	Mon, 16 Feb 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263299; cv=none; b=FpNfioE59+6HKw3tjGUzfPVHGWz/oSpi8AvM7UxXfZzZI+btmTNLLR9me03Rh4H2RxPwwwEUrZgzCXSLP27WWZuCLCa4LHd5UOTD7f/3pKWt2FsuX2PYXQu7dhdfiudx7qBhUHbkw142yB5i0J9c1xkYAWcW4D+nM31hrNPhqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263299; c=relaxed/simple;
	bh=S6jp6HE5bJ8WeLOUNbgWOl7kXGNoaQtsYcgu88yTK4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjhkMvUe0/R3prVpUR+Aowr312pG+1THONrc+aXJkuH8GJseTJk1h1vfl/WppEOzHKXWiQ4huUsNyG1ajip5g+D5YaKVYcMVejdfXafdZTlwYJ32FLd3gNiDOkxKuWNSPfLZDCSn9InJnAsq/3iSJORbVaS6+0/Zr6ET0PJTG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAi79op7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAi79op7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD86C116C6;
	Mon, 16 Feb 2026 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771263299;
	bh=S6jp6HE5bJ8WeLOUNbgWOl7kXGNoaQtsYcgu88yTK4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAi79op7OmjujgPmGbAINy2IUYbyIxv6hMs36SbUA4Y5Rsu1w4WVTPZpMOcrPZXkP
	 HCHaOnC6RJKIo1UhhEwWAMYhtoJziy0ZsRUcY3nJtGmGjNUDDZP+sqP2FIWpDTfOZx
	 748nFexrNYSbvSi028zEZd8uCjuWLj1kfzUU33pvEa0ZTUIurtHfynCZKNDm+DNKS0
	 0mJqN5pkCMhe6Z++5dMYTlwp5dPY25I52/SjRTUe5jlGnoJYiGn8E75cKuWxMKSYC/
	 /8P7QP5PioUN/fC8H2AZlfYnDz4BJ9KqJGBuQ3rzXbY7JQ2U6DE2dIRQngAoy4IpE9
	 BxxV1zgk8YmPQ==
Date: Mon, 16 Feb 2026 17:34:54 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana.Lazar@microchip.com, andriy.shevchenko@intel.com,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org,
	andy@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
Message-ID: <20260216-shiny-itunes-00a31d1f4db7@spud>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
 <20260212-germless-favoring-c27ab4c53128@spud>
 <aY4yaVP2TQFRI1E4@smile.fi.intel.com>
 <a3bab395580cd83410c1c7364283285586c9b128.camel@microchip.com>
 <5818b02c-4456-4484-9443-da7429cea3dc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dwx5aCoxHNCQkFWd"
Content-Disposition: inline
In-Reply-To: <5818b02c-4456-4484-9443-da7429cea3dc@baylibre.com>


--Dwx5aCoxHNCQkFWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:37:35AM -0600, David Lechner wrote:
> On 2/16/26 7:31 AM, Ariana.Lazar@microchip.com wrote:
> > Hi all,
> >=20
> > Thank you for your reviews.
> >=20
> >=20
> > On Thu, 2026-02-12 at 22:04 +0200, Andy Shevchenko wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >> know the content is safe
> >>
> >> On Thu, Feb 12, 2026 at 06:00:06PM +0000, Conor Dooley wrote:
> >>> On Thu, Feb 12, 2026 at 02:48:34PM +0200, Ariana Lazar wrote:
> >>>> This is the device tree schema for iio driver for Microchip
> >>>> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-
> >>>> Analog
> >>>> Converters with nonvolatile or volatile memory and an SPI
> >>>> Interface.
> >>>>
> >>>> The families support up to 8 output channels.
> >>>>
> >>>> The devices can be 8-bit, 10-bit and 12-bit.
> >>>>
> >>>> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> >>>
> >>> Other than the interface, what's actually different between this
> >>> and the
> >>> 47? Could they share the same binding?
> >>
> >> If that is the case, I don't think we even need a brand new driver,
> >> the
> >> existing one should be refactored to adapt SPI interface.
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
> >>
> >>
> >=20
> >=20
> > I have decided to submit two separate drivers, even though the chips
> > share similar functionality, in order to make it easier for the client
> > to identify the supported chips.
> >=20
> > For example the I2C family of devices has: 3 different resolutions,
> > with 4 different channel numbers available for a particular part and
> > most important you can get the same part with or without EEPROM.
> > That means the I2C driver will cover 24 different devices. The SPI
> > family follows the same pattern, covering another 24 devices.
> >=20
> > Microchip also has some devices (I2C and SPI) with Nonvolatile Memory
> > (similar to EEPROM but limited to fewer than 32 writes) and I want to
> > add these families to the existing drivers while maintaining the split
> > by interface.
> >=20
> > Please tell me if you have anything against this approach (having 2
> > different drivers split based on interface and each of them to support
> > at least 24 different part numbers).
> >=20
> > Best regards,
> > Ariana
>=20
> The usual way we support parts with the same register map that can have
> an I2C or a SPI bus it to make three modules: <name>_core.c, <name>_i2c.c
> and <name>_spi.c. If you look through the iio folders, you will see many
> drivers like this.
>=20
> The _i2c.c and _spi.c files will just contain the chip info tables that
> contain all of the differences between the chips and pass that to a
> common probe function in the _core.c module.
>=20
> It seems like this approach should work in your case as well.

These usually have merged bindings too, right? Only real difference is
going to be that the spi devices will need
spi-peripheral-properties.yaml which obviously the i2c ones wont.

--Dwx5aCoxHNCQkFWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZNVOAAKCRB4tDGHoIJi
0r+aAQD036OEam7410kZEc/wYZBW0bbyawg6RTLg0QL7t5aXjgD/UZIaDlaB3LWX
ZIpRo7HyG+Nqmii2sXht3TwI1kqK9AA=
=R0NF
-----END PGP SIGNATURE-----

--Dwx5aCoxHNCQkFWd--
