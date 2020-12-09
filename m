Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2EC4361B
	for <linux-iio@archiver.kernel.org>; Wed,  9 Dec 2020 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35C223BC7
	for <linux-iio@archiver.kernel.org>; Wed,  9 Dec 2020 23:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgLIXuJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:50:09 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39019 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgLIXt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 18:49:56 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 122A2C0008;
        Wed,  9 Dec 2020 23:49:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 6/6] iio:pressure:ms5637: add ms5803 support
Date:   Thu, 10 Dec 2020 00:48:57 +0100
Message-Id: <20201209234857.1521453-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ms5803 is very similar to the ms5805 but has less resolution options
and has the 128bit PROM layout.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 drivers/iio/pressure/ms5637.c                          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ab623ba930d5..84b0e44235c1 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -132,6 +132,8 @@ properties:
           - mcube,mc3230
             # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6225
+            # Measurement Specialities I2C pressure and temperature sensor
+          - meas,ms5803
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 2943b88734b3..39830a51ca78 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -192,8 +192,15 @@ static const struct ms_tp_hw_data ms5637_hw_data  = {
 	.max_res_index = 5
 };
 
+static const struct ms_tp_hw_data ms5803_hw_data  = {
+	.prom_len = 8,
+	.max_res_index = 4
+};
+
 static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
 
+static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
+
 static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
 
 static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
@@ -205,6 +212,7 @@ static const struct ms_tp_data ms8607_data = {
 
 static const struct of_device_id ms5637_of_match[] = {
 	{ .compatible = "meas,ms5637", .data = &ms5637_data },
+	{ .compatible = "meas,ms5803", .data = &ms5803_data },
 	{ .compatible = "meas,ms5805", .data = &ms5805_data },
 	{ .compatible = "meas,ms5837", .data = &ms5837_data },
 	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
-- 
2.28.0

