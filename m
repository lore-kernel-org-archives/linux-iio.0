Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] iio: mma8452: add i2c_device_id for mma8451
Date: Mon, 14 Mar 2016 12:33:14 +0100
Message-Id: <1457955194-6222-1-git-send-email-martink@posteo.de>
In-Reply-To: <1457954789-4885-1-git-send-email-martink@posteo.de>
References: <1457954789-4885-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This was forgotten about and is added for consistency now

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
I'm sorry, I messed up the first patch. Understandable though, given
it's complexity.


 drivers/iio/accel/mma8452.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 305ed0e..6aa2517 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1535,6 +1535,7 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 };
 
 static const struct i2c_device_id mma8452_id[] = {
+	{ "mma8451", mma8451 },
 	{ "mma8452", mma8452 },
 	{ "mma8453", mma8453 },
 	{ "mma8652", mma8652 },
-- 
2.1.4
