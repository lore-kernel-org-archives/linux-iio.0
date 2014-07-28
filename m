Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55574 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbaG1LTZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Jul 2014 07:19:25 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: linux-iio@vger.kernel.org
Cc: Teodora Baluta <teodora.baluta@intel.com>
Subject: [PATCH 2/5] staging: iio: ad5933: fix sparse warning cast to restricted __be16
Date: Mon, 28 Jul 2014 14:18:30 +0300
Message-Id: <1406546313-23031-3-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the following sparse endianness warnings:

  CHECK   drivers/staging/iio/impedance-analyzer/ad5933.c
drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:674:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:675:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
restricted __be16
drivers/staging/iio/impedance-analyzer/ad5933.c:677:34: warning: cast to
restricted __be16

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 2cef4b9..87ce844 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -647,7 +647,7 @@ static void ad5933_work(struct work_struct *work)
 	struct ad5933_state *st = container_of(work,
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
-	signed short buf[2];
+	u16 buf[2];
 	unsigned char status;
 
 	mutex_lock(&indio_dev->mlock);
@@ -671,10 +671,10 @@ static void ad5933_work(struct work_struct *work)
 				scan_count * 2, (u8 *)buf);
 
 		if (scan_count == 2) {
-			buf[0] = be16_to_cpu(buf[0]);
-			buf[1] = be16_to_cpu(buf[1]);
+			be16_to_cpus(&buf[0]);
+			be16_to_cpus(&buf[1]);
 		} else {
-			buf[0] = be16_to_cpu(buf[0]);
+			be16_to_cpus(&buf[0]);
 		}
 		iio_push_to_buffers(indio_dev, buf);
 	} else {
-- 
1.9.1

