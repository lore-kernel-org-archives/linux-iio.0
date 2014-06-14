Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46290 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbaFNQ5C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 12:57:02 -0400
Message-ID: <539C7F42.9060809@kernel.org>
Date: Sat, 14 Jun 2014 17:58:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: linux-iio@vger.kernel.org, workgroup.linux@csr.com,
	Guoying Zhang <Guoying.Zhang@csr.com>,
	Barry Song <Baohua.Song@csr.com>
Subject: Re: [PATCH] iio: adc: add CSR SiRFSoC internal ADC driver
References: <1402307665-3007-1-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1402307665-3007-1-git-send-email-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/14 10:54, Barry Song wrote:
> From: Guoying Zhang <Guoying.Zhang@csr.com>
>
> SiRFSoC internal ADC provides touchscreen single or dual touch
> channels, and provides several auxiliary channels to measure
> temperature, battery and so on.
>
> Signed-off-by: Guoying Zhang <Guoying.Zhang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
Why is this only an IIO driver?  Whilst we have prototype code for bridging
to input, this is a very input specific part.

A lot of interesting corners in here are about handling the touchscreen
measurement oddities.  It can be done cleaner, but does that make sense?

Obviously there are some aux channels, hence I'd suggest either an MFD
with input and IIO hanging off it, or (though I don't much like them) a
combined driver doing both.

Jonathan
> ---
>   drivers/iio/adc/Kconfig       |   9 +
>   drivers/iio/adc/Makefile      |   1 +
>   drivers/iio/adc/sirfsoc_adc.c | 722 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 732 insertions(+)
>   create mode 100644 drivers/iio/adc/sirfsoc_adc.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a80d236..8ea6e4b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -187,6 +187,15 @@ config NAU7802
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called nau7802.
>
> +config SIRFSOC_ADC
> +        tristate "SiRFSoC ADC"
> +	depends on ARCH_SIRF
> +	help
> +	  If you say yes here you get support for CSR SiRFSoC internal ADC.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called sirfsoc_adc.
> +
>   config TI_ADC081C
>   	tristate "Texas Instruments ADC081C021/027"
>   	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9d60f2d..2912e58 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
>   obj-$(CONFIG_MCP3422) += mcp3422.o
>   obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>   obj-$(CONFIG_NAU7802) += nau7802.o
> +obj-$(CONFIG_SIRFSOC_ADC) += sirfsoc_adc.o
>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>   obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/sirfsoc_adc.c b/drivers/iio/adc/sirfsoc_adc.c
> new file mode 100644
> index 0000000..568ae1c
> --- /dev/null
> +++ b/drivers/iio/adc/sirfsoc_adc.c
> @@ -0,0 +1,722 @@
> +/*
> +* ADC Driver for CSR SiRFprimaII/AtlasVI
> +*
> +* Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
> +*
> +* Licensed under GPLv2.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/reset.h>
> +#include <linux/rtc/sirfsoc_rtciobrg.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +
> +#define DRIVER_NAME "sirfsoc_adc"
> +
> +#define PWR_WAKEEN_TSC_SHIFT	23
> +#define PWR_WAKEEN_TS_SHIFT	5
> +#define SIRFSOC_PWRC_TRIGGER_EN	0x8
> +#define SIRFSOC_PWRC_BASE	0x3000
> +
> +#define DATA_SHIFT_BITS		14
> +
> +#define ADC_CONTROL1		0x00
> +#define ADC_CONTROL2		0x04
> +#define ADC_INTR		0x08
> +#define ADC_COORD		0x0C
> +#define ADC_PRESSURE		0x10
> +#define ADC_AUX1		0x14
> +#define ADC_AUX2		0x18
> +#define ADC_AUX3		0x1C
> +#define ADC_AUX4		0x20
> +#define ADC_AUX5		0x24
> +#define ADC_AUX6		0x28
> +#define ADC_CB			0x2C /* Read Back calibration register */
> +#define ADC_COORD2		0x30
> +#define ADC_COORD3		0x34
> +#define ADC_COORD4		0x38
> +#define ADC_CONTROL3		0x3C
> +
> +/* CTRL1 defines */
> +#define ADC_RESET_QUANT_EN	BIT(24)
> +#define ADC_RST_B		BIT(23)
> +#define ADC_RESOLUTION_12	BIT(22)
> +#define ADC_RBAT_DISABLE	(0x0 << 21)
> +#define ADC_RBAT_ENABLE		(0x1 << 21)
> +#define ADC_EXTCM_MASK		(0x3 << 19)
> +#define ADC_EXTCM(x)		(((x) & 0x3) << 19)
> +#define ADC_SGAIN_MASK		(0x7 << 16)
> +#define ADC_SGAIN(x)		(((x) & 0x7) << 16)
> +#define ADC_POLL		BIT(15)
> +#define ADC_SEL_MASK		(0xF << 11)
> +#define ADC_SEL(x)		 (((x) & 0xF) << 11)
> +#define ADC_FREQ_6K		(0x0 << 8)
> +#define ADC_FREQ_13K		(0x1 << 8)
> +#define ADC_DEL_SET_MASK	(0xF << 4)
> +#define ADC_DEL_SET(x)		(((x) & 0xF) << 4)
> +#define ADC_TP_TIME_MASK	(0x7)
> +#define ADC_TP_TIME(x)		(((x) & 0x7) << 0)
> +
> +/* CTRL2 defines */
> +#define ADC_PRP_MASK		(3 << 14)
> +/* Pen detector off, digitizer off */
> +#define ADC_PRP_MODE0		(0 << 14)
> +/* Pen detector on, digitizer off, digitizer wakes up on pen detect */
> +#define ADC_PRP_MODE1		BIT(14)
> +/* Pen detector on, digitizer off, no wake up on pen detect */
> +#define ADC_PRP_MODE2		(2 << 14)
> +/* Pen detector on, digitizer on */
> +#define ADC_PRP_MODE3		(3 << 14)
> +#define ADC_RTOUCH_MASK		(0x3 << 12)
> +#define ADC_RTOUCH(x)		(((x) & 0x3) << 12)
> +#define ADC_DEL_AUTO_MASK	(0xF << 8)
> +#define ADC_DEL_AUTO(x)		(((x) & 0xF) << 8)
> +#define ADC_DEL_PRE(x)		(((x) & 0xF) << 4)
> +#define ADC_DEL_DIS(x)		(((x) & 0xF) << 0)
> +
> +/* INTR register defines */
> +#define PEN_INTR_EN		BIT(5)
> +#define DATA_INTR_EN		BIT(4)
> +#define PEN_INTR		BIT(1)
> +#define DATA_INTR		BIT(0)
> +
> +/* DATA register defines */
> +#define PEN_DOWN		BIT(31)
> +#define DATA_YVALID		BIT(30)
> +#define DATA_XVALID		BIT(29)
> +#define DATA_Z2VALID		BIT(30)
> +#define DATA_Z1VALID		BIT(29)
> +#define DATA_AUXVALID		BIT(30)
> +#define DATA_CB_VALID		BIT(30)
> +#define DATA_Y2VALID		BIT(30)
> +#define DATA_X2VALID		BIT(29)
> +#define DATA_6VALID		BIT(30)
> +#define DATA_5VALID		BIT(29)
> +#define DATA_8VALID		BIT(30)
> +#define DATA_7VALID		BIT(29)
> +
> +#define ADC_DATA_MASK(x)	(0x3FFF << (x))
> +#define DATA_XMASK		ADC_DATA_MASK(0)
> +#define DATA_YMASK		ADC_DATA_MASK(DATA_SHIFT_BITS)
> +#define DATA_Z1MASK		ADC_DATA_MASK(0)
> +#define DATA_Z2MASK		ADC_DATA_MASK(DATA_SHIFT_BITS)
> +#define DATA_AUXMASK		ADC_DATA_MASK(0)
> +#define DATA_CBMASK		ADC_DATA_MASK(0)
> +#define DATA_X2MASK		ADC_DATA_MASK(0)
> +#define DATA_Y2MASK		ADC_DATA_MASK(DATA_SHIFT_BITS)
> +#define DATA_5MASK		ADC_DATA_MASK(0)
> +#define DATA_6MASK		ADC_DATA_MASK(DATA_SHIFT_BITS)
> +#define DATA_7MASK		ADC_DATA_MASK(0)
> +#define DATA_8MASK		ADC_DATA_MASK(DATA_SHIFT_BITS)
> +
> +#define ADC_IDEAL_RELA_RESULT	11597
> +#define ADC_IDEAL_ABSO_RESULT	9446
> +
> +#define ADC_MORE_CTL1		(of_machine_is_compatible("sirf,atlas6") ?\
> +					(ADC_RESET_QUANT_EN | ADC_RST_B) : (0))
> +
> +/* Select AD samples to read (SEL bits in ADC_CONTROL1 register) */
> +#define SIRFSOC_ADC_AUX1_SEL	0x04
> +#define SIRFSOC_ADC_AUX4_SEL	0x07
> +#define SIRFSOC_ADC_AUX5_SEL	0x08
> +#define SIRFSOC_ADC_AUX6_SEL	0x09
> +#define SIRFSOC_ADC_TS_SEL	0x0A    /* xy sample */
> +#define SIRFSOC_ADC_TS_SEL_DUAL	0x0F    /* samples for dual touch */
> +#define SIRFSOC_ADC_TS_SAMPLE_SIZE	4
> +#define SIRFSOC_ADC_CTL1(sel)    (ADC_POLL | ADC_SEL(sel) | ADC_DEL_SET(6) \
> +		| ADC_FREQ_6K | ADC_TP_TIME(0) | ADC_SGAIN(0) \
> +		| ADC_EXTCM(0) | ADC_RBAT_DISABLE | ADC_MORE_CTL1)
> +
> +#define SIRFSOC_ADC_CHANNEL(_index) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.channel = _index,				\
> +	.address = _index,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
A number of the channels seem to carefully ensure their output is in
volts. As such you should do the conversion to microvolts then
use IIO_CHAN_INFO_PROCESSED.

