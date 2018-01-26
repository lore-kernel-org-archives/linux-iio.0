Return-Path: <SRS0=NR6Q=EV=gmail.com=embed3d@kernel.org>
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
Subject: [PATCH 09/16] iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
Date: Fri, 26 Jan 2018 16:19:34 +0100
Message-Id: <20180126151941.12183-10-embed3d@gmail.com>
In-Reply-To: <20180126151941.12183-1-embed3d@gmail.com>
References: <20180126151941.12183-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the H3 ths sensor.

The H3 supports interrupts. The interrupt is configured to update the
the sensor values every second. The calibration data is writen at the
begin of the init process.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 77e07f042730..f2e0ec65c53e 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -145,6 +145,31 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.support_irq = false,
 };
 
+static const struct gpadc_data sun8i_h3_ths_data = {
+	.temp_offset = -1791,
+	.temp_scale = -121,
+	.temp_data = {SUNXI_THS_TDATA0, 0, 0, 0},
+	.sample_start = sunxi_ths_sample_start,
+	.sample_end = sunxi_ths_sample_end,
+	.has_bus_clk = true,
+	.has_bus_rst = true,
+	.has_mod_clk = true,
+	.sensor_count = 1,
+	.supports_nvmem = true,
+	.support_irq = true,
+	.ctrl0_map = SUNXI_THS_ACQ0(0xff),
+	.ctrl2_map = SUNXI_THS_ACQ1(0x3f),
+	.sensor_en_map = SUNXI_THS_TEMP_SENSE_EN0,
+	.filter_map = SUNXI_THS_FILTER_EN |
+		SUNXI_THS_FILTER_TYPE(0x2),
+	.irq_clear_map = SUNXI_THS_INTS_ALARM_INT_0 |
+			SUNXI_THS_INTS_SHUT_INT_0   |
+			SUNXI_THS_INTS_TDATA_IRQ_0  |
+			SUNXI_THS_INTS_ALARM_OFF_0,
+	.irq_control_map = SUNXI_THS_INTC_TDATA_IRQ_EN0 |
+		SUNXI_THS_TEMP_PERIOD(0x7),
+};
+
 struct sun4i_gpadc_iio {
 	struct iio_dev			*indio_dev;
 	struct completion		completion;
@@ -643,6 +668,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-ths",
+		.data = &sun8i_h3_ths_data,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.11.0
