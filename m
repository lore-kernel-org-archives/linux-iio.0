Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/6] IIO: Documentation: iio_utils: Prevent buffer overflow
Date: Thu, 24 Feb 2011 16:34:53 +0100
Message-ID: <1298561694-6930-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298561694-6930-1-git-send-email-michael.hennerich@analog.com>
References: <1298561694-6930-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

The first part of build_channel_array()identifies the number of enabled channels.
Further down this count is used to allocate the ci_array. The next section parses the
scan_elements directory again, and fills ci_array regardless if the channel is enabled or not.
So if less than available channels are enabled ci_array memory is overflowed.

This fix makes sure that we allocate enough memory. But the whole approach looks a bit
cumbersome to me. Why not allocate memory for MAX_CHANNLES, less say 64
(I never seen a part with more than that channels). And skip the first part entirely.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/iio_utils.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 4b023aa..bde2313 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -290,15 +290,17 @@ inline int build_channel_array(const char *device_dir,
 			fscanf(sysfsfp, "%u", &ret);
 			if (ret == 1)
 				(*counter)++;
+			count++;
 			fclose(sysfsfp);
 			free(filename);
 		}
-	*ci_array = malloc(sizeof(**ci_array)*(*counter));
+	*ci_array = malloc(sizeof(**ci_array)*count);
 	if (*ci_array == NULL) {
 		ret = -ENOMEM;
 		goto error_close_dir;
 	}
 	seekdir(dp, 0);
+	count = 0;
 	while (ent = readdir(dp), ent != NULL) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
--
1.6.0.2
