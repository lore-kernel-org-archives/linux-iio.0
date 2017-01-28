Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdA1X64 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 18:58:56 -0500
Date: Sun, 29 Jan 2017 00:57:48 +0100
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
Subject: [PATCH 0/2] iio: distance: devantech srf04 us ranger
Message-ID: <20170128235748.GA4775@andreas>
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
Look at the source code for details.

Documenation can be found at:
http://www.robot-electronics.co.uk/htm/srf04tech.htm

Andreas Klinger (2):
  iio: distance: add dt binding for devantech-srf04
  iio: distance: add devantech us ranger srf04

 .../bindings/iio/proximity/devantech-srf04.txt     |  17 ++
 MAINTAINERS                                        |   6 +
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/srf04.c                      | 269 +++++++++++++++++++++
 5 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
 create mode 100644 drivers/iio/proximity/srf04.c

-- 
2.1.4

