Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 18/32] tools:iio:generic_buffer: add error handling
Date: Sun, 31 May 2015 14:40:04 +0200
Message-Id: <1ce10e2764dd39dcd052fbce8c5cac3180086219.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Add error handling to calls which can indicate a major problem by
returning an error code.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 934b4c9..2f48843 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -347,7 +347,14 @@ int main(int argc, char **argv)
 				.events = POLLIN,
 			};
 
-			poll(&pfd, 1, -1);
+			ret = poll(&pfd, 1, -1);
+			if (ret < 0) {
+				ret = -errno;
+				goto error_close_buffer_access;
+			} else if (ret == 0) {
+				continue;
+			}
+
 			toread = buf_len;
 
 		} else {
@@ -378,11 +385,14 @@ int main(int argc, char **argv)
 
 	if (!notrigger)
 		/* Disconnect the trigger - just write a dummy name. */
-		write_sysfs_string("trigger/current_trigger",
-				   dev_dir_name, "NULL");
+		ret = write_sysfs_string("trigger/current_trigger",
+					 dev_dir_name, "NULL");
+		if (ret < 0)
+			printf("Failed to write to %s\n", dev_dir_name);
 
 error_close_buffer_access:
-	close(fp);
+	if (close(fp) == -1)
+		perror("Failed to close buffer");
 error_free_buffer_access:
 	free(buffer_access);
 error_free_data:
-- 
2.3.6
