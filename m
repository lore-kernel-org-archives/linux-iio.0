Return-Path: <SRS0=K2ZU=46=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCEAC2BB1D
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4AB2074D
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgCMKt7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:49:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:5285 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgCMKt7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 06:49:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="266689347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 03:49:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A653E1C9; Fri, 13 Mar 2020 12:49:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/8] iio: light: st_uvis25: Drop unneeded casting when print error code
Date:   Fri, 13 Mar 2020 12:49:48 +0200
Message-Id: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Explicit casting in printf() usually shows that something is not okay.
Here, we really don't need it by providing correct specifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 drivers/iio/light/st_uvis25_i2c.c | 4 ++--
 drivers/iio/light/st_uvis25_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 4889bbeb0c73..400724069d19 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -31,8 +31,8 @@ static int st_uvis25_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &st_uvis25_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index a9ceae4f58b3..cd3761a3ee3f 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -31,8 +31,8 @@ static int st_uvis25_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &st_uvis25_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-- 
2.25.1

