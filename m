Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35009 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab2BSQIu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2012 11:08:50 -0500
Message-ID: <4F411ECA.5020500@cam.ac.uk>
Date: Sun, 19 Feb 2012 16:09:46 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, grant.likely@secretlab.ca,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 4/4] iio: adc: New driver for AD9467 and AD9643 High-Speed
 LVDS ADCs
References: <1329482772-18054-1-git-send-email-michael.hennerich@analog.com> <1329482772-18054-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329482772-18054-4-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/17/2012 12:46 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Suitable FPGA interface HDL is available here:
> http://wiki.analog.com/resources/fpga/xilinx/fmc/ad9467

I don't know my way around the dma stuff so would appreciate review
for someone who does (if any such person is reading!)


Mostly for this one I would like a little more explanation of some
of the design descisions.
1) Registering as platform device rather than spi with extra bits.
    May well be cleaner this way around. If so please just briefly
    explain why.

2) Effectively embedded spi implementation rather than a separate
spi driver for the aim to spi stuff.
    I can see it would be fairly clunky given this only does very
    very special forms of spi, but it would cleanup this end by
    removing the special casing.

3) Separation (or lack there of) for the adc interface and the hardware
buffer implemented in the fpga.
    Probably tricky to pull off but a few lines saying where the problems
    lie would be informative.

