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
Subject: [PATCH 2/2] iio: generic_buffer: Add --device-num option
Date: Fri, 20 May 2016 18:45:31 +0300
Message-Id: <2ce694cc2161b74e5a0cebc726b7320e4cc8c65e.1463759121.git.leonard.crestez@intel.com>
In-Reply-To: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
References: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
In-Reply-To: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
References: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This makes it possible to distinguish between iio devices with the same
name.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 tools/iio/generic_buffer.c | 53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index e7bf477..f805ef9 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -251,7 +251,9 @@ void print_usage(void)
 		"  -e         Disable wait for event (new data)\n"
 		"  -g         Use trigger-less mode\n"
 		"  -l <n>     Set buffer length to n samples\n"
-		"  -n <name>  Set device name (mandatory)\n"
+		"  --device-name -n <name>\n"
+		"  --device-num -N <num>\n"
+		"        Set device by name or number"
 		"  -t <name>  Set trigger name\n"
 		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
@@ -319,6 +321,12 @@ void register_cleanup(void)
 	}
 }
 
+static const struct option longopts[] = {
+	{ "device-name",	1, 0, 'n' },
+	{ "device-num",		1, 0, 'N' },
+	{ },
+};
+
 int main(int argc, char **argv)
 {
 	unsigned long num_loops = 2;
@@ -333,7 +341,7 @@ int main(int argc, char **argv)
 
 	char *data;
 	ssize_t read_size;
-	int dev_num, trig_num;
+	int dev_num = -1, trig_num;
 	char *buffer_access;
 	int scan_size;
 	int noevents = 0;
@@ -344,7 +352,7 @@ int main(int argc, char **argv)
 
 	register_cleanup();
 
-	while ((c = getopt(argc, argv, "ac:egl:n:t:w:")) != -1) {
+	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:w:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'a':
 			autochannels = AUTOCHANNELS_ENABLED;
@@ -372,6 +380,12 @@ int main(int argc, char **argv)
 		case 'n':
 			device_name = optarg;
 			break;
+		case 'N':
+			errno = 0;
+			dev_num = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			break;
 		case 't':
 			trigger_name = optarg;
 			break;
@@ -387,24 +401,37 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (!device_name) {
-		fprintf(stderr, "Device name not set\n");
+	/* Find the device requested */
+	if (dev_num < 0 && !device_name) {
+		fprintf(stderr, "Device not set\n");
 		print_usage();
 		return -1;
+	} else if (dev_num >= 0 && device_name) {
+		fprintf(stderr, "Only one of --device-num or --device-name needs to be set\n");
+		print_usage();
+		return -1;
+	} else if (dev_num < 0) {
+		dev_num = find_type_by_name(device_name, "iio:device");
+		if (dev_num < 0) {
+			fprintf(stderr, "Failed to find the %s\n", device_name);
+			return dev_num;
+		}
 	}
-
-	/* Find the device requested */
-	dev_num = find_type_by_name(device_name, "iio:device");
-	if (dev_num < 0) {
-		fprintf(stderr, "Failed to find the %s\n", device_name);
-		return dev_num;
-	}
-
 	printf("iio device number being used is %d\n", dev_num);
 
 	ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
 	if (ret < 0)
 		return -ENOMEM;
+	if (!device_name) {
+		device_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!device_name)
+			return -ENOMEM;
+		ret = read_sysfs_string("name", dev_dir_name, device_name);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to read name of device %d\n", dev_num);
+			return ret;
+		}
+	}
 
 	if (!notrigger) {
 		if (!trigger_name) {
-- 
2.5.5
