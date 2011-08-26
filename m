Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/12] staging:iio: ABI rework - add in_ or out_ prefix to channnels
Date: Fri, 26 Aug 2011 11:16:24 +0100
Message-Id: <1314353795-7437-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Also involves changing current inX outX to in_voltageX and out_voltageX

V2: squash users of the IIO_CHAN_OUT macro and get rid of it.
There are very few of these, so it is easier to fix them.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5686.c        |   70 +++++++++---------------------
 drivers/staging/iio/iio.h               |   14 ++++--
 drivers/staging/iio/industrialio-core.c |   29 ++++++++-----
 3 files changed, 49 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 4dc1831..05545a2 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -96,63 +96,35 @@ enum ad5686_supported_device_ids {
 	ID_AD5685,
 	ID_AD5686,
 };
-
+#define AD5868_CHANNEL(chan, bits, shift) {			\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.output = 1,					\
+		.channel = chan,				\
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),	\
+		.address = AD5686_ADDR_DAC0,			\
+		.scan_type = IIO_ST('u', bits, 16, shift)	\
+}
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5684] = {
-		.channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC0,
-				    0, IIO_ST('u', 12, 16, 4), 0),
-		.channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC1,
-				    1, IIO_ST('u', 12, 16, 4), 0),
-		.channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC2,
-				    2, IIO_ST('u', 12, 16, 4), 0),
-		.channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC3,
-				    3, IIO_ST('u', 12, 16, 4), 0),
+		.channel[0] = AD5868_CHANNEL(0, 12, 4),
+		.channel[1] = AD5868_CHANNEL(1, 12, 4),
+		.channel[2] = AD5868_CHANNEL(2, 12, 4),
+		.channel[3] = AD5868_CHANNEL(3, 12, 4),
 		.int_vref_mv = 2500,
 	},
 	[ID_AD5685] = {
-		.channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC0,
-				    0, IIO_ST('u', 14, 16, 2), 0),
-		.channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC1,
-				    1, IIO_ST('u', 14, 16, 2), 0),
-		.channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC2,
-				    2, IIO_ST('u', 14, 16, 2), 0),
-		.channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC3,
-				    3, IIO_ST('u', 14, 16, 2), 0),
+		.channel[0] = AD5868_CHANNEL(0, 14, 2),
+		.channel[1] = AD5868_CHANNEL(1, 14, 2),
+		.channel[2] = AD5868_CHANNEL(2, 14, 2),
+		.channel[3] = AD5868_CHANNEL(3, 14, 2),
 		.int_vref_mv = 2500,
 	},
 	[ID_AD5686] = {
-		.channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC0,
-				    0, IIO_ST('u', 16, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC1,
-				    1, IIO_ST('u', 16, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC2,
-				    2, IIO_ST('u', 16, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD5686_ADDR_DAC3,
-				    3, IIO_ST('u', 16, 16, 0), 0),
+		.channel[0] = AD5868_CHANNEL(0, 16, 0),
+		.channel[1] = AD5868_CHANNEL(1, 16, 0),
+		.channel[2] = AD5868_CHANNEL(2, 16, 0),
+		.channel[3] = AD5868_CHANNEL(3, 16, 0),
 		.int_vref_mv = 2500,
 	},
 };
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 6b896a5..f423870 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -27,12 +27,11 @@ enum iio_data_type {
 
 enum iio_chan_type {
 	/* real channel types */
-	IIO_IN,
-	IIO_OUT,
+	IIO_VOLTAGE,
 	IIO_CURRENT,
 	IIO_POWER,
 	IIO_ACCEL,
-	IIO_IN_DIFF,
+	IIO_VOLTAGE_DIFF,
 	IIO_GYRO,
 	IIO_MAGN,
 	IIO_LIGHT,
@@ -45,6 +44,10 @@ enum iio_chan_type {
 	IIO_TIMESTAMP,
 };
 
+/* Nasty hack to avoid massive churn */
+#define	IIO_IN IIO_VOLTAGE
+#define	IIO_IN_DIFF IIO_VOLTAGE_DIFF
+
 #define IIO_MOD_X			0
 #define IIO_MOD_LIGHT_BOTH		0
 #define IIO_MOD_Y			1
@@ -127,14 +130,17 @@ struct iio_chan_spec {
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
+	unsigned		output:1;
 };
 
 #define IIO_ST(si, rb, sb, sh)						\
 	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
 
-#define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2,	\
+/* Macro assumes input channels */
+#define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2, \
 		 _inf_mask, _address, _si, _stype, _event_mask)		\
 	{ .type = _type,						\
+	  .output = 0,							\
 	  .modified = _mod,						\
 	  .indexed = _indexed,						\
 	  .processed_val = _proc,					\
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index f59a603..5717f19 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -44,13 +44,17 @@ static const char * const iio_data_type_name[] = {
 	[IIO_PROCESSED] = "input",
 };
 
+static const char * const iio_direction[] = {
+	[0] = "in",
+	[1] = "out",
+};
+
 static const char * const iio_chan_type_name_spec_shared[] = {
-	[IIO_IN] = "in",
-	[IIO_OUT] = "out",
+	[IIO_VOLTAGE] = "voltage",
 	[IIO_CURRENT] = "current",
 	[IIO_POWER] = "power",
 	[IIO_ACCEL] = "accel",
-	[IIO_IN_DIFF] = "in-in",
+	[IIO_VOLTAGE_DIFF] = "voltage-voltage",
 	[IIO_GYRO] = "gyro",
 	[IIO_MAGN] = "magn",
 	[IIO_LIGHT] = "illuminance",
@@ -64,7 +68,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 };
 
 static const char * const iio_chan_type_name_spec_complex[] = {
-	[IIO_IN_DIFF] = "in%d-in%d",
+	[IIO_VOLTAGE_DIFF] = "voltage%d-voltage%d",
 };
 
 static const char * const iio_modifier_names_light[] = {
@@ -462,19 +466,22 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		goto error_ret;
 
 	/* Special case for types that uses both channel numbers in naming */
-	if (chan->type == IIO_IN_DIFF && !generic)
+	if (chan->type == IIO_VOLTAGE_DIFF && !generic)
 		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s",
+			= kasprintf(GFP_KERNEL, "%s_%s_%s",
+				    iio_direction[chan->output],
 				    iio_chan_type_name_spec_complex[chan->type],
 				    full_postfix);
 	else if (generic || !chan->indexed)
 		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s",
+			= kasprintf(GFP_KERNEL, "%s_%s_%s",
+				    iio_direction[chan->output],
 				    iio_chan_type_name_spec_shared[chan->type],
 				    full_postfix);
 	else
 		name_format
-			= kasprintf(GFP_KERNEL, "%s%d_%s",
+			= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
+				    iio_direction[chan->output],
 				    iio_chan_type_name_spec_shared[chan->type],
 				    chan->channel,
 				    full_postfix);
@@ -587,7 +594,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 	ret = __iio_add_chan_devattr(iio_data_type_name[chan->processed_val],
 				     NULL, chan,
 				     &iio_read_channel_info,
-				     (chan->type == IIO_OUT ?
+				     (chan->output ?
 				      &iio_write_channel_info : NULL),
 				     0,
 				     0,
@@ -819,7 +826,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 		}
 		switch (chan->type) {
 			/* Switch this to a table at some point */
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			mask = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
 						    i/IIO_EV_TYPE_MAX,
 						    i%IIO_EV_TYPE_MAX);
@@ -829,7 +836,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 						  i/IIO_EV_TYPE_MAX,
 						  i%IIO_EV_TYPE_MAX);
 			break;
-		case IIO_IN_DIFF:
+		case IIO_VOLTAGE_DIFF:
 			mask = IIO_MOD_EVENT_CODE(chan->type, chan->channel,
 						  chan->channel2,
 						  i/IIO_EV_TYPE_MAX,
-- 
1.7.3.4
