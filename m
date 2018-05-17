Return-Path: <SRS0=yGHB=IE=xevo.com=mkelly@kernel.org>
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 2/2] tools: iio: iio_generic_buffer: allow continuous looping
Date: Thu, 17 May 2018 16:16:07 -0700
Message-Id: <20180517231607.10856-2-mkelly@xevo.com>
In-Reply-To: <20180517231607.10856-1-mkelly@xevo.com>
References: <20180517231607.10856-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

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
Another option for implementing this would be to implicitly assume looping
forever if -c is not specified (instead of the current default of 2). I did not
do this out of fear of breaking existing users but would be OK with doing so, as
I like it as a default. If you'd like to go this route, let me know.

 tools/iio/iio_generic_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index aa765c11992b..116c65cd0d14 100644
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
@@ -330,7 +330,7 @@ static const struct option longopts[] = {
 
 int main(int argc, char **argv)
 {
-	unsigned long num_loops = 2;
+	unsigned long long num_loops = 2;
 	unsigned long timedelay = 1000000;
 	unsigned long buf_len = 128;
 
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
