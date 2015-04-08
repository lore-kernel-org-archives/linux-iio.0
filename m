Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 2/8] iio: accel: mma9553: use unsigned counters
Date: Wed,  8 Apr 2015 17:37:31 +0300
Message-Id: <1428503857-9081-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use unsigned counters instead of signed when all the
possible values are positive.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9551_core.c | 11 +++++------
 drivers/iio/accel/mma9553.c      |  8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 54b3ae6..438cfed 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -387,8 +387,8 @@ EXPORT_SYMBOL(mma9551_read_status_word);
 int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
 			     u16 reg, u8 len, u16 *buf)
 {
-	int ret, i;
-	int len_words = len / sizeof(u16);
+	int ret;
+	u8 i, len_words = len / sizeof(u16);
 	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
 
 	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
@@ -422,8 +422,8 @@ EXPORT_SYMBOL(mma9551_read_config_words);
 int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
 			      u16 reg, u8 len, u16 *buf)
 {
-	int ret, i;
-	int len_words = len / sizeof(u16);
+	int ret;
+	u8 i, len_words = len / sizeof(u16);
 	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
 
 	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
@@ -457,8 +457,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
 int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
 			       u16 reg, u8 len, u16 *buf)
 {
-	int i;
-	int len_words = len / sizeof(u16);
+	u8 i, len_words = len / sizeof(u16);
 	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
 
 	for (i = 0; i < len_words; i++)
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index d095f81..9cfedb5 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -184,7 +184,7 @@ struct mma9553_data {
 	struct mutex mutex;
 	struct mma9553_conf_regs conf;
 	struct mma9553_event events[MMA9553_EVENTS_INFO_SIZE];
-	int num_events;
+	u8 num_events;
 	u8 gpio_bitnum;
 	/*
 	 * This is used for all features that depend on step count:
@@ -225,7 +225,7 @@ static enum iio_modifier mma9553_activity_to_mod(enum activity_level activity)
 
 static void mma9553_init_events(struct mma9553_data *data)
 {
-	int i;
+	u8 i;
 
 	data->num_events = MMA9553_EVENTS_INFO_SIZE;
 	for (i = 0; i < data->num_events; i++) {
@@ -239,7 +239,7 @@ static struct mma9553_event *mma9553_get_event(struct mma9553_data *data,
 					       enum iio_modifier mod,
 					       enum iio_event_direction dir)
 {
-	int i;
+	u8 i;
 
 	for (i = 0; i < data->num_events; i++)
 		if (data->events[i].info->type == type &&
@@ -254,7 +254,7 @@ static bool mma9553_is_any_event_enabled(struct mma9553_data *data,
 					 bool check_type,
 					 enum iio_chan_type type)
 {
-	int i;
+	u8 i;
 
 	for (i = 0; i < data->num_events; i++)
 		if ((check_type && data->events[i].info->type == type &&
-- 
1.9.1
