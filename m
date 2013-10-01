Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35762 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab3JAM4x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 08:56:53 -0400
Message-id: <524AC65B.9000401@samsung.com>
Date: Tue, 01 Oct 2013 21:55:55 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	jic23@kernel.org,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>,
	"ian.campbell@citrix.com" <ian.campbell@citrix.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	myungjoo.ham@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>,
	Peter Meerwald l <pmeerw@pmeerw.net>
Subject: [PATCH v5 0/2] iio: cm36651: Add CM36651 proximity/light sensor
Content-type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,

Thank you for your advices. I have revised some minor issues of v4 revision.

This patch is the fifth revision for Capella CM36651 proximity and RGB light sensor driver.
The driver exposes five channnels: Red, Green, Clear and proximity.
It also support detection proximity event.

This dricer supports:
	- Event: rising and falling proximity events.
	- Reading channel through read_raw callback.
	- Writing sensor data integration time each channel through write_raw callback.

v5 changed below:
	- Use *_REG_NUM macro at size of array.
	- Revise error handling in probe function.

Subject: [PATCH 0/2] *** SUBJECT HERE ***

*** BLURB HERE ***

Beomho Seo (2):
  iio: cm36651: Add CM36651 proximity light/sensor driver
  DT: Add documentation for cm36651 proximity/light sensor

 .../devicetree/bindings/iio/light/cm36651.txt      |   26 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/cm36651.c                        |  706 ++++++++++++++++++++
 4 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 create mode 100644 drivers/iio/light/cm36651.c

-- 
1.7.9.5


-- 

Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
