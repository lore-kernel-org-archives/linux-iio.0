Return-Path: <ana.calinov@gmail.com>
Date: Wed, 8 Jul 2015 05:44:42 -0700
From: Ana Calinov <ana.calinov@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	irina.tirdea@intel.com, srinivas.pandruvada@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk-1013: Remove blank lines
Message-ID: <20150708124442.GA10598@spook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the the following errors given by
checkpatch.pl with --strict:
Please don't use multiple blank lines.
Blank lines aren't necessary after an open brace '{'.

Signed-off-by: Ana Calinov <ana.calinov@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 567de26..f069c41 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -658,10 +658,8 @@ static int kxcjk1013_set_scale(struct kxcjk1013_data *data, int val)
 	int ret, i;
 	enum kxcjk1013_mode store_mode;
 
-
 	for (i = 0; i < ARRAY_SIZE(KXCJK1013_scale_table); ++i) {
 		if (KXCJK1013_scale_table[i].scale == val) {
-
 			ret = kxcjk1013_get_mode(data, &store_mode);
 			if (ret < 0)
 				return ret;
@@ -820,7 +818,6 @@ static int kxcjk1013_read_event_config(struct iio_dev *indio_dev,
 					  enum iio_event_type type,
 					  enum iio_event_direction dir)
 {
-
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
 	return data->ev_enable_state;
-- 
2.1.0
