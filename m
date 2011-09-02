Return-Path: <swarren@nvidia.com>
From: Stephen Warren <swarren@nvidia.com>
To: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@cam.ac.uk>
CC: Ben Dooks <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Andrew
 Chew <AChew@nvidia.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devel@driverdev.osuosl.org"
	<devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
Date: Fri, 2 Sep 2011 11:24:04 -0700
Subject: RE: [PATCH V3 1/5] i2c: Add irq_gpio field to struct i2c_client,
  i2c_board_info.
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A628@HQMAIL01.nvidia.com>
References: <1314914676-28397-1-git-send-email-swarren@nvidia.com>
	<20110902085620.4ad918c4@endymion.delvare>	<4E609F9C.5020403@cam.ac.uk>
 <20110902112435.69c9e8f7@endymion.delvare>
In-Reply-To: <20110902112435.69c9e8f7@endymion.delvare>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jean Delvare wrote at Friday, September 02, 2011 3:25 AM:
> Hi Jonathan,
>=20
> On Fri, 02 Sep 2011 10:19:24 +0100, Jonathan Cameron wrote:
> > On 09/02/11 07:56, Jean Delvare wrote:
> > > Stephen,
> > >
> > > Can you please fix your e-mail client / system / whatever so that you=
r
> > > patch series are no longer sent duplicated?
> > >
> > > On Thu,  1 Sep 2011 16:04:27 -0600, Stephen Warren wrote:
> > >> Some devices use a single pin as both an IRQ and a GPIO. In that cas=
e,
> > >> irq_gpio is the GPIO ID for that pin. Not all drivers use this featu=
re.
> > >> Where they do, and the use of this feature is optional, and the syst=
em
> > >> wishes to disable this feature, this field must be explicitly set to=
 a
> > >> defined invalid GPIO ID, such as -1.
> > >>
> > >> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > >> ---
> > >> v3: Also add the field to i2c_board_info, and copy the field from
> > >>     i2c_board_info to i2c_client upon instantiation
> > >
> > > I don't get the idea. The i2c core doesn't make any use of the field,
> > > and that field will only be used by a few drivers amongst the 420+
> > > i2c drivers in the tree. This looks like a waste of memory. What's wr=
ong
> > > with including the new field in the private platform or arch data
> > > structure for drivers which need it?
> >
> > Why not make it platform data for now and 'if' it becomes way more comm=
on
> > (probably won't) we can always propose adding as a general field at a l=
ater
> > date.
>=20
> Yes, this sounds like a much more reasonable approach.

BTW, if that's the direction that's decided, just take the first version
of the patchset I posted, plus Jonathan Cameron's subsequent patch to
modify ak8975 to accept GPIO ID through platform data.

--=20
nvpublic
