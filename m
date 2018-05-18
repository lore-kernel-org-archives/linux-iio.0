Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0054.outbound.protection.outlook.com ([104.47.32.54]:22558
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751530AbeERAPJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 May 2018 20:15:09 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Martin Kelly <mkelly@xevo.com>
Subject: [PATCH v2 2/2] tools: iio: iio_generic_buffer: allow continuous looping
Date: Thu, 17 May 2018 17:14:46 -0700
Message-Id: <20180518001446.15607-2-mkelly@xevo.com>
In-Reply-To: <20180518001446.15607-1-mkelly@xevo.com>
References: <20180518001446.15607-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sometimes it's useful to stream samples forever, such as when
stress-testing a driver overnight to check for memory leaks or other
issues. When the program receives a signal, it will gracefully cleanup,
so it is still safe to terminate at any time.

Add support for specifying a negative -c option, meaning that we should
loop forever. To do so, we need to use a long long (instead of just
long) for num_loops so that current code specifying num_loops greater
than UNSIGNED_LONG_MAX doesn't break.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
v2:
- Make j unsigned long long to match num_loops.

Another option for implementing this would be to implicitly assume looping
forever if -c is not specified (instead of the current default of 2). I did not
do this out of fear of breaking existing users but would be OK with doing so, as
I like it as a default. If you'd like to go this route, let me know.

 tools/iio/iio_generic_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index aa765c11992b..3040830d7797 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -248,7 +248,7 @@ void print_usage(void)
 		"Capture, convert and output data from IIO device buffer\n"
 		"  -a         Auto-activate all available channels\n"
 		"  -A         Force-activate ALL channels\n"
-		"  -c <n>     Do n conversions\n"
+		"  -c <n>     Do n conversions, or loop forever if n < 0\n"
 		"  -e         Disable wait for event (new data)\n"
 		"  -g         Use trigger-less mode\n"
 		"  -l <n>     Set buffer length to n samples\n"
@@ -330,12 +330,12 @@ static const struct option longopts[] = {
 
 int main(int argc, char **argv)
 {
-	unsigned long num_loops = 2;
+	unsigned long long num_loops = 2;
 	unsigned long timedelay = 1000000;
 	unsigned long buf_len = 128;
 
 	ssize_t i;
-	unsigned long j;
+	unsigned long long j;
 	unsigned long toread;
 	int ret, c;
 	int fp = -1;
@@ -369,7 +369,7 @@ int main(int argc, char **argv)
 			break;	
 		case 'c':
 			errno = 0;
-			num_loops = strtoul(optarg, &dummy, 10);
+			num_loops = strtoll(optarg, &dummy, 10);
 			if (errno) {
 				ret = -errno;
 				goto error;
@@ -637,7 +637,7 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
-	for (j = 0; j < num_loops; j++) {
+	for (j = 0; j < num_loops || num_loops < 0; j++) {
 		if (!noevents) {
 			struct pollfd pfd = {
 				.fd = fp,
-- 
2.11.0

