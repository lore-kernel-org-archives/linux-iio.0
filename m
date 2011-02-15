Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: Documentation: generic_buffer example: scan_size must be bytes_per_datum
Date: Tue, 15 Feb 2011 15:46:20 +0100
Message-ID: <1297781180-5071-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com>
References: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

In case a timestamp is present, scan size returned by size_from_channelarray()
is not longer valid. However size_from_channelarray() must be still called
in order to setup locations within the buffer.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 131d9d0..c382452 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -226,7 +226,13 @@ int main(int argc, char **argv)
 	ret = write_sysfs_int("enable", buf_dir_name, 1);
 	if (ret < 0)
 		goto error_free_buf_dir_name;
-	scan_size = size_from_channelarray(infoarray, num_channels);
+
+	scan_size = read_sysfs_posint("bytes_per_datum", buf_dir_name);
+	if (ret < 0)
+		goto error_free_buf_dir_name;
+
+	size_from_channelarray(infoarray, num_channels);
+
 	data = malloc(scan_size*buf_len);
 	if (!data) {
 		ret = -ENOMEM;
-- 
1.6.0.2
