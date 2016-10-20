Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 2/2] tools: iio: iio_generic_buffer: drop unneeded parentheses
Date: Thu, 20 Oct 2016 17:19:24 +0800
Message-Id: <514fcbf5d2713395ebe0b6aa0b141ccbbbbeb495.1476952931.git.eraretuya@gmail.com>
In-Reply-To: <cover.1476952931.git.eraretuya@gmail.com>
References: <cover.1476952931.git.eraretuya@gmail.com>
In-Reply-To: <cover.1476952931.git.eraretuya@gmail.com>
References: <cover.1476952931.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove extra parentheses introduced in commit <73e176a tools: iio:
iio_generic_buffer: add -A to force-enable all channels>.

Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 tools/iio/iio_generic_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 8ef39ae..f0c6f54 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -526,7 +526,7 @@ int main(int argc, char **argv)
 			"diag %s\n", dev_dir_name);
 		goto error;
 	}
-	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) &&
+	if (num_channels && autochannels == AUTOCHANNELS_ENABLED &&
 	    !force_autochannels) {
 		fprintf(stderr, "Auto-channels selected but some channels "
 			"are already activated in sysfs\n");
@@ -534,7 +534,7 @@ int main(int argc, char **argv)
 	}
 
 	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
-	    ((autochannels == AUTOCHANNELS_ENABLED) && force_autochannels)) {
+	    (autochannels == AUTOCHANNELS_ENABLED && force_autochannels)) {
 		fprintf(stderr, "Enabling all channels\n");
 
 		ret = enable_disable_all_channels(dev_dir_name, 1);
-- 
2.7.4
