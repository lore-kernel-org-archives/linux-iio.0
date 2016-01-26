Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36660 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbcAZMG3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 07:06:29 -0500
From: Lucas Tanure <tanure@linux.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: ltr501: Use a signed return type for ltr501_match_samp_freq
Date: Tue, 26 Jan 2016 10:06:22 -0200
Message-Id: <1453809982-3548-1-git-send-email-tanure@linux.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The return type "unsigned int" was used by the ltr501_match_samp_freq function
despite of the aspect that it will eventually return a negative error code.
So, change to signed int and get the value by reference in the parameters.

Done with the help of Coccinelle.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/iio/light/ltr501.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 809a961..99e8b12 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -180,16 +180,19 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
 			{500000, 2000000}
 };
 
-static unsigned int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
-					   int len, int val, int val2)
+static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
+					   int len, int val, int val2,
+					   int *ret)
 {
 	int i, freq;
 
 	freq = val * 1000000 + val2;
 
 	for (i = 0; i < len; i++) {
-		if (tab[i].freq_val == freq)
-			return i;
+		if (tab[i].freq_val == freq) {
+			*ret = i;
+			return 0;
+		}
 	}
 
 	return -EINVAL;
@@ -236,12 +239,12 @@ static int ltr501_als_write_samp_freq(struct ltr501_data *data,
 {
 	int i, ret;
 
-	i = ltr501_match_samp_freq(ltr501_als_samp_table,
+	ret = ltr501_match_samp_freq(ltr501_als_samp_table,
 				   ARRAY_SIZE(ltr501_als_samp_table),
-				   val, val2);
+				   val, val2, &i);
 
-	if (i < 0)
-		return i;
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&data->lock_als);
 	ret = regmap_field_write(data->reg_als_rate, i);
@@ -255,12 +258,12 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 {
 	int i, ret;
 
-	i = ltr501_match_samp_freq(ltr501_ps_samp_table,
+	ret = ltr501_match_samp_freq(ltr501_ps_samp_table,
 				   ARRAY_SIZE(ltr501_ps_samp_table),
-				   val, val2);
+				   val, val2, &i);
 
-	if (i < 0)
-		return i;
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&data->lock_ps);
 	ret = regmap_field_write(data->reg_ps_rate, i);
-- 
2.7.0

