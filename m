Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:45800 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751185AbdCPXhn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 19:37:43 -0400
From: Miguel Robles <miguel.robles@farole.net>
To: jic23@kernel.org, lars@metafoo.de, knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Robles <miguel.robles@farole.net>
Subject: [PATCH] iio: accel: Prefer unsigned int to bare use of unsigned
Date: Fri, 17 Mar 2017 00:35:45 +0100
Message-Id: <1489707345-20053-1-git-send-email-miguel.robles@farole.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix checkpatch warnings:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Miguel Robles <miguel.robles@farole.net>
---
 drivers/iio/accel/bma180.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 0890934..dd84e87 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -41,11 +41,11 @@ struct bma180_data;
 
 struct bma180_part_info {
 	const struct iio_chan_spec *channels;
-	unsigned num_channels;
+	unsigned int num_channels;
 	const int *scale_table;
-	unsigned num_scales;
+	unsigned int num_scales;
 	const int *bw_table;
-	unsigned num_bw;
+	unsigned int num_bw;
 
 	u8 int_reset_reg, int_reset_mask;
 	u8 sleep_reg, sleep_mask;
@@ -408,7 +408,7 @@ static void bma250_chip_disable(struct bma180_data *data)
 	dev_err(&data->client->dev, "failed to disable the chip\n");
 }
 
-static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned n,
+static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned int n,
 				 bool micros)
 {
 	size_t len = 0;
-- 
2.7.4

