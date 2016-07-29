Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35957 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbcG2Ig7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 04:36:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id y134so5107509pfg.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2016 01:36:59 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v3 0/3] iio: potentiostat: add LMP91000 support
Date: Fri, 29 Jul 2016 01:36:49 -0700
Message-Id: <1469781412-29686-1-git-send-email-mranostay@gmail.com>
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

Matt Ranostay (3):
  iio: buffer-callback: allow getting underlying iio_dev
  iio: adc: ti-adc161s626: add support for TI 1-channel differential
    ADCs
  iio: potentiostat: add LMP91000 support

 .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |  17 +
 .../bindings/iio/potentiostat/lmp91000.txt         |  30 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-adc161s626.c                    | 248 ++++++++++++++
 drivers/iio/buffer/industrialio-buffer-cb.c        |  24 +-
 drivers/iio/potentiostat/Kconfig                   |  22 ++
 drivers/iio/potentiostat/Makefile                  |   6 +
 drivers/iio/potentiostat/lmp91000.c                | 376 +++++++++++++++++++++
 include/linux/iio/consumer.h                       |  12 +
 12 files changed, 740 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
 create mode 100644 drivers/iio/adc/ti-adc161s626.c
 create mode 100644 drivers/iio/potentiostat/Kconfig
 create mode 100644 drivers/iio/potentiostat/Makefile
 create mode 100644 drivers/iio/potentiostat/lmp91000.c

-- 
2.7.4

