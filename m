Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] iio: core: deconstify members of struct iio_chan_spec
Date: Fri, 15 Jul 2011 14:59:02 +0200
Message-ID: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Allow dynamic allocation and population of channel spec.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 7a6ce4d..a9d7730 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -121,9 +121,9 @@ struct iio_chan_spec {
 		u8	storagebits;
 		u8	shift;
 	} scan_type;
-	const long		info_mask;
-	const long		event_mask;
-	const char		*extend_name;
+	long			info_mask;
+	long			event_mask;
+	char			*extend_name;
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
-- 
1.7.0.4
