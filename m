Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56881 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099AbaGNUiq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Jul 2014 16:38:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 0/3] iio: accel driver fixes
Date: Mon, 14 Jul 2014 22:38:35 +0200
Message-Id: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

couple of fixes for IIO accel drivers

patch 1 is just trivial error message fixing
patch 2 fixes the scan_type endianness of the I2C kxcjk-1013 sensor
patch 3 fixes the acceleration units (m/s^2 vs. g) of the bma180 driver

Peter Meerwald (3):
  iio:kxcjk-1013: Correct error messages
  iio:kxcjk-1013: Fix endianness in scan_type
  iio:bma180: Fix scale factors to report correct acceleration units

 drivers/iio/accel/bma180.c     | 4 ++--
 drivers/iio/accel/kxcjk-1013.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1

