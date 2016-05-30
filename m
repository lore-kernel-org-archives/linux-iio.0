Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26008 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161516AbcE3PTz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 May 2016 11:19:55 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v4 3/3] iio: generic_buffer: Add --trigger-num option
Date: Mon, 30 May 2016 18:19:28 +0300
Message-Id: <23d930be335cd757bb67a37db81d0e57f65f0976.1464610998.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464610998.git.leonard.crestez@intel.com>
References: <cover.1464610998.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464610998.git.leonard.crestez@intel.com>
References: <cover.1464610998.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 tools/iio/iio_generic_buffer.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 3f16e9f..0e8a1f7 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -254,7 +254,9 @@ void print_usage(void)
 		"  --device-name -n <name>\n"
 		"  --device-num -N <num>\n"
 		"        Set device by name or number (mandatory)\n"
-		"  -t <name>  Set trigger name\n"
+		"  --trigger-name -t <name>\n"
+		"  --trigger-num -T <num>\n"
+		"        Set trigger by name or number\n"
 		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
 
@@ -320,6 +322,8 @@ void register_cleanup(void)
 static const struct option longopts[] = {
 	{ "device-name",	1, 0, 'n' },
 	{ "device-num",		1, 0, 'N' },
+	{ "trigger-name",	1, 0, 't' },
+	{ "trigger-num",	1, 0, 'T' },
 	{ },
 };
 
@@ -337,7 +341,7 @@ int main(int argc, char **argv)
 
 	char *data = NULL;
 	ssize_t read_size;
-	int dev_num = -1, trig_num;
+	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
 	int scan_size;
 	int noevents = 0;
@@ -348,7 +352,7 @@ int main(int argc, char **argv)
 
 	register_cleanup();
 
-	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:w:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'a':
 			autochannels = AUTOCHANNELS_ENABLED;
@@ -391,6 +395,12 @@ int main(int argc, char **argv)
 		case 't':
 			trigger_name = strdup(optarg);
 			break;
+		case 'T':
+			errno = 0;
+			trig_num = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			break;
 		case 'w':
 			errno = 0;
 			timedelay = strtoul(optarg, &dummy, 10);
@@ -444,7 +454,23 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (!notrigger) {
+	if (notrigger) {
+		printf("trigger-less mode selected\n");
+	} if (trig_num >= 0) {
+		char *trig_dev_name;
+		ret = asprintf(&trig_dev_name, "%strigger%d", iio_dir, trig_num);
+		if (ret < 0) {
+			return -ENOMEM;
+		}
+		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
+		free(trig_dev_name);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to read trigger%d name from\n", trig_num);
+			return ret;
+		}
+		printf("iio trigger number being used is %d\n", trig_num);
+	} else {
 		if (!trigger_name) {
 			/*
 			 * Build the trigger name. If it is device associated
@@ -481,8 +507,6 @@ int main(int argc, char **argv)
 		}
 
 		printf("iio trigger number being used is %d\n", trig_num);
-	} else {
-		printf("trigger-less mode selected\n");
 	}
 
 	/*
-- 
2.5.5

