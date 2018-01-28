Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	davem@davemloft.net,
	hans.verkuil@cisco.com,
	mchehab@kernel.org,
	rask@formelder.dk,
	clabbe.montjoie@gmail.com,
	sean@mess.org,
	krzk@kernel.org,
	quentin.schulz@free-electrons.com,
	icenowy@aosc.io,
	edu.molinas@gmail.com,
	singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v2 05/16] iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
Date: Mon, 29 Jan 2018 00:29:08 +0100
Message-Id: <20180128232919.12639-6-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

For adding newer sensor some basic rework of the code is necessary.

The SoCs after H3 has newer thermal sensor ADCs, which have two clock
inputs (bus clock and sampling clock) and a reset. The registers are
also re-arranged.

This commit reworks the code, adds the process of the clocks and
resets.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index db57d9fffe48..51ec0104d678 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -22,6 +22,7 @@
  * shutdown for not being used.
  */
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -31,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/delay.h>
 
@@ -68,6 +70,9 @@ struct gpadc_data {
 	unsigned int	temp_data;
 	int		(*sample_start)(struct sun4i_gpadc_iio *info);
 	int		(*sample_end)(struct sun4i_gpadc_iio *info);
+	bool		has_bus_clk;
+	bool		has_bus_rst;
+	bool		has_mod_clk;
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -127,6 +132,9 @@ struct sun4i_gpadc_iio {
 	atomic_t			ignore_temp_data_irq;
 	const struct gpadc_data		*data;
 	bool				no_irq;
+	struct clk			*bus_clk;
+	struct clk			*mod_clk;
+	struct reset_control		*reset;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
@@ -420,6 +428,10 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
 
+	clk_disable(info->mod_clk);
+
+	clk_disable(info->bus_clk);
+
 	return info->data->sample_end(info);
 }
 
@@ -446,6 +458,10 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
 
+	clk_enable(info->mod_clk);
+
+	clk_enable(info->bus_clk);
+
 	return info->data->sample_start(info);
 }
 
@@ -560,10 +576,59 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (info->data->has_bus_rst) {
+		info->reset = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(info->reset)) {
+			ret = PTR_ERR(info->reset);
+			return ret;
+		}
+
+		ret = reset_control_deassert(info->reset);
+		if (ret)
+			return ret;
+	}
+
+	if (info->data->has_bus_clk) {
+		info->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(info->bus_clk)) {
+			ret = PTR_ERR(info->bus_clk);
+			goto assert_reset;
+		}
+
+		ret = clk_prepare_enable(info->bus_clk);
+		if (ret)
+			goto assert_reset;
+	}
+
+	if (info->data->has_mod_clk) {
+		info->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		if (IS_ERR(info->mod_clk)) {
+			ret = PTR_ERR(info->mod_clk);
+			goto disable_bus_clk;
+		}
+
+		/* Running at 6MHz */
+		ret = clk_set_rate(info->mod_clk, 4000000);
+		if (ret)
+			goto disable_bus_clk;
+
+		ret = clk_prepare_enable(info->mod_clk);
+		if (ret)
+			goto disable_bus_clk;
+	}
+
 	if (IS_ENABLED(CONFIG_THERMAL_OF))
 		info->sensor_device = &pdev->dev;
 
 	return 0;
+
+disable_bus_clk:
+	clk_disable_unprepare(info->bus_clk);
+
+assert_reset:
+	reset_control_assert(info->reset);
+
+	return ret;
 }
 
 static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
@@ -729,6 +794,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!info->no_irq)
 		iio_map_array_unregister(indio_dev);
 
+	clk_disable_unprepare(info->mod_clk);
+
+	clk_disable_unprepare(info->bus_clk);
+
+	reset_control_assert(info->reset);
+
 	return 0;
 }
 
-- 
2.11.0
