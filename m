Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:49478 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdHBXXB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 19:23:01 -0400
Date: Thu, 3 Aug 2017 01:22:59 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, wsa@the-dreams.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] iio: srf08: add support for similar devices and
 triggered buffers
Message-ID: <20170802232259.GA15210@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for the ultrasonic devices srf02 and srf10.

Triggered buffer support is added

Andreas Klinger (7):
  iio: srf08: add device tree binding for srf02 and srf10
  iio: srf08: add sensor type srf10
  iio: srf08: add triggered buffer support
  iio: srf08: add device tree table
  iio: srf08: add support for srf02 in i2c mode
  iio: srf08: add buffered to device mode
  iio: srf08: change text in Kconfig

 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 drivers/iio/proximity/Kconfig                      |  12 +-
 drivers/iio/proximity/srf08.c                      | 163 +++++++++++++++++----
 3 files changed, 145 insertions(+), 32 deletions(-)

-- 
2.1.4


-- 
