Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:37622 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732309AbeGKBSz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Jul 2018 21:18:55 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc: jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        masneyb@onstation.org
Subject: [PATCH 0/3] ARM: dts: qcom: msm8974-hammerhead: add support for mpu6515
Date: Tue, 10 Jul 2018 21:09:29 -0400
Message-Id: <20180711010932.20313-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), and temperature / pressure (bmp280)
sensors to the LG Nexus 5 (hammerhead) phone. Bindings for the MPU 6515
variant are added, along with regulator support to that driver in order
to correctly configure these drivers via device tree.

Brian Masney (3):
  iio: imu: mpu6050: add support for 6515 variant
  iio: imu: mpu6050: add support for regulator framework
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    mpu6515

 .../bindings/iio/imu/inv_mpu6050.txt          |  2 +
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 56 +++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 63 +++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  7 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  5 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  9 +++
 7 files changed, 147 insertions(+), 6 deletions(-)

-- 
2.17.1

