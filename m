Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:52466 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdAQNtn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2017 08:49:43 -0500
Date: Tue, 17 Jan 2017 14:48:47 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH v3 0/3] iio: distance: srf08: add IIO driver for us ranger
Message-ID: <20170117134847.GA22869@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds IIO driver support for srf08 ultrasonic ranger
devices.

The first patch add a trivial device tree binding for the device together
with a new vendor devantech.

The second patch is the IIO driver which in turn is using I2C to talk to
the device.

The third patch documents the added userspace ABI

Documentation about the sensor can be found here:

http://www.robot-electronics.co.uk/htm/srf08tech.html

Changes in v3:
Thanks to the reviews of Jonathan, Rob and Lars.
Some changes to the driver were made:

* Patch 2: "iio: distance: srf08: add IIO driver for us ranger"
  - defaults values for sensitivity (gain) and max. range are set in
    probe()
  - while waiting for ultrasonic echo first wait as long as the physically
    measurement need as a function of the max. range and then wait in 
    smaller steps until the response can be read.
  - attributes are now called sensor_sensitivity instead of gain and
    sensor_max_range instead of range_mm
  - device-name is now "srf08"
  - config menu is now calles "Proximity and distance sensors" instead of a
    separate menu

* Patch 3: "iio: distance: srf08: add driver ABI documentation"
  - newly created to document the driver specific interfaces

Changes in v2:
Lots of updates thanks to Peters really fast review within 30 minutes 
after first submission of the driver.

* Patch 2: "iio: distance: srf08: add IIO driver for us ranger"
  - alphabetic order in Makefile
  - use of u8 while accessing registers 
  - avoid endianness problems with 16 bit values
  - missing return value checks
  - some explaining documentation added

Andreas Klinger (3):
  iio: distance: srf08: add trivial DT binding
  iio: distance: srf08: add IIO driver for us ranger
  iio: distance: srf08: add driver ABI documentation

 .../ABI/testing/sysfs-bus-iio-distance-srf08       |  27 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  13 +-
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/srf08.c                      | 405 +++++++++++++++++++++
 6 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
 create mode 100644 drivers/iio/proximity/srf08.c

-- 
2.1.4


-- 

