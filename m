Return-Path: <SRS0=6PT2=II=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki"
	 <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg
	 <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Hartmut Knaack
	 <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Date: Mon, 21 May 2018 16:13:34 +0300
In-Reply-To: <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
	 <f9fc420005d926b2d35854331ec0288d3a98c925.camel@linux.intel.com>
	 <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2018-05-21 at 14:34 +0200, Hans de Goede wrote:
> On 21-05-18 11:19, Andy Shevchenko wrote:

> > > Patches 6-9 use the new functionality creating  one i2c-client per
> > > I2cSerialBusV2 resource to make the sensor cluster on the HP X2
> > > work
> > > and
> > > are posted as part of this series to show how this functionality
> > > can
> > > be
> > > used.
> > 
> > I suppose it's better to do an "MFD" type of IIO driver for that
> > chip.
> > Check, for example, drivers/iio/imu/bmi160/bmi160_core.c
> 
> That seems to be a single chip listening on a single i2c address / spi
> chip-select.

Ooops, wrong reference.

> In the BSG1160 case the 3 sensors are listening on 3 different i2c
> addresses.

There is a Bosh magnetometer + accelerometer chip (BMC150). We have just
two independent drivers for them. Luckily for ACPI they have different
IDs (on the platforms where it's used like that).

So, my series targeting the series of same IPs under one device...

> We could use the drivers/mfd framework, but the we get platform
> devices
> and we would need to patch all 3 existing drivers to support platform
> bindings and get a regmap from there (converting them to regmap where
> necessary).

...and in your case MFD sounds better. Though why do you need to have a
common regmap?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
