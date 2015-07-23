Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 2/2] tools: iio: print error message when buffer enable fails
Date: Thu, 23 Jul 2015 20:22:52 +0300
Message-Id: <1437672172-21189-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com>
References: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Running generic_buffer without enabling any channel of the
sensor will fail without printing any error message.

Add an error message that indicates buffer enable failed.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 tools/iio/generic_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 32f389eb..936469c 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -364,8 +364,11 @@ int main(int argc, char **argv)
 
 	/* Enable the buffer */
 	ret = write_sysfs_int("enable", buf_dir_name, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		fprintf(stderr,
+			"Failed to enable buffer: %s\n", strerror(errno));
 		goto error_free_buf_dir_name;
+	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
 	data = malloc(scan_size * buf_len);
-- 
1.9.1
