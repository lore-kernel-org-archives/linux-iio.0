Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35718 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbcJNKS4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 06:18:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id s8so6967830pfj.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2016 03:18:56 -0700 (PDT)
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH] tools: iio: iio_generic_buffer: add -A to force-enable all channels
Date: Fri, 14 Oct 2016 18:18:39 +0800
Message-Id: <1476440319-11124-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If attribute/s is/are already enabled (by default or via scripts or
manual interaction), issuing -a will fail to enable the channels thereby
one has to manually disable the said attribute/s before proceeding with
auto-enabling.

Add a command-line option -A to force-activate all channels regardless
of their current state.

Suggested-by: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 tools/iio/iio_generic_buffer.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index f39c0e9..84c9888 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -247,6 +247,7 @@ void print_usage(void)
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 		"Capture, convert and output data from IIO device buffer\n"
 		"  -a         Auto-activate all available channels\n"
+		"  -A         Force-activate ALL channels\n"
 		"  -c <n>     Do n conversions\n"
 		"  -e         Disable wait for event (new data)\n"
 		"  -g         Use trigger-less mode\n"
@@ -347,16 +348,22 @@ int main(int argc, char **argv)
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
+	int force = 0;
 
 	struct iio_channel_info *channels = NULL;
 
 	register_cleanup();
 
-	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "aAc:egl:n:N:t:T:w:", longopts,
+		NULL)) != -1) {
 		switch (c) {
 		case 'a':
 			autochannels = AUTOCHANNELS_ENABLED;
 			break;
+		case 'A':
+			autochannels = AUTOCHANNELS_ENABLED;
+			force = 1;
+			break;
 		case 'c':
 			errno = 0;
 			num_loops = strtoul(optarg, &dummy, 10);
@@ -519,15 +526,15 @@ int main(int argc, char **argv)
 			"diag %s\n", dev_dir_name);
 		goto error;
 	}
-	if (num_channels && autochannels == AUTOCHANNELS_ENABLED) {
+	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) && !force) {
 		fprintf(stderr, "Auto-channels selected but some channels "
 			"are already activated in sysfs\n");
 		fprintf(stderr, "Proceeding without activating any channels\n");
 	}
 
-	if (!num_channels && autochannels == AUTOCHANNELS_ENABLED) {
-		fprintf(stderr,
-			"No channels are enabled, enabling all channels\n");
+	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
+	    ((autochannels == AUTOCHANNELS_ENABLED) && force)) {
+		fprintf(stderr, "Enabling all channels\n");
 
 		ret = enable_disable_all_channels(dev_dir_name, 1);
 		if (ret) {
-- 
2.7.4

