Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:55787 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbaA2VAP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2014 16:00:15 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar20so2635874iec.34
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2014 13:00:15 -0800 (PST)
From: Matt Porter <mporter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Benoit Cousson <b-cousson@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	linux-pwm@vger.kernel.org,
	Linux OMAP List <linux-omap@vger.kernel.org>,
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
	Linaro Patches <patches@linaro.org>
Subject: [PATCH 3/5] iio: enable selection and build of pulse drivers
Date: Wed, 29 Jan 2014 15:59:57 -0500
Message-Id: <1391029199-3670-4-git-send-email-mporter@linaro.org>
In-Reply-To: <1391029199-3670-1-git-send-email-mporter@linaro.org>
References: <1391029199-3670-1-git-send-email-mporter@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the pulse driver subdirectory when configuring and building
IIO.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/iio/Kconfig  | 1 +
 drivers/iio/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5dd0e12..286acc3 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -74,6 +74,7 @@ if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
 source "drivers/iio/pressure/Kconfig"
+source "drivers/iio/pulse/Kconfig"
 source "drivers/iio/temperature/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 887d390..9a953c9 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -24,5 +24,6 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += orientation/
 obj-y += pressure/
+obj-y += pulse/
 obj-y += temperature/
 obj-y += trigger/
-- 
1.8.4

