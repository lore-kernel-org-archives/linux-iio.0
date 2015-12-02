Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34808 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbLBFTm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 00:19:42 -0500
Received: by padhx2 with SMTP id hx2so29090399pad.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2015 21:19:42 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] iio: light: add MAX30100 oximeter driver support
Date: Tue,  1 Dec 2015 21:19:45 -0800
Message-Id: <1449033586-26294-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* Add sign extend to temp sensor results
* Measurement function added to deal with non-incrementing FIFO address
* Added FIFO overflow checking support
* Removed some magic values into defines

Important Notes:
* smoke tested on real hardware

Matt Ranostay (1):
  iio: light: add MAX30100 oximeter driver support

 .../devicetree/bindings/iio/health/max30100.txt    |  21 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  21 +
 drivers/iio/health/Makefile                        |   7 +
 drivers/iio/health/max30100.c                      | 465 +++++++++++++++++++++
 6 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30100.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/max30100.c

-- 
1.9.1

