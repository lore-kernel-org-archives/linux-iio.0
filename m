Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:51185 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbaEBP5J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 May 2014 11:57:09 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 0/3] iio: mlx90614, take 2
Date: Fri,  2 May 2014 17:57:03 +0200
Message-Id: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

adding ABI documentation for object and ambient

Peter Meerwald (3):
  iio: Add TEMP_AMBIENT and TEMP_OBJECT channel modifiers
  iio: Add ABI documentation for object and ambient modifiers
  iio: Add Melexis mlx90614 contact-less infrared temperature sensor
    driver

 Documentation/ABI/testing/sysfs-bus-iio |   7 +-
 drivers/iio/industrialio-core.c         |   2 +
 drivers/iio/temperature/Kconfig         |  10 +++
 drivers/iio/temperature/Makefile        |   1 +
 drivers/iio/temperature/mlx90614.c      | 150 ++++++++++++++++++++++++++++++++
 include/linux/iio/types.h               |   2 +
 6 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/temperature/mlx90614.c

-- 
1.9.1

