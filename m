Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54937 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab3AaVnN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 16:43:13 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/11] staging/iio: (iio_hwmon) Use devm_kzalloc
Date: Thu, 31 Jan 2013 13:42:58 -0800
Message-Id: <1359668588-13678-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/iio/iio_hwmon.c |   70 ++++++++++++---------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index c7a5f97..5456272 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -55,63 +55,47 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
 	return sprintf(buf, "%d\n", result);
 }
 
-static void iio_hwmon_free_attrs(struct iio_hwmon_state *st)
-{
-	int i;
-	struct sensor_device_attribute *a;
-	for (i = 0; i < st->num_channels; i++)
-		if (st->attrs[i]) {
-			a = to_sensor_dev_attr(
-				container_of(st->attrs[i],
-					     struct device_attribute,
-					     attr));
-			kfree(a);
-		}
-}
-
 static int iio_hwmon_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct iio_hwmon_state *st;
 	struct sensor_device_attribute *a;
 	int ret, i;
 	int in_i = 1, temp_i = 1, curr_i = 1;
 	enum iio_chan_type type;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (st == NULL)
+		return -ENOMEM;
 
-	st->channels = iio_channel_get_all(dev_name(&pdev->dev));
-	if (IS_ERR(st->channels)) {
-		ret = PTR_ERR(st->channels);
-		goto error_free_state;
-	}
+	st->channels = iio_channel_get_all(dev_name(dev));
+	if (IS_ERR(st->channels))
+		return PTR_ERR(st->channels);
 
 	/* count how many attributes we have */
 	while (st->channels[st->num_channels].indio_dev)
 		st->num_channels++;
 
-	st->attrs = kzalloc(sizeof(st->attrs) * (st->num_channels + 1),
-			    GFP_KERNEL);
+	st->attrs = devm_kzalloc(dev,
+				 sizeof(st->attrs) * (st->num_channels + 1),
+				 GFP_KERNEL);
 	if (st->attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_release_channels;
 	}
+
 	for (i = 0; i < st->num_channels; i++) {
-		a = kzalloc(sizeof(*a), GFP_KERNEL);
+		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
 		if (a == NULL) {
 			ret = -ENOMEM;
-			goto error_free_attrs;
+			goto error_release_channels;
 		}
 
 		sysfs_attr_init(&a->dev_attr.attr);
 		ret = iio_get_channel_type(&st->channels[i], &type);
-		if (ret < 0) {
-			kfree(a);
-			goto error_free_attrs;
-		}
+		if (ret < 0)
+			goto error_release_channels;
+
 		switch (type) {
 		case IIO_VOLTAGE:
 			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
@@ -130,13 +114,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 			break;
 		default:
 			ret = -EINVAL;
-			kfree(a);
-			goto error_free_attrs;
+			goto error_release_channels;
 		}
 		if (a->dev_attr.attr.name == NULL) {
-			kfree(a);
 			ret = -ENOMEM;
-			goto error_free_attrs;
+			goto error_release_channels;
 		}
 		a->dev_attr.show = iio_hwmon_read_val;
 		a->dev_attr.attr.mode = S_IRUGO;
@@ -146,11 +128,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 
 	st->attr_group.attrs = st->attrs;
 	platform_set_drvdata(pdev, st);
-	ret = sysfs_create_group(&pdev->dev.kobj, &st->attr_group);
+	ret = sysfs_create_group(&dev->kobj, &st->attr_group);
 	if (ret < 0)
-		goto error_free_attrs;
+		goto error_release_channels;
 
-	st->hwmon_dev = hwmon_device_register(&pdev->dev);
+	st->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(st->hwmon_dev)) {
 		ret = PTR_ERR(st->hwmon_dev);
 		goto error_remove_group;
@@ -158,15 +140,9 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	return 0;
 
 error_remove_group:
-	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
-error_free_attrs:
-	iio_hwmon_free_attrs(st);
-	kfree(st->attrs);
+	sysfs_remove_group(&dev->kobj, &st->attr_group);
 error_release_channels:
 	iio_channel_release_all(st->channels);
-error_free_state:
-	kfree(st);
-error_ret:
 	return ret;
 }
 
@@ -176,8 +152,6 @@ static int iio_hwmon_remove(struct platform_device *pdev)
 
 	hwmon_device_unregister(st->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
-	iio_hwmon_free_attrs(st);
-	kfree(st->attrs);
 	iio_channel_release_all(st->channels);
 
 	return 0;
-- 
1.7.9.7

