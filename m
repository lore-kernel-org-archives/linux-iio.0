Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52950 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642AbbCCQSL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Mar 2015 11:18:11 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Subject: [PATCH v4 1/3] iio: bmc150: change sampling frequency
Date: Tue,  3 Mar 2015 18:17:56 +0200
Message-Id: <1425399478-5464-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425399478-5464-1-git-send-email-octavian.purdila@intel.com>
References: <1425399478-5464-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>

Currently driver reports device bandwidth list as available
sampling frequency. But sampling frequency is actually twice
the device bandwidth. This patch fixes this issue.

Signed-off-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 8004ce3..74ee54e 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -168,14 +168,14 @@ static const struct {
 	int val;
 	int val2;
 	u8 bw_bits;
-} bmc150_accel_samp_freq_table[] = { {7, 810000, 0x08},
-				     {15, 630000, 0x09},
-				     {31, 250000, 0x0A},
-				     {62, 500000, 0x0B},
-				     {125, 0, 0x0C},
-				     {250, 0, 0x0D},
-				     {500, 0, 0x0E},
-				     {1000, 0, 0x0F} };
+} bmc150_accel_samp_freq_table[] = { {15, 620000, 0x08},
+				     {31, 260000, 0x09},
+				     {62, 500000, 0x0A},
+				     {125, 0, 0x0B},
+				     {250, 0, 0x0C},
+				     {500, 0, 0x0D},
+				     {1000, 0, 0x0E},
+				     {2000, 0, 0x0F} };
 
 static const struct {
 	int bw_bits;
@@ -783,7 +783,7 @@ static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
-		"7.810000 15.630000 31.250000 62.500000 125 250 500 1000");
+		"15.620000 31.260000 62.50000 125 250 500 1000 2000");
 
 static struct attribute *bmc150_accel_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-- 
1.9.1

