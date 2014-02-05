Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:40090 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaBETBz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2014 14:01:55 -0500
Received: by mail-oa0-f44.google.com with SMTP id g12so1007426oah.17
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2014 11:01:55 -0800 (PST)
From: Matt Porter <mporter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux PWM List <linux-pwm@vger.kernel.org>,
	Linux OMAP List <linux-omap@vger.kernel.org>,
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/6] iio: enable selection and build of pulse drivers
Date: Wed,  5 Feb 2014 14:01:38 -0500
Message-Id: <1391626901-31684-4-git-send-email-mporter@linaro.org>
In-Reply-To: <1391626901-31684-1-git-send-email-mporter@linaro.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
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

