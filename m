Return-Path: <SRS0=HeX8=JJ=it-klinger.de=ak@kernel.org>
Date: Sat, 23 Jun 2018 20:54:47 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, linus.walleij@linaro.org,
	rdunlap@infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180623185447.GA17853@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

On a system with parasitic capacities it turned out that DOUT is not ready
after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
until DOUT has reached its correct value.

With this patch its now possible to wait until data is ready.

The wait time should not be higher than the maximum PD_SCK high time which
is corresponding to the datasheet 50000 ns.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 9430b54121e0..41e26ef324ee 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -97,6 +97,13 @@ struct hx711_data {
 	 * 2x32-bit channel + 64-bit timestamp
 	 */
 	u32			buffer[4];
+	/*
+	 * delay after a rising edge on SCK until the data is ready DOUT
+	 * this is dependent on the hx711 where the datasheet tells a
+	 * maximum value of 100 ns
+	 * but also on potential parasitic capacities on the wiring
+	 */
+	u32			data_ready_delay_ns;
 };
 
 static int hx711_cycle(struct hx711_data *hx711_data)
@@ -110,6 +117,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	preempt_disable();
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
+
+	/*
+	 * wait until DOUT is ready
+	 * it turned out that parasitic capacities are extending the time
+	 * until DOUT has reached it's value
+	 */
+	ndelay(hx711_data->data_ready_delay_ns);
+
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	/*
 	 * here we are not waiting for 0.2 us as suggested by the datasheet,
@@ -458,6 +473,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -530,6 +546,13 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->gain_set = 128;
 	hx711_data->gain_chan_a = 128;
 
+	ret = of_property_read_u32(np, "data-ready-delay-ns",
+					&hx711_data->data_ready_delay_ns);
+	if (ret < 0) {
+		dev_warn(dev, "data-ready-delay-ns not set - assuming 0 ns\n");
+		hx711_data->data_ready_delay_ns = 0;
+	}
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = "hx711";
-- 
2.1.4
