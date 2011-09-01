Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/3] staging:iio:magnetometer:ak8975 Don't use irq_to_gpio()
Date: Thu, 1 Sep 2011 18:20:25 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 Andrew Chew <AChew@nvidia.com>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <1314819657-828-1-git-send-email-swarren@nvidia.com> <201109011306.50936.arnd@arndb.de> <74CDBE0F657A3D45AFBB94109FB122FF04B327A2A4@HQMAIL01.nvidia.com>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A2A4@HQMAIL01.nvidia.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201109011820.25307.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 01 September 2011, Stephen Warren wrote:
> One question: When we add this field, how do drivers tell whether a value
> of 0 is an uninitialized field, or a legitimate GPIO value of 0? Should we
> add a flag to indicate validity, or just work hard to not enable driver-
> side code to use this value until we've fixed up all places that instantiate
> the driver to initialize the field to some invalid value like -1?

I think it's enough to coordinate the driver with the initialization of the
i2c data. If a driver requires a GPIO number, it can assume that it's valid.
Drivers that don't need one don't care. If it's an optional feature, you
might want to either use platform_data after all, or use different identifiers
for devices that have a gpio vs. those that have none -- in effect those are
different types of devices handled by the same driver.

	Arnd
