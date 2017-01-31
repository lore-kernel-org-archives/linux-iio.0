Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:50317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdAaSDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 13:03:41 -0500
Date: Tue, 31 Jan 2017 19:02:32 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org, dledford@redhat.com,
        akpm@linux-foundation.org, shraddha.6596@gmail.com, w@1wt.eu,
        balbi@kernel.org, mtk.manpages@gmail.com, sjenning@redhat.com,
        ksenija.stanojevic@gmail.com, vilhelm.gray@gmail.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH v3 0/2] iio: distance: devantech srf04 us ranger
Message-ID: <20170131180232.GA12868@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for the devantech srf04 ultrasonic ranger as
IIO device.

The device is able to recognize objects in a range of 1 cm and 3 meters.
The theoretical resolution is about 3 mm, practically more or less 1 cm.

Use cases for this device are level metering in tanks or distance measuring
in robotics.

This driver works by triggering the device and waiting for the echo, for
which a GPIO is set when send out and reset when the echo is received. 
The echo must be an interrupt and the time between rising and falling is
measured.

The returned distance is calculated with a ultrasonic speed of 343 m/s
which is the correct value at 20 degrees celsius.
For different temperatures one might want to compensate the temperature.
Look at the source code for a more detailed explanation of the calculation
and bounds.

The measurement cycle as timing diagram looks like: (taken from the source
code to illustrate here)

         +---+
GPIO     |   |
trig:  --+   +------------------------------------------------------
         ^   ^
         |<->|
        udelay(10)

ultra           +-+ +-+ +-+
sonic           | | | | | |
burst: ---------+ +-+ +-+ +-----------------------------------------
                          .
ultra                     .              +-+ +-+ +-+
sonic                     .              | | | | | |
echo:  ----------------------------------+ +-+ +-+ +----------------
                          .                        .
                          +------------------------+
GPIO                      |                        |
echo:  -------------------+                        +---------------
                          ^                        ^
                          interrupt                interrupt
                          (ts_rising)              (ts_falling)
                          |<---------------------->|
                             pulse time measured
                             --> one round trip of ultra sonic waves

Documenation can be found at:
http://www.robot-electronics.co.uk/htm/srf04tech.htm

Changes in v3:
Thanks to the review of Jonathan who pointed out two improvements.

* Patch 2: iio: distance: add devantech us ranger srf04
  - first get the time and then ask value of gpio pin to be more exactly in
    the interrupt_handler
  - use devm_iio_device_register() and remove srf04_remove()

Changes in v2:
Many thanks to the thorough reviews of Peter and Lars-Peter. Many
improvements have been identified and are now implemented in the driver.

* Patch 1: iio: distance: add dt binding for devantech-srf04
  - add more explanation about the GPIOs and there usage

* Patch 2: iio: distance: add devantech us ranger srf04
  - add documentation about how the driver is supposed to work together
    with a small timing diagram
  - improved locking: mutex is hold during the measurement cycle to ensure
    only one tasks set the output and waits for the response
  - documentation about maximum time accepted as valid ultrasonic response
  - removed dev_info(); it was there for debugging reasons and is no longer
    needed
  - usage of devm_request_irq() and iio_device_register()

Andreas Klinger (2):
  iio: distance: add dt binding for devantech-srf04
  iio: distance: add devantech us ranger srf04

 .../bindings/iio/proximity/devantech-srf04.txt     |  28 ++
 MAINTAINERS                                        |   6 +
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/srf04.c                      | 304 +++++++++++++++++++++
 5 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
 create mode 100644 drivers/iio/proximity/srf04.c

-- 
2.1.4

