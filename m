Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a8-242.smtp-out.amazonses.com ([54.240.8.242]:41646 "EHLO
        a8-242.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752349AbdK2WbN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Nov 2017 17:31:13 -0500
From: Jeremy Cline <jeremy@jcline.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 1/2] iio: accel: bmc150: Move struct definitions into the header
Date: Wed, 29 Nov 2017 22:31:12 +0000
Message-ID: <0100016009e7c593-065f58b2-ae0f-4d6d-a1ff-769e86d992d8-000000@email.amazonses.com>
In-Reply-To: <20171129223016.17848-1-jeremy@jcline.org>
References: <20171129223016.17848-1-jeremy@jcline.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The I2C driver needs to access the bmc150_accel_data struct defined in
bcm150-accel-core.c, so move it and the structs it requires into the
header file.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 43 --------------------------------
 drivers/iio/accel/bmc150-accel.h      | 47 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 870f92ef61c2..340914677322 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -163,49 +163,6 @@ struct bmc150_accel_chip_info {
 	const struct bmc150_scale_info scale_table[4];
 };
 
-struct bmc150_accel_interrupt {
-	const struct bmc150_accel_interrupt_info *info;
-	atomic_t users;
-};
-
-struct bmc150_accel_trigger {
-	struct bmc150_accel_data *data;
-	struct iio_trigger *indio_trig;
-	int (*setup)(struct bmc150_accel_trigger *t, bool state);
-	int intr;
-	bool enabled;
-};
-
-enum bmc150_accel_interrupt_id {
-	BMC150_ACCEL_INT_DATA_READY,
-	BMC150_ACCEL_INT_ANY_MOTION,
-	BMC150_ACCEL_INT_WATERMARK,
-	BMC150_ACCEL_INTERRUPTS,
-};
-
-enum bmc150_accel_trigger_id {
-	BMC150_ACCEL_TRIGGER_DATA_READY,
-	BMC150_ACCEL_TRIGGER_ANY_MOTION,
-	BMC150_ACCEL_TRIGGERS,
-};
-
-struct bmc150_accel_data {
-	struct regmap *regmap;
-	int irq;
-	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
-	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
-	struct mutex mutex;
-	u8 fifo_mode, watermark;
-	s16 buffer[8];
-	u8 bw_bits;
-	u32 slope_dur;
-	u32 slope_thres;
-	u32 range;
-	int ev_enable_state;
-	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
-	const struct bmc150_accel_chip_info *chip_info;
-};
-
 static const struct {
 	int val;
 	int val2;
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index ae6118ae11b1..c38754452883 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -2,6 +2,53 @@
 #ifndef _BMC150_ACCEL_H_
 #define _BMC150_ACCEL_H_
 
+struct bmc150_accel_chip_info;
+struct bmc150_accel_data;
+struct bmc150_accel_interrupt_info;
+
+struct bmc150_accel_interrupt {
+	const struct bmc150_accel_interrupt_info *info;
+	atomic_t users;
+};
+
+struct bmc150_accel_trigger {
+	struct bmc150_accel_data *data;
+	struct iio_trigger *indio_trig;
+	int (*setup)(struct bmc150_accel_trigger *t, bool state);
+	int intr;
+	bool enabled;
+};
+
+enum bmc150_accel_interrupt_id {
+	BMC150_ACCEL_INT_DATA_READY,
+	BMC150_ACCEL_INT_ANY_MOTION,
+	BMC150_ACCEL_INT_WATERMARK,
+	BMC150_ACCEL_INTERRUPTS,
+};
+
+enum bmc150_accel_trigger_id {
+	BMC150_ACCEL_TRIGGER_DATA_READY,
+	BMC150_ACCEL_TRIGGER_ANY_MOTION,
+	BMC150_ACCEL_TRIGGERS,
+};
+
+struct bmc150_accel_data {
+	struct regmap *regmap;
+	int irq;
+	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
+	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
+	struct mutex mutex;
+	u8 fifo_mode, watermark;
+	s16 buffer[8];
+	u8 bw_bits;
+	u32 slope_dur;
+	u32 slope_thres;
+	u32 range;
+	int ev_enable_state;
+	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
+	const struct bmc150_accel_chip_info *chip_info;
+};
+
 struct regmap;
 
 enum {
-- 
2.14.3

