Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33382 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcAOTnQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2016 14:43:16 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	devel@driverdev.osuosl.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] staging:iio:adc:added space around '-'
Date: Sat, 16 Jan 2016 01:12:41 +0530
Message-Id: <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
In-Reply-To: <cover.1452878721.git.bhumirks@gmail.com>
References: <cover.1452878721.git.bhumirks@gmail.com>
In-Reply-To: <cover.1452878721.git.bhumirks@gmail.com>
References: <cover.1452878721.git.bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds apace around '-' operator.Found using checkpatch.pl

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index f45ebed..0c73bce 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -744,14 +744,14 @@ out:
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		in_voltage - voltage_thresh_low_value,
 		S_IRUGO | S_IWUSR,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		in_voltage - voltage_thresh_high_value,
 		S_IRUGO | S_IWUSR,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
-- 
1.9.1

