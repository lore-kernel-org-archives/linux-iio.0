Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59533 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbaHSWnb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Aug 2014 18:43:31 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH v2 02/11] iio:bma180: Prefix remaining tables and functions with bma18_
Date: Wed, 20 Aug 2014 00:43:17 +0200
Message-Id: <1408488206-2633-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

and minor cleanups

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index f5e26fb..d7f34b4 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -49,7 +49,7 @@
 #define BMA180_SMP_SKIP		BIT(0)
 
 /* Bit masks for registers bit fields */
-#define BMA180_RANGE		0x0e /* Range of measured accel values*/
+#define BMA180_RANGE		0x0e /* Range of measured accel values */
 #define BMA180_BW		0xf0 /* Accel bandwidth */
 #define BMA180_MODE_CONFIG	0x03 /* Config operation modes */
 
@@ -93,8 +93,8 @@ enum bma180_axis {
 	AXIS_Z,
 };
 
-static int bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
-static int scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
+static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
+static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
 static int bma180_get_acc_reg(struct bma180_data *data, enum bma180_axis axis)
 {
@@ -107,7 +107,7 @@ static int bma180_get_acc_reg(struct bma180_data *data, enum bma180_axis axis)
 	ret = i2c_smbus_read_word_data(data->client, reg);
 	if (ret < 0)
 		dev_err(&data->client->dev,
-			"failed to read accel_%c registers\n", 'x' + axis);
+			"failed to read accel_%c register\n", 'x' + axis);
 
 	return ret;
 }
@@ -185,8 +185,8 @@ static int bma180_set_bw(struct bma180_data *data, int val)
 	if (data->sleep_state)
 		return -EBUSY;
 
-	for (i = 0; i < ARRAY_SIZE(bw_table); ++i) {
-		if (bw_table[i] == val) {
+	for (i = 0; i < ARRAY_SIZE(bma180_bw_table); ++i) {
+		if (bma180_bw_table[i] == val) {
 			ret = bma180_set_bits(data,
 					BMA180_BW_TCS, BMA180_BW, i);
 			if (ret) {
@@ -209,8 +209,8 @@ static int bma180_set_scale(struct bma180_data *data, int val)
 	if (data->sleep_state)
 		return -EBUSY;
 
-	for (i = 0; i < ARRAY_SIZE(scale_table); ++i)
-		if (scale_table[i] == val) {
+	for (i = 0; i < ARRAY_SIZE(bma180_scale_table); ++i)
+		if (bma180_scale_table[i] == val) {
 			ret = bma180_set_bits(data,
 					BMA180_OFFSET_LSB1, BMA180_RANGE, i);
 			if (ret) {
-- 
1.9.1

