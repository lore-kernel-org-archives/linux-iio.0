Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>
Subject: [PATCH v1 1/2] iio:iio-interrupt-trigger: device-tree support
Date: Fri, 19 Feb 2016 20:18:43 +0100
Message-ID: <d8f7902dbfe6e911e6ac0d1117502a02b1212022.1455908065.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455908065.git.gregor.boirie@parrot.com>
References: <cover.1455908065.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

From: Grégor Boirie <gregor.boirie@parrot.com>

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/trigger/iio-trig-interrupt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 572bc6f..3c4e18f 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -104,11 +104,20 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id iio_interrupt_trigger_of_match[] = {
+	{ .compatible = "iio-interrupt-trigger" },
+	{}
+};
+#endif
+
 static struct platform_driver iio_interrupt_trigger_driver = {
 	.probe = iio_interrupt_trigger_probe,
 	.remove = iio_interrupt_trigger_remove,
 	.driver = {
-		.name = "iio_interrupt_trigger",
+		.name           = "iio_interrupt_trigger",
+		.owner          = THIS_MODULE,
+		.of_match_table = of_match_ptr(iio_interrupt_trigger_of_match)
 	},
 };
 
-- 
2.1.4
