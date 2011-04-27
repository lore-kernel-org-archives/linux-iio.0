Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: arnd@arndb.de
Cc: linux-iio@vger.kernel.org,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH] IIO: break out const elements of iio_dev configuration
Date: Wed, 27 Apr 2011 11:09:35 +0100
Message-Id: <1303898975-26215-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This was originally suggested by Arnd when he took a look at the
first version of the chan_spec patches, but I elected to leave it
until we had a better idea of how everything fitted together post
the various major changes.

Note all of this is on top of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-onwards.git

which is where Michael and I have been working on the core changes.
Greg has now merged most of the prerequists (one for the later parts
needs to go through Thomas Gleixner) so we can move onto the
chan_spec stuff next.  Anyhow, back to this RFC.

In summary the idea is to pull out those elements that are effectively
constant for a given set of devices (not necessarily all of those in
a given driver though) into a const structure.  The questions
are

1) Is this a good idea from a comprehensibility point of view.
   The big gain in my view would be to reduce the number of aspects
   of iio_dev that are directly accessed by driver writers. Basically
   that will make refactoring simpler.

2) Is it a good idea from point of view of generated code - stats
   below.

3) What should be in the structure.

Now I've tried two versions for a couple of our more advanced drivers.
The first contained channel_spec pointer and count. The second did not
as these are typically the bits that change across the multiple chips
that are supported by a given driver.  The max1363 is a large example
of why this may make sense.

To sumarize the numbers on my pxa board. The first listing is the
output of du -b for relevant modules the second the output of lsmod
on the running board.

Original:
44662   drivers/staging/iio/industrialio.ko
19522   drivers/staging/iio/accel/lis3l02dq.ko
19856   drivers/staging/iio/imu/adis16400.ko
26063   drivers/staging/iio/adc/max1363.ko

max1363                15696  0 
lis3l02dq               9947  0 
industrialio           26987  7 lis3l02dq,max1363,ring_sw

V1 channels inside iio_info:
44746   drivers/staging/iio/industrialio.ko
19513   drivers/staging/iio/accel/lis3l02dq.ko
20268   drivers/staging/iio/imu/adis16400.ko
28193   drivers/staging/iio/adc/max1363.ko

max1363                17114  0 
lis3l02dq               9922  0 
industrialio           27071  7 max1363,lis3l02dq,ring_sw

V2: 
44730   drivers/staging/iio/industrialio.ko
19517   drivers/staging/iio/accel/lis3l02dq.ko
19899   drivers/staging/iio/imu/adis16400.ko
26575   drivers/staging/iio/adc/max1363.ko

max1363                15888  0 
lis3l02dq               9934  0 
industrialio           27055  7 lis3l02dq,max1363,ring_sw

In conclusion max1363 gets bigger in all ways if we break this
stuff out.  That is just down to the large number of devices supported.
lis3l02dq which supports only one part gets smaller.

So not a clear descision either way as far as I am concerned, but
putting the channel_spec into this structure is pretty costly for
typical multipart drivers.

So the upshot of this RFC to my mind is: Is the clarity gained
a good idea?

What do people think?

Thanks,

Jonathan

---
 drivers/staging/iio/accel/lis3l02dq_core.c |   23 +-
 drivers/staging/iio/adc/max1363.h          |    4 +-
 drivers/staging/iio/adc/max1363_core.c     |  782 +++++++++++++++-------------
 drivers/staging/iio/dummy.c                |   19 +-
 drivers/staging/iio/iio.h                  |   66 ++--
 drivers/staging/iio/imu/adis16400_core.c   |   12 +-
 drivers/staging/iio/industrialio-core.c    |   73 ++--
 7 files changed, 520 insertions(+), 459 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 2ddd46a..18d4e4b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -654,6 +654,18 @@ static const struct attribute_group lis3l02dq_attribute_group = {
 	.attrs = lis3l02dq_attributes,
 };
 
