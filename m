Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C635C001B0
	for <linux-iio@archiver.kernel.org>; Sun, 16 Jul 2023 17:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGPRwh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Jul 2023 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjGPRwh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 13:52:37 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1791E64;
        Sun, 16 Jul 2023 10:52:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,211,1684767600"; 
   d="scan'208";a="172947666"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jul 2023 02:52:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 31AA1400941A;
        Mon, 17 Jul 2023 02:52:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
Date:   Sun, 16 Jul 2023 18:52:18 +0100
Message-Id: <20230716175218.130557-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
_data() as we have similar I2C and DT-based matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/potentiometer/mcp4018.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 89daecc90305..a5d902845a1c 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -157,9 +157,9 @@ static int mcp4018_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->cfg = device_get_match_data(dev);
+	data->cfg = i2c_get_match_data(dev);
 	if (!data->cfg)
-		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
+		return -ENODEV;
 
 	indio_dev->info = &mcp4018_info;
 	indio_dev->channels = &mcp4018_channel;
-- 
2.25.1

