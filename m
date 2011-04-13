Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:60321 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab1DMNvB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2011 09:51:01 -0400
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/1] IIO: DAC: AD5446 add support for AD5541A devices
Date: Wed, 13 Apr 2011 15:42:10 +0200
Message-ID: <1302702130-4779-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5446.c |    7 +++++++
 drivers/staging/iio/dac/ad5446.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 8623a72..102bcc4 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -245,6 +245,12 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 0,
 		.store_sample = ad5446_store_sample,
 	},
+	[ID_AD5541A] = {
+		.bits = 16,
+		.storagebits = 16,
+		.left_shift = 0,
+		.store_sample = ad5542_store_sample,
+	},
 	[ID_AD5542A] = {
 		.bits = 16,
 		.storagebits = 16,
@@ -442,6 +448,7 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5444", ID_AD5444},
 	{"ad5446", ID_AD5446},
 	{"ad5512a", ID_AD5512A},
+	{"ad5541a", ID_AD5541A},
 	{"ad5542a", ID_AD5542A},
 	{"ad5543", ID_AD5543},
 	{"ad5553", ID_AD5553},
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 7ac63ab..e6ffd2b 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -92,6 +92,7 @@ struct ad5446_chip_info {
 enum ad5446_supported_device_ids {
 	ID_AD5444,
 	ID_AD5446,
+	ID_AD5541A,
 	ID_AD5542A,
 	ID_AD5543,
 	ID_AD5512A,
-- 
1.6.0.2

