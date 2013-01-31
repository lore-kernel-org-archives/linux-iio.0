Return-Path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/11] staging/iio: (iio_hwmon) Add support for sysfs name attribute
Date: Thu, 31 Jan 2013 13:42:59 -0800
Message-Id: <1359668588-13678-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

The 'name' attribute is mandatory for hwmon devices.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/iio/iio_hwmon.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index 5456272..7f260ea 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -55,6 +55,14 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
 	return sprintf(buf, "%d\n", result);
 }
 
+static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	return sprintf(buf, "iio_hwmon\n");
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static int iio_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -77,7 +85,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		st->num_channels++;
 
 	st->attrs = devm_kzalloc(dev,
-				 sizeof(st->attrs) * (st->num_channels + 1),
+				 sizeof(st->attrs) * (st->num_channels + 2),
 				 GFP_KERNEL);
 	if (st->attrs == NULL) {
 		ret = -ENOMEM;
@@ -125,7 +133,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		a->index = i;
 		st->attrs[i] = &a->dev_attr.attr;
 	}
-
+	st->attrs[st->num_channels] = &dev_attr_name.attr;
 	st->attr_group.attrs = st->attrs;
 	platform_set_drvdata(pdev, st);
 	ret = sysfs_create_group(&dev->kobj, &st->attr_group);
-- 
1.7.9.7
