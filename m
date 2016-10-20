Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 1/2] tools: iio: iio_generic_buffer: rename and change type of force variable
Date: Thu, 20 Oct 2016 17:19:23 +0800
Message-Id: <3749c6e558d696269bcdce627b470ddc60a87fc5.1476952931.git.eraretuya@gmail.com>
In-Reply-To: <cover.1476952931.git.eraretuya@gmail.com>
References: <cover.1476952931.git.eraretuya@gmail.com>
In-Reply-To: <cover.1476952931.git.eraretuya@gmail.com>
References: <cover.1476952931.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Replace the type of 'force' flag from int to bool and at the same time
rename it to 'force_autochannels' for better readability.

Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 tools/iio/iio_generic_buffer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 31ddd3a..8ef39ae 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
-	int force = 0;
+	bool force_autochannels = false;
 
 	struct iio_channel_info *channels = NULL;
 
@@ -362,7 +362,7 @@ int main(int argc, char **argv)
 			break;
 		case 'A':
 			autochannels = AUTOCHANNELS_ENABLED;
-			force = 1;
+			force_autochannels = true;
 			break;	
 		case 'c':
 			errno = 0;
@@ -526,14 +526,15 @@ int main(int argc, char **argv)
 			"diag %s\n", dev_dir_name);
 		goto error;
 	}
-	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) && !force) {
+	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) &&
+	    !force_autochannels) {
 		fprintf(stderr, "Auto-channels selected but some channels "
 			"are already activated in sysfs\n");
 		fprintf(stderr, "Proceeding without activating any channels\n");
 	}
 
 	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
-	    ((autochannels == AUTOCHANNELS_ENABLED) && force)) {
+	    ((autochannels == AUTOCHANNELS_ENABLED) && force_autochannels)) {
 		fprintf(stderr, "Enabling all channels\n");
 
 		ret = enable_disable_all_channels(dev_dir_name, 1);
-- 
2.7.4
