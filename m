Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44069 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932748AbeGBI75 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2018 04:59:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so14670539wrn.11
        for <linux-iio@vger.kernel.org>; Mon, 02 Jul 2018 01:59:56 -0700 (PDT)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com,
        pmeerw@pmeerw.net
Cc: pierre-moana.levesque@parrot.com,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v5 0/2] Add ISL29501 support.
Date: Mon,  2 Jul 2018 10:59:25 +0200
Message-Id: <1530521967-10152-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Here's v5 of this serie, please find the changelog below.

Thanks,

Mathieu

v5:
* Use IIO_MOD_LIGHT_CLEAR modifier for IIO_INTENSITY channel
describing ambient light intensity and remove extended_names doing so.
* Fix a possible leakage in isl29501_trigger_handler function.
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
 drivers/iio/light/isl29501.c                       | 1125 ++++++++++++++++++++
 include/uapi/linux/iio/types.h                     |    1 +
 tools/iio/iio_event_monitor.c                      |    2 +
 9 files changed, 1210 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29501.txt
 create mode 100644 drivers/iio/light/isl29501.c

-- 
2.7.4

