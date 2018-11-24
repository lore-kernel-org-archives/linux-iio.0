Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40171 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeKYJEC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Nov 2018 04:04:02 -0500
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/3] add support for Sensirion SPS30 PM sensor
Date: Sat, 24 Nov 2018 23:14:12 +0100
Message-Id: <20181124221415.10081-1-tduszyns@gmail.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for Sensirion SPS30 particulate matter
sensor. Along with a driver itself, new channel type and
two modifiers for distinguishing between coarse and fine particles
measurements are introduced.

Sensor datasheet can be downloaded from

https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/0_Datasheets/Particulate_Matter/Sensirion_PM_Sensors_SPS30_Datasheet.pdf

Tomasz Duszynski (3):
  iio: add IIO_MASSCONCENTRATION channel type
  iio: chemical: add support for Sensirion SPS30 sensor
  iio: chemical: sps30: add device tree support

 Documentation/ABI/testing/sysfs-bus-iio       |  11 +-
 .../bindings/iio/chemical/sensirion,sps30.txt |  12 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sps30.c                  | 359 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   3 +
 include/uapi/linux/iio/types.h                |   3 +
 tools/iio/iio_event_monitor.c                 |   6 +
 8 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 drivers/iio/chemical/sps30.c

--
2.19.2
