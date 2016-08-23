Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 3/3] iio: chemical: vz89x: prevent corrupted buffer from being read
Date: Mon, 22 Aug 2016 20:44:54 -0700
Message-Id: <1471923894-12194-4-git-send-email-mranostay@gmail.com>
In-Reply-To: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 0347761ebdba..c2a311c59190 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -54,6 +54,7 @@ struct vz89x_data {
 	int (*xfer)(struct vz89x_data *data, u8 cmd);
 	int (*valid)(struct vz89x_data *data);
 
+	bool is_valid;
 	unsigned long last_update;
 	u8 cmd;
 	u8 write_size;
@@ -220,8 +221,10 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 
 	/* sensor can only be polled once a second max per datasheet */
 	if (!time_after(jiffies, data->last_update + HZ))
-		return 0;
+		return data->is_valid ? 0 : -EAGAIN;
 
+	data->is_valid = false;
+	data->last_update = jiffies;
 	ret = data->xfer(data, data->cmd);
 	if (ret < 0)
 		return ret;
@@ -230,7 +233,7 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 	if (ret)
 		return -EAGAIN;
 
-	data->last_update = jiffies;
+	data->is_valid = true;
 
 	return 0;
 }
-- 
2.7.4
