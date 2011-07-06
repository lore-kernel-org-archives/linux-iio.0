Return-Path: <bfreed@google.com>
From: Bryan Freed <bfreed@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: jic23@cam.ac.uk, gregkh@suse.de, rklein@nvidia.com,
        linux-iio@vger.kernel.org, Bryan Freed <bfreed@chromium.org>
Subject: [PATCH 1/3] staging:iio: Reorder channel type strings to match the iio.h enums.
Date: Wed,  6 Jul 2011 11:56:24 -0700
Message-Id: <1309978586-10092-1-git-send-email-bfreed@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

This makes comparison between the iio_chan_type_name_spec_shared strings
and the iio_chan_type enums easier.

Signed-off-by: Bryan Freed <bfreed@chromium.org>
---
 drivers/staging/iio/industrialio-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 94d3bfa..4987bf4 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -44,20 +44,20 @@ struct bus_type iio_bus_type = {
 EXPORT_SYMBOL(iio_bus_type);
 
 static const char * const iio_chan_type_name_spec_shared[] = {
-	[IIO_TIMESTAMP] = "timestamp",
-	[IIO_ACCEL] = "accel",
 	[IIO_IN] = "in",
 	[IIO_CURRENT] = "current",
 	[IIO_POWER] = "power",
+	[IIO_ACCEL] = "accel",
 	[IIO_IN_DIFF] = "in-in",
 	[IIO_GYRO] = "gyro",
-	[IIO_TEMP] = "temp",
 	[IIO_MAGN] = "magn",
+	[IIO_LIGHT] = "illuminance",
+	[IIO_INTENSITY] = "intensity",
+	[IIO_TEMP] = "temp",
 	[IIO_INCLI] = "incli",
 	[IIO_ROT] = "rot",
-	[IIO_INTENSITY] = "intensity",
-	[IIO_LIGHT] = "illuminance",
 	[IIO_ANGL] = "angl",
+	[IIO_TIMESTAMP] = "timestamp",
 };
 
 static const char * const iio_chan_type_name_spec_complex[] = {
-- 
1.7.3.1
