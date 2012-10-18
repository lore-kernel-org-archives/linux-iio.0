Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1090 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab2JROmH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2012 10:42:07 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 4/4] iio: at91_adc: Use devm_kcalloc to allocate arrays
Date: Thu, 18 Oct 2012 16:43:19 +0200
Message-Id: <1350571399-17723-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-1-git-send-email-lars@metafoo.de>
References: <1350571399-17723-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use dev_kcalloc instead of devm_kzalloc to allocate arrays since it is
semantically more appropriate.

While we are at it the patch also fixes the following coccinelle warning:
	drivers/iio/adc/at91_adc.c:277:25-31: ERROR: application of sizeof to pointer

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3ed94bf..b81f93b 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -126,10 +126,8 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 	idev->num_channels = bitmap_weight(&st->channels_mask,
 					   st->num_channels) + 1;
 
-	chan_array = devm_kzalloc(&idev->dev,
-				  ((idev->num_channels + 1) *
-					sizeof(struct iio_chan_spec)),
-				  GFP_KERNEL);
+	chan_array = devm_kcalloc(&idev->dev, idev->num_channels + 1,
+					sizeof(*chan_array), GFP_KERNEL);
 
 	if (!chan_array)
 		return -ENOMEM;
@@ -273,9 +271,8 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 	struct at91_adc_state *st = iio_priv(idev);
 	int i, ret;
 
-	st->trig = devm_kzalloc(&idev->dev,
-				st->trigger_number * sizeof(st->trig),
-				GFP_KERNEL);
+	st->trig = devm_kcalloc(&idev->dev, st->trigger_number,
+				sizeof(*st->trig), GFP_KERNEL);
 
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
@@ -457,9 +454,8 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	st->registers->trigger_register = prop;
 
 	st->trigger_number = of_get_child_count(node);
-	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
-					sizeof(struct at91_adc_trigger),
-					GFP_KERNEL);
+	st->trigger_list = devm_kcalloc(&idev->dev, st->trigger_number,
+					sizeof(*st->trigger_list), GFP_KERNEL);
 	if (!st->trigger_list) {
 		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
 		ret = -ENOMEM;
-- 
1.7.10.4

