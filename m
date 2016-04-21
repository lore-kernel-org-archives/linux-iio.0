Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: Crestez Dan Leonard <leonard.crestez@intel.com>, Peter Rosin
	<peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hartmut
 Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Peter
 Meerwald-Stadler" <pmeerw@pmeerw.net>, Daniel Baluta
	<daniel.baluta@intel.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Kumar
 Gala" <galak@codeaurora.org>
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
Date: Thu, 21 Apr 2016 13:56:18 +0000
Message-ID: <AM4PR02MB1299B78B76BF112B2E06F20BBC6E0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Crestez Dan Leonard wrote:
> On 04/20/2016 11:31 PM, Peter Rosin wrote:
> > Crestez Dan Leonard wrote:
> >> Changes since that version:
> >> * Nest the adapter in inv_mpu6050_state instead of making it static
> >> * Explicitly forward of_node "i2c-aux-master" to allow describing aux =
devices
> >> via devicetree.
> >>
> >> For bypass/mux mode devicetree works automatically. The forwarding is =
based on
> >> the "chan_id" parameter to i2c_add_mux_adapter and is implemented here=
:
> >>
> >> http://lxr.free-electrons.com/source/drivers/i2c/i2c-mux.c?v=3D4.5#L15=
8
> >>
> >> Perhaps it might be better for devices handled via master mode to be d=
escribed
> >> via i2c@1? This would work by scanning the mpu node's children for som=
ething
> >> with reg =3D=3D 1.
> >=20
> > The 0 in i2c@0 (which is used by the mux mode) is the index of the mux =
slave
> > meaning that i2c@1 would be a second mux slave on the same mux, but thi=
s is
> > not a real mux as such, it is a gate which is piggybacking on the i2c m=
ux infra.
> > So, this "mux" can't have a second slave which is why only 0 is valid.
>=20
> This behavior is automatic in i2c mux code and seems to assume that all
> the children of mux_dev are i2c muxes. This might be obviously correct
> and useful for dedicated i2c mux devices but in my case mux_dev is just
> the i2c_client for a sensor.
>=20
> From Documentation/devicetree/bindings/i2c/i2c-mux.txt:
>=20
> > An i2c bus multiplexer/switch will have several child busses that are
> > numbered uniquely in a device dependent manner.  The nodes for an i2c
> > bus multiplexer/switch will have one child node for each child bus.
>=20
> This seems to be written in a way that would allow me to define the
> "auxiliary i2c master" as bus "1". After all, the numbering is device
> dependent and it's not clear that all the child busses need to be
> accessible through muxing rather than indirect access through device
> registers.

You are correct that if you have devicetree children where reg does
not match the chan_id given to i2c_add_mux_adapter() those children
will be ignored by the i2c-mux code. So, the code would be happy with
a devicetree such as:

	mpu6050@68 {
		compatible =3D "...";
		reg =3D <0x68>;
		...
		i2c-aux-mux@0 {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			reg =3D <0>;

			foo@44 {
				compatible =3D "bar";
				reg =3D <0x44>;
				...
			}
		}
		i2c-aux-master@1 {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			reg =3D <1>;

			gazonk@44 {
				compatible =3D "baz";
				reg =3D <0x44>;
				...
			}
		}
	}

as long as you do only call i2c_add_mux_adapter() with chan_id =3D 0. And t=
hat
is what you are doing. But I think it is a bit subtle...

> >> Or maybe the two busses should be called i2c-aux-master and i2c-aux-mu=
x? Not
> >> sure how to deal with that on the mux side.
> >=20
> > Changing i2c to i2c-aux-mux would break existing device trees, that see=
ms
> > like a bad thing, no?
>=20
> That support was not documented in mpu6050's bindings and might not be
> actually used.
>=20
> >> It is not clear how to properly handle this and suggestions are welcom=
e. The
> >> way it currently works with this patch is documented immediately below=
.
> >=20
> > I think the naming could be i2c-master0, i2c-master1 etc if it, with
> > future work, would be possible to add more than one master (you talked =
about
> > 5 i2c slaves..).
>=20
> The device has 5 sets of registers for controlling i2c slaves but only
> one physical auxiliary i2c bus. As far as I can tell slaves 0-3 are
> intended to be used for gathering readings for slaved sensors
> periodically without external intervention. Slave 4 can generate an
> interrupt on completion and is more suitable for general-purpose
> communication with any number of devices.

Ah, ok, so all 5 sets of slave registers are about the same physical i2c
bus. So, you basically cannot sanely use this physical aux i2c bus as an
i2c-mux and an extra i2c adapter in the same hw design. Correct?

In that case, couldn't you look at the names of any devicetree children
and use that to decide if you should even attempt to call
i2c_add_mux_adapter or i2c_add_adapter?

(But please don't clobber stuff for my i2c-mux rework, or you will have
to wait even longer for that deadlock to be resolved)

Cheers,
Peter
