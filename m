Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55904 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966858AbcKLSTy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:54 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 24/26] staging: iio: tsl2583: remove unnecessary variable initialization
Date: Sat, 12 Nov 2016 13:19:39 -0500
Message-Id: <1478974781-1457-25-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
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
index 712f753..b787952 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -849,7 +849,7 @@ static int __maybe_unused tsl2583_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -865,7 +865,7 @@ static int __maybe_unused tsl2583_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&chip->als_mutex);
 
-- 
2.7.4

