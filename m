Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/6] IIO: Documentation: iio_utils: Avoid double free()
Date: Thu, 24 Feb 2011 16:34:51 +0100
Message-ID: <1298561694-6930-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298561694-6930-1-git-send-email-michael.hennerich@analog.com>
References: <1298561694-6930-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

filename is used and freed later

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/iio_utils.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 4dc961c..3cf01a5 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -319,7 +319,6 @@ inline int build_channel_array(const char *device_dir,
 			}
 			fscanf(sysfsfp, "%u", &current->enabled);
 			fclose(sysfsfp);
-			free(filename);
 			current->scale = 1.0;
 			current->offset = 0;
 			current->name = strndup(ent->d_name,
--
1.6.0.2
