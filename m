Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49285 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaGEMim (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Jul 2014 08:38:42 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 0/3] iio: new color light sensor drivers
Date: Sat,  5 Jul 2014 14:38:31 +0200
Message-Id: <1404563914-27516-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

first patch is a cleanup/bug fix (locking around dependent
I2C communication)

patch 2 and 3 add new drivers for two digital color sensors
(Intersil isl29125 and AMS/TAOS TCS3414)

Peter Meerwald (3):
  iio:tcs3472: Check for buffer enabled and locking
  iio: Add Intersil isl29125 digital color light sensor driver
  iio: Add driver for AMS/TAOS tcs3414 digital color sensor

 drivers/iio/light/Kconfig    |  24 +++
 drivers/iio/light/Makefile   |   2 +
 drivers/iio/light/isl29125.c | 347 ++++++++++++++++++++++++++++++++++++
 drivers/iio/light/tcs3414.c  | 405 +++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/light/tcs3472.c  |  11 +-
 5 files changed, 788 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/light/isl29125.c
 create mode 100644 drivers/iio/light/tcs3414.c

-- 
1.9.1

