Return-Path: <mopsfelder@gmail.com>
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH v2 7/8] staging: iio: accel: lis3l02dq_ring.c: Add blank line between declarations and code
Date: Mon,  4 Aug 2014 22:47:02 -0300
Message-Id: <1407203223-9700-8-git-send-email-mopsfelder@gmail.com>
In-Reply-To: <1407203223-9700-1-git-send-email-mopsfelder@gmail.com>
References: <1407203223-9700-1-git-send-email-mopsfelder@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds missing blank line between declarations and code,
satisfying checkpatch.pl.

Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index bf33fde..1d934ee 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -19,6 +19,7 @@ static inline u16 combine_8_to_16(u8 lower, u8 upper)
 {
 	u16 _lower = lower;
 	u16 _upper = upper;
+
 	return _lower | (_upper << 8);
 }
 
-- 
2.1.0.rc1.204.gae8bc8d
