Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37287 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966488AbeF1Obm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jun 2018 10:31:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so8796774wmh.2
        for <linux-iio@vger.kernel.org>; Thu, 28 Jun 2018 07:31:41 -0700 (PDT)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com,
        pmeerw@pmeerw.net
Cc: pierre-moana.levesque@parrot.com,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v4 0/2] Add ISL29501 support.
Date: Thu, 28 Jun 2018 16:31:24 +0200
Message-Id: <1530196286-18891-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Here's a new version of this serie. Please find the changelog above.

changelog:

v4:
* Fix build warnings and rebase on top of next-20180628
v3:
* Renamings to add isl29501 prefix
* Rename "amb" -> "light" in extended fields
* Move mutex lock/unlock to register_read and register_write functions
* Improve IIO_PHASE scale output with a better pi estimation
v2:
* Add missing eof new line
* Do not set .indexed to true for all channels
* Add a .extended to differenciate "magnitude" and "ambient_light"
  intensity channels
* Return isl29501_begin_acquisition result in isl29501_init_chip
* Fix buffer size in isl29501_trigger_handler

Mathieu Othacehe (2):
  iio: Add channel for Phase
  iio: light: isl29501: Add support for the ISL29501 ToF sensor.

 Documentation/ABI/testing/sysfs-bus-iio            |    7 +
 Documentation/ABI/testing/sysfs-bus-iio-isl29501   |   47 +
 .../devicetree/bindings/iio/light/isl29501.txt     |   13 +
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/isl29501.c                       | 1140 ++++++++++++++++++++
 include/uapi/linux/iio/types.h                     |    1 +
 tools/iio/iio_event_monitor.c                      |    2 +
 9 files changed, 1225 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29501.txt
 create mode 100644 drivers/iio/light/isl29501.c

-- 
2.7.4

