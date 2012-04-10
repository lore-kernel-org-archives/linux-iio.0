Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/14] staging:iio:accel:sca3000 unwind use of IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:43 +0100
Message-Id: <1334089310-22576-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000_core.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 49764fb..b4a2747 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -433,13 +433,27 @@ static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 #define SCA3000_EVENT_MASK					\
 	(IIO_EV_BIT(IIO_EV_TYPE_MAG, IIO_EV_DIR_RISING))
 
+#define SCA3000_CHAN(index, mod)				\
+	{							\
+		.type = IIO_ACCEL,				\
+		.modified = 1,					\
+		.channel2 = mod,				\
+		.info_mask = SCA3000_INFO_MASK,			\
+		.address = index,				\
+		.scan_index = index,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 11,				\
+			.storagebits = 16,			\
+			.shift = 5,				\
+		},						\
+		.event_mask = SCA3000_EVENT_MASK,		\
+	 }
+
 static struct iio_chan_spec sca3000_channels[] = {
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X, SCA3000_INFO_MASK,
-		 0, 0, IIO_ST('s', 11, 16, 5), SCA3000_EVENT_MASK),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y, SCA3000_INFO_MASK,
-		 1, 1, IIO_ST('s', 11, 16, 5), SCA3000_EVENT_MASK),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z, SCA3000_INFO_MASK,
-		 2, 2, IIO_ST('s', 11, 16, 5), SCA3000_EVENT_MASK),
+	SCA3000_CHAN(0, IIO_MOD_X),
+	SCA3000_CHAN(1, IIO_MOD_Y),
+	SCA3000_CHAN(2, IIO_MOD_Z),
 };
 
 static u8 sca3000_addresses[3][3] = {
-- 
1.7.9.4
