Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43814 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeDMQiP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:38:15 -0400
Received: by mail-qk0-f196.google.com with SMTP id v2so9707688qkh.10
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:38:15 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 06/14] staging: iio: ad7746: Reorder variable declarations
Date: Fri, 13 Apr 2018 13:36:43 -0300
Message-Id: <1523637411-8531-7-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reorder some variable declarations in an inverse-pyramid scheme.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 9ef476a..f53612a 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -220,8 +220,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan)
 {
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, delay, idx;
 	u8 vt_setup, cap_setup;
+	int ret, delay, idx;
 
 	switch (chan->type) {
 	case IIO_CAPACITANCE:
@@ -289,8 +289,8 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	bool doit;
 	int ret, timeout = 10;
+	bool doit;
 
 	ret = strtobool(buf, &doit);
 	if (ret < 0)
@@ -680,8 +680,8 @@ static int ad7746_probe(struct i2c_client *client,
 	struct ad7746_platform_data *pdata = client->dev.platform_data;
 	struct ad7746_chip_info *chip;
 	struct iio_dev *indio_dev;
-	int ret = 0;
 	unsigned char regval = 0;
+	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
-- 
2.7.4

