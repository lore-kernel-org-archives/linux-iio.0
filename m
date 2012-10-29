Return-Path: <axel.lin@ingics.com>
Message-ID: <1351499156.14725.1.camel@phoenix>
Subject: [PATCH] Revert "iio: at91_adc: Use devm_kcalloc to allocate arrays"
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Maxime Ripard
	 <maxime.ripard@free-electrons.com>, linux-iio@vger.kernel.org
Date: Mon, 29 Oct 2012 16:25:56 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This reverts commit 45259859492812c8b700ae1d157be01a8d2babfe.
This fixes build error because devm_kcalloc does not exist in current tree.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/iio/adc/at91_adc.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a917672..2e2c9a8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -123,8 +123,10 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 	idev->num_channels = bitmap_weight(&st->channels_mask,
 					   st->num_channels) + 1;
 
-	chan_array = devm_kcalloc(&idev->dev, idev->num_channels + 1,
-					sizeof(*chan_array), GFP_KERNEL);
+	chan_array = devm_kzalloc(&idev->dev,
+				  ((idev->num_channels + 1) *
+					sizeof(struct iio_chan_spec)),
+				  GFP_KERNEL);
 
 	if (!chan_array)
 		return -ENOMEM;
@@ -268,8 +270,9 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 	struct at91_adc_state *st = iio_priv(idev);
 	int i, ret;
 
-	st->trig = devm_kcalloc(&idev->dev, st->trigger_number,
-				sizeof(*st->trig), GFP_KERNEL);
+	st->trig = devm_kzalloc(&idev->dev,
+				st->trigger_number * sizeof(st->trig),
+				GFP_KERNEL);
 
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
@@ -451,8 +454,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	st->registers->trigger_register = prop;
 
 	st->trigger_number = of_get_child_count(node);
-	st->trigger_list = devm_kcalloc(&idev->dev, st->trigger_number,
-					sizeof(*st->trigger_list), GFP_KERNEL);
+	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
+					sizeof(struct at91_adc_trigger),
+					GFP_KERNEL);
 	if (!st->trigger_list) {
 		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
 		ret = -ENOMEM;
-- 
1.7.9.5
