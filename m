Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: iio: mma8452: power saving features for v4.7
Date: Thu,  3 Mar 2016 09:24:00 +0100
Message-Id: <1456993444-21320-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

The accelerometers supported by mma8452 can use significantly less power if
configured accordingly. Let's make use of this:

 * add support for runtime power management
   (disabling the device after 2 seconds of inactivity), and
 * add a "power_modes" property to IIO sysfs, that offers a "low_power"
   *active* mode of operation that roughly consumes half the power of
   the default mode.

If you don't have CONFIG_PM enabled, by default nothing changes for you.

Here's how it's done and tested on MMA8653FC:

[PATCH 1/4] iio: mma8452: coding style fixes
[PATCH 2/4] iio: mma8452: avoid switching to active because of config
[PATCH 3/4] iio: mma8452: add support for runtime power management
[PATCH 4/4] iio: mma8452: add low_power mode
