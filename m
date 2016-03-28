Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron
	<jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Purdila, Octavian"
	<octavian.purdila@intel.com>, Markus Pargmann <mpa@pengutronix.de>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH 4/6] iio: accel: bmg160: optimize transfers in trigger
 handler
Date: Mon, 28 Mar 2016 16:05:19 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F2155A7@irsmsx105.ger.corp.intel.com>
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
 <1458811771-25217-5-git-send-email-irina.tirdea@intel.com>
 <56F8FFED.2090703@kernel.org> <alpine.DEB.2.02.1603281158290.4312@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1603281158290.4312@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net]
> Sent: 28 March, 2016 13:09
> To: Jonathan Cameron
> Cc: Tirdea, Irina; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.or=
g; Hartmut Knaack; Lars-Peter Clausen; Purdila, Octavian;
> Markus Pargmann; Pandruvada, Srinivas
> Subject: Re: [PATCH 4/6] iio: accel: bmg160: optimize transfers in trigge=
r handler
>=20
>=20

Thanks for the review, Peter!

> > > Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> > > enable/disable the bus at each i2c transfer and must wait for
> > > the enable/disable to happen before sending the data.
> > >
> > > When reading data in the trigger handler, the bmc150 accel driver doe=
s
>=20
> should refer to bmg160
>=20
> > > one bus transfer for each axis. This has an impact on the frequency
> > > of the accelerometer at high sample rates due to additional delays
> > > introduced by the bus at each transfer.
> > >
> > > Reading all axis values in one bus transfer reduces the delays
> > > introduced by the bus.
> > >
> > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > I forgot to highlight on the earlier driver that there is also 'technic=
ally'
> > a bit of an ABI change here because we are now exporting as LE rather t=
han CPU
> > order.  However, I 'hope' anyone actually accessing the buffered data i=
s either
> > doing it through a nice library or hasn't hacked the endian unwinding o=
ut of
> > the generic_buffer example!
>=20
> the patch takes away the possibility to do buffered reads on individual
> channels (not sure if this is useful per se)

We can still read individual channels, but the demux is now handled by the =
iio core
(through available_scan_masks, added in the previous patch).

As Jonathan mentioned in a previous patch, this will impact performance for=
 reading
only a subset of the available channels  (since we will read all 3 axes reg=
ardless of
how many axes the user actually requested  and will receive).
>=20
> this optimizes for the common case, ok;
>=20
> wondering if adding
> .endianness =3D IIO_LE
> is actually an unrelated fix
>=20

Thanks for catching this!=20
I already covered this point in the reply to Jonathan.

Thanks,
Irina=20
