Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4A2C77B7A
	for <linux-iio@archiver.kernel.org>; Thu, 25 May 2023 21:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbjEYV2n (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 25 May 2023 17:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjEYV2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 May 2023 17:28:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41255E66;
        Thu, 25 May 2023 14:28:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB18F6606E81;
        Thu, 25 May 2023 22:28:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685050107;
        bh=j2qbhtUEhsYOgwB5yEuSREejgg5NYmlmpVBBc3uuqiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUZxTVmHdiID1uTSssQoOF+AGu9yXAC7WYp7yUjlGKRmfwNX4Zg6P2xW1uEQ9FEIM
         0BqfDvFHJj1LfUySw8fmRQh6Hhm3neBnA7/m8QQ1woP/z1WfX2wOsjURNWl94FuiPZ
         vMQfDNeng/gK2OmVzgpOLjAWNzXMdKPndXMBMJ2NP9M+DCdk6AXvHuwlvLLVC8lXED
         1PLba8uIjf5JeMFpF7kvPT6ekxCszbVajbYQYMSU1ksUmQplvtPPDVNwrdyN/qjtx5
         0YrHrUq1yprxQwSSIEvQRTsadloOSmVBJ2q/D7eVIjucrotIBJx5x0yfdKeVEIyW/X
         xllO5CBBuKbYw==
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
Subject: [PATCH v2 5/8] iio: adc: rockchip_saradc: Match alignment with open parenthesis
Date:   Fri, 26 May 2023 02:57:09 +0530
Message-Id: <20230525212712.255406-6-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525212712.255406-1-shreeya.patel@collabora.com>
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Match alignment with open parenthesis for improving the code
readability.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2
  - Add a Reviewed-by tag.

 drivers/iio/adc/rockchip_saradc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1a5790264ec1..ede929d9bca0 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -150,7 +150,7 @@ static void rockchip_saradc_power_down(struct rockchip_saradc *info)
 }
 
 static int rockchip_saradc_conversion(struct rockchip_saradc *info,
-				   struct iio_chan_spec const *chan)
+				      struct iio_chan_spec const *chan)
 {
 	reinit_completion(&info->completion);
 
@@ -393,8 +393,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 }
 
 static int rockchip_saradc_volt_notify(struct notifier_block *nb,
-						   unsigned long event,
-						   void *data)
+				       unsigned long event, void *data)
 {
 	struct rockchip_saradc *info =
 			container_of(nb, struct rockchip_saradc, nb);
-- 
2.30.2

