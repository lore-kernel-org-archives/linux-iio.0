Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30248 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696AbbFEMmb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 08:42:31 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 2/2] rtc: fix drivers that consider 0 as a valid IRQ in client->irq
Date: Fri,  5 Jun 2015 15:41:58 +0300
Message-Id: <1433508118-3938-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1433508118-3938-1-git-send-email-octavian.purdila@intel.com>
References: <1433508118-3938-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since patch "i2c / ACPI: Use 0 to indicate that device does not have
interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
change all driver's checks accordingly.

The same issue occurs when the device is instantiated via device tree
with no IRQ, or from the i2c sysfs interface, even before the patch
above.

[1] https://lkml.org/lkml/2015/5/6/279

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1374.c | 4 ++--
 drivers/rtc/rtc-ds3232.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 167783f..592458c 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -689,7 +689,7 @@ static int ds1374_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (client->irq >= 0 && device_may_wakeup(&client->dev))
+	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
 	return 0;
 }
@@ -698,7 +698,7 @@ static int ds1374_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (client->irq >= 0 && device_may_wakeup(&client->dev))
+	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
 	return 0;
 }
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7e48e53..f280dd1 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -443,7 +443,7 @@ static int ds3232_remove(struct i2c_client *client)
 {
 	struct ds3232 *ds3232 = i2c_get_clientdata(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		mutex_lock(&ds3232->mutex);
 		ds3232->exiting = 1;
 		mutex_unlock(&ds3232->mutex);
-- 
1.9.1

