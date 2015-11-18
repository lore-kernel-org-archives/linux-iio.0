Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34566 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbbKRJTW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 04:19:22 -0500
Received: by padhx2 with SMTP id hx2so39225122pad.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2015 01:19:21 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v2 0/1] iio: light: add MAX30100 oximeter driver support
Date: Wed, 18 Nov 2015 01:19:10 -0800
Message-Id: <1447838351-5076-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
 * Add temp channel
 * Reworked path to drivers/iio/health patch
 * Removed magic numbers to defines

IMPORTANT NOTES:
 * Hasn't been tested on real hardware and won't be  till second week
   of December due to author on holiday in Asia

Matt Ranostay (1):
  iio: light: add MAX30100 oximeter driver support

 .../devicetree/bindings/iio/light/max30100.txt     |  22 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  21 +
 drivers/iio/health/Makefile                        |   7 +
 drivers/iio/health/max30100.c                      | 423 +++++++++++++++++++++
 6 files changed, 475 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/max30100.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/max30100.c

-- 
1.9.1

