Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35899 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbLFB6H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 20:58:07 -0500
Received: by pfdd184 with SMTP id d184so45746452pfd.3
        for <linux-iio@vger.kernel.org>; Sat, 05 Dec 2015 17:58:06 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v6 0/1] iio: light: add MAX30100 oximeter driver support
Date: Sat,  5 Dec 2015 17:58:11 -0800
Message-Id: <1449367092-2391-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v5:
* rename max30100_fifo_is_empty to max30100_fifo_count function
* move mutex lock to only in IIO_CHAN_INFO_RAW switch statement
* removed goto calls into directly returning from *_probe()

Matt Ranostay (1):
  iio: light: add MAX30100 oximeter driver support

 .../devicetree/bindings/iio/health/max30100.txt    |  21 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  21 +
 drivers/iio/health/Makefile                        |   7 +
 drivers/iio/health/max30100.c                      | 460 +++++++++++++++++++++
 6 files changed, 511 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30100.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/max30100.c

-- 
1.9.1

