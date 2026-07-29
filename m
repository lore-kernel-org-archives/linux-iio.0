Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABD3D9DD7;
	Wed, 29 Jul 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358080; cv=none; b=VJRm+Sq14d4WYfKT+QxKOv7aWAv3elX8/V9iufhnruRp/2aExDuLNueyzFzFtUWjiGll55odvAckDrmVq+/o04m5cKRHIl51sGUqT/hK3k6T+Ztz0TZgJfQH7sTtYz6A2k9Gl39Lvp8l5aaQIvjJS4OqIGi4KY4iniUltpv7TYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358080; c=relaxed/simple;
	bh=kmrVgsXdfqOCx8i6BHt0bOfCHxunCU/x25fxz7sPQPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAuKrh2p3z80E5rsHupubKYsrZu3CCCWTkmOYrDDmlCj9terZyFaUyyPry0RFUvjSTgv8PC3Z/bBQpsBKe+iiH6QVkUrLdAjBkwstPKbGSzc7+madCGdOpk2b+rom7YQXtWA6KN2+GyjEDW96EETCZ/QMlenF8suWfcE+AGwzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUxUsJhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUxUsJhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F08E1F000E9;
	Wed, 29 Jul 2026 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785358072;
	bh=YkV6rISoCu+fAaQT3dWDfFizbFzVweE3SNioXxA5sCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TUxUsJhp6JGmt6uXPS8WT/IN2BYerMuGdmcpsOsVJb6cp4hvYnaT4PcaOHYlZfmnW
	 atCZRsNMJQiDZoBY6425iXjdpt1cVnUzgpD3YCC/OrYWsJyhQ3b/PigJgIvcwnP9wr
	 RhQxEGeslvXbLhAK4g24oW78yfRSZ9lmeYQZGR6zHKCDZZ1AvU88SntwXYuYFOKO+U
	 4/xypX65fSLIfK+aDSYavLeMKbMxiA6XhW4Wq2NnZw5F4GqAWjLkfLFWt4EyjkwKji
	 pU6uMo+P7QZsUmTmbgVfx5hXYAjNRCNeLVI+RGdOKXizkwKlI6RJJijAgBM/kiFB0A
	 2wVXu0za1Lk/Q==
Date: Wed, 29 Jul 2026 21:47:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260729-hundredth-suffice-f28afa67bc06@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xw+N1UAUFYpS9Flr"
Content-Disposition: inline
In-Reply-To: <20260728221719.7f668a73@jic23-huawei>

--xw+N1UAUFYpS9Flr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote:
> On Tue, 28 Jul 2026 17:00:55 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote:
> > > On Sat, 25 Jul 2026 15:57:07 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >  =20
> > > > On 7/22/26 2:54 AM, Janani Sunil wrote: =20
> > > > > Add the generic spi-device-addr property to the binding and depre=
cate
> > > > > the existing vendor specific microchip,hw-device-address property.
> > > > >=20
> > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         |=
 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,=
mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.=
yaml
> > > > > index 675319276197..de1ea289e7f5 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564=
=2Eyaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564=
=2Eyaml
> > > > > @@ -80,6 +80,7 @@ properties:
> > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > >      minimum: 0
> > > > >      maximum: 3
> > > > > +    deprecated: true
> > > > >      description:
> > > > >        The address is set on a per-device basis by fuses in the f=
actory,
> > > > >        configured on request. If not requested, the fuses are set=
 for 0x1.
> > > > > @@ -91,6 +92,12 @@ properties:
> > > > >        clocking of the device address (BITS[7:6] - top two bits o=
f COMMAND BYTE
> > > > >        which is first one on the wire).
> > > > > =20
> > > > > +  spi-device-addr:
> > > > > +    maxItems: 1   =20
> > > >=20
> > > > Does it not make sense to all for more than once device connected
> > > > to the same CS here? I would expect maxItems to be 4 to match the
> > > > number of possible addresses.
> > > >  =20
> > >=20
> > > I think for this part their isn't a reason to aggregate.
> > > No magic accesses that touch them all at once.  So this hits
> > > exactly the point you raised about how we set the address for
> > > more than one of them. =20
> >=20
> > No David is actually right here, and maxitems should be 4.
> > Setting the address for multiple was already discussed I thought, with
> > the property being an array and each compatible being used to determine
> > the "stride" between entries based on the number of supported channels?
>=20
> I don't think that applies for this device or at least to do so
> is a major driver rewrite, not a simple binding change.  Probably we'd

Whether or not it is a big driver change, the binding should represent
what the hardware is capable of.

> just add a bus and hang the 4 instances off it. They are running on own
> timing etc so we can't grab data across all of them in any sort of
> synchronous way - the clocks will probably drift over time etc.

Did I miss something about the ADI devices in this thread where they
have some multicast ability to read all devices at once? I thought that
that was a different series where each device had dedicated mosi and
miso lines, rather than the shared ones here. I didn't think the ad5529r
did anything special from my reading of the datasheet but I'm not the
expert in this area!

> They are independent devices (think of them using spi-device-address
> like an i2c address) -  so why have one DT node for up to 4 of
> them?  Note this is different from the AD5529R where the design
> is intended for them to operate as one single larger device.

I don't buy this argument, I just don't see what differs between the
devices. The microchip datasheet I read talked about using 3 devices to
measure 3 phase power setups (I think that's what it was) which is, in
my book, evidence that they're not just intended to be used
independently.

That said, the more this discussion goes on, the more I think that
merging the devices into a single node is a mistake. Logically there may
be one device, but really there are one to four devices. Doing the
logical device thing is nice maybe for software but I no longer think
that it represents the hardware correctly. I know this will cause
problems with registration of devices in the SPI core, but we need to
pick one representation for these devices that fits in all usecases
and with the things brought up in the other mail I am having a lot of
doubts.

Only going to reply to this for now, I'll reply to the other thread of
this conversation later so as not to end up duplicating discussion, but
I am thinking of things like what if someone puts a mcp3654r and an
ad5529r on the same chip select? I think that's actually perfectly
functional on a hardware level, provided the fuses/pins are set up
correctly (and if it is not, mixing the microchip devices is possible
and probably mixing future ADI ones will be too).

Cheers,
Conor.

--xw+N1UAUFYpS9Flr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCampm8AAKCRB4tDGHoIJi
0mivAP9rCEbG5qLXmNs7la92hDJM/u5bXPae1zq/5WP52YDCYgD/WemkvJ6s/E9A
XEBSWh5RufyJUAiBfSDsxfxyGUTrNAU=
=OwuA
-----END PGP SIGNATURE-----

--xw+N1UAUFYpS9Flr--
