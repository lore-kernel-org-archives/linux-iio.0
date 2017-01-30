Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3278 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753462AbdA3Of0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 09:35:26 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/5] iio: adc: stm32: add dt option to set default trigger polarity
Date: Mon, 30 Jan 2017 15:33:57 +0100
Message-ID: <1485786840-4557-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC trigger polarity can be set to either rising, falling
or both edges. Add dt option to configure it.
Note: default value may be overridden later via trigger_polarity
sysfs attribute.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 9b49a6ad..be0e457 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -997,6 +997,13 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	of_property_read_u32(pdev->dev.of_node, "st,trigger-polarity",
+			     &adc->trigger_polarity);
+	if (adc->trigger_polarity >= ARRAY_SIZE(stm32_trig_pol_items)) {
+		dev_err(&pdev->dev, "Invalid st,trigger-polarity property\n");
+		return -EINVAL;
+	}
+
 	adc->irq = platform_get_irq(pdev, 0);
 	if (adc->irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-- 
1.9.1

