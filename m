Return-Path: <beomho.seo@samsung.com>
Message-id: <52496AA1.3010503@samsung.com>
Date: Mon, 30 Sep 2013 21:12:17 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 jic23@kernel.org, "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, myungjoo.ham@samsung.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Peter Meerwald l <pmeerw@pmeerw.net>
Subject: [PATCH v4 0/2] iio: cm36651: Add CM36651 proximity/light sensor
Content-type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello all,

Thank you for your review. I have revised v3 driver.
Please give your feedback at that time.

This patch is the fourth revision for Capella CM36651 proximity and RGB light sensor driver.
The driver exposes five channels: Red, Green, Blue, Clear and proximity.
It also support detection proximity event.

This driver supports
	- Event: rising and falling proximity events.
	- Reading channel through read_raw callback.
	- writing sensor data integration time each channel through write_raw callback.

v4 changed below:
	- Revised a binding documentation
	- add description to cm36651.txt
	- revise proximity sensor duty_ratio Macros.
	- fix be wrote register value.
	- fix return value at cm36651_read_raw function.
	- remove double space and blank line.
	- remove some APIs.(IIO_EVENT_EXTRACT_*)
	- remove some check code and unnecessary dbg/err message.
	- code cleanup

Subject: [PATCH 0/2] *** SUBJECT HERE ***

*** BLURB HERE ***

Beomho Seo (2):
  iio: cm36651: Add CM36651 proximity/light sensor driver
  DT: Add documentation for cm36651 proximity/light sensor

 .../devicetree/bindings/iio/light/cm36651.txt      |   26 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/cm36651.c                        |  704 ++++++++++++++++++++
 4 files changed, 742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 create mode 100644 drivers/iio/light/cm36651.c

-- 
1.7.9.5

-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
