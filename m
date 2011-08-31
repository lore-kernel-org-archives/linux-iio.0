Return-Path: <AChew@nvidia.com>
From: Andrew Chew <AChew@nvidia.com>
To: Stephen Warren <swarren@nvidia.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Russell King <linux@arm.linux.org.uk>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Arnd Bergmann <arnd@arndb.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Stephen Warren
	<swarren@nvidia.com>
Date: Wed, 31 Aug 2011 12:45:09 -0700
Subject: RE: [PATCH 1/3] staging:iio:magnetometer:ak8975 Don't use
 irq_to_gpio()
Message-ID: <643E69AA4436674C8F39DCC2C05F76383CF3C784A3@HQMAIL03.nvidia.com>
References: <1314819657-828-1-git-send-email-swarren@nvidia.com>
In-Reply-To: <1314819657-828-1-git-send-email-swarren@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Subject: [PATCH 1/3] staging:iio:magnetometer:ak8975 Don't=20
> use irq_to_gpio()
>=20
> Tegra doesn't have irq_to_gpio() any more, and ak8975 is included in
> tegra_defconfig. This causes a build failure. Solve this with=20
> a heavy-handed
> method for now.
>=20
> I suspect the long-term solution is to pass both the IRQ and GPIO IDs
> to the driver; the GPIO ID coming from either platform data,=20
> or perhaps
> enhancing struct i2c_client to add a gpio field alongside irq.
>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

The three patches in this set LGTM.

Acked-by: Andrew Chew <achew@nvidia.com>=20
