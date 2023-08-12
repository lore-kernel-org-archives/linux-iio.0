Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A34C41513
	for <linux-iio@archiver.kernel.org>; Sat, 12 Aug 2023 06:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjHLG5u (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Aug 2023 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLG5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 02:57:49 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B842728;
        Fri, 11 Aug 2023 23:57:48 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="172746827"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2023 15:57:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4B3944174399;
        Sat, 12 Aug 2023 15:57:44 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/2] Use i2c_get_match_data() for yamaha-yas530
Date:   Sat, 12 Aug 2023 07:57:39 +0100
Message-Id: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use i2c_get_match_data() to get match data for I2C, ACPI and DT-based
matching instead of device_get_match_data() the one for ACPI/DT-based
matching.

This patch series is only compile tested.

v1->v2:
 * Created separate patch for dropping enum chip_ids 

Biju Das (2):
  iio: magnetometer: yamaha-yas530: Use i2c_get_match_data()
  iio: magnetometer: yamaha-yas530: Drop enum chip_ids

 drivers/iio/magnetometer/yamaha-yas530.c | 150 +++++++++++------------
 1 file changed, 71 insertions(+), 79 deletions(-)

-- 
2.25.1

