Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41200 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934912AbaGPSdE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:04 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 00/13] iio:bma180: Fixes and BMA250 support
Date: Wed, 16 Jul 2014 20:32:43 +0200
Message-Id: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

patches 1 and 2 are fixes
patch 3 allows to use the device without an IRQ
patches 4, 5, 6 are cleanup
patch 7 exposes the temperature channel not supported previously
patch 8, 9, 10, 11, 12 rework the driver to make it easier to add similar devices
patch 13 adds support for the BMA250 sensor

the BMA250 shared measurement registers with the BMA180, but the configuration
registers are totally different

regards, p.

Peter Meerwald (13):
  iio:bma180: Fix scale factors to report correct acceleration units
  iio:bma180: Missing check for frequency fractional part
  iio:bma180: Enable use of device without IRQ
  iio:bma180: Prefix remaining tables and functions with bma18_
  iio:bma180: Rename BMA_180 to BMA180_
  iio:bma180: Use bool instead of int for state
  iio:bma180: Expose temperature channel
  iio:bma180: Drop _update_scan_mode()
  iio:bma180: Introduce part_info to differentiate further chip variants
  iio:bma180: Introduce part-specific _config() and disable() code
  iio:bma180: Prepare for accelerometer channels with different
    resolutions
  iio:bma180: Implement _available sysfs attribute dynamically
  iio:bma180: Add BMA250 chip support

 drivers/iio/accel/bma180.c | 477 +++++++++++++++++++++++++++++++--------------
 1 file changed, 329 insertions(+), 148 deletions(-)

-- 
1.9.1

