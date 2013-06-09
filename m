Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54838 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3FISQY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jun 2013 14:16:24 -0400
Message-ID: <51B4C675.8010006@kernel.org>
Date: Sun, 09 Jun 2013 19:16:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, Lars-Peter.Clausen@analog.com,
	dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 4/4] iio: frequency: adf4350: Add support for
 dt bindings
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com> <1370266249-26338-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1370266249-26338-4-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Per review feedback from Lars-Peter Clausen <lars@metafoo.de>
> Changes since V1:
> 	Fix return value handling of adf4350_parse_dt()
> 	Use of_get_gpio
> 	Avoid abbreviations in devicetree properties
> 	Fix typo in docs
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Applied to togreg branch of iio.git
> ---
>  .../devicetree/bindings/iio/frequency/adf4350.txt  |   86 +++++++++++++
>  drivers/iio/frequency/adf4350.c                    |  128 +++++++++++++++++++-
>  2 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4350.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4350.txt b/Documentation/devicetree/bindings/iio/frequency/adf4350.txt
> new file mode 100644
> index 0000000..f8c181d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4350.txt
> @@ -0,0 +1,86 @@
> +Analog Devices ADF4350/ADF4351 device driver
> +
> +Required properties:
> +	- compatible: Should be one of
> +		* "adi,adf4350": When using the ADF4350 device
> +		* "adi,adf4351": When using the ADF4351 device
> +	- reg: SPI chip select numbert for the device
> +	- spi-max-frequency: Max SPI frequency to use (< 20000000)
> +	- clocks: From common clock binding. Clock is phandle to clock for
> +		ADF435x Reference Clock (CLKIN).
> +
> +Optional properties:
> +	- gpios:	 GPIO Lock detect - If set with a valid phandle and GPIO number,
> +			pll lock state is tested upon read.
> +	- adi,channel-spacing: Channel spacing in Hz (influences MODULUS).
> +	- adi,power-up-frequency:	If set in Hz the PLL tunes to
> +			the desired frequency on probe.
> +	- adi,reference-div-factor: If set the driver skips dynamic calculation
> +			and uses this default value instead.
> +	- adi,reference-doubler-enable: Enables reference doubler.
> +	- adi,reference-div2-enable: Enables reference divider.
> +	- adi,phase-detector-polarity-positive-enable: Enables positive phase
> +			detector polarity. Default = negative.
> +	- adi,lock-detect-precision-6ns-enable: Enables 6ns lock detect precision.
> +			Default = 10ns.
> +	- adi,lock-detect-function-integer-n-enable: Enables lock detect
> +			for integer-N mode. Default = factional-N mode.
> +	- adi,charge-pump-current: Charge pump current in mA.
> +			Default = 2500mA.
> +	- adi,muxout-select: On chip multiplexer output selection.
> +			Valid values for the multiplexer output are:
> +			0: Three-State Output (default)
> +			1: DVDD
> +			2: DGND
> +			3: R-Counter output
> +			4: N-Divider output
> +			5: Analog lock detect
> +			6: Digital lock detect
> +	- adi,low-spur-mode-enable: Enables low spur mode.
> +			Default = Low noise mode.
> +	- adi,cycle-slip-reduction-enable: Enables cycle slip reduction.
> +	- adi,charge-cancellation-enable: Enabled charge pump
> +			charge cancellation for integer-N modes.
> +	- adi,anti-backlash-3ns-enable: Enables 3ns antibacklash pulse width
> +			 for integer-N modes.
> +	- adi,band-select-clock-mode-high-enable: Enables faster band
> +			selection logic.
> +	- adi,12bit-clk-divider: Clock divider value used when
> +			adi,12bit-clkdiv-mode != 0
> +	- adi,clk-divider-mode:
> +			Valid values for the clkdiv mode are:
> +			0: Clock divider off (default)
> +			1: Fast lock enable
> +			2: Phase resync enable
> +	- adi,aux-output-enable: Enables auxiliary RF output.
> +	- adi,aux-output-fundamental-enable: Selects fundamental VCO output on
> +			the auxiliary RF output. Default = Output of RF dividers.
> +	- adi,mute-till-lock-enable: Enables Mute-Till-Lock-Detect function.
> +	- adi,output-power: Output power selection.
> +			Valid values for the power mode are:
> +			0: -4dBm (default)
> +			1: -1dBm
> +			2: +2dBm
> +			3: +5dBm
> +	- adi,aux-output-power: Auxiliary output power selection.
> +			Valid values for the power mode are:
> +			0: -4dBm (default)
> +			1: -1dBm
> +			2: +2dBm
> +			3: +5dBm
> +
> +
> +Example:
> +		lo_pll0_rx_adf4351: adf4351-rx-lpc@4 {
> +			compatible = "adi,adf4351";
> +			reg = <4>;
> +			spi-max-frequency = <10000000>;
> +			clocks = <&clk0_ad9523 9>;
> +			clock-names = "clkin";
> +			adi,channel-spacing = <10000>;
> +			adi,power-up-frequency = <2400000000>;
> +			adi,phase-detector-polarity-positive-enable;
> +			adi,charge-pump-current = <2500>;
> +			adi,output-power = <3>;
> +			adi,mute-till-lock-enable;
> +		};
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index f6849c8..a4157cd 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -18,6 +18,8 @@
>  #include <linux/gpio.h>
>  #include <asm/div64.h>
>  #include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -375,14 +377,138 @@ static const struct iio_info adf4350_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +#ifdef CONFIG_OF
> +static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct adf4350_platform_data *pdata;
> +	unsigned int tmp;
> +	int ret;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "could not allocate memory for platform data\n");
> +		return NULL;
> +	}
> +
> +	strncpy(&pdata->name[0], np->name, SPI_NAME_SIZE - 1);
> +
> +	tmp = 10000;
> +	of_property_read_u32(np, "adi,channel-spacing", &tmp);
> +	pdata->channel_spacing = tmp;
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,power-up-frequency", &tmp);
> +	pdata->power_up_frequency = tmp;
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,reference-div-factor", &tmp);
> +	pdata->ref_div_factor = tmp;
> +
> +	ret = of_get_gpio(np, 0);
> +	if (ret < 0)
> +		pdata->gpio_lock_detect = -1;
> +	else
> +		pdata->gpio_lock_detect = ret;
> +
> +	pdata->ref_doubler_en = of_property_read_bool(np,
> +			"adi,reference-doubler-enable");
> +	pdata->ref_div2_en = of_property_read_bool(np,
> +			"adi,reference-div2-enable");
> +
> +	/* r2_user_settings */
> +	pdata->r2_user_settings = of_property_read_bool(np,
> +			"adi,phase-detector-polarity-positive-enable") ?
> +			ADF4350_REG2_PD_POLARITY_POS : 0;
> +	pdata->r2_user_settings |= of_property_read_bool(np,
> +			"adi,lock-detect-precision-6ns-enable") ?
> +			ADF4350_REG2_LDP_6ns : 0;
> +	pdata->r2_user_settings |= of_property_read_bool(np,
> +			"adi,lock-detect-function-integer-n-enable") ?
> +			ADF4350_REG2_LDF_INT_N : 0;
> +
> +	tmp = 2500;
> +	of_property_read_u32(np, "adi,charge-pump-current", &tmp);
> +	pdata->r2_user_settings |= ADF4350_REG2_CHARGE_PUMP_CURR_uA(tmp);
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,muxout-select", &tmp);
> +	pdata->r2_user_settings |= ADF4350_REG2_MUXOUT(tmp);
> +
> +	pdata->r2_user_settings |= of_property_read_bool(np,
> +			"adi,low-spur-mode-enable") ?
> +			ADF4350_REG2_NOISE_MODE(0x3) : 0;
> +
> +	/* r3_user_settings */
> +
> +	pdata->r3_user_settings = of_property_read_bool(np,
> +			"adi,cycle-slip-reduction-enable") ?
> +			ADF4350_REG3_12BIT_CSR_EN : 0;
> +	pdata->r3_user_settings |= of_property_read_bool(np,
> +			"adi,charge-cancellation-enable") ?
> +			ADF4351_REG3_CHARGE_CANCELLATION_EN : 0;
> +
> +	pdata->r3_user_settings |= of_property_read_bool(np,
> +			"adi,anti-backlash-3ns-enable") ?
> +			ADF4351_REG3_ANTI_BACKLASH_3ns_EN : 0;
> +	pdata->r3_user_settings |= of_property_read_bool(np,
> +			"adi,band-select-clock-mode-high-enable") ?
> +			ADF4351_REG3_BAND_SEL_CLOCK_MODE_HIGH : 0;
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,12bit-clk-divider", &tmp);
> +	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV(tmp);
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,clk-divider-mode", &tmp);
> +	pdata->r3_user_settings |= ADF4350_REG3_12BIT_CLKDIV_MODE(tmp);
> +
> +	/* r4_user_settings */
> +
> +	pdata->r4_user_settings = of_property_read_bool(np,
> +			"adi,aux-output-enable") ?
> +			ADF4350_REG4_AUX_OUTPUT_EN : 0;
> +	pdata->r4_user_settings |= of_property_read_bool(np,
> +			"adi,aux-output-fundamental-enable") ?
> +			ADF4350_REG4_AUX_OUTPUT_FUND : 0;
> +	pdata->r4_user_settings |= of_property_read_bool(np,
> +			"adi,mute-till-lock-enable") ?
> +			ADF4350_REG4_MUTE_TILL_LOCK_EN : 0;
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,output-power", &tmp);
> +	pdata->r4_user_settings |= ADF4350_REG4_OUTPUT_PWR(tmp);
> +
> +	tmp = 0;
> +	of_property_read_u32(np, "adi,aux-output-power", &tmp);
> +	pdata->r4_user_settings |= ADF4350_REG4_AUX_OUTPUT_PWR(tmp);
> +
> +	return pdata;
> +}
> +#else
> +static
> +struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int adf4350_probe(struct spi_device *spi)
>  {
> -	struct adf4350_platform_data *pdata = spi->dev.platform_data;
> +	struct adf4350_platform_data *pdata;
>  	struct iio_dev *indio_dev;
>  	struct adf4350_state *st;
>  	struct clk *clk = NULL;
>  	int ret;
>  
> +	if (spi->dev.of_node) {
> +		pdata = adf4350_parse_dt(&spi->dev);
> +		if (pdata == NULL)
> +			return -EINVAL;
> +	} else {
> +		pdata = spi->dev.platform_data;
> +	}
> +
>  	if (!pdata) {
>  		dev_warn(&spi->dev, "no platform data? using default\n");
>  		pdata = &default_pdata;
> 
