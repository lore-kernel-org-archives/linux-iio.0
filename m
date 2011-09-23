Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51226 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab1IWLx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2011 07:53:26 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/16] staging:iio:adc:ad799x fix incorrect scan_type descriptions.
Date: Fri, 23 Sep 2011 13:01:27 +0100
Message-Id: <1316779302-12357-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A few of these had the wrong shifts, which would lead to
userspace hacking off the top couple of bits.  Also, one
part had the wrong accuracy.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad799x_core.c |   40 ++++++++++++++++----------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index b6662db..58f70aa 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -506,16 +506,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7995] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       0, 0, IIO_ST('u', 10, 16, 0), 0),
+				       0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       1, 1, IIO_ST('u', 10, 16, 0), 0),
+				       1, 1, IIO_ST('u', 10, 16, 2), 0),
 		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       2, 2, IIO_ST('u', 10, 16, 0), 0),
+				       2, 2, IIO_ST('u', 10, 16, 2), 0),
 		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       3, 3, IIO_ST('u', 10, 16, 0), 0),
+				       3, 3, IIO_ST('u', 10, 16, 2), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 1024,
@@ -524,16 +524,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7999] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       0, 0, IIO_ST('u', 10, 16, 0), 0),
+				       0, 0, IIO_ST('u', 8, 16, 4), 0),
 		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       1, 1, IIO_ST('u', 10, 16, 0), 0),
+				       1, 1, IIO_ST('u', 8, 16, 4), 0),
 		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       2, 2, IIO_ST('u', 10, 16, 0), 0),
+				       2, 2, IIO_ST('u', 8, 16, 4), 0),
 		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       3, 3, IIO_ST('u', 10, 16, 0), 0),
+				       3, 3, IIO_ST('u', 8, 16, 4), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 1024,
@@ -555,16 +555,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7993] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       0, 0, IIO_ST('u', 10, 16, 0), 0),
+				       0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       1, 1, IIO_ST('u', 10, 16, 0), 0),
+				       1, 1, IIO_ST('u', 10, 16, 2), 0),
 		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       2, 2, IIO_ST('u', 10, 16, 0), 0),
+				       2, 2, IIO_ST('u', 10, 16, 2), 0),
 		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       3, 3, IIO_ST('u', 10, 16, 0), 0),
+				       3, 3, IIO_ST('u', 10, 16, 2), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		.num_channels = 5,
 		.int_vref_mv = 1024,
@@ -593,28 +593,28 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7997] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  0, 0, IIO_ST('u', 10, 16, 0), 0),
+					  0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  1, 1, IIO_ST('u', 10, 16, 0), 0),
+					  1, 1, IIO_ST('u', 10, 16, 2), 0),
 		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  2, 2, IIO_ST('u', 10, 16, 0), 0),
+					  2, 2, IIO_ST('u', 10, 16, 2), 0),
 		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  3, 3, IIO_ST('u', 10, 16, 0), 0),
+					  3, 3, IIO_ST('u', 10, 16, 2), 0),
 		.channel[4] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  4, 4, IIO_ST('u', 10, 16, 0), 0),
+					  4, 4, IIO_ST('u', 10, 16, 2), 0),
 		.channel[5] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  5, 5, IIO_ST('u', 10, 16, 0), 0),
+					  5, 5, IIO_ST('u', 10, 16, 2), 0),
 		.channel[6] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  6, 6, IIO_ST('u', 10, 16, 0), 0),
+					  6, 6, IIO_ST('u', 10, 16, 2), 0),
 		.channel[7] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
-					  7, 7, IIO_ST('u', 10, 16, 0), 0),
+					  7, 7, IIO_ST('u', 10, 16, 2), 0),
 		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
 		.num_channels = 9,
 		.int_vref_mv = 1024,
-- 
1.7.3.4

