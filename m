Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59527 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaHSWnb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Aug 2014 18:43:31 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 00/11] iio:bma180: Add BMA250 support v2
Date: Wed, 20 Aug 2014 00:43:15 +0200
Message-Id: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

reposting patch series to add BMA250 support to the BMA180 IIO driver, see
http://article.gmane.org/gmane.linux.kernel.iio/12970 (July 16, 2014)

no functional change, the first two patches (fixes) have been applied already

v2 updates Kconfig in patch 11 to mention BMA250

Peter Meerwald (11):
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

 drivers/iio/accel/Kconfig  |   6 +-
 drivers/iio/accel/bma180.c | 475 +++++++++++++++++++++++++++++++--------------
 2 files changed, 330 insertions(+), 151 deletions(-)

-- 
1.9.1

