Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39237 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeCEHuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Mar 2018 02:50:18 -0500
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 06/11] Staging: iio: accel: Reverse christmas tree
Date: Mon,  5 Mar 2018 13:19:25 +0530
Message-Id: <1520236170-14668-7-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Prefer reverse christmas tree ordering of declarations to improve
readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 476b1c3..907fb85 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -243,9 +243,9 @@ static const struct adis_data adis16201_data = {
 
 static int adis16201_probe(struct spi_device *spi)
 {
-	int ret;
-	struct adis *st;
 	struct iio_dev *indio_dev;
+	struct adis *st;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.7.4

