Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33150 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbcDLIzS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2016 04:55:18 -0400
Received: by mail-lf0-f46.google.com with SMTP id e190so15694388lfe.0
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2016 01:55:17 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] iio: tools: generic_buffer: auto-enable channels
Date: Tue, 12 Apr 2016 10:55:11 +0200
Message-Id: <1460451311-9819-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If no channels are enabled when we run generic_buffer on a
device, add a command-line option to just enable all of them,
run the sampling and disable them all again afterwards.

This is extremely useful when I'm low-level testing my
sensors with interrupts and triggers, sample session:

root@Ux500:/ lsiio
Device 000: lsm303dlh_accel
Device 001: lis331dl_accel
Device 002: l3g4200d
Device 003: lsm303dlh_magn
Device 004: lps001wp
Trigger 000: lsm303dlh_accel-trigger
Trigger 001: lis331dl_accel-trigger
Trigger 002: l3g4200d-trigger

root@Ux500:/ generic_buffer -a -c 10 -n l3g4200d
iio device number being used is 2
iio trigger number being used is 2
No channels are enabled, enabling all channels
Enabling: in_anglvel_x_en
Enabling: in_anglvel_y_en
Enabling: in_anglvel_z_en
Enabling: in_timestamp_en
/sys/bus/iio/devices/iio:device2 l3g4200d-trigger
-3.593664 -0.713133 4.870143 946684863662292480
3.225546 0.867357 -4.945878 946684863671875000
-0.676413 0.127296 0.106641 946684863681488037
-0.661113 0.110160 0.128826 946684863690673828
-0.664173 0.113067 0.123471 946684863700683593
-0.664938 0.109395 0.124848 946684863710144042
-0.664173 0.110619 0.130203 946684863719512939
-0.666162 0.111231 0.132651 946684863729125976
-0.668610 0.111690 0.130662 946684863738739013
-0.660501 0.110466 0.131733 946684863748565673
Disabling: in_anglvel_x_en
Disabling: in_anglvel_y_en
Disabling: in_anglvel_z_en
Disabling: in_timestamp_en

Pure awesomeness. If some channels have been enabled through
scripts or manual interaction, nothing happens.

Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Provide for using the -a flag to indicate that you want all
  available channels enabled.
---
 tools/iio/generic_buffer.c | 90 +++++++++++++++++++++++++++++++++++++++++-----
 tools/iio/iio_utils.h      |  7 ++++
 2 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index c42b7f836b48..81ebead47547 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -191,10 +191,51 @@ void process_scan(char *data,
 	printf("\n");
 }
 
+int enable_disable_all_channels(char *dev_dir_name, int enable)
+{
+	const struct dirent *ent;
+	char scanelemdir[256];
+	DIR *dp;
+	int ret;
+
+	snprintf(scanelemdir, sizeof(scanelemdir),
+		 FORMAT_SCAN_ELEMENTS_DIR, dev_dir_name);
+	scanelemdir[sizeof(scanelemdir)-1] = '\0';
+
+	dp = opendir(scanelemdir);
+	if (!dp) {
+		fprintf(stderr, "Enabling/disabling channels: can't open %s\n",
+			scanelemdir);
+		return -EIO;
+	}
+
+	ret = -ENOENT;
+	while (ent = readdir(dp), ent) {
+		if (check_suffix(ent->d_name, "_en")) {
+			printf("%sabling: %s\n",
+			       enable ? "En" : "Dis",
+			       ent->d_name);
+			ret = write_sysfs_int(ent->d_name, scanelemdir,
+					      enable);
+			if (ret < 0)
+				fprintf(stderr, "Failed to enable/disable %s\n",
+					ent->d_name);
+		}
+	}
+
+	if (closedir(dp) == -1) {
+		perror("Enabling/disabling channels: "
+		       "Failed to close directory");
+		return -errno;
+	}
+	return 0;
+}
+
 void print_usage(void)
 {
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 		"Capture, convert and output data from IIO device buffer\n"
+		"  -a         Auto-activate all available channels\n"
 		"  -c <n>     Do n conversions\n"
 		"  -e         Disable wait for event (new data)\n"
 		"  -g         Use trigger-less mode\n"
@@ -225,12 +266,16 @@ int main(int argc, char **argv)
 	int scan_size;
 	int noevents = 0;
 	int notrigger = 0;
+	int autochannels = 0;
 	char *dummy;
 
 	struct iio_channel_info *channels;
 
-	while ((c = getopt(argc, argv, "c:egl:n:t:w:")) != -1) {
+	while ((c = getopt(argc, argv, "ac:egl:n:t:w:")) != -1) {
 		switch (c) {
+		case 'a':
+			autochannels = 1;
+			break;
 		case 'c':
 			errno = 0;
 			num_loops = strtoul(optarg, &dummy, 10);
@@ -340,14 +385,36 @@ int main(int argc, char **argv)
 			"diag %s\n", dev_dir_name);
 		goto error_free_triggername;
 	}
-	if (!num_channels) {
+	if (num_channels && autochannels) {
+		fprintf(stderr, "Auto-channels selected but some channels "
+			"are already activated in sysfs\n");
+		fprintf(stderr, "Proceeding without activating any channels\n");
+	}
+	if (!num_channels && autochannels) {
 		fprintf(stderr,
-			"No channels are enabled, we have nothing to scan.\n");
-		fprintf(stderr, "Enable channels manually in "
-			FORMAT_SCAN_ELEMENTS_DIR
-			"/*_en and try again.\n", dev_dir_name);
-		ret = -ENOENT;
-		goto error_free_triggername;
+			"No channels are enabled, enabling all channels\n");
+
+		ret = enable_disable_all_channels(dev_dir_name, 1);
+		if (ret) {
+			fprintf(stderr, "Failed to enable all channels\n");
+			goto error_free_triggername;
+		}
+
+		/* This flags that we need to disable the channels again */
+		autochannels = 2;
+		ret = build_channel_array(dev_dir_name, &channels,
+					  &num_channels);
+		if (ret) {
+			fprintf(stderr, "Problem reading scan element "
+				"information\n"
+				"diag %s\n", dev_dir_name);
+			goto error_disable_channels;
+		}
+		if (!num_channels) {
+			fprintf(stderr, "Still no channels after "
+				"auto-enabling, giving up\n");
+			goto error_disable_channels;
+		}
 	}
 
 	/*
@@ -479,7 +546,12 @@ error_free_channels:
 error_free_triggername:
 	if (datardytrigger)
 		free(trigger_name);
-
+error_disable_channels:
+	if (autochannels == 2) {
+		ret = enable_disable_all_channels(dev_dir_name, 0);
+		if (ret)
+			fprintf(stderr, "Failed to disable all channels\n");
+	}
 error_free_dev_dir_name:
 	free(dev_dir_name);
 
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index e3503bfe538b..9d5601421820 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -52,6 +52,13 @@ struct iio_channel_info {
 	unsigned location;
 };
 
+static inline int check_suffix(const char *str, const char *suffix)
+{
+	return strlen(str) > strlen(suffix) &&
+		strncmp(str+strlen(str)-strlen(suffix),
+			suffix, strlen(suffix)) == 0;
+}
+
 int iioutils_break_up_name(const char *full_name, char **generic_name);
 int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 		      unsigned *shift, uint64_t *mask, unsigned *be,
-- 
2.4.3

