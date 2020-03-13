Return-Path: <SRS0=K2ZU=46=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA9C5ACC2
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C102074E
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgCMKuC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:50:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:41875 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgCMKuB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="442379998"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 03:49:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D9BC64A9; Fri, 13 Mar 2020 12:49:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/8] iio: humidity: hts221: Use dev_get_platdata() to get platform_data
Date:   Fri, 13 Mar 2020 12:49:53 +0200
Message-Id: <20200313104955.30423-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use dev_get_platdata() to get the platform_data instead of
referencing it directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/iio/humidity/hts221_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 81d50a861c22..5f142a44c1dd 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -74,10 +74,10 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
 
 int hts221_allocate_trigger(struct hts221_hw *hw)
 {
+	struct st_sensors_platform_data *pdata = dev_get_platdata(hw->dev);
 	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
 	bool irq_active_low = false, open_drain = false;
 	struct device_node *np = hw->dev->of_node;
-	struct st_sensors_platform_data *pdata;
 	unsigned long irq_type;
 	int err;
 
@@ -106,7 +106,6 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 	if (err < 0)
 		return err;
 
-	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
 	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
 	    (pdata && pdata->open_drain)) {
 		irq_type |= IRQF_SHARED;
-- 
2.25.1

