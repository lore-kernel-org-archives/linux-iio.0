Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: light: isl29125: Add scale_available information
Date: Sat, 20 Jun 2015 14:02:30 +0200
Message-Id: <1434801750-5500-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/isl29125.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index c82f4a6..fc96999 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -197,9 +197,21 @@ done:
 	return IRQ_HANDLED;
 }
 
+static IIO_CONST_ATTR(scale_available, "0.005722 0.152590");
+
+static struct attribute *isl29125_attributes[] = {
+	&iio_const_attr_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group isl29125_attribute_group = {
+	.attrs = isl29125_attributes,
+};
+
 static const struct iio_info isl29125_info = {
 	.read_raw = isl29125_read_raw,
 	.write_raw = isl29125_write_raw,
+	attrs = &isl29125_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.9.1
