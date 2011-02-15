Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: Documentation: iio_utils: Fix typo
Date: Tue, 15 Feb 2011 15:46:19 +0100
Message-ID: <1297781180-5071-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com>
References: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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
