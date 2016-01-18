Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34988 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346AbcARP2s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2016 10:28:48 -0500
Received: by mail-pa0-f65.google.com with SMTP id gi1so40090181pac.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2016 07:28:48 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/3] iio: chemical: add atlas ph sensor support
Date: Mon, 18 Jan 2016 07:28:41 -0800
Message-Id: <1453130924-28840-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* calibration status check to report missing reference points
* add temp range check
* switch to using both edges of interrupt option to avoid having to
  re-enable after every event. Which could cause a rare deadlock if an
  interrupt was dropped
* add missing iio_trigger_poll and irq_work queue to schedule task
* add missing ->num_channels field

Matt Ranostay (3):
  devicetree: add Atlas Scientific LLC vendor prefix
  iio: ph: add IIO_PH channel type
  iio: chemical: add Atlas pH-SM sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   4 +-
 drivers/iio/chemical/Kconfig                       |  13 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 505 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 9 files changed, 553 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 drivers/iio/chemical/atlas-ph-sensor.c

-- 
2.7.0.rc3

