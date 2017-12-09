Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdLIXZk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Dec 2017 18:25:40 -0500
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Marius Tarcatu <marius.tarcatu@infineon.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] iio: magnetometer: Infineon TLV493D-A1B6 support
Date: Sun, 10 Dec 2017 00:25:05 +0100
Message-Id: <20171209232507.18594-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This mini-series adds initial support for the Infineon TLV493D-A1B6 3D Magnetic
Sensor found on the Infineon 3D Magnetic Sensor 2Go Kit.

Tested on a Raspberry Pi 3 with a DT Overlay.
https://github.com/afaerber/dt-overlays/blob/master/bcm2837-rpi-3-b%2Btlv493d-a1b6.dts

Have a lot of fun!

Cheers,
Andreas

Cc: Marius Tarcatu <marius.tarcatu@infineon.com>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org

Andreas Färber (2):
  dt-bindings: Add Infineon TLV493D-A1B6
  iio: magnetometer: Add Infineon TLV493D-A1B6

 .../devicetree/bindings/trivial-devices.txt        |   1 +
 drivers/iio/magnetometer/Kconfig                   |   9 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 328 +++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 drivers/iio/magnetometer/tlv493d.c

-- 
2.13.6

