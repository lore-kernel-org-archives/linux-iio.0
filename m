Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	pmeerw@pmeerw.net,
	o.v.kravchenko@globallogic.com,
	stigge@antcom.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/24] staging:iio:mag:hmc5843 fix incorrect endianness of channel as a result of missuse of the IIO_ST macro.
Date: Wed, 11 Dec 2013 18:45:19 +0000
Message-Id: <1386787542-19666-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This driver sets the shift value equal to IIO_BE (or 1) rather than setting
that to 0 and specificying the endianness.  This means the channel type is
missreported as
[be|le]:u16/16>>1 where the be|le is dependent on the cpu native endianness,
rather than
be:u16/16>>0 resulting in any userspace code using this information, miss
converting the channel and generating thoroughly trashed data.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index bdb018878296..680eb743df9a 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -451,7 +451,12 @@ done:
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 		.scan_index = idx,					\
-		.scan_type = IIO_ST('s', 16, 16, IIO_BE),		\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,				\
+			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
+			},						\
 	}
 
 static const struct iio_chan_spec hmc5843_channels[] = {
-- 
1.8.4.2
