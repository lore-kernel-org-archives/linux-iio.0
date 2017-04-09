Return-Path: <SRS0=8m7H=3R=foxmail.com=chen.chenchacha@kernel.org>
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: pmeerw@pmeerw.net,
	jic23@kernel.org
Cc: Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v4 1/1] iio:meter:ade7759: Removing use of deprecated macros (S_IRUGO, S_IWUSR)
Date: Sun,  9 Apr 2017 23:21:00 +0800
Message-Id: <20170409152100.30778-2-chen.chenchacha@foxmail.com>
In-Reply-To: <20170409152100.30778-1-chen.chenchacha@foxmail.com>
References: <20170409043027.13930-3-chen.chenchacha@foxmail.com>
 <20170409152100.30778-1-chen.chenchacha@foxmail.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes the coding style issue of using (S_IWUSR | S_IRUGO) in place of
4-digit octal numbers.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 68405046dae3..1691760339da 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -317,11 +317,11 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_APGAIN);
-static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(1, 0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(2, 0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_CH2OS);
-- 
2.11.0
