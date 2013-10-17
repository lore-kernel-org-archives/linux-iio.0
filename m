Return-Path: <beomho.seo@samsung.com>
Message-id: <525F49F6.702@samsung.com>
Date: Thu, 17 Oct 2013 11:22:46 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 jic23@kernel.org, Mark Rutland <mark.rutland@arm.com>,
 myungjoo.ham@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Peter Meerwald l <pmeerw@pmeerw.net>
Subject: [PATCH v7 0/2] iio: cm36651: Add CM36651 proximity/light sensor
Content-type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

hello all,

Thank you for your comments. I have revised some issues of v6 revision.

This patch is the seventh revision for Capella CM36651 proximity and RGB light sensor driver.
The driver exposes five channels: Red, Green, Blue, Clear and proximity.
It also support detection proximity event.

This driver supports:
	- Event: rising and falling proximity events.
	- Reading channel through read_raw callback.
	- Writing sensor data integration time each channel through write_raw callback.

Changes from v7 to v6:
	- Add a new entry in alphabetical order at Makefile
	- Remove/revise some goto 
	- Include linux/err.h

Changes form v6 to v5:
	- Remove enable/disable_irq APIs.
	- Add some macros.
	- Code cleanup

Changes from v5 to v4:
	- Use *_REG_NUM macro at size of array.
	- Revised error handling in probe function.

Changes from v4 to v3:
	- Revised a binding documentation.
	- Add description to cm36651.txt
	- Revised proximitysensor duty_ratio Macros.
	- Fix be wrote register value.
	- Fix return value at cm36651_read_raw function.
	- Remove double space and blank line.
	- Remove some APIs. (IIO_EVENT_EXTRACT_*)
	- Remove some check code and unnecessary dbg/err message.
	- code cleanup

Changes from v3 to v2:
	- Revised a binding documentation.
	- fixed vendor-prefixes documentation in alphabetical order.
	- Add/ Remove/ Revise some #define register and commands.
	- Add write_raw callback function for set/get sensor data integration time.
	- Use IIO_CONST_ATTR API for *_integration_time_available.
	- Revised some comments and message.
	- Code cleanup

Changes from v2 to v1:
	- Add a new entry in alphabetical order at Kconfig.
	- Use #define register and commands.
	- Use CM36651_* prefix.
	- Use i2c_smbus_* APIs.
	- Fix cm36651_read_output() function.
	- Code cleanup

>From ea0ed756d449ab71db28f5d0561d478a19b21d73 Mon Sep 17 00:00:00 2001
From: Beomho Seo <beomho.seo@samsung.com>
Date: Thu, 17 Oct 2013 10:51:28 +0900
Subject: [PATCH 0/2] *** SUBJECT HERE ***

*** BLURB HERE ***

Beomho Seo (2):
  iio: cm36651: Add CM36651 proximity/light sensor
  DT: Add documentation for cm36651 proximity/light sensor

 .../devicetree/bindings/iio/light/cm36651.txt      |   26 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/cm36651.c                        |  708 ++++++++++++++++++++
 5 files changed, 747 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 create mode 100644 drivers/iio/light/cm36651.c

-- 
1.7.9.5

-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
