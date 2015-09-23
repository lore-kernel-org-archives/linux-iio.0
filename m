Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55671 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbbIWJCV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 23 Sep 2015 05:02:21 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: srinivas.pandruvada@linux.intel.com, hadess@hadess.net,
	daniel.baluta@intel.com, irina.tirdea@intel.com, ao2@ao2.it,
	u.kleine-koenig@pengutronix.de, vlad.dogaru@intel.com,
	linus.walleij@linaro.org, tiberiu.a.breana@intel.com,
	javier@osg.samsung.com, dan.carpenter@oracle.com,
	geert@linux-m68k.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 1/2] iio: fix drivers that use 0 as a valid IRQ in client->irq (part 2)
Date: Wed, 23 Sep 2015 12:02:00 +0300
Message-Id: <1442998921-17665-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
References: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since commit dab472eb931bc291 ("i2c / ACPI: Use 0 to indicate that
device does not have interrupt assigned") 0 is not a valid i2c
client irq anymore, so change all driver's checks accordingly.

The same issue occurs when the device is instantiated via device tree
with no IRQ, or from the i2c sysfs interface, even before the patch
above.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/stk8312.c  | 2 +-
 drivers/iio/accel/stk8ba50.c | 2 +-
 drivers/iio/light/stk3310.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index c764af2..a578694 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -572,7 +572,7 @@ static int stk8312_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = stk8312_gpio_probe(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						stk8312_data_rdy_trig_poll,
 						NULL,
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 80f77d8..a59f5d8 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -468,7 +468,7 @@ static int stk8ba50_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = stk8ba50_gpio_probe(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						stk8ba50_data_rdy_trig_poll,
 						NULL,
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 25c6a71..4e56c90 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -636,7 +636,7 @@ static int stk3310_probe(struct i2c_client *client,
 		}
 	}
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						stk3310_irq_handler,
 						stk3310_irq_event_handler,
-- 
1.9.1

