Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/6] IIO: Documentation: iio_utils: style consistency fix
Date: Thu, 24 Feb 2011 16:34:52 +0100
Message-ID: <1298561694-6930-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298561694-6930-1-git-send-email-michael.hennerich@analog.com>
References: <1298561694-6930-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

No functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/iio_utils.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 3cf01a5..4b023aa 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -374,7 +374,7 @@ inline int build_channel_array(const char *device_dir,
 		}
 	}
 	/* reorder so that the array is in index order*/
-	current = malloc(sizeof(**ci_array)**counter);
+	current = malloc(sizeof(**ci_array)*(*counter));
 	if (current == NULL) {
 		ret = -ENOMEM;
 		goto error_cleanup_array;
--
1.6.0.2
