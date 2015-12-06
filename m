Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33988 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbLFG6Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Dec 2015 01:58:16 -0500
Received: by pacwq6 with SMTP id wq6so30830406pac.1
        for <linux-iio@vger.kernel.org>; Sat, 05 Dec 2015 22:58:15 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] iio: chemical: add AMS iAQ-core support
Date: Sat,  5 Dec 2015 22:58:21 -0800
Message-Id: <1449385102-14393-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* Change IIO_CHAN_INFO_RAW to IIO_CHAN_INFO_PROCESSED in *_read_raw check

Matt Ranostay (1):
  iio: chemical: add AMS iAQ-core support

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 drivers/iio/chemical/Kconfig                       |   8 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/ams-iaq-core.c                | 200 +++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 drivers/iio/chemical/ams-iaq-core.c

-- 
1.9.1

