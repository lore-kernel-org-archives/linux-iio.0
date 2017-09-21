Return-Path: <SRS0=Ufmi=AW=free-electrons.com=maxime.ripard@kernel.org>
Date: Thu, 21 Sep 2017 21:32:11 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/6] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
Message-ID: <20170921193211.pjsikkez5by46mfh@flea>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
 <20170918073336.j7finend3g76chsu@flea.lan>
 <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io>
 <20170918083045.7bfiialtbm7w6i7j@flea.lan>
 <e73ead447af89031749e85207cac1e69@aosc.io>
 <20170920075223.jaeswlhcqgu4yhse@flea.home>
 <27449039-F0D4-4663-B596-C95D4408D471@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xrpfzdegowdydefx"
In-Reply-To: <27449039-F0D4-4663-B596-C95D4408D471@aosc.io>
List-ID: <linux-iio@vger.kernel.org>


--xrpfzdegowdydefx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 08:04:02AM +0000, Icenowy Zheng wrote:
> =E4=BA=8E 2017=E5=B9=B49=E6=9C=8820=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
3:52:23, Maxime Ripard <maxime.ripard@free-electrons.com> =E5=86=99=E5=88=
=B0:
> >On Mon, Sep 18, 2017 at 03:47:25PM +0000, icenowy@aosc.io wrote:
> >> =E5=9C=A8 2017-09-18 16:30=EF=BC=8CMaxime Ripard =E5=86=99=E9=81=93=EF=
=BC=9A
> >> > On Mon, Sep 18, 2017 at 03:36:43PM +0800, Icenowy Zheng wrote:
> >> > > =E4=BA=8E 2017=E5=B9=B49=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=
=E5=8D=883:33:36, Maxime Ripard
> >> > > <maxime.ripard@free-electrons.com> =E5=86=99=E5=88=B0:
> >> > > >On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
> >> > > >> Allwinner H3 features a thermal sensor like the one in A33,
> >but has
> >> > > >its
> >> > > >> register re-arranged, the clock divider moved to CCU
> >(originally the
> >> > > >> clock divider is in ADC) and added a pair of bus clock and
> >reset.
> >> > > >>
> >> > > >> Update the binding document to cover H3.
> >> > > >>
> >> > > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> > > >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >> > > >> ---
> >> > > >> Changes in v4:
> >> > > >> - Add nvmem calibration data (not yet used by the driver)
> >> > > >> Changes in v3:
> >> > > >> - Clock name changes.
> >> > > >> - Example node name changes.
> >> > > >> - Add interupts (not yet used by the driver).
> >> > > >>
> >> > > >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30
> >> > > >++++++++++++++++++++--
> >> > > >>  1 file changed, 28 insertions(+), 2 deletions(-)
> >> > > >>
> >> > > >> diff --git
> >a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> > > >b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> > > >> index badff3611a98..6c470d584bf9 100644
> >> > > >> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> > > >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> > > >> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can
> >also
> >> > > >act as a thermal sensor
> >> > > >>  and sometimes as a touchscreen controller.
> >> > > >>
> >> > > >>  Required properties:
> >> > > >> -  - compatible: "allwinner,sun8i-a33-ths",
> >> > > >> +  - compatible: must contain one of the following
> >compatibles:
> >> > > >> +		- "allwinner,sun8i-a33-ths"
> >> > > >> +		- "allwinner,sun8i-h3-ths"
> >> > > >>    - reg: mmio address range of the chip,
> >> > > >>    - #thermal-sensor-cells: shall be 0,
> >> > > >>    - #io-channel-cells: shall be 0,
> >> > > >>
> >> > > >> -Example:
> >> > > >> +Optional properties:
> >> > > >> +  - nvmem-cells: A phandle to the calibration data provided
> >by a
> >> > > >nvmem device.
> >> > > >> +                 If unspecified default values shall be used.
> >> > > >> +  - nvmem-cell-names: Should be "calibration-data"
> >> > > >
> >> > > >I'd prefer to have which sensor it applies to here. It wouldn't
> >change
> >> > > >anything for the H3, but it definitely does for example for the
> >A83t
> >> > > >that has two sensors, one for each cluster, and one for the GPU,
> >each
> >> > > >with calibration data.
> >> > > >
> >> > > >What about cluster0-calibration?
> >>=20
> >> I prefer sensor0-calibration to sensor3-calibration now.
> >> (Theortically the new generation THS can support up to 4 sensors)
> >
> >The mapping that explains what sensor0 means can change in the
> >future. It's better to be explicit here, and just say upfront what
> >it's about.
>=20
> I think for some SoC (e.g. A64) there's no clear explain on
> the functions of the sensors.

It's documented in the user manual ("sensor0 located in the CPU, sensor1 and
sensor2 located in the GPU"

> In addition, in the THS controller the sensors has a explicit
> sequence, and when referencing it in the DT the number is still
> needed (in thermal zones).

Yes, but that's something that can be made easier through defines too.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--xrpfzdegowdydefx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZxBO7AAoJEBx+YmzsjxAg6f4P/30UxRxlmMOxvj6Pb00SZ/R9
pUnGUwcyWdLSvR/dp6sQC85b75OGsX9kxp0ntFITQ9Bx9CHbsZa29GGa+zKMRw1L
ONcyRG3vt8bqUuwlXe6xIIWnUW5p5Gp/iIS2V1ZHT0d+vSha9MmldAO5RwvlK0NI
vW90Q++EDGS/X2jmv/Qi8kh2gtf+ghREVMuN8Mgh/LPIXyJ2BcodvHGXZFIRZ91S
rBTB4K9tZMl7CLaSJtlj7/hOuquUUfQUMD8ftbwyt0jbUJQA+NfkwmB2a3kPIVVz
qIzr++Rhl+d5B2Ipi4gjh6UFN/Pvnka94d06HMzr534HaTKByyki6MvIuBKiLLVJ
JpYIA4OAiEvkmBPf2JObFej0iyB3crbT9gVeau/f8eP11JwPDeqCFrd3yPVsbDtL
XP/E4x+b217mjNWPx9mFRg4MNCKFR5om8Qyzhkp+F3EJu6TppeJp/05nx+PK4OtC
Ljs2iWLPSarNH8bt7gL4E9HL+/vXfvo12CgxAkbCsvUQ8iwmSNQGIRzJLw46XBTv
qpJw7X4gKNGH93OboA518bGDIO3etr8+tmzxKaCOkrBU/lNgT6ewrNeM6NAIk53f
8BaBXNHXB2E4qbFeuW8IM+fc6fejT26tFVlZw7VR/tPUVE/WCWxbYyXt2IJQSuT/
TZEQiHAbBuCYMChM5gwU
=aKAN
-----END PGP SIGNATURE-----

--xrpfzdegowdydefx--
