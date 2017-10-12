Return-Path: <SRS0=aWpD=BL=samsung.com=m.purski@kernel.org>
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>,
	Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski
	<m.purski@samsung.com>
Subject: [PATCH v3 0/4] Make max expected current configurable for ina2xx
 drivers
Date: Thu, 12 Oct 2017 15:17:58 +0200
Message-id: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
References: <CGME20171012131810eucas1p12659f5aff3de838366690fa13e06ea54@eucas1p1.samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

this patchset makes it possible to calibrate ina2xx drivers with different
calibration values, which are calculated using max expected current value.
It can be read from device tree, platform data or changed during run-time
using sysfs. If it isn't specified in device tree or platform data, the
driver uses default value, thanks to which the behaviour of the driver
doesn't change in this case.

There are two drivers for ina2xx: hwmon and iio. Changes are made
for both of them and their bindings as well.

These changes allow setting sensor's precision to the required by the board.
It is useful in Odroid XU3. Therefore this patchset also sets
max-expected-current in OdroidXU3 device tree to values from documentation.

Best Regards,

	Maciej Purski

---
Changes in v3:
- fix units inconsistency

Changes in v2:
- make scale attribute for current iio channel writable as instead of
  adding new attribute max_expected_current
- use currX_max standard attribute in hwmon instead of adding new
  attribute
- fix max expected current property name
- update commit messages

Maciej Purski (4):
  iio: adc: ina2xx: Make max expected current configurable
  hwmon: (ina2xx) Make max expected current configurable
  dt-bindings: hwmon: Add ti-max-expected-current-microamp property to
    ina2xx
  ARM: dts: Add ti-max-expected-current-microamp properties for ina231
    in Odroid XU3

 Documentation/devicetree/bindings/hwmon/ina2xx.txt |   4 +-
 Documentation/hwmon/ina2xx                         |   3 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   4 +
 drivers/hwmon/ina2xx.c                             | 106 ++++++++++++++++++---
 drivers/iio/adc/ina2xx-adc.c                       |  97 ++++++++++++++-----
 include/linux/platform_data/ina2xx.h               |   2 +
 6 files changed, 178 insertions(+), 38 deletions(-)

-- 
2.7.4
