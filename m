Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:33836 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938708AbcIYLlJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 07:41:09 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 3/3] staging: iio: isl29018: fix comparison between signed and unsigned integers
Date: Sun, 25 Sep 2016 07:41:07 -0400
Message-Id: <1474803667-21776-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
References: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes warning found by make W=2:
warning: comparison between signed and unsigned integer expressions

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 0a35588..4e2ce74 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -104,7 +104,8 @@ struct isl29018_chip {
 static int isl29018_set_integration_time(struct isl29018_chip *chip,
 					 unsigned int utime)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 	unsigned int int_time, new_int_time;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i) {
@@ -139,7 +140,8 @@ static int isl29018_set_integration_time(struct isl29018_chip *chip,
 
 static int isl29018_set_scale(struct isl29018_chip *chip, int scale, int uscale)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 	struct isl29018_scale new_scale;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i) {
@@ -275,7 +277,8 @@ static ssize_t show_scale_available(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
-	int i, len = 0;
+	unsigned int i;
+	int len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
 		len += sprintf(buf + len, "%d.%06d ",
@@ -292,7 +295,8 @@ static ssize_t show_int_time_available(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
-	int i, len = 0;
+	unsigned int i;
+	int len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
 		len += sprintf(buf + len, "0.%06d ",
-- 
2.7.4

