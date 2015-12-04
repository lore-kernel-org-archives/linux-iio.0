Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33207 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbLDFWi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2015 00:22:38 -0500
Received: by pfnn128 with SMTP id n128so20434871pfn.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2015 21:22:37 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/1] iio: light: add MAX30100 oximeter driver support
Date: Thu,  3 Dec 2015 21:15:30 -0800
Message-Id: <1449206131-9875-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v4:
* Removed whitespace from documention
* Reorder statement in max30100_read_raw to reduce un-needed statements
* Changed buffer from u8 array to __be16 array

Matt Ranostay (1):
  iio: light: add MAX30100 oximeter driver support

 .../devicetree/bindings/iio/health/max30100.txt    |  21 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  21 +
 drivers/iio/health/Makefile                        |   7 +
 drivers/iio/health/max30100.c                      | 457 +++++++++++++++++++++
 6 files changed, 508 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30100.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/max30100.c

-- 
1.9.1

