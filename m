Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com,
	amit.kucheria@verdurent.com,
	pmeerw@pmeerw.net,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] staging:iio:tsl2563 Simplify exit path on error in read_interrupt_config.
Date: Sat, 12 Jan 2013 10:35:22 +0000
Message-Id: <1357986924-11471-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1357986924-11471-1-git-send-email-jic23@kernel.org>
References: <1357986924-11471-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

A rather over complicated exit path given there is only one exit
route and nothing much is done after it.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2563.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 547203c..1a3092a 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -672,11 +672,9 @@ static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
 				       TSL2563_CMD | TSL2563_REG_INT);
 	mutex_unlock(&chip->lock);
 	if (ret < 0)
-		goto error_ret;
-	ret = !!(ret & 0x30);
-error_ret:
+		return ret;
 
-	return ret;
+	return !!(ret & 0x30);
 }
 
 static struct i2c_driver tsl2563_i2c_driver;
-- 
1.8.1
