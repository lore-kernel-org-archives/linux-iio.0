Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F63E120B;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390312; cv=none; b=V5WWi0vd9cd0JWkeqn0FSyiwwoxZG/XXYV4C0mmaEZBiDPEltny9uA1wXX56yBtsg1Mo5uyD1xNl/xcISY6izG3t41zlDS7fwCcDXBZ0hu8VmLdEtWhm4FAzHlAPPWAzu4wy4sBna8ZdrVDk0+H+NyEolFBdImhtKB6yvVBHQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390312; c=relaxed/simple;
	bh=/jYIbOPw613lNUQGAbcZaAKMdwMql3FWfpbb2NN5FOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cj0VW3d3cx122eP4vJYaqI9bkD+7J7M5Lo3RUQ96BEvschqMJcz8oxRQVKHdeNxdHuggH4tmZ7AvBg32PwReROaxT47yTfHMRHcZzqvosnXcfL6/Lv6PsawiwWt0Dc/ITRaDyFIwUe/bYDel317MQ9KJyHzGndbpBP1Wylptvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUlxH2iU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUlxH2iU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A89CC2BCB4;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782390312;
	bh=/jYIbOPw613lNUQGAbcZaAKMdwMql3FWfpbb2NN5FOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IUlxH2iU1C98didPNBbEvE7sb2OOTko64OZ9/iWf5EfihQ5A/Bd4FrPYqgY0FQngU
	 aDtdi5i9BYe29DEeqvU9TBy7oDVI/zbpqq9Oi/JjmfEj8zNrTdTzXwN/nG3bNZpt4P
	 8RfDedKQbNanNoU40DkIHL0MdMKiqyaNKIA/sfdqXqVmc8jtyC+ZCkbCWDeQ2+PmKt
	 8O0StYTL5LS+b50C58f0X83nG8e0FOTlQskmDTh2dMV0CTAYSZnzrZQcLoilO+XiMW
	 g/Azn3Et6StBYe/QoO8BdI71LFQqiyWY4v1SCW/HyRGDAwXkx/YtANTmxOe2SrRt5t
	 SGJVlM5QpV75g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BAECDB479;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 25 Jun 2026 14:24:52 +0200
Subject: [PATCH v4 1/2] iio: imu: inv_icm42600: reorder all driver headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-1-8b4c8bfa96d7@tdk.com>
References: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
In-Reply-To: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782390310; l=7887;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=dqJTKh2aunfRO+/DEMHAfa8LgIQtEsznlvfnJJptMOw=;
 b=W4DlU9sb39Yfsr4uGPtShZFkkdajI7idx8cgw2+bRYC21RRVIdXUE+7VkcuQziq+l2VOkVo3s
 EpE8BwWnnSiBfgTdMRuw86fYuzFExx8tfALmzSWU3hZGxnoA7blTxET
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Reorder headers includes following linux rules.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  8 +++++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 13 +++++++------
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  7 ++++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 12 ++++++------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 11 ++++++-----
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |  8 ++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |  8 ++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |  3 ++-
 9 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c8b48a5c5ed0..2ab863c9d53a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -6,13 +6,15 @@
 #ifndef INV_ICM42600_H_
 #define INV_ICM42600_H_
 
-#include <linux/bits.h>
 #include <linux/bitfield.h>
-#include <linux/regmap.h>
+#include <linux/bits.h>
 #include <linux/mutex.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
 #include <linux/iio/iio.h>
+
 #include <linux/iio/common/inv_sensors_timestamp.h>
 
 #include "inv_icm42600_buffer.h"
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 532d5fdffaf8..87471e8c9bc7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -3,25 +3,26 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
-#include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/delay.h>
-#include <linux/math64.h>
-#include <linux/minmax.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
 #include "inv_icm42600.h"
-#include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_temp.h"
 
 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 68a395758031..26817158ec78 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -3,18 +3,19 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
-#include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/delay.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index ffca4da1e249..6ab1eb1a0051 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -6,8 +6,8 @@
 #ifndef INV_ICM42600_BUFFER_H_
 #define INV_ICM42600_BUFFER_H_
 
-#include <linux/kernel.h>
 #include <linux/bits.h>
+#include <linux/kernel.h>
 
 struct inv_icm42600_state;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 76eb22488e5f..dc97d8a274e3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -3,18 +3,18 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
+#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/regulator/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 11339ddf1da3..ea8aa64a3f33 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -3,22 +3,23 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
-#include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/delay.h>
-#include <linux/math64.h>
 
 #include <linux/iio/buffer.h>
-#include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
 #include "inv_icm42600.h"
-#include "inv_icm42600_temp.h"
 #include "inv_icm42600_buffer.h"
+#include "inv_icm42600_temp.h"
 
 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
 	{								\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 99d37ac53bbe..f422523207ee 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -3,13 +3,13 @@
  * Copyright (C) 2020 InvenSense, Inc.
  */
 
-#include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
-#include <linux/regmap.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 
 #include "inv_icm42600.h"
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 13e2e7d38638..ec8dac9f24aa 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -3,13 +3,13 @@
  * Copyright (C) 2020 InvenSense, Inc.
  */
 
-#include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/module.h>
+#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
-#include <linux/spi/spi.h>
-#include <linux/regmap.h>
+#include <linux/module.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
 
 #include "inv_icm42600.h"
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 727b03d541a5..7f80bda471c3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -3,11 +3,12 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
-#include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"

-- 
2.54.0


