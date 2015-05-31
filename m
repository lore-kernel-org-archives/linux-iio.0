Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 29/32] tools:iio: rework program parameters
Date: Sun, 31 May 2015 14:40:22 +0200
Message-Id: <cd3645ea3071573bbdc97304943ed16f5b712d6f.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In generic_buffer.c: sort program parameters alphabetically and provide
		     usage information
In lsiio.c: drop unused parameters

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 55 ++++++++++++++++++++++++++++++----------------
 tools/iio/lsiio.c          |  6 ++---
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index f17b168..c546852 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -168,6 +168,19 @@ void process_scan(char *data,
 	printf("\n");
 }
 
+void print_usage(void)
+{
+	printf("Usage: generic_buffer [options]...\n"
+	       "Capture, convert and output data from IIO device buffer\n"
+	       "  -c <n>     Do n conversions\n"
+	       "  -e         Disable wait for event (new data)\n"
+	       "  -g         Use trigger-less mode\n"
+	       "  -l <n>     Set buffer length to n samples\n"
+	       "  -n <name>  Set device name (mandatory)\n"
+	       "  -t <name>  Set trigger name\n"
+	       "  -w <n>     Set delay between reads in us (event-less mode)\n");
+}
+
 int main(int argc, char **argv)
 {
 	unsigned long num_loops = 2;
@@ -193,29 +206,19 @@ int main(int argc, char **argv)
 
 	struct iio_channel_info *channels;
 
-	while ((c = getopt(argc, argv, "l:w:c:et:n:g")) != -1) {
+	while ((c = getopt(argc, argv, "c:egl:n:t:w:")) != -1) {
 		switch (c) {
-		case 'n':
-			device_name = optarg;
-			break;
-		case 't':
-			trigger_name = optarg;
-			datardytrigger = 0;
-			break;
-		case 'e':
-			noevents = 1;
-			break;
 		case 'c':
 			errno = 0;
 			num_loops = strtoul(optarg, &dummy, 10);
 			if (errno)
 				return -errno;
 			break;
-		case 'w':
-			errno = 0;
-			timedelay = strtoul(optarg, &dummy, 10);
-			if (errno)
-				return -errno;
+		case 'e':
+			noevents = 1;
+			break;
+		case 'g':
+			notrigger = 1;
 			break;
 		case 'l':
 			errno = 0;
@@ -223,16 +226,30 @@ int main(int argc, char **argv)
 			if (errno)
 				return -errno;
 			break;
-		case 'g':
-			notrigger = 1;
+		case 'n':
+			device_name = optarg;
+			break;
+		case 't':
+			trigger_name = optarg;
+			datardytrigger = 0;
+			break;
+		case 'w':
+			errno = 0;
+			timedelay = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
 			break;
 		case '?':
+			print_usage();
 			return -1;
 		}
 	}
 
-	if (device_name == NULL)
+	if (device_name == NULL) {
+		printf("Device name not set\n");
+		print_usage();
 		return -1;
+	}
 
 	/* Find the device requested */
 	dev_num = find_type_by_name(device_name, "iio:device");
diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index b1089ad..b59ee17 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -164,7 +164,7 @@ int main(int argc, char **argv)
 {
 	int c, err = 0;
 
-	while ((c = getopt(argc, argv, "d:D:v")) != EOF) {
+	while ((c = getopt(argc, argv, "v")) != EOF) {
 		switch (c) {
 		case 'v':
 			verblevel++;
@@ -179,9 +179,7 @@ int main(int argc, char **argv)
 	if (err || argc > optind) {
 		fprintf(stderr, "Usage: lsiio [options]...\n"
 			"List industrial I/O devices\n"
-			"  -v, --verbose\n"
-			"      Increase verbosity (may be given multiple times)\n"
-			);
+			"  -v  Increase verbosity (may be given multiple times)\n");
 		exit(1);
 	}
 
-- 
2.3.6
