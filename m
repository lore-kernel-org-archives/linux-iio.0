Return-Path: <swarren@nvidia.com>
From: Stephen Warren <swarren@nvidia.com>
To: Greg KH <greg@kroah.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@cam.ac.uk>, "devel@driverdev.osuosl.org"
	<devel@driverdev.osuosl.org>, Andrew Chew <AChew@nvidia.com>, Arnd Bergmann
	<arnd@arndb.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely
	<grant.likely@secretlab.ca>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
Date: Mon, 19 Sep 2011 14:59:07 -0700
Subject: RE: [PATCH V3 1/5] i2c: Add irq_gpio field to struct i2c_client,
 i2c_board_info.
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B7321434@HQMAIL01.nvidia.com>
References: <1314914676-28397-1-git-send-email-swarren@nvidia.com>
 <20110902085620.4ad918c4@endymion.delvare> <4E609F9C.5020403@cam.ac.uk>
 <20110902112435.69c9e8f7@endymion.delvare>
 <74CDBE0F657A3D45AFBB94109FB122FF04B327A628@HQMAIL01.nvidia.com>
 <20110906225708.GA28957@kroah.com>
In-Reply-To: <20110906225708.GA28957@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Greg KH wrote at Tuesday, September 06, 2011 4:57 PM:
> On Fri, Sep 02, 2011 at 11:24:04AM -0700, Stephen Warren wrote:
> > Jean Delvare wrote at Friday, September 02, 2011 3:25 AM:
...
> > > > Why not make it platform data for now and 'if' it becomes way more =
common
> > > > (probably won't) we can always propose adding as a general field at=
 a later
> > > > date.
> > >
> > > Yes, this sounds like a much more reasonable approach.
> >
> > BTW, if that's the direction that's decided, just take the first versio=
n
> > of the patchset I posted, plus Jonathan Cameron's subsequent patch to
> > modify ak8975 to accept GPIO ID through platform data.
>=20
> I don't know which patchset that would be, can you please just resend
> what you want applied so that I know I get the correct one?

Sorry for the slow response; I was on vacation for the last couple weeks.
I've now posted an updated version of this patchset, without any of the
changes for I2C/SPI core/types/...

--=20
nvpublic
