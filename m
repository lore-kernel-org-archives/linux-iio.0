Return-Path: <SRS0=QiD3=CE=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Maciej Purski <m.purski@samsung.com>
CC: <linux-iio@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	<linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>, "Javier
 Martinez Canillas" <javier@osg.samsung.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>
Subject: Re: [2/3] iio: adc: ina2xx: Adhere to documented ABI, use Ohm instead of uOhm
Date: Mon, 6 Nov 2017 11:21:03 +0100
Message-ID: <1952714.EgNKj5xy7d@pebbles>
In-Reply-To: <678f7605-3fc8-cc28-cb16-45381d75bad7@samsung.com>
References: <7ee955b2-a58f-45e0-985d-1f7508d41ae7@rwthex-w2-a.rwth-ad.de> <2075928.pSFUuclJ1z@pebbles.site> <678f7605-3fc8-cc28-cb16-45381d75bad7@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4233964.QcaCUNRIVi";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--nextPart4233964.QcaCUNRIVi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, November 2, 2017 10:04:01 AM CET Maciej Purski wrote:
> On 10/14/2017 08:27 PM, Stefan Bruens wrote:
> > On Montag, 9. Oktober 2017 11:29:43 CEST Maciej Purski wrote:
> >> On 10/01/2017 09:48 PM, Stefan Br=FCns wrote:
> >>> According to the ABI documentation, the shunt resistor value should be
> >>> specificied in Ohm. As this is also used/documented for the MAX9611,
> >>> use the same for the INA2xx driver.
> >>>=20
> >>> This poses an ABI break for anyone actually altering the shunt value
> >>> through the sysfs interface, it does not alter the default value nor
> >>> a value set from the devicetree.
> >>>=20
> >>> Minor change: Fix comment, 1mA is 10^-3A.
> >>=20
> >> I have just a minor issue. There could be an inconsistency with units =
as
> >> in
> >> my patch I make current_lsb adjustable and I need it to be in uA (it u=
sed
> >> to be hardcoded as 1 mA so to achieve better precision we need smaller
> >> units). So in order to keep calibration register properly scaled, I
> >> convert
> >> uOhms to mOhms on each set_calibration(). So if both my changes and yo=
ur
> >> changes were applied, on each shunt_resistore_store we would be
> >> performing
> >> multiplication by 10^6 and then in set_calibration() division by 10^3
> >> which
> >> seems odd to me.
> >>=20
> >> I guess we could keep it as shunt_resistor_ohms instead of
> >> shunt_resistor_uohm. We could avoid performing division on each
> >> shunt_resistor_show() and perform multiplication by 10^3 only once in
> >> set_calibration() on each
> >> shunt_resistore_store(). We could then change the default value and
> >> perform
> >> division only on probing, when reading the shunt_resistance from device
> >> tree.
> >>=20
> >> There are many other options. It's not a major issue so maybe we could
> >> leave it as it is or you could suggest some changes in my patch.
> >=20
> > Sorry it took me so long to answer ...
> >=20
> > The current fixed current_lsb of 1mA is indeed a bad choice for everyth=
ing
> > but a shunt resistor value of 10mOhm, as it truncates the current value.
> > So what is a *good* choice?
> >=20
> > One important point is the current register is merely more than a
> > convenience register. At least for the INA219/220, it provides nothing
> > not achievable in software, and for the INA226 family it only has added
> > value if the current is varying faster than the readout frequency and t=
he
> > averaging is used.
> >=20
> > The precision of the current register is limited by the precision of the
> > shunt voltage register, and may be reduced by the applied
> > scaling/calibration factor.
> >=20
> > The precision of the shunt voltage register is fixed at 10uV (INA219)
> > resp.
> > 2.5uV (INA226). Changing conversion time (both) and PGA (219) affects t=
he
> > noise and offset, but the lsb value is still fixed.
> >=20
> > If one wants to carry over the shunt voltage register precision into the
> > current register, its important no (or hardly any) truncation happens. =
The
> > terms therefor are given in the manual, formulas 8.5.1 (4) resp 7.5.1 (=
3):
> >=20
> > INA219: current =3D shunt_voltage * cal_register / 4096
> > INA226: current =3D shunt_voltage * cal_register / 2048
> >=20
> > So any cal value smaller than 4096 (2048) will introduce truncation
> > errors,
> > larger values may introduce overflows, if the full input range is used.
> > Now, would it not be wise to always use 4096 (2048) for the calibration
> > value?
> >=20
> > The raw values from the IIO subsystem are meaningless without their
> > accompanying scale factor. Instead of changing the calibration value, w=
hy
> > not just change the reported scale factor?
> >=20
> > More opinions are very welcome.
> >=20
> > Kind regards,
> >=20
> > Stefan
>=20
> Thanks for the reply.
>=20
> I agree that cal_register set to 4096 (2048) allows us to eliminate
> truncaction error. However according to your suggestion, if we made cal_r=
eg
> a fixed value, then current_lsb and r_shunt should be also a fixed value,
> as they are related according to formula 8.5 (1)
>=20
> cal_register =3D 0.00512 / (current_lsb * r_shunt)

A fixed cal_register only means the current_lsb is implied by the selected=
=20
shunt resistor value.

If you insert 2048 into the equation above, you get:

current_lsb =3D 2.5 * 1e-6 * r_shunt,

and using Ohms law to replace r_shunt, thats exactly the resolution of the=
=20
shunt_voltage register as specified in the datasheet. The higher the shunt=
=20
resistor value, the smaller the current_lsb.
=20
> Therefore, changing the scale value wouldn't affect the calib_reg value, =
so
> it wouldn't give the user any information on the actual current_lsb of the
> device. The real value is calculated like this by the user:
>=20
> processed_value =3D raw_value * scale
>=20
> I think that even after changing the scale value processed_value is expec=
ted
> to be approximately the same.

A fixed cal_register means you change the current_lsb by changing the shunt=
=20
resistor. This exposes the full ADC resolution.
=20
The current_lsb *is* the scale value.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart4233964.QcaCUNRIVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgA3jwAKCRBvf0o9jP6q
U5fBAJ0eZlkfq6thm9Q5vO0S1nXQES2EMgCfZPUm4qNLnBbmO/HeISO+zVcpPs4=
=vxie
-----END PGP SIGNATURE-----

--nextPart4233964.QcaCUNRIVi--