+static const struct iio_info lis3l02dq_info = {
+	.num_interrupt_lines = 1,
+	.read_raw = &lis3l02dq_read_raw,
+	.write_raw = &lis3l02dq_write_raw,
+	.read_event_value = &lis3l02dq_read_thresh,
+	.write_event_value = &lis3l02dq_write_thresh,
+	.write_event_config = &lis3l02dq_write_event_config,
+	.read_event_config = &lis3l02dq_read_event_config,
+	.driver_module = THIS_MODULE,
+	.attrs = &lis3l02dq_attribute_group,
+};
+
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -673,17 +685,10 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	mutex_init(&st->buf_lock);
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->num_interrupt_lines = 1;
+	indio_dev->info = &lis3l02dq_info;
 	indio_dev->channels = lis3l02dq_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
-	indio_dev->read_raw = &lis3l02dq_read_raw;
-	indio_dev->write_raw = &lis3l02dq_write_raw;
-	indio_dev->read_event_value = &lis3l02dq_read_thresh;
-	indio_dev->write_event_value = &lis3l02dq_write_thresh;
-	indio_dev->write_event_config = &lis3l02dq_write_event_config;
-	indio_dev->read_event_config = &lis3l02dq_read_event_config;
-	indio_dev->attrs = &lis3l02dq_attribute_group;
-	indio_dev->driver_module = THIS_MODULE;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = lis3l02dq_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 15227bd..31af36b 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -154,7 +154,7 @@ enum max1363_modes {
  * @name:		indentification string for chip
  * @bits:		accuracy of the adc in bits
  * @int_vref_mv:	the internal reference voltage
- * @monitor_mode:	whether the chip supports monitor interrupts
+ * @info:		iio core function callbacks structure
  * @mode_list:		array of available scan modes
  * @num_modes:		the number of scan modes available
  * @default_mode:	the scan mode in which the chip starts up
@@ -164,7 +164,7 @@ enum max1363_modes {
 struct max1363_chip_info {
 	u8				bits;
 	u16				int_vref_mv;
-	bool				monitor_mode;
+	const struct iio_info		*info;
 	const enum max1363_modes	*mode_list;
 	int				num_modes;
 	enum max1363_modes		default_mode;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 736d7d4..fa166ef 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -661,356 +661,6 @@ enum { max1361,
        max11647
 };
 
-/* max1363 and max1368 tested - rest from data sheet */
-static const struct max1363_chip_info max1363_chip_info_tbl[] = {
-	[max1361] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1361_channels,
-		.num_channels = ARRAY_SIZE(max1361_channels),
-	},
-	[max1362] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1361_channels,
-		.num_channels = ARRAY_SIZE(max1361_channels),
-	},
-	[max1363] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max1364] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.monitor_mode = 1,
-		.mode_list = max1363_mode_list,
-		.num_modes = ARRAY_SIZE(max1363_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max1036] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max1037] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max1038] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1038_channels,
-		.num_channels = ARRAY_SIZE(max1038_channels),
-	},
-	[max1039] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1038_channels,
-		.num_channels = ARRAY_SIZE(max1038_channels),
-	},
-	[max1136] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max1137] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max1138] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1138_channels,
-		.num_channels = ARRAY_SIZE(max1138_channels),
-	},
-	[max1139] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1138_channels,
-		.num_channels = ARRAY_SIZE(max1138_channels),
-	},
-	[max1236] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1236_channels,
-		.num_channels = ARRAY_SIZE(max1236_channels),
-	},
-	[max1237] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max1236_mode_list,
-		.num_modes = ARRAY_SIZE(max1236_mode_list),
-		.default_mode = s0to3,
-		.channels = max1236_channels,
-		.num_channels = ARRAY_SIZE(max1236_channels),
-	},
-	[max1238] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max1239] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11600] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max11601] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1036_channels,
-		.num_channels = ARRAY_SIZE(max1036_channels),
-	},
-	[max11602] = {
-		.bits = 8,
-		.int_vref_mv = 4096,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11602_channels,
-		.num_channels = ARRAY_SIZE(max11602_channels),
-	},
-	[max11603] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11602_channels,
-		.num_channels = ARRAY_SIZE(max11602_channels),
-	},
-	[max11604] = {
-		.bits = 8,
-		.int_vref_mv = 4098,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11605] = {
-		.bits = 8,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11606] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max11607] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1136_channels,
-		.num_channels = ARRAY_SIZE(max1136_channels),
-	},
-	[max11608] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11608_channels,
-		.num_channels = ARRAY_SIZE(max11608_channels),
-	},
-	[max11609] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11608_channels,
-		.num_channels = ARRAY_SIZE(max11608_channels),
-	},
-	[max11610] = {
-		.bits = 10,
-		.int_vref_mv = 4098,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11611] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11612] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max11613] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max11607_mode_list,
-		.num_modes = ARRAY_SIZE(max11607_mode_list),
-		.default_mode = s0to3,
-		.channels = max1363_channels,
-		.num_channels = ARRAY_SIZE(max1363_channels),
-	},
-	[max11614] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11614_channels,
-		.num_channels = ARRAY_SIZE(max11614_channels),
-	},
-	[max11615] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max11608_mode_list,
-		.num_modes = ARRAY_SIZE(max11608_mode_list),
-		.default_mode = s0to7,
-		.channels = max11614_channels,
-		.num_channels = ARRAY_SIZE(max11614_channels),
-	},
-	[max11616] = {
-		.bits = 12,
-		.int_vref_mv = 4098,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11617] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max1238_mode_list,
-		.num_modes = ARRAY_SIZE(max1238_mode_list),
-		.default_mode = s0to11,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
-	},
-	[max11644] = {
-		.bits = 12,
-		.int_vref_mv = 2048,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11644_channels),
-	},
-	[max11645] = {
-		.bits = 12,
-		.int_vref_mv = 4096,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11644_channels),
-	},
-	[max11646] = {
-		.bits = 10,
-		.int_vref_mv = 2048,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11646_channels),
-	},
-	[max11647] = {
-		.bits = 10,
-		.int_vref_mv = 4096,
-		.mode_list = max11644_mode_list,
-		.num_modes = ARRAY_SIZE(max11644_mode_list),
-		.default_mode = s0to1,
-		.channels = max11644_channels,
-		.num_channels = ARRAY_SIZE(max11646_channels),
-	},
-};
-
 static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
 					      8300, 4200, 2000, 1000 };
 
