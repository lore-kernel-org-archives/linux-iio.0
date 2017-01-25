Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33828 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdAYHEm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jan 2017 02:04:42 -0500
Received: by mail-pg0-f48.google.com with SMTP id 14so62148870pgg.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Jan 2017 23:04:41 -0800 (PST)
From: Matt Ranostay <matt@ranostay.consulting>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v2 0/2] iio: health: add MAX30102 oximeter driver support
Date: Tue, 24 Jan 2017 23:04:40 -0800
Message-Id: <20170125070442.10715-1-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
* add newlines to dev_err/dev_info statements
* update documentation to 400hz samples, but actually 100hz to FIFO
* fix storage bits to a power of 2, and the required buffer processing
* fixed return code from max30102_read_measurement()

Matt Ranostay (2):
  devicetree: add documentation for MAX30102 oximeter
  iio: health: add MAX30102 oximeter driver support

 .../devicetree/bindings/iio/health/max30102.txt    |  30 ++
 drivers/iio/health/Kconfig                         |  13 +
 drivers/iio/health/Makefile                        |   1 +
 drivers/iio/health/max30102.c                      | 485 +++++++++++++++++++++
 4 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30102.txt
 create mode 100644 drivers/iio/health/max30102.c

-- 
2.10.2

