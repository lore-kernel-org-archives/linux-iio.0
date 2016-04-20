Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: Crestez Dan Leonard <leonard.crestez@intel.com>, Jonathan Cameron
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hartmut
 Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Peter
 Meerwald-Stadler" <pmeerw@pmeerw.net>, Daniel Baluta
	<daniel.baluta@intel.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Kumar
 Gala" <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
Date: Wed, 20 Apr 2016 20:31:00 +0000
Message-ID: <AM4PR02MB129981BAE6A4E893DDD38173BC6D0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Crestez Dan Leonard wrote:
> The MPU has an auxiliary I2C bus for connecting external
> sensors. This bus has two operating modes:
> * pass-through, which connects the primary and auxiliary busses
> together. This is already supported via an i2c mux.
> * I2C master mode, where the mpu60x0 acts as a master to any external
> connected sensors. This is implemented by this patch.
>=20
> This I2C master mode also works when the MPU itself is connected via
> SPI.
>=20
> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
> mode while slave 4 is different. This patch implements an i2c adapter
> using slave 4 because it has a cleaner interface and it has an
> interrupt that signals when data from slave to master arrived.
>=20
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>=20
> This is based on earlier work by Daniel Baluta <daniel.baluta@intel.com>:
> https://www.spinics.net/lists/linux-iio/msg23573.html
>=20
> Changes since that version:
> * Nest the adapter in inv_mpu6050_state instead of making it static
> * Explicitly forward of_node "i2c-aux-master" to allow describing aux dev=
ices
> via devicetree.
>=20
> For bypass/mux mode devicetree works automatically. The forwarding is bas=
ed on
> the "chan_id" parameter to i2c_add_mux_adapter and is implemented here:
>=20
> http://lxr.free-electrons.com/source/drivers/i2c/i2c-mux.c#L158

With any luck [1], this reference will be stale when 4.6 is released. It
should be qulified with a version, something like .../i2c-mux.c?v=3D4.5#L15=
8

> Perhaps it might be better for devices handled via master mode to be desc=
ribed
> via i2c@1? This would work by scanning the mpu node's children for someth=
ing
> with reg =3D=3D 1.

The 0 in i2c@0 (which is used by the mux mode) is the index of the mux slav=
e
meaning that i2c@1 would be a second mux slave on the same mux, but this is
not a real mux as such, it is a gate which is piggybacking on the i2c mux i=
nfra.
So, this "mux" can't have a second slave which is why only 0 is valid.

Tl;dr i2c@1 is definitely wrong for something that is not related to i2c@0.

> Or maybe the two busses should be called i2c-aux-master and i2c-aux-mux? =
Not
> sure how to deal with that on the mux side.

Changing i2c to i2c-aux-mux would break existing device trees, that seems
like a bad thing, no?

> It is not clear how to properly handle this and suggestions are welcome. =
The
> way it currently works with this patch is documented immediately below.

I think the naming could be i2c-master0, i2c-master1 etc if it, with
future work, would be possible to add more than one master (you talked abou=
t
5 i2c slaves..).

Cheers,
Peter

[1] https://lkml.org/lkml/2016/4/20/467
