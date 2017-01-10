Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbdAJSrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 13:47:35 -0500
Date: Tue, 10 Jan 2017 19:47:01 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH v2 0/2] iio: distance: srf08: add IIO driver for us ranger
Message-ID: <20170110184701.GA15501@andreas>
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

Documentation about the sensor can be found here:

http://www.robot-electronics.co.uk/htm/srf08tech.html

Changes in v2:
Lots of updates thanks to Peters really fast review within 30 minutes 
after first submission of the driver.

* Patch 2: "iio: distance: srf08: add IIO driver for us ranger"
  - alphabetic order in Makefile
  - use of u8 while accessing registers 
  - avoid endianness problems with 16 bit values
  - missing return value checks
  - some explaining documentation added

Andreas Klinger (2):
  iio: distance: srf08: add trivial DT binding
  iio: distance: srf08: add IIO driver for us ranger

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  15 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/srf08.c                      | 362 +++++++++++++++++++++
 5 files changed, 380 insertions(+)
 create mode 100644 drivers/iio/proximity/srf08.c

-- 
2.1.4

