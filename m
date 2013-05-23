Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <dan.carpenter@oracle.com>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 4/4] iio: frequency: adf4350: Add support for dt bindings
Date: Thu, 23 May 2013 17:00:59 +0200
Message-ID: <1369321259-14602-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1369321259-14602-1-git-send-email-michael.hennerich@analog.com>
References: <1369321259-14602-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../devicetree/bindings/iio/frequency/adf4350.txt  |   84 ++++++++++++++
 drivers/iio/frequency/adf4350.c                    |  122 +++++++++++++++++++-
 2 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4350.txt

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4350.txt b/Documentation/devicetree/bindings/iio/frequency/adf4350.txt
new file mode 100644
index 0000000..ab99cfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4350.txt
@@ -0,0 +1,84 @@
+Analog Devices ADF4350/ADF4351 device driver
+
+Required properties:
+	- compatible: Should be one of
+		* "adi,adf4350": When using the ADF4350 device
+		* "adi,adf4351": When using the ADF4351 device
+	- reg: SPI chip select numbert for the device
+	- spi-max-frequency: Max SPI frequency to use (< 20000000)
+	- clocks: From common clock binding. Clock is phandle to clock for
+		ADF435x Reference Clock (CLKIN).
+
+Optional properties:
+	- adi,channel-spacing: Channel spacing in Hz (influences MODULUS).
+	- adi,power-up-frequency:	If set in Hz the PLL tunes to
+			the desired frequency on probe.
+	- adi,ref-div-factor: If set the driver skips dynamic calculation
+			and uses this default value instead.
+	- adi,ref-doubler-en: Enables reference doubler.
+	- adi,ref-div2-en: Enables reference divider.
+	- adi,gpio-lock-detect:	If set with a valid GPIO number, pll lock state
+			is tested upon read.
+	- adi,reg2-pd-polarity-pos-en: Enables positive phase
+			detector polarity. Default = negative.
+	- adi,reg2-ldp-6ns-en: Enables 6ns lock detect precision.
+			Default = 10ns.
+	- adi,reg2-ldf-int-n-en: Enables lock detect for integer-N mode.
+			Default = factional-N mode.
+	- adi,reg2-charge-pump-curr-ua: Charge pump current in mA.
+			Default = 2500mA.
+	- adi,reg2-muxout: On chip multiplexer output selection.
+			Valid values for the multiplexer output are:
+			0: Three-State Output (default)
+			1: DVDD
+			2: DGND
+			3: R-Counter output
+			4: N-Divider output
+			5: Analog lock detect
+			6: Digital lock detect
+	- adi,reg2-noise-mode: Enables low noise mode. Default = Low spur mode.
+	- adi,reg3-csr-en: Enables cycle slip reduction.
+	- adi,reg3-charge-cancellation-en: Enabled charge pump
+			charge cancellation for integer-N modes.
+	- adi,reg3-anti-backlash-3ns-en: Enables 3ns antibacklash pulse width
+			 for integer-N modes.
+	- adi,reg3-band-sel-clock-mode-high-en: Enables faster band selection logic.
+	- adi,reg3-12bit-clkdiv: Clock divider value used when
+			adi,reg3-12bit-clkdiv-mode != 0
+	- adi,reg3-12bit-clkdiv-mode:
+			Valid values for the clkdiv mode are:
+			0: Clock divider off (default)
+			1: Fast lock enable
+			2: Phase resync enable
+	- adi,reg4-aux-output-en: Enables auxiliary RF output.
+	- adi,reg4-aux-output-fund-en: Selects fundamental VCO output on the
+			auxiliary RF output. Default = Output of RF dividers.
+	- adi,reg4-mute-till-lock-en: Enables Mute-Till-Lock-Detect function.
+	- adi,reg4-output-pwr: Output power selection.
+			Valid values for the power mode are:
+			0: -4dBM (default)
+			1: -1dBM
+			2: +2dBM
+			3: +5dBM
+	- adi,reg4-aux-output-pwr: Auxiliary output power selection.
+			Valid values for the power mode are:
+			0: -4dBM (default)
+			1: -1dBM
+			2: +2dBM
+			3: +5dBM
+
+
+Example:
+		lo_pll0_rx_adf4351: adf4351-rx-lpc@4 {
+			compatible = "adi,adf4351";
+			reg = <4>;
+			spi-max-frequency = <10000000>;
+			clocks = <&clk0_ad9523 9>;
+			clock-names = "clkin";
+			adi,channel-spacing = <10000>;
+			adi,power-up-frequency = <2400000000>;
+			adi,reg2-pd-polarity-pos-en;
+			adi,reg2-charge-pump-curr-ua = <2500>;
+			adi,reg4-output-pwr = <3>;
+			adi,reg4-mute-till-lock-en;
+		};
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index f6849c8..828ce3e1 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -375,14 +376,133 @@ static const struct iio_info adf4350_info = {
 	.driver_module = THIS_MODULE,
 };
 
