Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE646C04A94
	for <linux-iio@archiver.kernel.org>; Sat, 12 Aug 2023 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjHLLyx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Aug 2023 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLLyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 07:54:52 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C5B127;
        Sat, 12 Aug 2023 04:54:55 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176442322"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2023 20:54:54 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AF56B41D4E36;
        Sat, 12 Aug 2023 20:54:51 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Crt Mori <cmo@melexis.com>, Marek Vasut <marex@denx.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/2] Use i2c_get_match_data() for mcp4725 DAC
Date:   Sat, 12 Aug 2023 12:54:47 +0100
Message-Id: <20230812115449.89942-1-biju.das.jz@bp.renesas.com>
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

Biju Das (2):
  iio: dac: mcp4725: Replace variable 'id' from struct mcp4725_data
  iio: dac: mcp4725: Use i2c_get_match_data()

 drivers/iio/dac/mcp4725.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.25.1

