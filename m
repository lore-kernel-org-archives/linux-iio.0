Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:32837 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbGJLAK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jul 2015 07:00:10 -0400
Date: Fri, 10 Jul 2015 13:59:28 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com,
	julia.lawall@lip6.fr
Subject: [PATCH v2 2/4] tools: iio: Send usage error messages to stderr
Message-ID: <979fcb9eef2ae9eb9088c61460ad4fd986eb5795.1436524490.git.cristina.opriceana@gmail.com>
References: <cover.1436524490.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1436524490.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Incorrect usage messages should be sent to stderr.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 tools/iio/generic_buffer.c    | 2 +-
 tools/iio/iio_event_monitor.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 2f4e12f..af350cc 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -193,7 +193,7 @@ void process_scan(char *data,
 
 void print_usage(void)
 {
-	printf("Usage: generic_buffer [options]...\n"
+	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 	       "Capture, convert and output data from IIO device buffer\n"
 	       "  -c <n>     Do n conversions\n"
 	       "  -e         Disable wait for event (new data)\n"
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 843bc4c..1c138fc 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -251,7 +251,7 @@ int main(int argc, char **argv)
 	int fd, event_fd;
 
 	if (argc <= 1) {
-		printf("Usage: %s <device_name>\n", argv[0]);
+		fprintf(stderr, "Usage: %s <device_name>\n", argv[0]);
 		return -1;
 	}
 
-- 
1.9.1