Alternative is to unwind the rather involved conversion function
(which looks linear in the actual reading from the ADC). Then provide
a scale and offset for each channel).
> +}
> +
> +/* high priority queue with the bigger value */
> +enum sirfsoc_adc_service_t {
> +	SIRFSOC_ADC_SERVICE_AUX = 0,
> +	SIRFSOC_ADC_SERVICE_TS_PARADOX,
> +	SIRFSOC_ADC_SERVICE_MAX,
> +};
> +
> +enum sirfsoc_adc_req_status_t {
> +	SIRFSOC_ADC_REQ_NONE = 0,
> +	SIRFSOC_ADC_REQ_ACTIVE,
> +	SIRFSOC_ADC_REQ_BUSY,
> +	SIRFSOC_ADC_REQ_MAX,
> +};
> +
> +enum sirfsoc_adc_iio_channel {
> +	CHANNEL_COORD,
> +	CHANNEL_COORD_DUAL,
> +	CHANNEL_AUX1,
> +	CHANNEL_AUX4,
> +	CHANNEL_AUX5,
> +	CHANNEL_AUX6,
> +};
> +
> +struct sirfsoc_adc_data {
> +	u16 x;
> +	u16 y;
> +	u16 z1;
> +	u16 z2;
> +	u16 aux;
> +	u8 datavalid;
> +};
> +
> +struct sirfsoc_adc_request {
> +	enum sirfsoc_adc_service_t type;
> +	struct sirfsoc_adc_data adc_data;
> +	u16 mode;
> +	u16 aux;
> +	u16 reference;
> +	u8 delay_bits;
> +	u32 s_gain_bits;
> +	enum sirfsoc_adc_req_status_t req_status;
> +};
> +
> +struct sirfsoc_adc {
> +	struct clk	*clk;
> +	void __iomem	*base;
> +	struct sirfsoc_adc_request req;
> +	struct completion	done;
> +	struct mutex	adc_lock;
> +};
> +
> +static int sirfsoc_adc_send_request(struct sirfsoc_adc_request *req)
> +{
> +	struct sirfsoc_adc *adc = container_of(req, struct sirfsoc_adc, req);
> +	int control1, control2, intr;
> +	int data, reg_offset;
> +	int ret = 0;
> +
> +	mutex_lock(&adc->adc_lock);
> +
> +	intr = readl(adc->base + ADC_INTR);

I'd name these two to indicate they are a cache to be put back later...
> +	control1 = readl(adc->base + ADC_CONTROL1);
> +	control2 = readl(adc->base + ADC_CONTROL2);
> +	writel(intr | DATA_INTR_EN | DATA_INTR, (adc->base + ADC_INTR));
Clean up brackets...
> +
> +	writel(ADC_PRP_MODE3 | req->reference,
> +		adc->base + ADC_CONTROL2);
Clean up line breaks.  THere doesn't need to be one here.
> +
> +	writel(ADC_POLL | ADC_MORE_CTL1 | req->mode |
> +		req->aux | req->delay_bits | ADC_RESOLUTION_12,
> +			adc->base + ADC_CONTROL1);
> +
> +	if (!wait_for_completion_timeout(&adc->done,
> +		msecs_to_jiffies(50))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	switch (req->mode) {
> +	case ADC_SEL(3):
> +		data = readl(adc->base + ADC_PRESSURE);
> +		if ((data & DATA_Z1VALID) && (data & DATA_Z2VALID)) {
> +			req->adc_data.z1 = data & DATA_Z1MASK;
> +			req->adc_data.z2 =
> +			(data & DATA_Z2MASK) >> DATA_SHIFT_BITS;
> +			req->adc_data.datavalid = 1;
> +		}
> +		break;
> +	case ADC_SEL(4):
> +	case ADC_SEL(5):
> +	case ADC_SEL(6):
> +	case ADC_SEL(7):
> +	case ADC_SEL(8):
> +	case ADC_SEL(9):
> +		reg_offset = 0x14 + ((req->mode >> 11) - 0x04) * 4;
> +		data = readl(adc->base + reg_offset);
> +		if ((data & DATA_AUXVALID)) {
> +			req->adc_data.aux = data & DATA_AUXMASK;
> +			req->adc_data.datavalid = 1;
> +		}
> +		break;
> +	case ADC_SEL(11):
> +	case ADC_SEL(12):
> +	case ADC_SEL(13):
> +		reg_offset = ADC_CB;
> +		data = readl(adc->base + reg_offset);
> +		if ((data & DATA_AUXVALID)) {
> +			req->adc_data.aux = data & DATA_AUXMASK;
> +			req->adc_data.datavalid = 1;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +out:
> +	writel(intr, adc->base + ADC_INTR);
> +	writel(control1, adc->base + ADC_CONTROL1);
> +	writel(control2, adc->base + ADC_CONTROL2);
> +	mutex_unlock(&adc->adc_lock);
> +	return ret;
> +}
> +
> +/*struct store params to calibrate*/
> +struct sirfsoc_adc_cali_data {
> +	u32 digital_offset;
> +	u32 digital_again;
> +	u32 digital_ideal;
> +	bool is_calibration;
> +};
> +
> +static u32 sirfsoc_adc_offset_cali(struct sirfsoc_adc_request *req)
> +{
> +	u32 i, digital_offset = 0, count = 0, sum = 0;
> +	/* To set the reigsters in order to get the ADC offset */
> +	req->mode = ADC_SEL(11);
> +	req->aux = ADC_CB;
> +	req->s_gain_bits = ADC_SGAIN(7);
> +	req->delay_bits = ADC_DEL_SET(4);
> +	req->req_status = SIRFSOC_ADC_REQ_NONE;
> +
> +	for (i = 0; i < 10; i++) {
> +		if (unlikely(sirfsoc_adc_send_request(req)))
> +			break;
> +		digital_offset = req->adc_data.aux;
> +		/* Maybe the value is wrong, so remove it use experience */
Does this actually happen?  If so why?
> +		if (digital_offset < 230 && digital_offset > 130) {
> +			sum += digital_offset;
> +			count++;
> +		}
> +	}
> +	if (!sum || !count)
> +		digital_offset = 170;
> +	else
> +		digital_offset = sum / count;
> +
> +	return digital_offset;
> +}
> +
> +
> +/* Gain Calibration calibrates the ADC gain error */
> +static u32 sirfsoc_adc_gain_cali(struct sirfsoc_adc_request *req)
> +{
> +	u32 i, digital_gain = 0, count = 0, sum = 0;
> +	/* To set the reigsters in order to get the ADC gain */
> +	req->mode = ADC_SEL(12);
> +	req->aux = ADC_CB;
> +	req->s_gain_bits = ADC_SGAIN(0);
> +	req->delay_bits = ADC_DEL_SET(4);
> +	req->req_status = SIRFSOC_ADC_REQ_NONE;
> +
> +	for (i = 0; i < 10; i++) {
> +		if (unlikely(sirfsoc_adc_send_request(req)))
Don't bother with the unlikely.  This isn't a particularly fast path.
> +			break;
> +		digital_gain = req->adc_data.aux;
> +		/* Maybe the value is wrong, so remove it use experience */
> +		if (digital_gain < 6500 && digital_gain > 5500) {
> +			sum += digital_gain;
> +			count++;
> +		}
> +	}
> +	if (!sum || !count)
> +		digital_gain = 5555;
> +	else
> +		digital_gain = sum / count;
> +
> +	return digital_gain;
> +}
> +
> +/* absolute gain calibration */
> +static int sirfsoc_adc_adc_cali(struct sirfsoc_adc_request *req,
> +				struct sirfsoc_adc_cali_data *cali_data)
> +{
> +	cali_data->digital_offset = sirfsoc_adc_offset_cali(req);
> +	if (!(cali_data->digital_offset))
> +		return -EINVAL;
> +	cali_data->digital_again = sirfsoc_adc_gain_cali(req);
> +	if (!(cali_data->digital_again))
> +		return -EINVAL;
> +	/*
> +	 * see Equation 3.2 of SiRFprimaII™ Internal ADC and Touch
> +	 * User Guide
> +	 */
> +	cali_data->digital_ideal = (16384 * 1200) / (14 * 333);
> +	return 0;
> +}
> +
> +
> +/* get voltage after ADC conversion */
This also appears to trigger the capture in the first place?
> +static u32 sirfsoc_adc_get_adc_volt(struct sirfsoc_adc *adc,
> +				struct sirfsoc_adc_cali_data *cali_data)
> +{
> +	u32 digital_out, digital_convert, volt;
> +	struct sirfsoc_adc_request *req = &adc->req;
blank line here.

Perhaps a comment on what is going on in this calibration read back?
It seems like a bad idea to have this here. My inclination would be
to perform calibration on driver load rather than first read...
> +	if (!(cali_data->is_calibration)) {
> +		if (sirfsoc_adc_adc_cali(req, cali_data))
> +			return 0;
> +		cali_data->is_calibration = true;
> +	}
> +	req->s_gain_bits = ADC_SGAIN(0);
> +	req->delay_bits = ADC_DEL_SET(4);
> +
> +	sirfsoc_adc_send_request(req);
> +	if (req->adc_data.aux) {
> +		digital_out = req->adc_data.aux;
> +		/*
> +		 * see Equation 3.3 of SiRFprimaII™ Internal ADC and Touch
> +		 */
> +		digital_convert = ((digital_out - 2 * cali_data->digital_offset
> +			* 11645 / 140000) * cali_data->digital_ideal)
> +			/ (cali_data->digital_again -
> +			2 * cali_data->digital_offset
> +			* 11645 / 140000);
> +		volt = (1200 * digital_convert) / cali_data->digital_ideal;
> +		volt = volt * 2;
> +
> +	} else {
> +		return 0;
> +	}
> +
> +	return volt;
> +}
> +
> +/* get touchscreen coordinates for single touch */
> +static int sirfsoc_adc_single_ts_sample(struct sirfsoc_adc *adc, int *sample)
> +{
> +	int adc_intr;
> +
> +	adc_intr = readl(adc->base + ADC_INTR);
> +	if (adc_intr & PEN_INTR)
> +		writel(PEN_INTR | PEN_INTR_EN | DATA_INTR_EN,
> +			adc->base + ADC_INTR);
> +
> +	/* check pen status */
> +	if (!(readl(adc->base + ADC_COORD) & PEN_DOWN))
> +		return -EINVAL;
> +
This function is rather similar to the 'dual' one.  Could we combine them
and pass in an appropriate parameter to say which one we are interested
in...
> +	writel(SIRFSOC_ADC_CTL1(SIRFSOC_ADC_TS_SEL),
> +		adc->base + ADC_CONTROL1);
> +
> +	if (!wait_for_completion_timeout(&adc->done,
> +		msecs_to_jiffies(50))) {
> +		return -EBUSY;
> +	}
> +
> +	*sample = readl(adc->base + ADC_COORD);
> +	return 0;
> +}
> +
> +static const u32 sirfsoc_adc_ts_reg[SIRFSOC_ADC_TS_SAMPLE_SIZE] = {
> +	ADC_COORD, ADC_COORD2, ADC_COORD3, ADC_COORD4
> +};
> +
> +/* get touchscreen coordinates for dual touch */
> +static int sirfsoc_adc_dual_ts_sample(struct sirfsoc_adc *adc, int *samples)
> +{
> +	int adc_intr;
> +	int i;
> +
> +	adc_intr = readl(adc->base + ADC_INTR);
> +	if (adc_intr & PEN_INTR)
> +		writel(PEN_INTR | PEN_INTR_EN | DATA_INTR_EN,
> +			adc->base + ADC_INTR);
> +
> +	/* check pen status */
> +	if (!(readl(adc->base + ADC_COORD) & PEN_DOWN))
> +		return -EINVAL;
> +
> +	writel(SIRFSOC_ADC_CTL1(SIRFSOC_ADC_TS_SEL_DUAL),
> +		adc->base + ADC_CONTROL1);
> +
> +	if (!wait_for_completion_timeout(&adc->done,
> +		msecs_to_jiffies(50))) {
> +		return -EBUSY;
> +	}
> +
> +	for (i = 0; i < SIRFSOC_ADC_TS_SAMPLE_SIZE; i++)
> +		samples[i] = readl(adc->base + sirfsoc_adc_ts_reg[i]);
So this is writing multiple values into a pointer to a single integer.

Couple of options here.  Either write a true input driver (combined with IIO
is never elegant, but we do let those in if Dmitry doesn't mind), or
pull out whichever signal is actually requested.

A short explanation of what exactly is intended would be helpful.

> +
> +	return 0;
> +}
> +
> +static int sirfsoc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val,
> +				int *val2,
> +				long mask)
> +{
> +	struct sirfsoc_adc *adc = iio_priv(indio_dev);
> +	struct sirfsoc_adc_cali_data cali_data;
> +	int ret = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel) {
> +		case CHANNEL_COORD:
> +			ret = sirfsoc_adc_single_ts_sample(adc, val);
> +			break;
> +		case CHANNEL_COORD_DUAL:
> +			ret = sirfsoc_adc_dual_ts_sample(adc, val);
Um. This writes multiple values into a pointer that only points to 1...
> +			break;
> +		case CHANNEL_AUX1:
> +			adc->req.mode = ADC_SEL(SIRFSOC_ADC_AUX1_SEL);
> +			adc->req.aux = ADC_AUX1;
> +			*val = sirfsoc_adc_get_adc_volt(adc,
> +						&cali_data);
> +			break;
> +		case CHANNEL_AUX4:
> +			adc->req.mode = ADC_SEL(SIRFSOC_ADC_AUX4_SEL);
> +			adc->req.aux = ADC_AUX4;
> +			*val = sirfsoc_adc_get_adc_volt(adc,
> +						&cali_data);
> +			break;
> +		case CHANNEL_AUX5:
> +			adc->req.mode = ADC_SEL(SIRFSOC_ADC_AUX5_SEL);
> +			adc->req.aux = ADC_AUX5;
> +			*val = sirfsoc_adc_get_adc_volt(adc,
> +						&cali_data);
> +			break;
> +		case CHANNEL_AUX6:
> +			adc->req.mode = ADC_SEL(SIRFSOC_ADC_AUX6_SEL);
> +			adc->req.aux = ADC_AUX6;
> +			*val = sirfsoc_adc_get_adc_volt(adc,
> +						&cali_data);
> +			break;
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t sirfsoc_adc_data_irq(int irq, void *handle)
> +{
> +	struct iio_dev *indio_dev = handle;
> +	struct sirfsoc_adc *adc = iio_priv(indio_dev);
> +	int val;
> +
> +	val = readl(adc->base + ADC_INTR);
> +
If this isn't the case, are we dealing with a shared interrupt register?
In which case, should it not be only returning IRQ_HANDLED if it is
relevant to the adc?
> +	if (val & DATA_INTR) {
> +		writel(PEN_INTR_EN | DATA_INTR | DATA_INTR_EN,
> +			adc->base + ADC_INTR);
> +		complete(&adc->done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int sirfsoc_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct sirfsoc_adc *adc = iio_priv(indio_dev);
> +
> +	sirfsoc_rtc_iobrg_writel(sirfsoc_rtc_iobrg_readl(
> +		SIRFSOC_PWRC_BASE + SIRFSOC_PWRC_TRIGGER_EN)
> +		& ~(1 << PWR_WAKEEN_TSC_SHIFT),
> +		SIRFSOC_PWRC_BASE + SIRFSOC_PWRC_TRIGGER_EN);
> +
> +	clk_disable_unprepare(adc->clk);
blank line here...
> +	return 0;
> +}
> +
> +static int sirfsoc_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct sirfsoc_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +	int val;
> +
> +	clk_prepare_enable(adc->clk);
> +
> +	sirfsoc_rtc_iobrg_writel(sirfsoc_rtc_iobrg_readl(
> +		SIRFSOC_PWRC_BASE + SIRFSOC_PWRC_TRIGGER_EN)
> +		| (1 << PWR_WAKEEN_TS_SHIFT),
> +		SIRFSOC_PWRC_BASE + SIRFSOC_PWRC_TRIGGER_EN);
> +
> +	ret = device_reset(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to reset\n");
> +		return ret;
> +	}
> +
> +	writel(ADC_PRP_MODE3 | ADC_RTOUCH(1) | ADC_DEL_PRE(2) |
> +		ADC_DEL_DIS(5),  adc->base + ADC_CONTROL2);
> +
> +	val = readl(adc->base + ADC_INTR);
> +
> +	/* Clear interrupts and enable PEN interrupt */
> +	writel(val | PEN_INTR | DATA_INTR | PEN_INTR_EN |
> +		DATA_INTR_EN,  adc->base + ADC_INTR);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops sirfsoc_adc_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_adc_suspend, sirfsoc_adc_resume)
> +};
> +
> +static const struct of_device_id sirfsoc_adc_of_match[] = {
> +	{ .compatible = "sirf,prima2-adc",},
> +	{}
> +};
> +
> +static struct iio_chan_spec const sirfsoc_adc_iio_channels[] = {
> +	SIRFSOC_ADC_CHANNEL(CHANNEL_COORD),
> +	SIRFSOC_ADC_CHANNEL(CHANNEL_COORD_DUAL),
> +	SIRFSOC_ADC_CHANNEL(CHANNEL_AUX1),
> +	/* AtlasVI has no AUX2 and AUX3 */
> +	SIRFSOC_ADC_CHANNEL(CHANNEL_AUX4),
> +	SIRFSOC_ADC_CHANNEL(CHANNEL_AUX5),
> +	SIRFSOC_ADC_CHANNEL(CHANNEL_AUX6),
> +};
> +
> +static const struct iio_info sirfsoc_adc_info = {
> +	.read_raw = &sirfsoc_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int sirfsoc_adc_probe(struct platform_device *pdev)
> +{
> +	struct resource	*mem_res;
> +	struct sirfsoc_adc *adc;
> +	struct iio_dev *indio_dev;
> +	int irq;
> +	int ret = 0;
> +
> +	indio_dev = iio_device_alloc(sizeof(struct sirfsoc_adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->info = &sirfsoc_adc_info;
> +	indio_dev->channels = sirfsoc_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sirfsoc_adc_iio_channels);
> +	indio_dev->name = "sirfsoc adc";
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	adc = iio_priv(indio_dev);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	adc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(adc->clk)) {
> +		dev_err(&pdev->dev, "get adc clk err\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	clk_prepare_enable(adc->clk);
> +
> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem_res) {
> +		dev_err(&pdev->dev, "Unalbe to get io resource\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	adc->base = devm_request_and_ioremap(&pdev->dev, mem_res);
> +	if (adc->base == NULL) {
> +		dev_err(&pdev->dev, "IO remap failed!\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	init_completion(&adc->done);
> +	mutex_init(&adc->adc_lock);
> +
> +	sirfsoc_rtc_iobrg_writel(sirfsoc_rtc_iobrg_readl(SIRFSOC_PWRC_BASE +
> +		SIRFSOC_PWRC_TRIGGER_EN) | (1 << PWR_WAKEEN_TS_SHIFT),
Perhaps use BIT(PWR_WAKEEN_TS_SHIFT)?
> +		SIRFSOC_PWRC_BASE + SIRFSOC_PWRC_TRIGGER_EN);
> +
> +	ret = device_reset(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to reset\n");
> +		goto err;
> +	}
> +
> +	writel(ADC_PRP_MODE3 | ADC_RTOUCH(1) | ADC_DEL_PRE(2) |
> +		ADC_DEL_DIS(5),  adc->base + ADC_CONTROL2);
> +
> +	/* Clear interrupts and enable PEN INTR */
> +	writel(readl(adc->base + ADC_INTR) | PEN_INTR | DATA_INTR |
> +		PEN_INTR_EN | DATA_INTR_EN,  adc->base + ADC_INTR);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ!\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, sirfsoc_adc_data_irq,
> +		0, DRIVER_NAME, indio_dev);
> +
no blank line here.
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register irq handler\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	ret = of_platform_populate(pdev->dev.of_node, sirfsoc_adc_of_match,
> +		NULL, &pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add child nodes\n");
> +		goto err;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register adc iio dev\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
use devm_iio_device_alloc and this error path goes away.
> +	iio_device_free(indio_dev);
> +	return ret;
> +}
> +
> +static int sirfsoc_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct sirfsoc_adc *adc = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	clk_disable_unprepare(adc->clk);
use devm_iio_device_alloc then you can drop this free.
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sirfsoc_adc_driver = {
> +	.driver = {
> +		.name	= DRIVER_NAME,
> +		.of_match_table = sirfsoc_adc_of_match,
> +		.pm	= &sirfsoc_adc_pm_ops,
> +	},
> +	.probe		= sirfsoc_adc_probe,
> +	.remove		= sirfsoc_adc_remove,
> +};
> +
> +module_platform_driver(sirfsoc_adc_driver);
> +
> +MODULE_AUTHOR("Guoying Zhang <Guoying.Zhang@csr.com>");
> +MODULE_DESCRIPTION("SiRF SoC On-chip ADC driver");
> +MODULE_LICENSE("GPL v2");
>