A nice interest example and well written driver otherwise.  Couple
of things like documentation requests and small tidy ups inline.

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/adc/Kconfig          |   13 +
>  drivers/staging/iio/adc/Makefile         |    3 +
>  drivers/staging/iio/adc/cf_ad9467.h      |  161 ++++++++
>  drivers/staging/iio/adc/cf_ad9467_core.c |  585 ++++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/cf_ad9467_ring.c |  214 +++++++++++
>  5 files changed, 976 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/cf_ad9467.h
>  create mode 100644 drivers/staging/iio/adc/cf_ad9467_core.c
>  create mode 100644 drivers/staging/iio/adc/cf_ad9467_ring.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index d9decea..266e807 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -169,6 +169,19 @@ config AD7280
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7280a
>  
> +config CF_AD9467
> +	tristate "Analog Devices AD9467 AD9643 High-Speed ADC driver"
> +	select IIO_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices AD9467 and AD9643,
> +	  High-Speed LVDS analog to digital converters (ADC).
> +	  FPGA interface HDL is available here:
> +	  http://wiki.analog.com/resources/fpga/xilinx/fmc/ad9467
> +	  If unsure, say N (but it's safe to say "Y").
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cf_ad9467.
> +
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index ceee7f3..2f37d85 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -29,6 +29,9 @@ ad7298-y := ad7298_core.o
>  ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
>  obj-$(CONFIG_AD7298) += ad7298.o
>  
> +cf_ad9467-y := cf_ad9467_core.o cf_ad9467_ring.o
> +obj-$(CONFIG_CF_AD9467) += cf_ad9467.o
> +
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7780) += ad7780.o
>  obj-$(CONFIG_AD7793) += ad7793.o
> diff --git a/drivers/staging/iio/adc/cf_ad9467.h b/drivers/staging/iio/adc/cf_ad9467.h
> new file mode 100644
> index 0000000..1423e4c
> --- /dev/null
> +++ b/drivers/staging/iio/adc/cf_ad9467.h
> @@ -0,0 +1,161 @@
> +/*
> + * ADI-AIM ADI ADC Interface Module
> + *
> + * Copyright 2012 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + *
> + * http://wiki.analog.com/resources/fpga/xilinx/fmc/ad9467
> + */
> +
> +#ifndef ADI_AIM_H_
> +#define ADI_AIM_H_
> +
> +/* PCORE CoreFPGA register map */
> +
> +#define AD9467_PCORE_VERSION		0x00
> +#define AD9467_PCORE_SPI_CTRL		0x04
> +#define AD9467_PCORE_SPI_RDSTAT		0x08
> +#define AD9467_PCORE_DMA_CTRL		0x0C
> +#define AD9467_PCORE_DMA_STAT		0x10
> +#define AD9467_PCORE_ADC_STAT		0x14
> +#define AD9467_PCORE_PN_ERR_CTRL	0x24
> +
> +/* AD9467_PCORE_SPI_CTRL */
> +#define AD9647_SPI_START		(1 << 25)
> +#define AD9647_SPI_SEL(x)		(((x) & 0x1) << 24)
> +#define AD9647_SPI_READ			(1 << 23)
> +#define AD9647_SPI_WRITE		(0 << 23)
> +#define AD9647_SPI_ADDR(x)		(((x) & 0x1FFF) << 8)
> +#define AD9647_SPI_DATA(x)		(((x) & 0xFF) << 0)
> +
> +/* AD9467_PCORE_SPI_RDSTAT */
> +#define AD9647_SPI_IDLE			(1 << 8)
> +#define AD9647_SPI_READVAL(x)		((x) & 0xFF)
> +
> +/* AD9467_PCORE_DMA_CTRL */
> +#define AD9647_DMA_CAP_EN		(1 << 16)
> +#define AD9647_DMA_CNT(x)		(((x) & 0xFFFF) << 0)
> +
> +/* AD9467_PCORE_DMA_STAT */
> +#define AD9647_DMA_STAT_BUSY		(1 << 0)
> +#define AD9647_DMA_STAT_OVF		(1 << 1)
> +#define AD9647_DMA_STAT_UNF		(1 << 2)
> +
> +/* AD9467_PCORE_ADC_STAT */
> +#define AD9467_PCORE_ADC_STAT_OVR	(1 << 0)
> +#define AD9467_PCORE_ADC_STAT_PN_OOS	(1 << 1) /* W1C */
> +#define AD9467_PCORE_ADC_STAT_PN_ERR	(1 << 2) /* W1C */
> +
> +/* AD9467_PCORE_PN_ERR_CTRL */
> +#define AD9467_PN23_EN			(1 << 0)
> +#define AD9467_PN9_EN			(0 << 0)
> +
> +/*
> + * ADI High-Speed ADC common spi interface registers
> + * See Application-Note AN-877
> + */
> +
> +#define ADC_REG_CHIP_PORT_CONF		0x00
> +#define ADC_REG_CHIP_ID			0x01
> +#define ADC_REG_CHIP_GRADE		0x02
> +#define ADC_REG_TRANSFER		0xFF
> +#define ADC_REG_MODES			0x08
> +#define ADC_REG_TEST_IO			0x0D
> +#define ADC_REG_ADC_INPUT		0x0F
> +#define ADC_REG_OFFSET			0x10
> +#define ADC_REG_OUTPUT_MODE		0x14
> +#define ADC_REG_OUTPUT_ADJUST		0x15
> +#define ADC_REG_OUTPUT_PHASE		0x16
> +#define ADC_REG_OUTPUT_DELAY		0x17
> +#define ADC_REG_VREF			0x18
> +#define ADC_REG_ANALOG_INPUT		0x2C
> +
> +/* ADC_REG_TRANSFER */
> +#define TRANSFER_SYNC			0x1
> +
> +/* ADC_REG_TEST_IO */
> +#define TESTMODE_OFF			0x0
> +#define TESTMODE_MIDSCALE_SHORT		0x1
> +#define TESTMODE_POS_FULLSCALE		0x2
> +#define TESTMODE_NEG_FULLSCALE		0x3
> +#define TESTMODE_ALT_CHECKERBOARD	0x4
> +#define TESTMODE_PN23_SEQ		0x5
> +#define TESTMODE_PN9_SEQ		0x6
> +#define TESTMODE_ONE_ZERO_TOGGLE	0x7
> +
> +/* ADC_REG_OUTPUT_MODE */
> +#define OUTPUT_MODE_OFFSET_BINARY	0x0
> +#define OUTPUT_MODE_TWOS_COMPLEMENT	0x1
> +#define OUTPUT_MODE_GRAY_CODE		0x2
> +
> +/*
> + * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
> + */
> +
> +#define AD9467_DEF_OUTPUT_MODE		0x08
> +#define AD9467_REG_VREF_MASK		0x0F
> +#define CHIPID_AD9467			0x50
> +
> +/*
> + * Analog Devices AD9643 Dual 14-Bit, 170/210/250 MSPS ADC
> + */
> +
> +#define CHIPID_AD9643			0x82
> +#define AD9643_REG_VREF_MASK		0x1F
> +#define AD9643_DEF_OUTPUT_MODE		0x04
> +
> +enum {
> +	ID_AD9467,
> +	ID_AD9643,
> +};
> +
> +struct aim_chip_info {
> +	char				name[8];
> +	unsigned			num_channels;
> +	unsigned long			available_scan_masks[2];
> +	const int			(*scale_table)[2];
> +	int				num_scales;
> +	struct iio_chan_spec		channel[2];
> +};
> +
> +struct aim_state {
> +	struct spi_device		*spi;
> +	struct mutex			lock;
> +	struct completion		dma_complete;
> +	struct dma_chan			*rx_chan;
> +	const struct aim_chip_info	*chip_info;
> +	void __iomem			*regs;
> +	void				*buf_virt;
> +	dma_addr_t			buf_phys;
> +	unsigned			spi_ssel;
> +	unsigned			ring_lenght;
> +	unsigned			bytes_per_datum;
> +	unsigned			id;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
no blank line here and one above the comment perhaps?
> +
> +	unsigned char			data[3] ____cacheline_aligned;
> +};
> +
> +/*
> + * IO accessors
> + */
> +
> +static inline void aim_write(struct aim_state *st, unsigned reg, unsigned val)
> +{
> +	iowrite32(val, st->regs + reg);
> +}
> +
> +static inline unsigned int aim_read(struct aim_state *st, unsigned reg)
> +{
> +	return ioread32(st->regs + reg);
> +}
> +
> +void aim_register_ring_funcs(struct iio_dev *indio_dev);
> +int aim_configure_ring(struct iio_dev *indio_dev);
> +void aim_unconfigure_ring(struct iio_dev *indio_dev);
> +
> +#endif /* ADI_AIM_H_ */
> diff --git a/drivers/staging/iio/adc/cf_ad9467_core.c b/drivers/staging/iio/adc/cf_ad9467_core.c
> new file mode 100644
> index 0000000..811a659
> --- /dev/null
> +++ b/drivers/staging/iio/adc/cf_ad9467_core.c
> @@ -0,0 +1,585 @@
> +/*
> + * ADI-AIM ADI ADC Interface Module
> + *
> + * Copyright 2012 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + *
> + * http://wiki.analog.com/resources/fpga/xilinx/fmc/ad9467
> + */
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/wait.h>
> +#include <linux/spi/spi.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/delay.h>
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_spi.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../buffer.h"
> +
> +#include "cf_ad9467.h"
> +
> +static int aim_spi_read(struct aim_state *st, unsigned reg)
> +{
> +	unsigned long timeout = jiffies + HZ / 4;
> +	int ret;
> +
> +	if (st->spi) {
> +		unsigned char *buf = st->data;
> +		buf[0] = 0x80 | (reg >> 8);
> +		buf[1] = reg & 0xFF;
> +
> +		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		return buf[2];
> +	}
> +
> +	aim_write(st, AD9467_PCORE_SPI_CTRL, 0);
> +	aim_write(st, AD9467_PCORE_SPI_CTRL,
> +		AD9647_SPI_START |
> +		AD9647_SPI_READ |
> +		AD9647_SPI_SEL(st->spi_ssel) |
> +		AD9647_SPI_ADDR(reg));
> +
> +	while (!(aim_read(st, AD9467_PCORE_SPI_RDSTAT) & AD9647_SPI_IDLE)) {
> +		cpu_relax();
> +		if (time_after(jiffies, timeout))
> +			return -EIO;
> +	}
> +
> +	return AD9647_SPI_READVAL(aim_read(st, AD9467_PCORE_SPI_RDSTAT));
> +}
> +
> +static int aim_spi_write(struct aim_state *st, unsigned reg, unsigned val)
> +{
> +	unsigned long timeout = jiffies + HZ / 4;
> +
> +	int ret;
> +
> +	if (st->spi) {
> +		unsigned char *buf = st->data;
> +		buf[0] = reg >> 8;
> +		buf[1] = reg & 0xFF;
> +		buf[2] = val;
> +		ret = spi_write(st->spi, buf, 3);
> +		if (ret < 0)
> +			return ret;
> +
> +		return 0;
> +	}
> +
This is 'unusual'.  Perhaps it really should be a limited functionality
spi driver?
> +	aim_write(st, AD9467_PCORE_SPI_CTRL, 0);
> +	aim_write(st, AD9467_PCORE_SPI_CTRL,
> +		AD9647_SPI_START |
> +		AD9647_SPI_WRITE |
> +		AD9647_SPI_SEL(st->spi_ssel) |
> +		AD9647_SPI_ADDR(reg) |
> +		AD9647_SPI_DATA(val));
> +
> +
> +	while (!(aim_read(st, AD9467_PCORE_SPI_RDSTAT) & AD9647_SPI_IDLE)) {
> +		cpu_relax();
> +		if (time_after(jiffies, timeout))
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aim_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	if (inode->i_private)
> +		file->private_data = inode->i_private;
> +
> +	return 0;
> +}
> +
> +static ssize_t aim_debugfs_pncheck_read(struct file *file, char __user *userbuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev = file->private_data;
> +	struct aim_state *st = iio_priv(indio_dev);
> +	char buf[80], *p = buf;
> +	unsigned stat;
> +
> +	stat = aim_read(st, AD9467_PCORE_VERSION);
> +	p += sprintf(p, "%s %s\n", stat & AD9467_PCORE_ADC_STAT_PN_OOS ?
> +		"Out of Sync" : "", stat & AD9467_PCORE_ADC_STAT_PN_ERR ?
> +		"PN Error" : "");
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +}
> +
> +static ssize_t aim_debugfs_pncheck_write(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev = file->private_data;
> +	struct aim_state *st = iio_priv(indio_dev);
> +	unsigned mode;
> +	char buf[80], *p = buf;
> +
> +	count = min_t(size_t, count, (sizeof(buf)-1));
> +	if (copy_from_user(p, userbuf, count))
> +		return -EFAULT;
> +
> +	if (sysfs_streq(p, "PN9"))
> +		mode = TESTMODE_PN9_SEQ;
> +	else if (sysfs_streq(p, "PN23"))
> +		mode = TESTMODE_PN23_SEQ;
> +	else
> +		mode = TESTMODE_OFF;
> +
> +	aim_spi_write(st, ADC_REG_TEST_IO, mode);
> +	aim_spi_write(st, ADC_REG_TRANSFER, TRANSFER_SYNC);
> +
> +	aim_write(st, AD9467_PCORE_PN_ERR_CTRL, mode == TESTMODE_PN23_SEQ ?
> +		  AD9467_PN23_EN : AD9467_PN9_EN);
> +
> +	mdelay(1);
document why please.
> +
> +	aim_write(st, AD9467_PCORE_ADC_STAT,
> +		  AD9467_PCORE_ADC_STAT_PN_OOS |
> +		  AD9467_PCORE_ADC_STAT_PN_OOS |
> +		  AD9467_PCORE_ADC_STAT_OVR);
> +
> +	return count;
> +}
> +
> +static const struct file_operations aim_debugfs_pncheck_fops = {
> +	.open = aim_debugfs_open,
> +	.read = aim_debugfs_pncheck_read,
> +	.write = aim_debugfs_pncheck_write,
> +};
> +
> +static int aim_reg_access(struct iio_dev *indio_dev,
> +			      unsigned reg, unsigned writeval,
> +			      unsigned *readval)
> +{
> +	struct aim_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	if (readval == NULL) {
> +		ret = aim_spi_write(st, reg, writeval);
> +		aim_spi_write(st, ADC_REG_TRANSFER, TRANSFER_SYNC);
> +	} else {
> +		ret = aim_spi_read(st, reg);
> +		if (ret < 0)
> +			return ret;
> +		*readval = ret;
> +		ret = 0;
> +	}
Seems like an excess blank line....
> +
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int aim_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
> +{
> +	struct aim_state *st = iio_priv(indio_dev);
> +	int i;
> +	unsigned vref_val;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_val = aim_spi_read(st, ADC_REG_VREF) &
> +			(st->id == CHIPID_AD9643 ? AD9643_REG_VREF_MASK :
> +			AD9467_REG_VREF_MASK);
> +
> +		for (i = 0; i < st->chip_info->num_scales; i++)
> +			if (vref_val == st->chip_info->scale_table[i][1])
> +				break;
> +
> +		*val =  0;
> +		*val2 = st->chip_info->scale_table[i][0];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +
> +
> +static int aim_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct aim_state *st = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		for (i = 0; i < st->chip_info->num_scales; i++)
> +			if (val2 == st->chip_info->scale_table[i][0])
> +				break;
what if it isn't any of them?
> +
> +		aim_spi_write(st, ADC_REG_VREF,
> +			      st->chip_info->scale_table[i][1]);
> +		aim_spi_write(st, ADC_REG_TRANSFER, TRANSFER_SYNC);
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t aim_show_scale_available(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct aim_state *st = iio_priv(indio_dev);
> +	int i, len = 0;
> +
> +	for (i = 0; i < st->chip_info->num_scales; i++)
> +		len += sprintf(buf + len, "0.%06u ",
> +			       st->chip_info->scale_table[i][0]);
> +
> +	len += sprintf(buf + len, "\n");
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> +		       aim_show_scale_available, NULL, 0);
> +
> +static struct attribute *aim_attributes[] = {
> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group aim_attribute_group = {
> +	.attrs = aim_attributes,
> +};
> +
> +static const int ad9467_scale_table[][2] = {
> +	{30517, 0}, {32043, 6}, {33569, 7},
> +	{35095, 8}, {36621, 9}, {38146, 10},
> +};
> +
> +static const int ad9643_scale_table[][2] = {
> +	{31738, 0xF}, {31403, 0xE}, {31067, 0xD}, {30731, 0xC}, {30396, 0xB},
> +	{30060, 0xA}, {29724, 0x9}, {29388, 0x8}, {29053, 0x7}, {28717, 0x6},
> +	{28381, 0x5}, {28046, 0x4}, {27710, 0x3}, {27374, 0x2}, {27039, 0x1},
> +	{26703, 0x0}, {26367, 0x1F}, {26031, 0x1E}, {25696, 0x1D},
> +	{25360, 0x1C}, {25024, 0x1B}, {24689, 0x1A}, {24353, 0x19},
> +	{24017, 0x18}, {23682, 0x17}, {23346, 0x16}, {23010, 0x15},
> +	{22675, 0x14}, {22339, 0x13}, {22003, 0x12}, {21667, 0x11},
> +	{21332, 0x10},
> +};
> +
> +#define AIM_CHAN(_chan, _name, _si, _bits, _sign)			\
> +	{ .type = IIO_VOLTAGE,						\
> +	  .indexed = 1,							\
> +	  .extend_name = _name,						\
> +	  .channel = _chan,						\
> +	  .info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,			\
> +	  .scan_index = _si,						\
> +	  .scan_type =  IIO_ST(_sign, _bits, 16, 0)}
> +
> +static const struct aim_chip_info aim_chip_info_tbl[] = {
> +	[ID_AD9467] = {
> +		.name = "AD9467",
> +		.scale_table = ad9467_scale_table,
> +		.num_scales = ARRAY_SIZE(ad9467_scale_table),
> +		.num_channels = 1,
> +		.available_scan_masks[0] = BIT(0),
> +		.channel[0] = AIM_CHAN(0, NULL, 0, 16, 's'),
> +	},
> +	[ID_AD9643] = {
> +		.name = "AD9643",
> +		.scale_table = ad9643_scale_table,
> +		.num_scales = ARRAY_SIZE(ad9643_scale_table),
> +		.num_channels = 2,
> +		.available_scan_masks[0] = BIT(0) | BIT(1),
> +		.channel[0] = AIM_CHAN(0, "I", 0, 14, 'u'),
> +		.channel[1] = AIM_CHAN(1, "Q", 1, 14, 'u'),
> +	},
Why I and Q?  I clearly could be a quadrature pair of channels but
is there anything in inherent in the device forcing this?  Also
is this documented?
> +};
> +
> +static const struct iio_info aim_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &aim_read_raw,
> +	.write_raw = &aim_write_raw,
> +	.attrs = &aim_attribute_group,
> +	.debugfs_reg_access = aim_reg_access,
> +};
> +
> +struct aim_dma_params {
> +	struct device_node *of_node;
> +	int chan_id;
> +};
> +
> +static bool aim_dma_filter(struct dma_chan *chan, void *param)
> +{
> +	struct aim_dma_params *p = param;
> +
> +	return chan->device->dev->of_node == p->of_node &&
> +		chan->chan_id == p->chan_id;
> +}
> +
> +/**
> + * aim_of_probe - probe method for the AIM device.
> + * @of_dev:	pointer to OF device structure
> + * @match:	pointer to the structure used for matching a device
> + *
> + * This function probes the AIM device in the device tree.
> + * It initializes the driver data structure and the hardware.
> + * It returns 0, if the driver is bound to the AIM device, or a negative
> + * value if there is an error.
> + */
> +static int __devinit aim_of_probe(struct platform_device *op)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &op->dev;
> +	struct aim_state *st;
> +	struct resource r_mem; /* IO mem resources */
> +	struct spi_master *spi_master;
> +	struct device_node *nspi;
> +	struct aim_dma_params dma_params;
> +	struct of_phandle_args dma_spec;
> +	dma_cap_mask_t mask;
> +	resource_size_t remap_size, phys_addr;
> +	unsigned def_mode;
> +	int ret;
> +
> +	dev_info(dev, "Device Tree Probing \'%s\'\n",
> +		 op->dev.of_node->name);
> +
> +	/* Get iospace for the device */
> +	ret = of_address_to_resource(op->dev.of_node, 0, &r_mem);
> +	if (ret) {
> +		dev_err(dev, "invalid address\n");
> +		return ret;
> +	}
> +
> +	indio_dev = iio_allocate_device(sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	dev_set_drvdata(dev, indio_dev);
> +	mutex_init(&st->lock);
> +
> +	phys_addr = r_mem.start;
> +	remap_size = resource_size(&r_mem);
> +	if (!request_mem_region(phys_addr, remap_size, KBUILD_MODNAME)) {
> +		dev_err(dev, "Couldn't lock memory region at 0x%08llX\n",
> +			(unsigned long long)phys_addr);
> +		ret = -EBUSY;
> +		goto failed1;
> +	}
> +
> +	st->regs = ioremap(phys_addr, remap_size);
> +	if (st->regs == NULL) {
> +		dev_err(dev, "Couldn't ioremap memory at 0x%08llX\n",
> +			(unsigned long long)phys_addr);
> +		ret = -EFAULT;
> +		goto failed2;
> +	}
> +	/* Get dma channel for the device */
> +	ret = of_parse_phandle_with_args(op->dev.of_node, "dma-request",
> +					 "#dma-cells", 0, &dma_spec);
> +	if (ret) {
> +		dev_err(dev, "Couldn't parse dma-request\n");
> +		goto failed2;
> +	}
> +
> +	dma_params.of_node = dma_spec.np;
> +	dma_params.chan_id = dma_spec.args[0];
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE | DMA_PRIVATE, mask);
> +
> +	st->rx_chan = dma_request_channel(mask, aim_dma_filter, &dma_params);
> +	if (!st->rx_chan) {
> +		dev_err(dev, "failed to find rx dma device\n");
> +		goto failed2;
> +	}
> +	/*
> +	 * Get SPI configuration interface for the device
> +	 * We are platform_driver, so we need other means to get the
> +	 * associated control interface.
> +	 */
> +	ret = of_property_read_u32(op->dev.of_node,
> +				   "spibus-slaveselect-connected",
> +				   &st->spi_ssel);
> +	if (ret) {
> +		dev_err(dev, "failed to get connected SPI slave select\n");
> +		goto failed3;
> +	}
> +
> +	nspi = of_parse_phandle(op->dev.of_node, "spibus-connected", 0);
Could you explain decision to do registration like this.
(platform device and manual handling of spi register?)
Could do spi device with resources for platform pass into it for example.
I'm not arguing one way or the other, just would like to see your
thinking on this.

> +	spi_master = spi_of_node_to_master(nspi);
> +
> +	if (spi_master != NULL) {
> +		struct spi_board_info info = {
> +			.modalias = KBUILD_MODNAME,
> +			.max_speed_hz = 1000000,
> +			.chip_select = st->spi_ssel,
> +			.mode = SPI_MODE_0 | SPI_3WIRE,
> +		};
> +		st->spi = spi_new_device(spi_master, &info);
> +		if (st->spi == NULL) {
> +			dev_err(dev, "failed to add spi device\n");
> +			goto failed3;
> +		}
> +	} else {
> +		dev_dbg(dev, "could not find SPI master node,"
> +			"using pcore spi implementation\n");
> +	}
> +
> +	/* Probe device */
> +	st->id = aim_spi_read(st, ADC_REG_CHIP_ID);
> +
> +	switch (st->id) {
> +	case CHIPID_AD9467:
> +		st->chip_info = &aim_chip_info_tbl[ID_AD9467];
> +		def_mode = AD9467_DEF_OUTPUT_MODE | OUTPUT_MODE_TWOS_COMPLEMENT;
> +		break;
> +	case CHIPID_AD9643:
> +		st->chip_info = &aim_chip_info_tbl[ID_AD9643];
> +		def_mode = AD9643_DEF_OUTPUT_MODE | OUTPUT_MODE_OFFSET_BINARY;
> +		break;
> +	default:
> +		dev_err(dev, "Unrecognized CHIP_ID 0x%X\n", st->id);
> +		ret = -ENODEV;
> +		goto failed3;
> +	}
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = op->dev.of_node->name;
> +	indio_dev->channels = st->chip_info->channel;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->available_scan_masks = st->chip_info->available_scan_masks;
> +	indio_dev->info = &aim_info;
> +
> +	init_completion(&st->dma_complete);
> +
> +	aim_spi_write(st, ADC_REG_OUTPUT_MODE, def_mode);
> +	aim_spi_write(st, ADC_REG_TEST_IO, TESTMODE_OFF);
> +	aim_spi_write(st, ADC_REG_TRANSFER, TRANSFER_SYNC);
> +
> +	aim_configure_ring(indio_dev);
> +	aim_register_ring_funcs(indio_dev);
> +	ret = iio_buffer_register(indio_dev,
> +				  st->chip_info->channel,
> +				  ARRAY_SIZE(st->chip_info->channel));
> +	if (ret)
> +		goto failed4;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto failed4;
> +
> +	dev_info(dev, "ADI AIM (0x%X) at 0x%08llX mapped to 0x%p,"
> +		 " DMA-%d probed ADC %s\n",
> +		 aim_read(st, AD9467_PCORE_VERSION),
> +		 (unsigned long long)phys_addr, st->regs,
> +		 st->rx_chan->chan_id, st->chip_info->name);
> +
documented anywhere?
> +	if (indio_dev->debugfs_dentry)
> +		debugfs_create_file("pseudorandom_err_check", 0644,
> +					indio_dev->debugfs_dentry,
> +					indio_dev, &aim_debugfs_pncheck_fops);
> +
> +	return 0;
> +
> +failed4:
> +	aim_unconfigure_ring(indio_dev);
> +failed3:
> +	dma_release_channel(st->rx_chan);
> +failed2:
> +	release_mem_region(phys_addr, remap_size);
> +failed1:
> +	iio_free_device(indio_dev);
> +	dev_set_drvdata(dev, NULL);
> +
> +	return ret;
> +}
> +
> +/**
> + * aim_of_remove - unbinds the driver from the AIM device.
> + * @of_dev:	pointer to OF device structure
> + *
> + * This function is called if a device is physically removed from the system or
> + * if the driver module is being unloaded. It frees any resources allocated to
> + * the device.
> + */
> +static int __devexit aim_of_remove(struct platform_device *op)
> +{
> +	struct device *dev = &op->dev;
> +	struct resource r_mem; /* IO mem resources */
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct aim_state *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_buffer_unregister(indio_dev);
> +	aim_unconfigure_ring(indio_dev);
> +
> +	dma_release_channel(st->rx_chan);
> +
> +	iounmap(st->regs);
> +
> +	/* Get iospace of the device */
> +	if (of_address_to_resource(op->dev.of_node, 0, &r_mem))
> +		dev_err(dev, "invalid address\n");
> +	else
> +		release_mem_region(r_mem.start, resource_size(&r_mem));
> +
> +	iio_free_device(indio_dev);
> +
> +	dev_set_drvdata(dev, NULL);
> +
> +	return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id aim_of_match[] __devinitconst = {
> +	{ .compatible = "xlnx,cf-ad9467-core-1.00.a", },
> +	{ .compatible = "xlnx,cf-ad9643-core-1.00.a", },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, aim_of_match);
> +
> +static struct platform_driver aim_of_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = aim_of_match,
> +	},
> +	.probe		= aim_of_probe,
> +	.remove		= __devexit_p(aim_of_remove),
> +};
> +
> +module_platform_driver(aim_of_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> +MODULE_DESCRIPTION("Analog Devices ADI-AIM");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/adc/cf_ad9467_ring.c b/drivers/staging/iio/adc/cf_ad9467_ring.c
> new file mode 100644
> index 0000000..c6b2230
> --- /dev/null
> +++ b/drivers/staging/iio/adc/cf_ad9467_ring.c
> @@ -0,0 +1,214 @@
> +/*
> + * ADI-AIM ADC Interface Module
> + *
> + * Copyright 2012 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/poll.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../buffer.h"
> +#include "../ring_hw.h"
> +#include "cf_ad9467.h"
> +
> +static int aim_read_first_n_hw_rb(struct iio_buffer *r,
> +				      size_t count, char __user *buf)
> +{
> +	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
> +	struct iio_dev *indio_dev = hw_ring->private;
> +	struct aim_state *st = iio_priv(indio_dev);
> +	struct dma_async_tx_descriptor *desc;
> +	dma_cookie_t cookie;
> +	unsigned rcount;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (count == 0) {
> +		ret = -EINVAL;
> +		goto error_ret;
> +	}
> +
> +	if (count % 8)
> +		rcount = (count + 8) & 0xFFFFFFF8;
> +	else
> +		rcount = count;
> +
> +	st->buf_virt = dma_alloc_coherent(indio_dev->dev.parent,
> +					  PAGE_ALIGN(rcount), &st->buf_phys,
> +					  GFP_KERNEL);
> +	if (st->buf_virt == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(st->rx_chan, st->buf_phys, rcount,
> +					   DMA_FROM_DEVICE, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to allocate a dma descriptor\n");
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
> +
> +	desc->callback = (dma_async_tx_callback) complete;
> +	desc->callback_param = &st->dma_complete;
> +
> +	cookie = dmaengine_submit(desc);
> +	if (cookie < 0) {
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to submit a dma transfer\n");
> +		ret = cookie;
> +		goto error_free;
> +	}
> +
> +	dma_async_issue_pending(st->rx_chan);
> +
> +	aim_write(st, AD9467_PCORE_DMA_CTRL, 0);
> +	aim_read(st, AD9467_PCORE_DMA_STAT);
> +	aim_write(st, AD9467_PCORE_DMA_CTRL,
> +		  AD9647_DMA_CAP_EN | AD9647_DMA_CNT((rcount / 8) - 1));
> +
> +	ret = wait_for_completion_interruptible_timeout(&st->dma_complete,
> +							2 * HZ);
> +	if (ret == 0) {
> +		ret = -ETIMEDOUT;
> +		goto error_free;
> +	} else if (ret < 0) {
> +		goto error_free;
> +	}
> +
> +	if (copy_to_user(buf, st->buf_virt, count))
> +		ret = -EFAULT;
> +
> +error_free:
> +	dma_free_coherent(indio_dev->dev.parent, PAGE_ALIGN(rcount),
> +			  st->buf_virt, st->buf_phys);
> +	r->stufftoread = 0;
> +error_ret:
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : count;
> +}
> +
> +static int aim_ring_get_length(struct iio_buffer *r)
> +{
> +	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
> +	struct iio_dev *indio_dev = hw_ring->private;
> +	struct aim_state *st = iio_priv(indio_dev);
> +
> +	return st->ring_lenght;
> +}
> +
> +static int aim_ring_set_length(struct iio_buffer *r, int length)
> +{
> +	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
> +	struct iio_dev *indio_dev = hw_ring->private;
> +	struct aim_state *st = iio_priv(indio_dev);
could squish last two lines together without it getting harder
to follow.
> +
> +	st->ring_lenght = length;
lenght?
> +
> +	return 0;
> +}
> +
> +static int aim_ring_get_bytes_per_datum(struct iio_buffer *r)
> +{
> +	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
> +	struct iio_dev *indio_dev = hw_ring->private;
> +	struct aim_state *st = iio_priv(indio_dev);
> +
> +	return st->bytes_per_datum;
> +}
> +
> +static IIO_BUFFER_ENABLE_ATTR;
> +static IIO_BUFFER_LENGTH_ATTR;
> +
> +static struct attribute *aim_ring_attributes[] = {
> +	&dev_attr_length.attr,
> +	&dev_attr_enable.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group aim_ring_attr = {
> +	.attrs = aim_ring_attributes,
> +	.name = "buffer",
> +};
> +
> +static struct iio_buffer *aim_rb_allocate(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buf;
> +	struct iio_hw_buffer *ring;
> +
> +	ring = kzalloc(sizeof *ring, GFP_KERNEL);
> +	if (!ring)
> +		return NULL;
> +
> +	ring->private = indio_dev;
> +	buf = &ring->buf;
> +	buf->stufftoread = 0;
technically no need to zero as you just kzalloc'd this
> +	buf->attrs = &aim_ring_attr;
> +	iio_buffer_init(buf);
> +
> +	return buf;
> +}
> +
> +static inline void aim_rb_free(struct iio_buffer *r)
> +{
> +	kfree(iio_to_hw_buf(r));
> +}
> +
> +static const struct iio_buffer_access_funcs aim_ring_access_funcs = {
> +	.read_first_n = &aim_read_first_n_hw_rb,
> +	.get_length = &aim_ring_get_length,
> +	.set_length = &aim_ring_set_length,
> +	.get_bytes_per_datum = &aim_ring_get_bytes_per_datum,
> +};
> +
> +int aim_configure_ring(struct iio_dev *indio_dev)
> +{
> +	indio_dev->buffer = aim_rb_allocate(indio_dev);
> +	if (indio_dev->buffer == NULL)
> +		return -ENOMEM;
> +
> +	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> +	indio_dev->buffer->access = &aim_ring_access_funcs;
> +
> +	return 0;
> +}
> +
> +void aim_unconfigure_ring(struct iio_dev *indio_dev)
> +{
> +	aim_rb_free(indio_dev->buffer);
> +}
> +
These next three seem a little 'odd'.  Why have them at all?
I don't think you are obliged to provide any of the callbacks...
> +static inline int __aim_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
> +{
> +	return 0;
> +}
> +
> +static int aim_hw_ring_preenable(struct iio_dev *indio_dev)
> +{
> +	return __aim_hw_ring_state_set(indio_dev, 1);
> +}
> +
> +static int aim_hw_ring_postdisable(struct iio_dev *indio_dev)
> +{
> +	return __aim_hw_ring_state_set(indio_dev, 0);
> +}
> +
> +static const struct iio_buffer_setup_ops aim_ring_setup_ops = {
> +	.preenable = &aim_hw_ring_preenable,
> +	.postdisable = &aim_hw_ring_postdisable,
> +};
> +
> +void aim_register_ring_funcs(struct iio_dev *indio_dev)
> +{
> +	indio_dev->setup_ops = &aim_ring_setup_ops;
> +}

