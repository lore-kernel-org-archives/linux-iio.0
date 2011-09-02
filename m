Return-Path: <swarren@nvidia.com>
From: Stephen Warren <swarren@nvidia.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>, Russell King
	<linux@arm.linux.org.uk>, Andrew Chew <AChew@nvidia.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Date: Fri, 2 Sep 2011 08:30:31 -0700
Subject: RE: [PATCH V2 1/4] i2c: Add irq_gpio field to struct i2c_client.
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A55D@HQMAIL01.nvidia.com>
References: <1314895964-15964-1-git-send-email-swarren@nvidia.com>
 <1314895964-15964-5-git-send-email-swarren@nvidia.com>
 <4E60985B.6010901@cam.ac.uk>
In-Reply-To: <4E60985B.6010901@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote at Friday, September 02, 2011 2:48 AM:
> On 09/01/11 17:52, Stephen Warren wrote:
> > Some devices use a single pin as both an IRQ and a GPIO. In that case,
> > irq_gpio is the GPIO ID for that pin. Not all drivers use this feature.
> > Where they do, and the use of this feature is optional, and the system
> > wishes to disable this feature, this field must be explicitly set to a
> > defined invalid GPIO ID, such as -1.
>
> Why make it specifically an irq related gpio?  Might as well just call it
> gpio then it can be used for cases where it never corresponds to an irq
> such as capture trigger pins.
>=20
> Otherwise I'd be happy to see this go in.

The idea was specifically to replace the need to call irq_to_gpio(i2c->irq)=
.
If we did just rename it plain "gpio" and allow it to be used for anything,
then that does indeed start looking more like device-specific platform data=
.

I guess it sounds like consensus is to go that way. It does seem like that
will end up creating a bunch more device-specific platform-data files thoug=
h.
I wonder if adding IORESOURCE_GPIO would make sense so this could be handle=
d
in a generic way without custom platform data types?

--=20
nvpublic
