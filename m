Return-Path: <hns@goldelico.com>
Subject: [PATCH v2 2/3] iio:adc:palmas: add DT support
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <cover.1443973837.git.hns@goldelico.com>
Date: Sun, 4 Oct 2015 18:05:59 +0200
Cc: devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Grazvydas Ignotas <notasas@gmail.com>
Message-Id: <6C211191-87B8-4444-ADA7-8BE454C2B3D3@goldelico.com>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com> <cover.1443973837.git.hns@goldelico.com>
To: Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@arm.linux.org.uk>,
 Marek Belisko <marek@goldelico.com>,
 Pradeep Goudagunta <pgoudagunta@nvidia.com>,
 Nikolaus Schaller <hns@goldelico.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 gg@slimlogic.co.uk,
 jic23@jic23.retrosnub.co.uk
List-ID: <linux-iio@vger.kernel.org>

From: Marek Belisko <marek@goldelico.com>

Code was found at:
=
https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6e7abcc=
bdf9d730b36270%5E%21/#F1

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
[Fixed minor typos + add channels list to documentation]
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
.../devicetree/bindings/iio/adc/palmas-gpadc.txt   | 46 =
+++++++++++++++++++
drivers/iio/adc/palmas_gpadc.c                     | 52 =
+++++++++++++++++++---
2 files changed, 93 insertions(+), 5 deletions(-)
create mode 100644 =
Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt =
b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
new file mode 100644
index 0000000..2149afe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
@@ -0,0 +1,46 @@
+* Palmas general purpose ADC IP block devicetree bindings
+
+Channels list:
+	0 battery type
+	1 battery temp NTC (optional current source)
+	2 GP
+	3 temp (with ext. diode, optional current source)
+	4 GP
+	5 GP
+	6 VBAT_SENSE
+	7 VCC_SENSE
+	8 Backup Battery voltage
+	9 external charger (VCHG)
+	10 VBUS
+	11 DC-DC current probe (how does this work?)
+	12 internal die temp
+	13 internal die temp
+	14 USB ID pin voltage
+	15 test network
+
+Required properties:
+- compatible : Must be "ti,palmas-gpadc".
+
+Optional sub-nodes:
+ti,channel0-current-microamp: Channel 0 current in uA.
+	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
+ti,channel3-current-microamp: Channel 3 current in uA.
+	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
+ti,enable-extended-delay: Enable extended delay.
+
+Example:
+
+pmic {
+	compatible =3D "ti,twl6035-pmic", "ti,palmas-pmic";
+	...
+	gpadc {
+		compatible =3D "ti,palmas-gpadc";
+		interrupts =3D <18 0
+			      16 0
+			      17 0>;
+		ti,channel0-current-microamp =3D <5>;
+		ti,channel3-current-microamp =3D <10>;
+		};
+	};
+	...
+};
diff --git a/drivers/iio/adc/palmas_gpadc.c =
b/drivers/iio/adc/palmas_gpadc.c
index 6805d81..1297c81 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -21,6 +21,8 @@
#include <linux/pm.h>
#include <linux/mfd/palmas.h>
#include <linux/completion.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
#include <linux/iio/iio.h>
#include <linux/iio/machine.h>
#include <linux/iio/driver.h>
@@ -460,6 +462,34 @@ static const struct iio_chan_spec =
palmas_gpadc_iio_channel[] =3D {
	PALMAS_ADC_CHAN_IIO(IN15, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
};

+static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
+	struct palmas_gpadc_platform_data **gpadc_pdata)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct palmas_gpadc_platform_data *gp_data;
+	int ret;
+	u32 pval;
+
+	gp_data =3D devm_kzalloc(&pdev->dev, sizeof(*gp_data), =
GFP_KERNEL);
+	if (!gp_data)
+		return -ENOMEM;
+
+	ret =3D of_property_read_u32(np, "ti,channel0-current-microamp", =
&pval);
+	if (!ret)
+		gp_data->ch0_current =3D pval;
+
+	ret =3D of_property_read_u32(np, "ti,channel3-current-microamp", =
&pval);
+	if (!ret)
+		gp_data->ch3_current =3D pval;
+
+	gp_data->extended_delay =3D of_property_read_bool(np,
+					"ti,enable-extended-delay");
+
+	*gpadc_pdata =3D gp_data;
+
+	return 0;
+}
+
static int palmas_gpadc_probe(struct platform_device *pdev)
{
	struct palmas_gpadc *adc;
@@ -469,12 +499,17 @@ static int palmas_gpadc_probe(struct =
platform_device *pdev)
	int ret, i;

	pdata =3D dev_get_platdata(pdev->dev.parent);
-	if (!pdata || !pdata->gpadc_pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		return -ENODEV;
-	}

-	gpadc_pdata =3D pdata->gpadc_pdata;
+	if (pdata && pdata->gpadc_pdata)
+		gpadc_pdata =3D pdata->gpadc_pdata;
+
+	if (!gpadc_pdata && pdev->dev.of_node) {
+		ret =3D palmas_gpadc_get_adc_dt_data(pdev, =
&gpadc_pdata);
+		if (ret < 0)
+			return ret;
+	}
+	if (!gpadc_pdata)
+		return -EINVAL;

	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
	if (!indio_dev) {
@@ -790,6 +825,12 @@ static const struct dev_pm_ops palmas_pm_ops =3D {
				palmas_gpadc_resume)
};

+static const struct of_device_id of_palmas_gpadc_match_tbl[] =3D {
+	{ .compatible =3D "ti,palmas-gpadc", },
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
+
static struct platform_driver palmas_gpadc_driver =3D {
	.probe =3D palmas_gpadc_probe,
	.remove =3D palmas_gpadc_remove,
@@ -797,6 +838,7 @@ static struct platform_driver palmas_gpadc_driver =3D =
{
		.name =3D MOD_NAME,
		.owner =3D THIS_MODULE,
		.pm =3D &palmas_pm_ops,
+		.of_match_table =3D of_palmas_gpadc_match_tbl,
	},
};

--=20
2.5.1
