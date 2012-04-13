Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37400 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758359Ab2DMKEh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:04:37 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 13/13] staging:iio: drop procesed_val element of chan_spec.
Date: Fri, 13 Apr 2012 11:04:31 +0100
Message-Id: <1334311471-23054-14-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no longer any need for this as we have separate
info_mask elements for raw and processed value reads.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/cdc/ad7746.c                |    2 --
 drivers/staging/iio/iio.h                       |   13 ++++++-------
 drivers/staging/iio/impedance-analyzer/ad5933.c |    1 -
 drivers/staging/iio/industrialio-core.c         |    5 -----
 drivers/staging/iio/light/isl29018.c            |    1 -
 drivers/staging/iio/light/tsl2563.c             |    1 -
 6 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 6c75605..750bf4b 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -142,7 +142,6 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.processed_val = IIO_PROCESSED,
 		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_INT_TEMP,
@@ -151,7 +150,6 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 1,
-		.processed_val = IIO_PROCESSED,
 		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_TEMP,
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 16b6901..6770ec8 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -19,12 +19,6 @@
  * Currently assumes nano seconds.
  */
 
-enum iio_data_type {
-	IIO_RAW,
-	IIO_PROCESSED,
-};
-
-/* Could add the raw attributes as well - allowing buffer only devices */
 enum iio_chan_info_enum {
 	IIO_CHAN_INFO_RAW = 0,
 	IIO_CHAN_INFO_PROCESSED,
@@ -138,11 +132,17 @@ struct iio_chan_spec_ext_info {
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
  * @datasheet_name:	A name used in in kernel mapping of channels. It should
+<<<<<<< HEAD
  *			correspond to the first name that the channel is referred
  *			to by in the datasheet (e.g. IND), or the nearest
  *			possible compound name (e.g. IND-INC).
  * @processed_val:	Flag to specify the data access attribute should be
  *			*_input rather than *_raw.
+=======
+ *			correspond to the first name that the channel is
+ *			referred to by in the datasheet (e.g. IND), or the
+ *			nearest	possible compound name (e.g. IND-INC).
+>>>>>>> adbde46... staging:iio: drop procesed_val element of chan_spec.
  * @modified:		Does a modifier apply to this channel. What these are
  *			depends on the channel type.  Modifier is set in
  *			channel2. Examples are IIO_MOD_X for axial sensors about
@@ -171,7 +171,6 @@ struct iio_chan_spec {
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
 	const char		*datasheet_name;
-	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
 	unsigned		output:1;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9d5738a..93e5a71 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -112,7 +112,6 @@ static struct iio_chan_spec ad5933_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.indexed = 1,
-		.processed_val = 1,
 		.channel = 0,
 		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.address = AD5933_REG_TEMP_DATA,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 20bed97..80c1b8b 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -42,11 +42,6 @@ EXPORT_SYMBOL(iio_bus_type);
 
 static struct dentry *iio_debugfs_dentry;
 
-static const char * const iio_data_type_name[] = {
-	[IIO_RAW] = "raw",
-	[IIO_PROCESSED] = "input",
-};
-
 static const char * const iio_direction[] = {
 	[0] = "in",
 	[1] = "out",
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 350f12c..073e899 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -420,7 +420,6 @@ static const struct iio_chan_spec isl29018_channels[] = {
 		.type = IIO_LIGHT,
 		.indexed = 1,
 		.channel = 0,
-		.processed_val = IIO_PROCESSED,
 		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}, {
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index a334a88..a1e5cbe 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -535,7 +535,6 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.indexed = 1,
-		.processed_val = 1,
 		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.channel = 0,
 	}, {
-- 
1.7.0.4

