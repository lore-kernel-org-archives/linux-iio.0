Return-Path: <beomho.seo@samsung.com>
Message-id: <5243B54E.7000804@samsung.com>
Date: Thu, 26 Sep 2013 13:17:18 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org, rob.herring@calxeda.com,
 pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, myungjoo.ham@samsung.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Peter Meerwald l <pmeerw@pmeerw.net>
Subject: [PATCH v3 0/2] iio: cm36651: Add CM36651 proximity/light sensor driver
Content-type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello all,

Thank you for your review. I have revised v2 driver.
Please give your feedback at that time.

This patch is the third revision for Capella CM36651 proximity and RGB light sensor driver.
The driver exposes five channels: Red, Green, Blue, Clear and proximity.
It also support detection proximity event.

This driver supports
	- Event: rising and falling proximity events.
	- Reading channel through read_raw callback.
	- Writing sensor data integration time each channel through write_raw callback.

v3 changed below:
	- Revised a binding documentation.
	- fixed vendor-prefixes documentation in alphabetical order.
	- Add/ Remove/ Revise some #define register and commands.
	- Add write_raw callback function for set/get sensor data integration time.
	- Use IIO_CONST_ATTR API for *_integration_time_available.
	- Revised some comments and message.
	- code cleanup

>>From 51e47f86e8ac9c4acf2ff2b5ede0b392cc3f2837 Mon Sep 17 00:00:00 2001
From: Beomho Seo <beomho.seo@samsung.com>
Date: Thu, 26 Sep 2013 10:34:53 +0900
Subject: [PATCH 0/2] *** SUBJECT HERE ***

*** BLURB HERE ***

Beomho Seo (2):
  iio: cm36651: Add CM36651 proximity/light sensor driver
  DT: Add documentation for cm36651 proximity/light sensor

 .../devicetree/bindings/iio/light/cm36651.txt      |   25 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/cm36651.c                        |  715 ++++++++++++++++++++
 4 files changed, 752 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 create mode 100644 drivers/iio/light/cm36651.c

-- 
1.7.9.5

-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
