Return-Path: <SRS0=7Lrc=3V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8874C33CB3
	for <linux-iio@archiver.kernel.org>; Sat,  1 Feb 2020 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F59E2067C
	for <linux-iio@archiver.kernel.org>; Sat,  1 Feb 2020 18:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBASBV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:01:21 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:53986 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgBASBV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 13:01:21 -0500
Received: from localhost.localdomain (silversquare.silversquare.eu [185.174.184.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A34F4251F6;
        Sat,  1 Feb 2020 19:01:18 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 1/7] dt-bindings: iio: light: add support for Dyna-Image AL3320A
Date:   Sat,  1 Feb 2020 19:00:20 +0100
Message-Id: <20200201180024.328700-4-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201180024.328700-1-david@ixit.cz>
References: <20200201180024.328700-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Subject: [PATCH v3 3/7] iio: light: al3320a slightly improve code formatting

Modified to be in part with al3010 driver.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index a21aa99e74e4..613830b7df6e 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -38,6 +38,11 @@
 
 #define AL3320A_GAIN_SHIFT		1
 #define AL3320A_GAIN_MASK		(BIT(2) | BIT(1))
+#define AL3320A_GAIN_READ(g) \
+	(((g) & AL3320A_GAIN_MASK) >> AL3320A_GAIN_SHIFT)
+#define AL3320A_GAIN_WRITE(g) \
+	(((g) << AL3320A_GAIN_SHIFT) & AL3320A_GAIN_MASK)
+
 
 /* chip params default values */
 #define AL3320A_DEFAULT_MEAN_TIME	4
@@ -90,7 +95,7 @@ static int al3320a_init(struct al3320a_data *data)
 		return ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
-					AL3320A_RANGE_3 << AL3320A_GAIN_SHIFT);
+					AL3320A_GAIN_WRITE(AL3320A_RANGE_3));
 	if (ret < 0)
 		return ret;
 
@@ -133,7 +138,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		ret = (ret & AL3320A_GAIN_MASK) >> AL3320A_GAIN_SHIFT;
+		ret = AL3320A_GAIN_READ(ret);
 		*val = al3320a_scales[ret][0];
 		*val2 = al3320a_scales[ret][1];
 
@@ -152,11 +157,13 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (i = 0; i < ARRAY_SIZE(al3320a_scales); i++) {
-			if (val == al3320a_scales[i][0] &&
-			    val2 == al3320a_scales[i][1])
-				return i2c_smbus_write_byte_data(data->client,
-					AL3320A_REG_CONFIG_RANGE,
-					i << AL3320A_GAIN_SHIFT);
+			if (val != al3320a_scales[i][0] ||
+			    val2 != al3320a_scales[i][1])
+				continue;
+
+			return i2c_smbus_write_byte_data(data->client,
+						AL3320A_REG_CONFIG_RANGE,
+						AL3320A_GAIN_WRITE(i));
 		}
 		break;
 	}
-- 
2.25.0