@@ -1351,9 +1001,414 @@ static struct attribute *max1363_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group max1363_event_attribute_group = {
-	.attrs = max1363_event_attributes,
-};
+static struct attribute_group max1363_event_attribute_group = {
+	.attrs = max1363_event_attributes,
+};
+
+#define MAX1363_EVENT_FUNCS						\
+
+
+static const struct iio_info max1238_info = {
+	.read_raw = &max1363_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info max1363_info = {
+	.read_event_value = &max1363_read_thresh,
+	.write_event_value = &max1363_write_thresh,
+	.read_event_config = &max1363_read_event_config,
+	.write_event_config = &max1363_write_event_config,
+	.read_raw = &max1363_read_raw,
+	.driver_module = THIS_MODULE,
+	.num_interrupt_lines = 1,
+	.event_attrs = &max1363_event_attribute_group,
+};
+
+/* max1363 and max1368 tested - rest from data sheet */
+static const struct max1363_chip_info max1363_chip_info_tbl[] = {
+	[max1361] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1361_channels,
+		.num_channels = ARRAY_SIZE(max1361_channels),
+		.info = &max1363_info,
+	},
+	[max1362] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1361_channels,
+		.num_channels = ARRAY_SIZE(max1361_channels),
+		.info = &max1363_info,
+	},
+	[max1363] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+		.info = &max1363_info,
+	},
+	[max1364] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max1363_mode_list,
+		.num_modes = ARRAY_SIZE(max1363_mode_list),
+		.default_mode = s0to3,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+		.info = &max1363_info,
+	},
+	[max1036] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max1037] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max1038] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1038_channels,
+		.num_channels = ARRAY_SIZE(max1038_channels),
+	},
+	[max1039] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1038_channels,
+		.num_channels = ARRAY_SIZE(max1038_channels),
+	},
+	[max1136] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max1137] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max1138] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1138_channels,
+		.num_channels = ARRAY_SIZE(max1138_channels),
+	},
+	[max1139] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1138_channels,
+		.num_channels = ARRAY_SIZE(max1138_channels),
+	},
+	[max1236] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1236_channels,
+		.num_channels = ARRAY_SIZE(max1236_channels),
+	},
+	[max1237] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1236_mode_list,
+		.num_modes = ARRAY_SIZE(max1236_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1236_channels,
+		.num_channels = ARRAY_SIZE(max1236_channels),
+	},
+	[max1238] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max1239] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11600] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max11601] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1036_channels,
+		.num_channels = ARRAY_SIZE(max1036_channels),
+	},
+	[max11602] = {
+		.bits = 8,
+		.int_vref_mv = 4096,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11602_channels,
+		.num_channels = ARRAY_SIZE(max11602_channels),
+	},
+	[max11603] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11602_channels,
+		.num_channels = ARRAY_SIZE(max11602_channels),
+	},
+	[max11604] = {
+		.bits = 8,
+		.int_vref_mv = 4098,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11605] = {
+		.bits = 8,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11606] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max11607] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1136_channels,
+		.num_channels = ARRAY_SIZE(max1136_channels),
+	},
+	[max11608] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11608_channels,
+		.num_channels = ARRAY_SIZE(max11608_channels),
+	},
+	[max11609] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11608_channels,
+		.num_channels = ARRAY_SIZE(max11608_channels),
+	},
+	[max11610] = {
+		.bits = 10,
+		.int_vref_mv = 4098,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11611] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11612] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+	},
+	[max11613] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11607_mode_list,
+		.num_modes = ARRAY_SIZE(max11607_mode_list),
+		.default_mode = s0to3,
+		.info = &max1238_info,
+		.channels = max1363_channels,
+		.num_channels = ARRAY_SIZE(max1363_channels),
+	},
+	[max11614] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11614_channels,
+		.num_channels = ARRAY_SIZE(max11614_channels),
+	},
+	[max11615] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11608_mode_list,
+		.num_modes = ARRAY_SIZE(max11608_mode_list),
+		.default_mode = s0to7,
+		.info = &max1238_info,
+		.channels = max11614_channels,
+		.num_channels = ARRAY_SIZE(max11614_channels),
+	},
+	[max11616] = {
+		.bits = 12,
+		.int_vref_mv = 4098,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11617] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max1238_mode_list,
+		.num_modes = ARRAY_SIZE(max1238_mode_list),
+		.default_mode = s0to11,
+		.info = &max1238_info,
+		.channels = max1238_channels,
+		.num_channels = ARRAY_SIZE(max1238_channels),
+	},
+	[max11644] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11644_channels),
+	},
+	[max11645] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11644_channels),
+	},
+	[max11646] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11646_channels,
+		.num_channels = ARRAY_SIZE(max11646_channels),
+	},
+	[max11647] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.info = &max1238_info,
+		.channels = max11646_channels,
+		.num_channels = ARRAY_SIZE(max11646_channels),
+	},
+};
+
+
 
 static int max1363_initial_setup(struct max1363_state *st)
 {
@@ -1414,22 +1469,9 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	/* Estabilish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
-	indio_dev->read_event_value = &max1363_read_thresh;
-	indio_dev->write_event_value = &max1363_write_thresh;
-	indio_dev->read_event_config = &max1363_read_event_config;
-	indio_dev->write_event_config = &max1363_write_event_config;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
-	indio_dev->read_raw = &max1363_read_raw;
-	/* Todo: this shouldn't be here. */
-	indio_dev->driver_module = THIS_MODULE;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (st->chip_info->monitor_mode && client->irq) {
-		indio_dev->num_interrupt_lines = 1;
-		indio_dev->event_attrs
-			= &max1363_event_attribute_group;
-	}
 
+	indio_dev->info = st->chip_info->info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	ret = max1363_initial_setup(st);
 	if (ret)
 		goto error_free_available_scan_masks;
@@ -1448,7 +1490,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_cleanup_ring;
 
-	if (st->chip_info->monitor_mode && client->irq) {
+	if (client->irq) {
 		ret = request_threaded_irq(st->client->irq,
 					   NULL,
 					   &max1363_event_handler,
@@ -1488,7 +1530,7 @@ static int max1363_remove(struct i2c_client *client)
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct regulator *reg = st->reg;
 
-	if (st->chip_info->monitor_mode && client->irq)
+	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	max1363_ring_cleanup(indio_dev);
diff --git a/drivers/staging/iio/dummy.c b/drivers/staging/iio/dummy.c
index 4ba4f79..2cc5760 100644
--- a/drivers/staging/iio/dummy.c
+++ b/drivers/staging/iio/dummy.c
@@ -112,21 +112,24 @@ static irqreturn_t dummy_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_info dummy_info = {
+	.read_raw = &dummy_read_raw,
+	.read_event_value = &dummy_read_ev_value,
+	.write_event_value = &dummy_write_ev_value,
+	.read_event_config = &dummy_read_ev_config,
+	.write_event_config = &dummy_write_ev_config,
+	.driver_module = THIS_MODULE,
+};
+
 static __init int dummy_init(void)
 {
 	int ret;
 	indio_dev = iio_allocate_device(0);
 	
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &dummy_info;
 	indio_dev->channels = dummy_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dummy_channels);
-	indio_dev->read_raw = &dummy_read_raw;
-	indio_dev->read_event_value = &dummy_read_ev_value;
-	indio_dev->write_event_value = &dummy_write_ev_value;
-	indio_dev->read_event_config = &dummy_read_ev_config;
-	indio_dev->write_event_config = &dummy_write_ev_config;
-	indio_dev->driver_module = THIS_MODULE;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->num_interrupt_lines = 0;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
 	if (indio_dev->ring == NULL) {
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 7f94197..789ea29 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -182,6 +182,40 @@ static inline s64 iio_get_time_ns(void)
  * call to iio_device_register. */
 #define IIO_VAL_INT 1
 #define IIO_VAL_INT_PLUS_MICRO 2
+
+struct iio_info {
+	struct module			*driver_module;
+  	int				num_interrupt_lines;
+	struct attribute_group		*event_attrs;
+	const struct attribute_group	*attrs;
+
+	int (*read_raw)(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val,
+			int *val2,
+			long mask);
+
+	int (*write_raw)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val,
+			 int val2,
+			 long mask);
+
+	int (*read_event_config)(struct iio_dev *indio_dev,
+				 int event_code);
+
+	int (*write_event_config)(struct iio_dev *indio_dev,
+				  int event_code,
+				  int state);
+
+	int (*read_event_value)(struct iio_dev *indio_dev,
+				int event_code,
+				int *val);
+	int (*write_event_value)(struct iio_dev *indio_dev,
+				 int event_code,
+				 int val);
+};
+
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
@@ -209,11 +243,7 @@ struct iio_dev {
 	int				modes;
 	int				currentmode;
 	struct device			dev;
-	const struct attribute_group	*attrs;
-	struct module			*driver_module;
 
-	int				num_interrupt_lines;
-	struct attribute_group		*event_attrs;
 	struct iio_event_interface	*event_interfaces;
 
 	struct iio_ring_buffer		*ring;
@@ -225,34 +255,10 @@ struct iio_dev {
 
 	struct iio_chan_spec const *channels;
 	int num_channels;
-	struct list_head channel_attr_list;
 
+	struct list_head channel_attr_list;
 	const char *name;
-	int (*read_raw)(struct iio_dev *indio_dev,
-			struct iio_chan_spec const *chan,
-			int *val,
-			int *val2,
-			long mask);
-
-	int (*write_raw)(struct iio_dev *indio_dev,
-			 struct iio_chan_spec const *chan,
-			 int val,
-			 int val2,
-			 long mask);
-
-	int (*read_event_config)(struct iio_dev *indio_dev,
-				 int event_code);
-
-	int (*write_event_config)(struct iio_dev *indio_dev,
-				  int event_code,
-				  int state);
-
-	int (*read_event_value)(struct iio_dev *indio_dev,
-				int event_code,
-				int *val);
-	int (*write_event_value)(struct iio_dev *indio_dev,
-				 int event_code,
-				 int val);
+	const struct iio_info *info;
 };
 
 /**
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 09737d0..d95aa7e 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -770,7 +770,12 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	}
 };
 
-
+static const struct iio_info adis16400_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &adis16400_read_raw,
+	.write_raw = &adis16400_write_raw,
+	.attrs = &adis16400_attribute_group,
+};
 
 static int __devinit adis16400_probe(struct spi_device *spi)
 {
@@ -792,12 +797,9 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->attrs = &adis16400_attribute_group;
 	indio_dev->channels = st->variant->channels;
 	indio_dev->num_channels = st->variant->num_channels;
-	indio_dev->read_raw = &adis16400_read_raw;
-	indio_dev->write_raw = &adis16400_write_raw;
-	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->info = &adis16400_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16400_configure_ring(indio_dev);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index b9776de..4fe77e5 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -377,8 +377,8 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val, val2;
-	int ret = indio_dev->read_raw(indio_dev, this_attr->c,
-				      &val, &val2, this_attr->address);
+	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
+					    &val, &val2, this_attr->address);
 
 	if (ret < 0)
 		return ret;
@@ -405,7 +405,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	bool integer_part = true, negative = false;
 
 	/* Assumes decimal - precision based on number of digits */
-	if (!indio_dev->write_raw)
+	if (!indio_dev->info->write_raw)
 		return -EINVAL;
 	if (buf[0] == '-') {
 		negative = true;
@@ -440,8 +440,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
 			micro = -micro;
 	}
 
-	ret = indio_dev->write_raw(indio_dev, this_attr->c,
-				       integer, micro, this_attr->address);
+	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
+					 integer, micro, this_attr->address);
 	if (ret)
 		return ret;
 
@@ -630,8 +630,9 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 	int i, ret = 0;
 	struct iio_dev_attr *p, *n;
 
-	if (dev_info->attrs) {
-		ret = sysfs_create_group(&dev_info->dev.kobj, dev_info->attrs);
+	if (dev_info->info->attrs) {
+		ret = sysfs_create_group(&dev_info->dev.kobj,
+					 dev_info->info->attrs);
 		if (ret) {
 			dev_err(dev_info->dev.parent,
 				"Failed to register sysfs hooks\n");
@@ -667,8 +668,8 @@ error_clear_attrs:
 		list_del(&p->l);
 		iio_device_remove_and_free_read_attr(dev_info, p);
 	}
-	if (dev_info->attrs)
-		sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
+	if (dev_info->info->attrs)
+		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
 error_ret:
 	return ret;
 
@@ -687,8 +688,8 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 		iio_device_remove_and_free_read_attr(dev_info, p);
 	}
 
-	if (dev_info->attrs)
-		sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
+	if (dev_info->info->attrs)
+		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
 }
 
 /* Return a negative errno on failure */
@@ -747,8 +748,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = indio_dev->write_event_config(indio_dev, this_attr->address,
-					    val);
+	ret = indio_dev->info->write_event_config(indio_dev,
+						  this_attr->address,
+						  val);
 	return (ret < 0) ? ret : len;
 }
 
@@ -758,7 +760,8 @@ static ssize_t iio_ev_state_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int val = indio_dev->read_event_config(indio_dev, this_attr->address);
+	int val = indio_dev->info->read_event_config(indio_dev,
+						     this_attr->address);
 
 	if (val < 0)
 		return val;
@@ -774,8 +777,8 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val, ret;
 
-	ret = indio_dev->read_event_value(indio_dev,
-					  this_attr->address, &val);
+	ret = indio_dev->info->read_event_value(indio_dev,
+						this_attr->address, &val);
 	if (ret < 0)
 		return ret;
 
@@ -796,8 +799,8 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = indio_dev->write_event_value(indio_dev, this_attr->address,
-					   val);
+	ret = indio_dev->info->write_event_value(indio_dev, this_attr->address,
+						 val);
 	if (ret < 0)
 		return ret;
 
@@ -853,8 +856,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 					       extending the bitmask - but
 					       how far*/
 					     0,
-					     &dev_info->event_interfaces[0]
-					     .dev,
+					     &dev_info->event_interfaces[0].dev,
 					     &dev_info->event_interfaces[0].
 					     dev_attr_list);
 		kfree(postfix);
@@ -938,23 +940,23 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 {
 	int ret = 0, i, j;
 
-	if (dev_info->num_interrupt_lines == 0)
+	if (dev_info->info->num_interrupt_lines == 0)
 		return 0;
 
 	dev_info->event_interfaces =
 		kzalloc(sizeof(struct iio_event_interface)
-			*dev_info->num_interrupt_lines,
+			*dev_info->info->num_interrupt_lines,
 			GFP_KERNEL);
 	if (dev_info->event_interfaces == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		ret = iio_setup_ev_int(&dev_info->event_interfaces[i],
 				       dev_name(&dev_info->dev),
 				       i,
-				       dev_info->driver_module,
+				       dev_info->info->driver_module,
 				       &dev_info->dev);
 		if (ret) {
 			dev_err(&dev_info->dev,
@@ -965,11 +967,12 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		dev_set_drvdata(&dev_info->event_interfaces[i].dev,
 				(void *)dev_info);
 
-		if (dev_info->event_attrs != NULL)
+		if (dev_info->info->event_attrs != NULL)
 			ret = sysfs_create_group(&dev_info
 						 ->event_interfaces[i]
 						 .dev.kobj,
-						 &dev_info->event_attrs[i]);
+						 &dev_info->info
+						 ->event_attrs[i]);
 
 		if (ret) {
 			dev_err(&dev_info->dev,
@@ -978,7 +981,7 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 		}
 	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		ret = __iio_add_event_config_attrs(dev_info, i);
 		if (ret)
 			goto error_unregister_config_attrs;
@@ -989,13 +992,13 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 error_unregister_config_attrs:
 	for (j = 0; j < i; j++)
 		__iio_remove_event_config_attrs(dev_info, i);
-	i = dev_info->num_interrupt_lines - 1;
+	i = dev_info->info->num_interrupt_lines - 1;
 error_remove_sysfs_interfaces:
 	for (j = 0; j < i; j++)
-		if (dev_info->event_attrs != NULL)
+		if (dev_info->info->event_attrs != NULL)
 			sysfs_remove_group(&dev_info
 				   ->event_interfaces[j].dev.kobj,
-				   &dev_info->event_attrs[j]);
+				   &dev_info->info->event_attrs[j]);
 error_free_setup_ev_ints:
 	for (j = 0; j < i; j++)
 		iio_free_ev_int(&dev_info->event_interfaces[j]);
@@ -1009,17 +1012,17 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 {
 	int i;
 
-	if (dev_info->num_interrupt_lines == 0)
+	if (dev_info->info->num_interrupt_lines == 0)
 		return;
-	for (i = 0; i < dev_info->num_interrupt_lines; i++) {
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++) {
 		__iio_remove_event_config_attrs(dev_info, i);
-		if (dev_info->event_attrs != NULL)
+		if (dev_info->info->event_attrs != NULL)
 			sysfs_remove_group(&dev_info
 					   ->event_interfaces[i].dev.kobj,
-					   &dev_info->event_attrs[i]);
+					   &dev_info->info->event_attrs[i]);
 	}
 
-	for (i = 0; i < dev_info->num_interrupt_lines; i++)
+	for (i = 0; i < dev_info->info->num_interrupt_lines; i++)
 		iio_free_ev_int(&dev_info->event_interfaces[i]);
 	kfree(dev_info->event_interfaces);
 }
-- 
1.7.3.4
