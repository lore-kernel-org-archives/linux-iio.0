Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52688 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932835AbcAYPwZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2016 10:52:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad5933: avoid uninitialized variable in error case
Date: Mon, 25 Jan 2016 16:50:46 +0100
Message-Id: <1453737099-1959671-1-git-send-email-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad5933_i2c_read function returns an error code to indicate
whether it could read data or not. However ad5933_work() ignores
this return code and just accesses the data unconditionally,
which gets detected by gcc as a possible bug:

drivers/staging/iio/impedance-analyzer/ad5933.c: In function 'ad5933_work':
drivers/staging/iio/impedance-analyzer/ad5933.c:649:16: warning: 'status' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds minimal error handling so we only evaluate the
data if it was correctly read.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 10c43dda0f5a..304bb464e478 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -647,6 +647,7 @@ static void ad5933_work(struct work_struct *work)
 	__be16 buf[2];
 	int val[2];
 	unsigned char status;
+	int ret;
 
 	mutex_lock(&indio_dev->mlock);
 	if (st->state == AD5933_CTRL_INIT_START_FREQ) {
@@ -658,9 +659,9 @@ static void ad5933_work(struct work_struct *work)
 		return;
 	}
 
-	ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
+	ret = ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
 
-	if (status & AD5933_STAT_DATA_VALID) {
+	if (!ret && (status & AD5933_STAT_DATA_VALID)) {
 		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
 					       indio_dev->masklength);
 		ad5933_i2c_read(st->client,
-- 
2.7.0

