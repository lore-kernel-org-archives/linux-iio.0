Return-Path: <SRS0=K2ZU=46=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B3C10DCE
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FF20724
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCMKuA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:50:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:41875 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgCMKuA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="442379991"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 03:49:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5E11377; Fri, 13 Mar 2020 12:49:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/8] iio: st_sensors: Drop unneeded casting when print error code
Date:   Fri, 13 Mar 2020 12:49:51 +0200
Message-Id: <20200313104955.30423-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 286830fb5d35..b400560bac93 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -49,8 +49,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_i2c(client, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap (%ld)\n",
+			PTR_ERR(sdata->regmap));
 		return PTR_ERR(sdata->regmap);
 	}
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index dcbdef4a77f8..ee70515bb89f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -101,8 +101,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_spi(spi, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap (%ld)\n",
+			PTR_ERR(sdata->regmap));
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.25.1

