Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:60829 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdINOxT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 10:53:19 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 0/6] IIO-based thermal sensor driver for Allwinner H3 SoC
Date: Thu, 14 Sep 2017 22:52:45 +0800
Message-Id: <20170914145251.21784-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allwiner H3 SoC has a thermal sensor, which is a large refactored version of
the old Allwinner "GPADC" (although it have already only thermal part left
in A33).

This patch tried to add support for the sensor in H3 based on the A33 thermal
sensor driver by Quentin Schulz, which is already merged.

Icenowy Zheng (6):
  dt-bindings: update the Allwinner GPADC device tree binding for H3
  iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
    A33
  iio: adc: sun4i-gpadc-iio: rework code for supporting newer THS
    variants
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  ARM: sun8i: h3: add support for the thermal sensor in H3
  ARM: sun8i: h3: add partial CPU thermal zone

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  30 +++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 ++++
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 173 ++++++++++++++++++++-
 include/linux/mfd/sun4i-gpadc.h                    |  33 +++-
 4 files changed, 249 insertions(+), 13 deletions(-)

-- 
2.13.5

