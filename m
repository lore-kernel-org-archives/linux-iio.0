Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36790 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdAaFQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 00:16:40 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so99607828pfu.3
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2017 21:16:14 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Richard Purdie <rpurdie@rpsys.net>,
        Pavel Machek <pavel@ucw.cz>, Jingoo Han <jingoohan1@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v6 2/5] mfd: lm3533: Support initialization from Device Tree
Date: Mon, 30 Jan 2017 13:17:16 -0800
Message-Id: <20170130211719.31017-2-bjorn.andersson@linaro.org>
In-Reply-To: <20170130211719.31017-1-bjorn.andersson@linaro.org>
References: <20170130211719.31017-1-bjorn.andersson@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Implement support for initialization of the lm3533 driver core and
probing child devices from Device Tree.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mfd/lm3533-core.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

Note that this patch can be merged independently of the other patches in the
series.

Changes since v5:
- Added comment re of_platform_populate()

Changes since v4:
- Moved of_node check into lm3533_pdata_from_of_node()

Changes since v3:
- Moved parsing of child of nodes into each child driver
- Use of_platform_populate() to instanciate child devices


diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 5abcbb2e8849..89c79328c78e 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -18,6 +18,8 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -512,6 +514,16 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
+	/*
+	 * Check of_node as of_platform_populate treats NULL as the root node,
+	 * which would cause side effects in certain unlikely DT/non-DT hybrid
+	 * solutions.
+	 */
+	if (lm3533->dev->of_node) {
+		of_platform_populate(lm3533->dev->of_node, NULL, NULL,
+				     lm3533->dev);
+	}
+
 	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
 	if (ret < 0) {
 		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
@@ -588,10 +600,76 @@ static const struct regmap_config regmap_config = {
 	.precious_reg	= lm3533_precious_register,
 };
 
+static int lm3533_of_parse_enum(struct device *dev, const char *propname,
+				const unsigned int *match, size_t num_matches)
+{
+	size_t i;
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(dev->of_node, propname, &val);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse %s\n", propname);
+		return ret;
+	}
+
+	for (i = 0; i < num_matches; i++) {
+		if (val == match[i])
+			return i;
+	}
+
+	dev_err(dev, "unsupported value of %s\n", propname);
+	return -EINVAL;
+}
+
+static int lm3533_pdata_from_of_node(struct device *dev)
+{
+	struct lm3533_platform_data *pdata;
+	int ret;
+	const unsigned int freqs[] = {
+		[LM3533_BOOST_FREQ_500KHZ] = 500000,
+		[LM3533_BOOST_FREQ_1000KHZ] = 1000000,
+	};
+	const unsigned int ovps[] = {
+		[LM3533_BOOST_OVP_16V] = 16000,
+		[LM3533_BOOST_OVP_24V] = 24000,
+		[LM3533_BOOST_OVP_32V] = 32000,
+		[LM3533_BOOST_OVP_40V] = 40000,
+	};
+
+	if (!dev->of_node)
+		return 0;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->gpio_hwen = of_get_named_gpio(dev->of_node, "hwen-gpios", 0);
+	if (pdata->gpio_hwen < 0)
+		return pdata->gpio_hwen;
+
+	ret = lm3533_of_parse_enum(dev, "ti,boost-freq-hz",
+				   freqs, ARRAY_SIZE(freqs));
+	if (ret < 0)
+		return ret;
+	pdata->boost_freq = ret;
+
+	ret = lm3533_of_parse_enum(dev, "ti,boost-ovp-mv",
+				   ovps, ARRAY_SIZE(ovps));
+	if (ret < 0)
+		return ret;
+	pdata->boost_ovp = ret;
+
+	dev->platform_data = pdata;
+
+	return 0;
+}
+
 static int lm3533_i2c_probe(struct i2c_client *i2c,
 					const struct i2c_device_id *id)
 {
 	struct lm3533 *lm3533;
+	int ret;
 
 	dev_dbg(&i2c->dev, "%s\n", __func__);
 
@@ -608,6 +686,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c,
 	lm3533->dev = &i2c->dev;
 	lm3533->irq = i2c->irq;
 
+	ret = lm3533_pdata_from_of_node(lm3533->dev);
+	if (ret < 0)
+		return ret;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.11.0

