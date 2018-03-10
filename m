Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50348 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeCJWG6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Mar 2018 17:06:58 -0500
Received: by mail-wm0-f66.google.com with SMTP id w128so9904942wmw.0
        for <linux-iio@vger.kernel.org>; Sat, 10 Mar 2018 14:06:57 -0800 (PST)
Message-ID: <cb0f18f82afd7df898e58dda7ddd3e973941fcfe.camel@elementarea.net>
Subject: [PATCH v2 0/2] iio: chemical: sgp30: Support SGP30 / SGPC3 Gas
 Sensors
From: Andreas Brauchli <a.brauchli@elementarea.net>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sat, 10 Mar 2018 23:06:55 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for Sensirion SGP30 and SGPC3 I2C gas
sensors.

Further product specs available from:
https://www.sensirion.com/en/environmental-sensors/gas-sensors/multi-pixel-gas-sensors/
https://www.sensirion.com/en/about-us/links/#c15360

Patch 1/2 add new IIO modifiers used by the driver
Patch 2/2 add sgp30/sgpc3 driver and documentation

Major changes to v1:
* Driver renamed to sgp30
* No or minimal sensor knowledge required to use the device:
  automatic fixed interval polling (see next point) and initialization.
* Background thread for IAQ polling
* Remove triggered-buffers support
* Add new IIO modifiers for ethanol and H2
* Support for SGPC3 product increment ("feature set 0.6") including 
  humidity compensation and an ultra-low power mode. Unfortunately, the
  datasheet for this new SGPC3 has not been released yet.
* ABI/DT Documentation

Many thanks to Peter Meerwald-Standler and Jonathan Cameron for their most valuable feedback on v1.

Andreas Brauchli (2):
  iio: Add modifiers for ethanol and H2 gases
  iio: chemical: sgp30: Support Sensirion SGPxx sensors

 Documentation/ABI/testing/sysfs-bus-iio            |    4 +
 .../ABI/testing/sysfs-bus-iio-chemical-sgp30       |   62 ++
 .../bindings/iio/chemical/sensirion,sgp30.txt      |   15 +
 Documentation/iio/chemical/sgp30.txt               |   97 ++
 drivers/iio/chemical/Kconfig                       |   13 +
 drivers/iio/chemical/Makefile                      |    1 +
 drivers/iio/chemical/sgp30.c                       | 1120 ++++++++++++++++++++
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/iio_event_monitor.c                      |    4 +
 9 files changed, 1318 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 create mode 100644 Documentation/iio/chemical/sgp30.txt
 create mode 100644 drivers/iio/chemical/sgp30.c

-- 
2.15.1

