Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6365 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbaCKVNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 11 Mar 2014 17:13:31 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] iio: ak8975: Don't bail out for irq setup error
Date: Tue, 11 Mar 2014 14:15:57 -0700
Message-Id: <1394572557-8102-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1394572557-8102-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1394572557-8102-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver can very well work via polling, if request_irq failed.
The problem is that many times i2c interrupts are shared. This
driver is not ready for shared interrupt as it will return IRQ_HANDLED,
in every case. Here we will get EBUSY when some other driver registered
handler and this driver is grabbing in exclusive mode.
So in this case just print error and continue in polling mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index fe5e9c8..0f9c407 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -236,9 +236,15 @@ static int ak8975_setup(struct i2c_client *client)
 	if (data->eoc_gpio > 0 || client->irq) {
 		ret = ak8975_setup_irq(data);
 		if (ret < 0) {
-			dev_err(&client->dev,
-				"Error setting data ready interrupt\n");
-			return ret;
+			if (ret == -EBUSY) {
+				dev_err(&client->dev,
+					"device Intr busy:polling required\n");
+				ret = 0;
+			} else {
+				dev_err(&client->dev,
+					"Error setting data ready interrupt\n");
+				return ret;
+			}
 		}
 	}
 
-- 
1.7.11.7