+#ifdef CONFIG_OF
+static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct adf4350_platform_data *pdata;
+	unsigned int tmp;
+	int ret;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "could not allocate memory for platform data\n");
+		return NULL;
+	}
+
+	strncpy(&pdata->name[0], np->name, SPI_NAME_SIZE - 1);
+
+	tmp = 10000;
+	of_property_read_u32(np, "adi,channel-spacing", &tmp);
+	pdata->channel_spacing = tmp;
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,power-up-frequency", &tmp);
+	pdata->power_up_frequency = tmp;
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,ref-div-factor", &tmp);
+	pdata->ref_div_factor = tmp;
+
+	ret = of_property_read_u32(np, "adi,gpio-lock-detect",
+				   &pdata->gpio_lock_detect);
+	if (ret < 0)
+		pdata->gpio_lock_detect = -1;
+
+	pdata->ref_doubler_en = of_property_read_bool(np, "adi,ref-doubler-en");
+	pdata->ref_div2_en = of_property_read_bool(np, "adi,ref-div2-en");
+
+	/* r2_user_settings */
+	pdata->r2_user_settings =
+		of_property_read_bool(np, "adi,reg2-pd-polarity-pos-en") ?
+					ADF4350_REG2_PD_POLARITY_POS : 0;
+	pdata->r2_user_settings |=
+		of_property_read_bool(np, "adi,reg2-ldp-6ns-en") ?
+					ADF4350_REG2_LDP_6ns : 0;
+	pdata->r2_user_settings |=
+		of_property_read_bool(np, "adi,reg2-ldf-int-n-en") ?
+					ADF4350_REG2_LDF_INT_N : 0;
+	tmp = 2500;
+	of_property_read_u32(np, "adi,reg2-charge-pump-curr-ua", &tmp);
+	pdata->r2_user_settings |= ADF4350_REG2_CHARGE_PUMP_CURR_uA(tmp);
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,reg2-muxout", &tmp);
+	pdata->r2_user_settings |= ADF4350_REG2_MUXOUT(tmp);
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,reg2-noise-mode", &tmp);
+	pdata->r2_user_settings |= ADF4350_REG2_NOISE_MODE(tmp);
+
+	/* r3_user_settings */
+
+	pdata->r3_user_settings =
+		of_property_read_bool(np, "adi,reg3-csr-en") ?
+					ADF4350_REG3_12BIT_CSR_EN : 0;
+	pdata->r3_user_settings |=
+		of_property_read_bool(np, "adi,reg3-charge-cancellation-en") ?
+					ADF4351_REG3_CHARGE_CANCELLATION_EN : 0;
+	pdata->r3_user_settings |=
+		of_property_read_bool(np, "adi,reg3-anti-backlash-3ns-en") ?
+					ADF4351_REG3_ANTI_BACKLASH_3ns_EN : 0;
+	pdata->r3_user_settings |=
+		of_property_read_bool(np,
+				      "adi,reg3-band-sel-clock-mode-high-en") ?
+				      ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH : 0;
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,reg3-12bit-clkdiv", &tmp);
+	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV(tmp);
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,reg3-12bit-clkdiv-mode", &tmp);
+	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV_MODE(tmp);
+
+	/* r4_user_settings */
+
+	pdata->r4_user_settings =
+		of_property_read_bool(np, "adi,reg4-aux-output-en") ?
+					ADF4350_REG4_AUX_OUTPUT_EN : 0;
+	pdata->r4_user_settings |=
+		of_property_read_bool(np, "adi,reg4-aux-output-fund-en") ?
+					ADF4350_REG4_AUX_OUTPUT_FUND : 0;
+	pdata->r4_user_settings |=
+		of_property_read_bool(np, "adi,reg4-mute-till-lock-en") ?
+					ADF4350_REG4_MUTE_TILL_LOCK_EN : 0;
+	tmp = 0;
+	of_property_read_u32(np, "adi,reg4-output-pwr", &tmp);
+	pdata->r4_user_settings |= ADF4350_REG4_OUTPUT_PWR(tmp);
+
+	tmp = 0;
+	of_property_read_u32(np, "adi,reg4-aux-output-pwr", &tmp);
+	pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_PWR(tmp);
+
+	return pdata;
+}
+#else
+static
+struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int adf4350_probe(struct spi_device *spi)
 {
-	struct adf4350_platform_data *pdata = spi->dev.platform_data;
+	struct adf4350_platform_data *pdata;
 	struct iio_dev *indio_dev;
 	struct adf4350_state *st;
 	struct clk *clk = NULL;
 	int ret;
 
+	if (spi->dev.of_node) {
+		pdata = adf4350_parse_dt(&spi->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	} else {
+		pdata = spi->dev.platform_data;
+	}
+
 	if (!pdata) {
 		dev_warn(&spi->dev, "no platform data? using default\n");
 		pdata = &default_pdata;
-- 
1.7.9.5
