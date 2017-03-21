Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33289 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933124AbdCUQKh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:10:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id p189so17108455pfp.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:10:36 -0700 (PDT)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [RESEND PATCH] staging: ade7754: Replace mlock with buf_lock and refactor code
Date: Tue, 21 Mar 2017 21:31:41 +0530
Message-Id: <1490112101-30192-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes. Replace it with buf_lock in the devices global data.

As buf_lock already protects operations in ade7754_write_frequency,
there isn't a need to acquire the lock inside ade7754_spi_write_reg_8
when writing to the register.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
 drivers/staging/iio/meter/ade7754.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 024463a..eb03469 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -29,6 +29,15 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7754_state *st = iio_priv(indio_dev);
 
+	if (reg_address == ADE7754_WAVMODE) {
+		st->tx[0] = ADE7754_WRITE_REG(reg_address);
+		st->tx[1] = val;
+
+		ret = spi_write(st->us, st->tx, 2);
+
+		return ret;
+	}
+
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7754_WRITE_REG(reg_address);
 	st->tx[1] = val;
@@ -430,7 +439,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->buf_lock);
 
 	t = 26000 / val;
 	if (t > 0)
@@ -451,7 +460,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
-- 
2.7.4

