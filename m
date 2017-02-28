Return-Path: <SRS0=u7RT=2J=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>,
        =?UTF-8?q?Gr=C3=A9gor=20Boirie?=
	<gregor.boirie@parrot.com>
Subject: [PATCH v3 4/6] iio: iio-interrupt-trigger: device-tree support
Date: Tue, 28 Feb 2017 17:51:17 +0100
Message-ID: <1488300679-3259-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

From: Grégor Boirie <gregor.boirie@parrot.com>

Add compatible string that should be used in DT.
Also cascade of_node to newly allocated trigger device.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Original PATCH from Gregor Boirie:
https://marc.info/?l=linux-iio&m=145590953607905&w=4

Updates:
- compatible string changed to "interrupt-trigger"
- cascade of_node down to iio trigger device
---
 drivers/iio/trigger/iio-trig-interrupt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index e18f12b..6ee1f7e 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -62,6 +62,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 	}
 	iio_trigger_set_drvdata(trig, trig_info);
 	trig_info->irq = irq;
+	trig->dev.of_node = pdev->dev.of_node;
 	trig->ops = &iio_interrupt_trigger_ops;
 	ret = request_irq(irq, iio_interrupt_trigger_poll,
 			  irqflags, trig->name, trig);
@@ -104,11 +105,20 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id iio_interrupt_trigger_of_match[] = {
+	{ .compatible = "interrupt-trigger" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, iio_interrupt_trigger_of_match);
+#endif
+
 static struct platform_driver iio_interrupt_trigger_driver = {
 	.probe = iio_interrupt_trigger_probe,
 	.remove = iio_interrupt_trigger_remove,
 	.driver = {
 		.name = "iio_interrupt_trigger",
+		.of_match_table = of_match_ptr(iio_interrupt_trigger_of_match),
 	},
 };
 
-- 
1.9.1
