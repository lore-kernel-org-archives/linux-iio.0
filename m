Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:50749 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbdKFHUY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Nov 2017 02:20:24 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 8CC1720CE1
        for <linux-iio@vger.kernel.org>; Mon,  6 Nov 2017 08:20:22 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: harinath922@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] iio: mma8452: add power_mode sysfs configuration
Date: Mon,  6 Nov 2017 08:19:58 +0100
Message-Id: <20171106071958.322-1-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the power_mode sysfs interface to the device as documented in
sysfs-bus-iio.

---

Note that I explicitely don't sign off on this.

This is a starting point for anybody who can test it and check for correct
API usage, and ABI correctness, as documented in Documentation/ABI/testing/sys-bus-iio
(grep it for "power_mode"). The ABI doc probably would need an addition
too, if the 4 power modes here seem generally useful (there are only
 2 listed there)!

So, if you can test this, feel free to set up a proper patch or
two, and I'm happy to review.

Please note that this patch is quite old. It really should be that simple
as far as my understanding back then. We always list the available frequencies
of the given power mode we are in, for example, already, and everything
basically is in place except for the user interface.

thanks
                            martin



 drivers/iio/accel/mma8452.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index bfd4bc806fc2..640bbd9872ab 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1166,6 +1166,41 @@ static struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
 };
 
+static const char * const mma8452_power_modes[] = {"normal",
+						   "low_noise_low_power",
+						   "low_noise",
+						   "low_power"};
+
+static int mma8452_get_power_mode_iio_enum(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan)
+{
+	struct mma8452_data *data = iio_priv(indio_dev);
+
+	return mma8452_get_power_mode(data);
+}
+
+static int mma8452_set_power_mode_iio_enum(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan,
+					   unsigned int mode)
+{
+	struct mma8452_data *data = iio_priv(indio_dev);
+
+	return mma8452_set_power_mode(data, mode);
+}
+
+static const struct iio_enum mma8452_power_mode_enum = {
+	.items = mma8452_power_modes,
+	.num_items = ARRAY_SIZE(mma8452_power_modes),
+	.get = mma8452_get_power_mode_iio_enum,
+	.set = mma8452_set_power_mode_iio_enum,
+};
+
+static const struct iio_chan_spec_ext_info mma8452_ext_info[] = {
+	IIO_ENUM("power_mode", true, &mma8452_power_mode_enum),
+	IIO_ENUM_AVAILABLE("power_mode", &mma8452_power_mode_enum),
+	{ },
+};
+
 #define MMA8452_FREEFALL_CHANNEL(modifier) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -1204,6 +1239,7 @@ static struct attribute_group mma8452_event_attribute_group = {
 	}, \
 	.event_spec = mma8452_transient_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
+	.ext_info = mma8452_ext_info, \
 }
 
 #define MMA8652_CHANNEL(axis, idx, bits) { \
@@ -1225,6 +1261,7 @@ static struct attribute_group mma8452_event_attribute_group = {
 	}, \
 	.event_spec = mma8452_motion_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
+	.ext_info = mma8452_ext_info, \
 }
 
 static const struct iio_chan_spec mma8451_channels[] = {
-- 
2.11.0

