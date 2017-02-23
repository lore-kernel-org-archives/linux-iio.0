Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:54411 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751271AbdBWRPW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Feb 2017 12:15:22 -0500
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Harald Geyer <harald@ccbib.org>
Subject: [PATCH 1/2] regulator: core: Add new notification for enabling of regulator
Date: Thu, 23 Feb 2017 17:06:52 +0000
Message-Id: <1487869613-11927-1-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is useful for devices, which need some time to start up, to help
the drivers track how long the supply has been up already. Ie whether
it can safely talk to the HW or needs to wait.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
If this change gets accepted soon, it can go in via the regulator tree
and everything will be in place for patch 2/2 to go in via iio when I'm
done with longterm tests.

 drivers/regulator/core.c           | 2 ++
 include/linux/regulator/consumer.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 04baac9..6b9bb1b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2162,6 +2162,8 @@ static int _regulator_enable(struct regulator_dev *rdev)
 			if (ret < 0)
 				return ret;
 
+			_notifier_call_chain(rdev, REGULATOR_EVENT_ENABLE,
+					     NULL);
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %d\n", ret);
 			return ret;
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index ea0fffa..df176d7 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -119,6 +119,7 @@ struct regmap;
 #define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE	0x200
 #define REGULATOR_EVENT_PRE_DISABLE		0x400
 #define REGULATOR_EVENT_ABORT_DISABLE		0x800
+#define REGULATOR_EVENT_ENABLE			0x1000
 
 /*
  * Regulator errors that can be queried using regulator_get_error_flags
-- 
2.1.4

