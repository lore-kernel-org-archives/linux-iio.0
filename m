Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 04/32] tools:iio: free channel-array completely
Date: Sun, 31 May 2015 14:39:44 +0200
Message-Id: <7a72ee8343eeb317432204577f4ee8c689674c76.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In iio_utils.c build_channel_array() dynamically allocates the string
generic_name in the current iio_channel_info, which doesn't got freed in
case of an error.
This dynamically allocated channel-array is used by generic_buffer, and
needs to be freed on the error/exit path.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 8 +++++++-
 tools/iio/iio_utils.c      | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 7859ee9..0410948 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -255,7 +255,7 @@ int main(int argc, char **argv)
 		       "%siio:device%d/buffer", iio_dir, dev_num);
 	if (ret < 0) {
 		ret = -ENOMEM;
-		goto error_free_triggername;
+		goto error_free_channels;
 	}
 
 	if (!notrigger) {
@@ -351,6 +351,12 @@ error_free_data:
 	free(data);
 error_free_buf_dir_name:
 	free(buf_dir_name);
+error_free_channels:
+	for (i = num_channels - 1; i >= 0; i--) {
+		free(channels[i].name);
+		free(channels[i].generic_name);
+	}
+	free(channels);
 error_free_triggername:
 	if (datardytrigger)
 		free(trigger_name);
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index f879ad7..6daf98f 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -410,8 +410,10 @@ int build_channel_array(const char *device_dir,
 	return 0;
 
 error_cleanup_array:
-	for (i = count - 1;  i >= 0; i--)
+	for (i = count - 1;  i >= 0; i--) {
 		free((*ci_array)[i].name);
+		free((*ci_array)[i].generic_name);
+	}
 	free(*ci_array);
 error_close_dir:
 	closedir(dp);
-- 
2.3.6
