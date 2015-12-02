Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35168 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbbLBKiR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 05:38:17 -0500
Received: by pacej9 with SMTP id ej9so37443843pac.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2015 02:38:17 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/1] iio: light: add MAX30100 oximeter driver support
Date: Wed,  2 Dec 2015 02:37:39 -0800
Message-Id: <1449052660-29585-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v3:
* remove warnings from unused variables
* switch from i2c_transfer to i2c_smbus_read_i2c_block_data 

Matt Ranostay (1):
  iio: light: add MAX30100 oximeter driver support

 .../devicetree/bindings/iio/health/max30100.txt    |  21 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  21 +
 drivers/iio/health/Makefile                        |   7 +
 drivers/iio/health/max30100.c                      | 454 +++++++++++++++++++++
 6 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30100.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/max30100.c

-- 
1.9.1

