Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 16/17] iio: accel: mma9553: document use of mutex
Date: Mon, 13 Apr 2015 18:41:03 +0300
Message-Id: <1428939664-12503-17-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fix checkpatch.pl --strict check:
CHECK: struct mutex definition without comment
+     struct mutex mutex;

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/accel/mma9553.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 08f28c3..a605280 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -182,6 +182,10 @@ struct mma9553_conf_regs {
 
 struct mma9553_data {
 	struct i2c_client *client;
+	/*
+	 * 1. Serialize access to HW (requested by mma9551_core API).
+	 * 2. Serialize sequences that power on/off the device and access HW.
+	 */
 	struct mutex mutex;
 	struct mma9553_conf_regs conf;
 	struct mma9553_event events[MMA9553_EVENTS_INFO_SIZE];
-- 
1.9.1
