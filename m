Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34991 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbcITCxm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2016 22:53:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id 6so237139pfl.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2016 19:53:42 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v5 0/2] iio: potentiostat: add LMP91000 support
Date: Mon, 19 Sep 2016 19:53:36 -0700
Message-Id: <1474340018-26647-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
 * Rename ti-adc1x1s.c driver to ti-adc161s626.c
 * Switch from iio_channel_read() to using the industrialio-buffer-cb
interface
 * Process data in ADC trigger handler for buffer callbacks
 * Set the mux trigger to the ADC referenced by io-channels by default

Changes from v2:
 * Fix configuration index shifting values
 * Switch from wait_for_completion_interruptible to wait_for_completion_timeout

Changes from v3:
 * Fix order of probe function error rollback

Changes from v4:
 * Report back scale + offset from adc
 * Switch temperature channel from IIO_VOLTAGE to IIO_TEMP with processing
 * Add iio_read_channel_offset helper

Matt Ranostay (2):
  iio: inkern: add iio_read_channel_offset helper
  iio: potentiostat: add LMP91000 support

 .../bindings/iio/potentiostat/lmp91000.txt         |  30 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/inkern.c                               |  18 +
 drivers/iio/potentiostat/Kconfig                   |  22 ++
 drivers/iio/potentiostat/Makefile                  |   6 +
 drivers/iio/potentiostat/lmp91000.c                | 439 +++++++++++++++++++++
 include/linux/iio/consumer.h                       |  13 +
 8 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
 create mode 100644 drivers/iio/potentiostat/Kconfig
 create mode 100644 drivers/iio/potentiostat/Makefile
 create mode 100644 drivers/iio/potentiostat/lmp91000.c

-- 
2.7.4

