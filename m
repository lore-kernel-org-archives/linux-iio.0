Return-Path: <bfreed@google.com>
From: Bryan Freed <bfreed@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: jic23@cam.ac.uk, gregkh@suse.de, rklein@nvidia.com,
        linux-iio@vger.kernel.org, Bryan Freed <bfreed@chromium.org>
Subject: [PATCH 2/3] staging:iio: Add an iio channel type string to support proximity sensors.
Date: Wed,  6 Jul 2011 11:56:25 -0700
Message-Id: <1309978586-10092-2-git-send-email-bfreed@chromium.org>
In-Reply-To: <1309978586-10092-1-git-send-email-bfreed@chromium.org>
References: <1309978586-10092-1-git-send-email-bfreed@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

Add "proximity" to the iio_chan_type_name_spec_shared string list to
support proximity sensors.
Now this list fully matches the declared iio_chan_type enums.

Signed-off-by: Bryan Freed <bfreed@chromium.org>
---
 drivers/staging/iio/industrialio-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 4987bf4..ef9a11e 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -53,6 +53,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_MAGN] = "magn",
 	[IIO_LIGHT] = "illuminance",
 	[IIO_INTENSITY] = "intensity",
+	[IIO_PROXIMITY] = "proximity",
 	[IIO_TEMP] = "temp",
 	[IIO_INCLI] = "incli",
 	[IIO_ROT] = "rot",
-- 
1.7.3.1
