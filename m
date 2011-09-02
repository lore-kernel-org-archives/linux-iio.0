Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH V2 1/4] i2c: Add irq_gpio field to struct i2c_client.
Date: Fri, 2 Sep 2011 18:05:27 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 Jean Delvare <khali@linux-fr.org>,
 Ben Dooks <ben-linux@fluff.org>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Chew <AChew@nvidia.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Grant Likely <grant.likely@secretlab.ca>
References: <1314895964-15964-1-git-send-email-swarren@nvidia.com> <4E60985B.6010901@cam.ac.uk> <74CDBE0F657A3D45AFBB94109FB122FF04B327A55D@HQMAIL01.nvidia.com>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A55D@HQMAIL01.nvidia.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201109021805.27569.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Friday 02 September 2011, Stephen Warren wrote:
> The idea was specifically to replace the need to call irq_to_gpio(i2c->irq).
> If we did just rename it plain "gpio" and allow it to be used for anything,
> then that does indeed start looking more like device-specific platform data.
> 
> I guess it sounds like consensus is to go that way. It does seem like that
> will end up creating a bunch more device-specific platform-data files though.
> I wonder if adding IORESOURCE_GPIO would make sense so this could be handled
> in a generic way without custom platform data types?

Interesting point. That's probably best for Grant to comment on, because
it depends on the long-term direction he wants to take with this.

I suppose that an IORESOURCE_GPIO makes a lot of sense if we expect
to keep having a flat system-wide gpio number space in the long run,
similar to irq numbers.

It would not fit well if we expect gpio numbers to be local to
a gpio controller, with no unique global identifier for them, similar
to how dma channels in the dma-engine subsystem are handled.

	Arnd
