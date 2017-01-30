Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33898 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdAaFQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 00:16:40 -0500
Received: by mail-pf0-f176.google.com with SMTP id e4so99103418pfg.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2017 21:16:20 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 4/5] iio: light: lm3533-als: Support initialization from Device Tree
Date: Mon, 30 Jan 2017 13:17:18 -0800
Message-Id: <20170130211719.31017-4-bjorn.andersson@linaro.org>
In-Reply-To: <20170130211719.31017-1-bjorn.andersson@linaro.org>
References: <20170130211719.31017-1-bjorn.andersson@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Implement support for initialization of the lm3533 als driver from
Device Tree.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Note that this patch can be merged independently of the other patches in the
series.

Changes since v5:
- None

Changes since v4:
- None

Changes since v3:
- Moved als DT parsing from mfd driver
- Gave driver its own compatible

 drivers/iio/light/lm3533-als.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index f409c2047c05..eef9f06eb0b1 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mfd/core.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -831,6 +832,32 @@ static const struct iio_info lm3533_als_info = {
 	.read_raw	= &lm3533_als_read_raw,
 };
 
+static struct lm3533_als_platform_data *lm3533_als_of_parse(struct device *dev)
+{
+	struct lm3533_als_platform_data *als_pdata;
+	struct device_node *node = dev->of_node;
+	int ret;
+	u32 val;
+
+	als_pdata = devm_kzalloc(dev, sizeof(*als_pdata), GFP_KERNEL);
+	if (!als_pdata)
+		return NULL;
+
+	als_pdata->pwm_mode = of_property_read_bool(node, "ti,pwm-mode");
+
+	ret = of_property_read_u32(node, "ti,als-resistance-ohm", &val);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "unable to read ti,als-resistance-ohm");
+		return NULL;
+	}
+
+	/* Leave at high-Z, if the property was omitted or specified as 0 */
+	if (!ret && val != 0)
+		als_pdata->r_select = 200000 / val;
+
+	return als_pdata;
+}
+
 static int lm3533_als_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
@@ -843,7 +870,11 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	if (!lm3533)
 		return -EINVAL;
 
-	pdata = pdev->dev.platform_data;
+	if (pdev->dev.of_node)
+		pdata = lm3533_als_of_parse(&pdev->dev);
+	else
+		pdata = pdev->dev.platform_data;
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data\n");
 		return -EINVAL;
@@ -914,9 +945,16 @@ static int lm3533_als_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id lm3533_als_of_match[] = {
+	{ .compatible = "ti,lm3533-als", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lm3533_als_of_match);
+
 static struct platform_driver lm3533_als_driver = {
 	.driver	= {
 		.name	= "lm3533-als",
+		.of_match_table = lm3533_als_of_match,
 	},
 	.probe		= lm3533_als_probe,
 	.remove		= lm3533_als_remove,
-- 
2.11.0

