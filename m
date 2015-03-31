Return-Path: <vigneshr@ti.com>
From: Vignesh R <vigneshr@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Karol Wrona <k.wrona@samsung.com>,
        Jan Kardell
	<jan.kardell@telliq.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <fcooper@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] iio: adc: ti_am335x_adc: refactor DT parsing into a function
Date: Tue, 31 Mar 2015 16:42:36 +0530
Message-ID: <1427800357-21680-2-git-send-email-vigneshr@ti.com>
In-Reply-To: <1427800357-21680-1-git-send-email-vigneshr@ti.com>
References: <1427800357-21680-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Refactor DT parsing into a separate function from probe() to
help addition of more DT parameters later.

No functional changes.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 2e5cc4409f78..2f818405ffbe 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -396,16 +396,30 @@ static const struct iio_info tiadc_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static int tiadc_parse_dt(struct platform_device *pdev,
+			  struct tiadc_device *adc_dev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct property *prop;
+	const __be32 *cur;
+	int channels = 0;
+	u32 val;
+
+	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+		adc_dev->channel_line[channels] = val;
+		channels++;
+	}
+
+	adc_dev->channels = channels;
+	return 0;
+}
+
 static int tiadc_probe(struct platform_device *pdev)
 {
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
 	struct device_node	*node = pdev->dev.of_node;
-	struct property		*prop;
-	const __be32		*cur;
 	int			err;
-	u32			val;
-	int			channels = 0;
 
 	if (!node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -421,12 +435,7 @@ static int tiadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 
 	adc_dev->mfd_tscadc = ti_tscadc_dev_get(pdev);
-
-	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
-		adc_dev->channel_line[channels] = val;
-		channels++;
-	}
-	adc_dev->channels = channels;
+	tiadc_parse_dt(pdev, adc_dev);
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.9.1
