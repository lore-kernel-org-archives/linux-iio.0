Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35020 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdATFl0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 00:41:26 -0500
Received: by mail-pf0-f180.google.com with SMTP id f144so19606482pfa.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Jan 2017 21:41:03 -0800 (PST)
From: Matt Ranostay <matt@ranostay.consulting>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 0/2] iio: health: add MAX30102 oximeter driver support
Date: Thu, 19 Jan 2017 21:40:58 -0800
Message-Id: <20170120054100.902-1-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for the MAX30102 oximeter unit. This driver is heavily based on
the previous MAX30100 driver but has much more functionality that prevents a
common core which includes but not limited to:
 * sample averaging
 * bigger FIFO
 * much different register mapping
 * more fine tuned LED current settings

Important Note: ADC data from both IR + RED has been confirmed to be valid but
hasn't been plotted on a graph yet.

Matt Ranostay (2):
  devicetree: add documentation for MAX30102
  iio: health: add MAX30102 oximeter driver support

 .../devicetree/bindings/iio/health/max30102.txt    |  30 ++
 drivers/iio/health/Kconfig                         |  13 +
 drivers/iio/health/Makefile                        |   1 +
 drivers/iio/health/max30102.c                      | 478 +++++++++++++++++++++
 4 files changed, 522 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30102.txt
 create mode 100644 drivers/iio/health/max30102.c

-- 
2.10.2

