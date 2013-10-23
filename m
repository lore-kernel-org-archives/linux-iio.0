Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:57011 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753296Ab3JWTQF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 15:16:05 -0400
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: [PATCH 7/8] staging: Remove OOM message after input_allocate_device
Date: Wed, 23 Oct 2013 12:14:53 -0700
Message-Id: <607933414008a7de55bcd88348d525cbec238ed1.1382555436.git.joe@perches.com>
In-Reply-To: <cover.1382555436.git.joe@perches.com>
References: <cover.1382555436.git.joe@perches.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Emitting an OOM message isn't necessary after input_allocate_device
as there's a generic OOM and a dump_stack already done.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/cptm1217/clearpad_tm1217.c    | 2 --
 drivers/staging/iio/adc/mxs-lradc.c           | 4 +---
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c | 2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/cptm1217/clearpad_tm1217.c b/drivers/staging/cptm1217/clearpad_tm1217.c
index 42a5f5c..ca4c2c6 100644
--- a/drivers/staging/cptm1217/clearpad_tm1217.c
+++ b/drivers/staging/cptm1217/clearpad_tm1217.c
@@ -457,8 +457,6 @@ static int cp_tm1217_probe(struct i2c_client *client,
 	for (i = 0; i < TOUCH_SUPPORTED; i++) {
 		input_dev = input_allocate_device();
 		if (input_dev == NULL) {
-			dev_err(ts->dev,
-				"cp_tm1217:Input Device Struct alloc failed\n");
 			retval = -ENOMEM;
 			goto fail;
 		}
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 9da64bf..696fbb3 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -529,10 +529,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 		return 0;
 
 	input = input_allocate_device();
-	if (!input) {
-		dev_err(dev, "Failed to allocate TS device!\n");
+	if (!input)
 		return -ENOMEM;
-	}
 
 	input->name = DRIVER_NAME;
 	input->id.bustype = BUS_HOST;
diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
index 386362c..28b3930 100644
--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -911,8 +911,6 @@ static int synaptics_rmi4_probe
 
 	rmi4_data->input_dev = input_allocate_device();
 	if (rmi4_data->input_dev == NULL) {
-		dev_err(&client->dev, "%s:input device alloc failed\n",
-						__func__);
 		retval = -ENOMEM;
 		goto err_input;
 	}
-- 
1.8.1.2.459.gbcd45b4.dirty

