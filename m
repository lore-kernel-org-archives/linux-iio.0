Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34966 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbdI1Mur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Sep 2017 08:50:47 -0400
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 0/4] Make max expected current configurable for ina2xx
 drivers
Date: Thu, 28 Sep 2017 14:50:11 +0200
Message-id: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
References: <CGME20170928125043eucas1p14a7e57443912a37152037b844c1b9967@eucas1p1.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

this patchset makes it possible to calibrate ina2xx drivers with different
calibration values, which are calculated using max expected current value.
It can be read from device tree, platform data or changed during run-time
using sysfs. If it isn't specified in device tree or platform data, the
driver uses default value, thanks to which the behaviour of the driver
don't change in this case.

There are two drivers for ina2xx: hwmon and iio. Changes are made
for both of them and their bindings as well.

These changes allow setting sensor's precision to the required by the board.
It is useful in Odroid XU3. Therefore this patchset also sets
max-expected-current in OdroidXU3 device tree to values from documentation.

Best Regards,

	Maciej Purski

Maciej Purski (4):
  iio: adc: ina2xx: Make max expected current configurable
  hwmon: (ina2xx) Make max expected current configurable
  dt-bindings: hwmon: Add max-expected-current property to ina2xx
  ARM: dts: Add max-expected-current properties for ina231 in Odroid XU3

 Documentation/devicetree/bindings/hwmon/ina2xx.txt |   4 +-
 Documentation/hwmon/ina2xx                         |   9 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   4 +
 drivers/hwmon/ina2xx.c                             | 105 +++++++++++++++++---
 drivers/iio/adc/ina2xx-adc.c                       | 110 ++++++++++++++++++---
 include/linux/platform_data/ina2xx.h               |   2 +
 6 files changed, 203 insertions(+), 31 deletions(-)

-- 
2.7.4

