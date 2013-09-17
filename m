Return-Path: <beomho.seo@samsung.com>
Message-id: <5237E16A.6070301@samsung.com>
Date: Tue, 17 Sep 2013 13:58:18 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org, rob.herring@calxeda.com,
 pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, myungjoo.ham@samsung.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Beomho Seo <beomho.seo@samsung.com>,
 "pmeerw@pmeerw.net >> Peter Meerwald l" <pmeerw@pmeerw.net>
Subject: [PATCH v2 0/2] iio: cm36651: Add CM36651 proximity/light sensor driver
Content-type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello all,

Thank you for your review. I have revised v1 driver.
Please give your feedback at that time.

This patch is second revision for Capella CM36651 proximity and RGB light sensor driver.
The driver exposes five channels: Red, Green, Blue, Clear and proximity.
It also support detection proximity event.

This driver supports:
	- Event: rising and falling proximity events.
	- Reading channels through read_raw_callback.

v2 changed below:
	- Add a new entry in alphabetical order at Kconfig.
	- Use #define register and commands.
	- Use CM36651_* prefix.
	- Use i2c_smbus_* APIs.
	- Fixed cm36651_read_output() function.
	- Code cleanup

>From 493802a4f3788579789b6f03dffaaf3a0d9fc225 Mon Sep 17 00:00:00 2001
From: Beomho Seo <beomho.seo@samsung.com>
Date: Tue, 17 Sep 2013 11:59:47 +0900
Subject: [PATCH 0/2] *** SUBJECT HERE ***

*** BLURB HERE ***

Beomho Seo (2):
  iio: cm36651: Add CM36651 proximity/light sensor driver
  DT: Add binding documentation for CM36651 proximity/light sensor

 .../devicetree/bindings/iio/light/cm36651.txt      |   24 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/cm36651.c                        |  591 ++++++++++++++++++++
 4 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 create mode 100644 drivers/iio/light/cm36651.c

-- 
1.7.9.5

Best regards,
-- 
Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
