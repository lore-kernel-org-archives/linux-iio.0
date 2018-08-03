Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:33936 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeHCCMi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:38 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc: jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 0/9] treewide: add support for various sensors on the LG Nexus 5 (hammerhead)
Date: Thu,  2 Aug 2018 20:18:51 -0400
Message-Id: <20180803001900.25371-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), temperature / pressure (bmp280), and
proximity / ALS (tsl2772) sensors to the LG Nexus 5 (hammerhead) phone.

Changes since v2:
- Updated dt property names for tsl2772: amstaos,proximity-diodes and
  led-max-microamp based on feedback from Jonathan Cameron and Rob
  Herring.
- Removed regulator_enabled flags.
- Refactored tsl2772 regulator code.
- Split out device tree bindings into separate patches.

Changes since v1:
- Correct mpu6050 patch based on feedback from Jonathan Cameron. See
  that patch for more details.
- Add support for proximity / ALS driver (tsl2772).

Brian Masney (9):
  iio: imu: mpu6050: add support for regulator framework
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    mpu6515
  iio: tsl2772: add support for reading proximity led settings from
    device tree
  dt-bindings: iio: tsl2772: add new bindings
  iio: tsl2772: add support for regulator framework
  dt-bindings: iio: tsl2772: add bindings for regulator framework
  iio: tsl2772: add support for avago,apds9930
  dt-bindings: iio: tsl2772: add binding for avago,apds9930
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS /
    proximity

 .../bindings/iio/imu/inv_mpu6050.txt          |   1 +
 .../devicetree/bindings/iio/light/tsl2772.txt |  42 ++++
 .../devicetree/bindings/trivial-devices.txt   |  10 -
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  83 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  22 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  62 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   2 +
 drivers/iio/light/tsl2772.c                   | 194 +++++++++++++++++-
 8 files changed, 403 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt

-- 
2.17.1

