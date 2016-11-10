Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50644 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755152AbcKJJ02 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:28 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 26/28] staging: iio: tsl2583: remove unnecessary variable initialization
Date: Thu, 10 Nov 2016 04:26:02 -0500
Message-Id: <1478769964-7065-27-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ret variable in tsl2583_suspend() and tsl2583_resume() was
initialized to 0. This is not necessary so this patch removes the
initialization.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index b5ebe31..13cf88a 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -845,7 +845,7 @@ static int __maybe_unused tsl2583_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -861,7 +861,7 @@ static int __maybe_unused tsl2583_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&chip->als_mutex);
 
-- 
2.7.4

