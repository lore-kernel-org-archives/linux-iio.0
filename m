Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD80C7EE2F
	for <linux-iio@archiver.kernel.org>; Thu, 25 May 2023 21:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjEYV2d (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 25 May 2023 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjEYV2c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 May 2023 17:28:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C877E58;
        Thu, 25 May 2023 14:28:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6140C6601F54;
        Thu, 25 May 2023 22:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685050101;
        bh=7hciE8XoQj7YqlZBospZkfZLJzFdMH510lvKyu7BdNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF0qvBDPNvxoe16vml3vZK/8BatpX4/GsrtRd3QOH/jD1xufqG2yBD7FFWze7l1NK
         ngN34u7iM26d6UurhdFCBGS/KtTyUPFVGysd+qIlj9kZH4amPZuReUotzwENmWg08E
         TQNZAEBHslxP0Xo21v0FoLSiaZiEAUijpZsS+vreK/K1Zvsu6ZVMNvDYRUuUAAJjfJ
         k9X0Fu4yza4WvjOUY1QhqVanVn06opgwniw7kJ8XywWzzWEu5elkrm2dtrmouvnoNI
         H1d2Ko6fiLjHtcUOxuGxN0y0sdMFwjRlER9NWtj+fPgbz8F3Yh549tmEnWP6ZSTTZR
         rQ15X7TtjtufQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 4/8] iio: adc: rockchip_saradc: Use of_device_get_match_data
Date:   Fri, 26 May 2023 02:57:08 +0530
Message-Id: <20230525212712.255406-5-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525212712.255406-1-shreeya.patel@collabora.com>
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2
  - Add a Reviewed-by tag.

 drivers/iio/adc/rockchip_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 41226b76a995..1a5790264ec1 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -414,10 +414,10 @@ static void rockchip_saradc_regulator_unreg_notifier(void *data)
 
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
+	const struct rockchip_saradc_data *match_data;
 	struct rockchip_saradc *info = NULL;
 	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev = NULL;
-	const struct of_device_id *match;
 	int ret;
 	int irq;
 
@@ -431,13 +431,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	}
 	info = iio_priv(indio_dev);
 
-	match = of_match_device(rockchip_saradc_match, &pdev->dev);
-	if (!match) {
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data) {
 		dev_err(&pdev->dev, "failed to match device\n");
 		return -ENODEV;
 	}
 
-	info->data = match->data;
+	info->data = match_data;
 
 	/* Sanity check for possible later IP variants with more channels */
 	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
-- 
2.30.2

