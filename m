Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbdHPTct (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2017 15:32:49 -0400
Date: Wed, 16 Aug 2017 21:32:57 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] iio: srf08: add support for similar devices and
 triggered buffers
Message-ID: <20170816193257.GA24393@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for:
- triggered buffer
- ultrasonic devices srf02 and srf10

Thanks for the review of Peter and Wolfram.

@Wolfram: please let me know, if you want a separate patch for [PATCH 1/5]

Changes in v3:
- introduce struct chip_info for device specific features
- remove locking error in srf08_trigger_handler()

Changes in v2:
- removed unnecessary patch "[PATCH 6/7] iio: srf08: add buffered to device mode"
- incorporated patch "[PATCH 7/7] iio: srf08: change text in Kconfig" where suitable
- changed order of patches to improve logical flow of changes
- improved distinction of sensor types


Andreas Klinger (5):
  iio: srf08: add device tree binding for srf02 and srf10
  iio: srf08: add device tree table
  iio: srf08: add triggered buffer support
  iio: srf08: add sensor type srf10
  iio: srf08: add support for srf02 in i2c mode

 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 drivers/iio/proximity/Kconfig                      |   8 +-
 drivers/iio/proximity/srf08.c                      | 227 ++++++++++++++++++---
 3 files changed, 203 insertions(+), 34 deletions(-)

-- 
2.1.4


-- 
