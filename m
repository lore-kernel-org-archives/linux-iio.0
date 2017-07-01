Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36816 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdGAVyz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jul 2017 17:54:55 -0400
Received: by mail-qt0-f195.google.com with SMTP id v31so19362699qtb.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Jul 2017 14:54:54 -0700 (PDT)
From: Reno Farnesi <nfarnesi4@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Reno Farnesi <nfarnesi4@gmail.com>
Subject: [PATCH] iio: adis16400: Change unsigned to unsigned int
Date: Sat,  1 Jul 2017 17:54:08 -0400
Message-Id: <20170701215408.27600-1-nfarnesi4@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the following checkpatch warnings:

Prefer 'unsigned int' to bare use of 'unsigned

Signed-off-by: Reno Farnesi <nfarnesi4@gmail.com>
---
 drivers/iio/imu/adis16400_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index fb7c0dbed51c..9b697d35dbef 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -217,7 +217,7 @@ static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
 	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
 }
 
-static const unsigned adis16400_3db_divisors[] = {
+static const unsigned int adis16400_3db_divisors[] = {
 	[0] = 2, /* Special case */
 	[1] = 6,
 	[2] = 12,
@@ -890,7 +890,7 @@ static const struct adis_data adis16400_data = {
 static void adis16400_setup_chan_mask(struct adis16400_state *st)
 {
 	const struct adis16400_chip_info *chip_info = st->variant;
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < chip_info->num_channels; i++) {
 		const struct iio_chan_spec *ch = &chip_info->channels[i];
-- 
2.13.2

