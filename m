Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13034 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbbC0MxM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 27 Mar 2015 08:53:12 -0400
From: Alin Arhip <alin.g.arhip@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alin Gabriel Arhip <alin.g.arhip@intel.com>
Subject: [PATCH] tools: iio: Add help option for generic_buffer
Date: Fri, 27 Mar 2015 14:42:19 +0200
Message-Id: <1427460139-5136-1-git-send-email-alin.g.arhip@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alin Gabriel Arhip <alin.g.arhip@intel.com>

This patch adds usage instructions and -h parameter to view available
command line parameters.

Signed-off-by: Alin Gabriel Arhip <alin.g.arhip@intel.com>
---
 tools/iio/generic_buffer.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 8f8f058..8dd77ac 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -166,7 +166,17 @@ int main(int argc, char **argv)
 
 	struct iio_channel_info *channels;
 
-	while ((c = getopt(argc, argv, "l:w:c:et:n:g")) != -1) {
+	if (argc <= 1) {
+		printf("Usage: %s -n <device_name> -t <trigger_name>\n"
+			"\tIf trigger name is not specified the program\n"
+			"\tassumes you want a dataready trigger associated\n"
+			"\twith the device and goes looking for it.\n"
+			"\tUse -h to see available command line parameters.\n",
+			argv[0]);
+		return -1;
+	}
+
+	while ((c = getopt(argc, argv, "l:w:c:et:n:gh")) != -1) {
 		switch (c) {
 		case 'n':
 			device_name = optarg;
@@ -190,7 +200,15 @@ int main(int argc, char **argv)
 		case 'g':
 			notrigger = 1;
 			break;
-		case '?':
+		case '?': case 'h':
+			printf("Usage: %s -n <device_name> to set device name\n"
+				"\t-t <trigger_name> to set trigger name\n"
+				"\t-e to set noevents to 1\n"
+				"\t-c <num_loops> to set number of loops\n"
+				"\t-w <timedelay> to set time delay\n"
+				"\t-l <buf_len> to set buffer length\n"
+				"\t-g to set notrigger to 1\n"
+				"\t-h to see this help\n", argv[0]);
 			return -1;
 		}
 	}
-- 
1.9.1

