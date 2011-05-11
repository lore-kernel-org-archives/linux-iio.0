Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 2/2] IIO-work: Add channel types IIO_CURRENT and IIO_POWER
Date: Wed, 11 May 2011 13:58:39 +0200
Message-ID: <1305115119-8850-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305115119-8850-1-git-send-email-michael.hennerich@analog.com>
References: <1305115119-8850-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add channel types IIO_CURRENT and IIO_POWER.
This is required for the ADE7758 driver cleanup.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio.h               |    2 ++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index d9f2692..80a81d4 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -30,6 +30,8 @@
 enum iio_chan_type {
 	/* real channel types */
 	IIO_IN,
+	IIO_CURRENT,
+	IIO_POWER,
 	IIO_ACCEL,
 	IIO_IN_DIFF,
 	IIO_GYRO,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index faa34af..9218fee 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -47,6 +47,8 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_ACCEL] = "accel",
 	[IIO_IN] = "in",
+	[IIO_CURRENT] = "current",
+	[IIO_POWER] = "power",
 	[IIO_IN_DIFF] = "in-in",
 	[IIO_GYRO] = "gyro",
 	[IIO_TEMP] = "temp",
-- 
1.6.0.2
