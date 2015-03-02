Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 2/3] iio: Provide new API to get the current resolution of timestamps
Date: Mon,  2 Mar 2015 20:56:05 +0000
Message-Id: <1425329766-14703-3-git-send-email-harald@ccbib.org>
In-Reply-To: <1425329766-14703-1-git-send-email-harald@ccbib.org>
References: <1425329766-14703-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 include/linux/iio/iio.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 80d8550..2d352a0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -286,6 +286,11 @@ static inline s64 iio_get_time_ns(void)
 	return ktime_get_real_ns();
 }
 
+static inline u32 iio_get_time_resolution_ns(void)
+{
+	return ktime_get_resolution_ns();
+}
+
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_BUFFER_TRIGGERED		0x02
-- 
1.7.2.5
