Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk
Subject: [PATCH 2/7] iio staging: remove unused variable
Date: Mon, 25 Jun 2012 21:11:40 +0200
Message-Id: <1340651505-31081-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

---
 drivers/staging/iio/Documentation/generic_buffer.c |    2 --
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 8d6e91c..81358ac 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -131,8 +131,6 @@ int main(int argc, char **argv)
 
 
 	int ret, c, i, j, toread;
-
-	FILE *fp_ev;
 	int fp;
 
 	int num_channels;
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 6f3a392..6fe8540 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -280,7 +280,7 @@ inline int build_channel_array(const char *device_dir,
 {
 	DIR *dp;
 	FILE *sysfsfp;
-	int count, temp, i;
+	int count, i;
 	struct iio_channel_info *current;
 	int ret;
 	const struct dirent *ent;
-- 
1.7.9.5
