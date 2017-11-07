Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47220 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdKGPgv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Nov 2017 10:36:51 -0500
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] iio: add Intersil isl76683 light sensor support
Date: Tue,  7 Nov 2017 16:36:20 +0100
Message-Id: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds initial support for isl76683 light sensor.

Christoph Fritz (3):
  iio: light: add support for Intersil isl76683 sensor
  dt-bindings: iio: add Intersil isl76683 light sensor bindings
  iio: light: isl76683 add way to adjust irq threshold

 .../ABI/testing/sysfs-bus-iio-light-isl76683       |  17 +
 .../devicetree/bindings/iio/light/isl76683.txt     |  26 +
 drivers/iio/light/Kconfig                          |  12 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/isl76683.c                       | 743 +++++++++++++++++++++
 5 files changed, 799 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl76683.txt
 create mode 100644 drivers/iio/light/isl76683.c

-- 
2.1.4

