Return-Path: <SRS0=EFIe=A6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139DC433EC
	for <linux-iio@archiver.kernel.org>; Sun, 19 Jul 2020 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264952073A
	for <linux-iio@archiver.kernel.org>; Sun, 19 Jul 2020 20:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGSUyU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 19 Jul 2020 16:54:20 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:32909 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGSUyS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2020 16:54:18 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D78A0FF805;
        Sun, 19 Jul 2020 20:54:14 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v9 2/5] IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
Date:   Sun, 19 Jul 2020 22:53:04 +0200
Message-Id: <20200719205307.87385-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200719205307.87385-1-contact@artur-rojek.eu>
References: <20200719205307.87385-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide an of_xlate callback in order to retrieve the correct channel
specifier index from the IIO channels array.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

 Changes:

 v2-v9: no change

 drivers/iio/adc/ingenic-adc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 059c2573e4a9..a742724fa7e6 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -401,6 +401,21 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 	}
 }
 
+static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
+				const struct of_phandle_args *iiospec)
+{
+	int i;
+
+	if (!iiospec->args_count)
+		return -EINVAL;
+
+	for (i = 0; i < iio_dev->num_channels; ++i)
+		if (iio_dev->channels[i].channel == iiospec->args[0])
+			return i;
+
+	return -EINVAL;
+}
+
 static void ingenic_adc_clk_cleanup(void *data)
 {
 	clk_unprepare(data);
@@ -410,6 +425,7 @@ static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
 	.read_avail = ingenic_adc_read_avail,
+	.of_xlate = ingenic_adc_of_xlate,
 };
 
 static const struct iio_chan_spec ingenic_channels[] = {
-- 
2.27.0

