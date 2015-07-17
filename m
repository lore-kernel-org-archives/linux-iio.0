Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:51555 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbbGQW5I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Jul 2015 18:57:08 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Martin Liska <marxin.liska@gmail.com>,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 1/1] iio:light:acpi-als: add missing prefixes
Date: Sat, 18 Jul 2015 00:56:57 +0200
Message-Id: <1437173817-10434-1-git-send-email-knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some macros and a function were missing the acpi_als_ prefix, so add it.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/acpi-als.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 1dafa0756bfa..60537ec0c923 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -65,20 +65,20 @@ static const struct iio_chan_spec acpi_als_channels[] = {
  * to acpi_als_channels[], the evt_buffer below will grow
  * automatically.
  */
-#define EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
-#define EVT_BUFFER_SIZE		\
-	(sizeof(s64) + (EVT_NR_SOURCES * sizeof(s32)))
+#define ACPI_ALS_EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
+#define ACPI_ALS_EVT_BUFFER_SIZE		\
+	(sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
 
 struct acpi_als {
 	struct acpi_device	*device;
 	struct mutex		lock;
 
-	s32			evt_buffer[EVT_BUFFER_SIZE];
+	s32			evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
 };
 
 /*
  * All types of properties the ACPI0008 block can report. The ALI, ALC, ALT
- * and ALP can all be handled by als_read_value() below, while the ALR is
+ * and ALP can all be handled by acpi_als_read_value() below, while the ALR is
  * special.
  *
  * The _ALR property returns tables that can be used to fine-tune the values
@@ -93,7 +93,7 @@ struct acpi_als {
 #define ACPI_ALS_POLLING	"_ALP"
 #define ACPI_ALS_TABLES		"_ALR"
 
-static int als_read_value(struct acpi_als *als, char *prop, s32 *val)
+static int acpi_als_read_value(struct acpi_als *als, char *prop, s32 *val)
 {
 	unsigned long long temp_val;
 	acpi_status status;
@@ -122,11 +122,11 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
 
 	mutex_lock(&als->lock);
 
-	memset(buffer, 0, EVT_BUFFER_SIZE);
+	memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
 
 	switch (event) {
 	case ACPI_ALS_NOTIFY_ILLUMINANCE:
-		ret = als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
+		ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
 		if (ret < 0)
 			goto out;
 		*buffer++ = val;
@@ -159,7 +159,7 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
 	if (chan->type != IIO_LIGHT)
 		return -EINVAL;
 
-	ret = als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
+	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
 	if (ret < 0)
 		return ret;
 
-- 
2.4.3

