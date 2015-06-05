Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29347 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbbFEMmb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
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
Subject: [PATCH v2 1/2] iio: fix drivers that consider 0 as a valid IRQ in client->irq
Date: Fri,  5 Jun 2015 15:41:57 +0300
Message-Id: <1433508118-3938-2-git-send-email-octavian.purdila@intel.com>
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
---
 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/accel/mma9553.c      | 2 +-
 drivers/iio/imu/kmx61.c          | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 4e70f51..55751d9 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -1663,7 +1663,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = bmc150_accel_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(
 						&client->dev, client->irq,
 						bmc150_accel_irq_handler,
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 0d9bd35..aa93cbd 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1243,7 +1243,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = kxcjk1013_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kxcjk1013_data_rdy_trig_poll,
 						kxcjk1013_event_handler,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 9d649c4..df043b3 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1143,7 +1143,7 @@ static int mma9553_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = mma9553_gpio_probe(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						mma9553_irq_handler,
 						mma9553_event_handler,
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 462a010..82cdf50 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1363,7 +1363,7 @@ static int kmx61_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = kmx61_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kmx61_data_rdy_trig_poll,
 						kmx61_event_handler,
@@ -1445,10 +1445,10 @@ err_iio_unregister_mag:
 err_iio_unregister_acc:
 	iio_device_unregister(data->acc_indio_dev);
 err_buffer_cleanup_mag:
-	if (client->irq >= 0)
+	if (client->irq > 0)
 		iio_triggered_buffer_cleanup(data->mag_indio_dev);
 err_buffer_cleanup_acc:
-	if (client->irq >= 0)
+	if (client->irq > 0)
 		iio_triggered_buffer_cleanup(data->acc_indio_dev);
 err_trigger_unregister_motion:
 	iio_trigger_unregister(data->motion_trig);
@@ -1472,7 +1472,7 @@ static int kmx61_remove(struct i2c_client *client)
 	iio_device_unregister(data->acc_indio_dev);
 	iio_device_unregister(data->mag_indio_dev);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		iio_triggered_buffer_cleanup(data->acc_indio_dev);
 		iio_triggered_buffer_cleanup(data->mag_indio_dev);
 		iio_trigger_unregister(data->acc_dready_trig);
-- 
1.9.1

