Return-Path: <SRS0=SQs8=KJ=gmail.com=marcus.folkesson@kernel.org>
Date: Wed, 25 Jul 2018 21:04:41 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180725190441.GA3373@gmail.com>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
 <20180724183004.20279-2-marcus.folkesson@gmail.com>
 <20180725175117.GA825@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <20180725175117.GA825@rob-hp-laptop>
List-ID: <linux-iio@vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

Thank you for the review.

On Wed, Jul 25, 2018 at 11:51:17AM -0600, Rob Herring wrote:
> On Tue, Jul 24, 2018 at 08:30:03PM +0200, Marcus Folkesson wrote:
> > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > ---
> >=20
> > Notes:
> >     v2:
> >     	- drop channel width
> >     	- drop `external_vref`
> >     	- replace `external-clock` with proper clock bindings
> >=20
> >  .../devicetree/bindings/iio/adc/mcp3911.txt        | 28 ++++++++++++++=
++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.t=
xt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Do=
cumentation/devicetree/bindings/iio/adc/mcp3911.txt
> > new file mode 100644
> > index 000000000000..af5472f51a84
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > @@ -0,0 +1,28 @@
> > +* Microchip MCP3911 Dual channel analog front end (ADC)
> > +
> > +Required properties:
> > + - compatible: Should be "microchip,mcp3911"
> > + - reg: SPI chip select number for the device
> > +
> > +Recommended properties:
> > + - spi-max-frequency: Definition as per
> > +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> > +	 Max frequency for this chip is 20MHz.
> > +
> > +Optional properties:
> > + - device-addr: Device address when multiple MCP3911 chips are present=
 on the
> > +	same SPI bus. Valid values are 0-3. Defaults to 0.
>=20
> Isn't this the reg value?
>=20

The reg value defines which chip select the chip hangs on.
The chip has support to connect up to four chips on the same SPI bus,
including the same chip select signal.

The chips are separated by the device-addr as it is part of the
communication protocol.

When reading the description for device-addr, I agree that it fits well
for the reg property as well..


> > + - vref-supply: Phandle to the external reference voltage supply.
> > + - clocks: Phandle and clock identifier (see clock-names)
> > + - clock-names: "adc_clk" for the ADC (sampling) clock
>=20
> Datasheet calls this clki (or mclk internally). Or just drop clock-names=
=20
> as it is pointless=20
> when there is only 1 clock.=20

I will drop the clock-names, thanks!

>=20
> Also DR handling as an IRQ is missing.

I have considered using the DR signal, but as we not support buffering
yet I did not see any point in using it.

=46rom the datasheet, section 7.1 ::

	These registers [channel registers] are latched when an
	ADC read communication occurs. When a data ready
	event occurs during a read communication, the most
	current ADC data is also latched to avoid data
	corruption issues. The three bytes of each channel are
	updated synchronously at a DRCLK rate. The three
	bytes can be accessed separately if needed but are
	refreshed synchronously.

So it should be safe to read the values independently of the DR signal.
Or maybe I'm missing something.


Best regards
Marcus Folkesson

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltYycQACgkQiIBOb1ld
UjJHZw/8CMIIsAbrC+kAnKC22Si3zdJ0wI2utMTjCdlmdRwDSKxUdw1kNM0+vlDR
Er66pJ6okfPp1Y7+kXTYa8QKcoXwAp6+wIeCoAGRZ1gP6ZeK2IPIED0d/tPa62xO
4f/Z68+P936iQp1avmY0ncgu2JtGIxmQDC+wa1aPqATgMm/RGrGjnDJnU9NCNAHx
l3JhP/4Gd0WCZOfZu+UaAF1tU4ZCbr/FR3u8XVOJeg6c7cnMA7YeUtGnjv1pi7du
Yqy2mPLqdVdux3SwXZ60UzZ06G+AgswkOvGcVcNHPTn4fawkrbeZ0staPd2FkGCn
LTQ07nnGc717C6O16axSqmnC1Bk/tzFXQYazruhTQ3pJ+I0fzLovdUN0rBHnSJ/e
jzqGcDKRTp41XiNaUHGo1GgCILxoSvCMWT8Ja5zNW2Zmn38jK8cqv4wA/sqVAUXj
2K8HMmL3GNNy5IysRKSnofWc5347u76cF2SowwsXz0CH9lT2qkk7p7Fdy+pFEJVl
6nGrzY5+MS0MJwkFb7iWDiC6rBA5Saw5xOo5ZECvMv0u9v0oo6i9qOQhpyS4Ezdl
Rqt3CXEfkZhebNA+Mekqafie832Z6U3Ai8Gri6ZNjdEPxzEppRufovvXmI8CB1xT
v3+tzULwxbJ1blSUhzp9kfJECzcK1ia9yCHpbCCw0EIDUqxgwes=
=xhv2
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
