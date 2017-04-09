Return-Path: <SRS0=8m7H=3R=foxmail.com=chen.chenchacha@kernel.org>
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: pmeerw@pmeerw.net,
	jic23@kernel.org
Cc: Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v3 2/2] iio:meter:ade7759: realign the rest with opening bracket
Date: Sun,  9 Apr 2017 12:30:27 +0800
Message-Id: <20170409043027.13930-3-chen.chenchacha@foxmail.com>
In-Reply-To: <20170409043027.13930-1-chen.chenchacha@foxmail.com>
References: <260495ce-b068-a5ce-6ec3-a90fdd7e2510@foxmail.com>
 <20170409043027.13930-1-chen.chenchacha@foxmail.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes the coding style issue of using (S_IWUSR | S_IRUGO) in place of
4-digit octal numbers with realign the rest with opening bracket.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 68405046dae3..9ddfa4ec7da9 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -317,11 +317,15 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_APGAIN);
-static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(
+		1,
+		0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(
+		2,
+		0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_CH2OS);
-- 
2.11.0
