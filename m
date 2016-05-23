Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCHv3 3/7] iio: generic_buffer: Add --trigger-num option
Date: Mon, 23 May 2016 21:39:58 +0300
Message-Id: <2c51dcad4cbc011247ea3a5f8360f56594bdd40a.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 tools/iio/generic_buffer.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 3f16e9f..e8c3052 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
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
+	} if (trig_num > 0) {
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
