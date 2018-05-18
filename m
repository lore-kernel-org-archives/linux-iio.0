Return-Path: <SRS0=DTdo=IF=xevo.com=mkelly@kernel.org>
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Martin Kelly <mkelly@xevo.com>
Subject: [PATCH v2 1/2] tools: iio: iio_generic_buffer: fix types to match
Date: Thu, 17 May 2018 17:14:45 -0700
Message-Id: <20180518001446.15607-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Several types are mismatched and causing implicit conversions.  Fix them
up so the types match.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 tools/iio/iio_generic_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index f0c6f54a8b2f..aa765c11992b 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -334,7 +334,10 @@ int main(int argc, char **argv)
 	unsigned long timedelay = 1000000;
 	unsigned long buf_len = 128;
 
-	int ret, c, i, j, toread;
+	ssize_t i;
+	unsigned long j;
+	unsigned long toread;
+	int ret, c;
 	int fp = -1;
 
 	int num_channels = 0;
-- 
2.11.0
