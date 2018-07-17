Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58194 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbeGQJNd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:33 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc: jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 0/7] ARM: dts: qcom: msm8974-hammerhead: add more sensors
Date: Tue, 17 Jul 2018 04:41:51 -0400
Message-Id: <20180717084158.23532-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), temperature / pressure (bmp280), and
proximity / ALS (tsl2772) sensors to the LG Nexus 5 (hammerhead) phone.

Changes since v1:
- Correct mpu6050 patch based on feedback from Jonathan Cameron. See
  that patch for more details.
- Add support for proximity / ALS driver (tsl2772).

Brian Masney (7):
  iio: imu: mpu6050: add support for regulator framework
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    mpu6515
  iio: tsl2772: add support for reading power settings from device tree
  dt-bindings: trivial: remove tsl2772
  iio: tsl2772: add support for regulator framework
  iio: tsl2772: add device tree binding for avago,apds9930
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS /
    proximity

 .../bindings/iio/imu/inv_mpu6050.txt          |   1 +
 .../devicetree/bindings/iio/light/tsl2772.txt |  44 +++++++
 .../devicetree/bindings/trivial-devices.txt   |  10 --
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  83 +++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  22 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  73 +++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   3 +
 drivers/iio/light/tsl2772.c                   | 116 +++++++++++++++++-
 include/dt-bindings/iio/amstaos,tsl2772.h     |  24 ++++
 9 files changed, 363 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
 create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h

-- 
2.17.1

