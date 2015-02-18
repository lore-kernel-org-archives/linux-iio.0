Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.165]:55282 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527AbbBROJI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 09:09:08 -0500
Message-ID: <cf14316d275a74b9a57660c0a8783a14b5f08eb5.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 18 Feb 2015 14:08:37 +0000
Subject: [PATCH v7 7/7] MAINTAINERS: Include DA9150 files in Dialog Semiconductor
 support list.
To: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, <linux-iio@vger.kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	<linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	<devicetree@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>
CC: <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d66a97d..10df1bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3090,12 +3090,15 @@ S:	Supported
 F:	Documentation/hwmon/da90??
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
+F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
 F:	drivers/mfd/da90??-*.c
+F:	drivers/mfd/da91??-*.c
 F:	drivers/power/da9052-battery.c
+F:	drivers/power/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
 F:	drivers/rtc/rtc-da90??.c
@@ -3105,6 +3108,7 @@ F:	include/linux/mfd/da903x.h
 F:	include/linux/mfd/da9052/
 F:	include/linux/mfd/da9055/
 F:	include/linux/mfd/da9063/
+F:	include/linux/mfd/da9150/
 F:	include/sound/da[79]*.h
 F:	sound/soc/codecs/da[79]*.[ch]

--
1.9.3

