Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:60794 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeETLWx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 May 2018 07:22:53 -0400
Date: Sun, 20 May 2018 12:22:24 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        John Syne <john3909@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/4] staging:iio:meter: Drop ADE7758 driver
Message-ID: <20180520122224.0a01c764@archlinux>
In-Reply-To: <20180512175104.24797-4-Jonathan.Cameron@huawei.com>
References: <20180512175104.24797-1-Jonathan.Cameron@huawei.com>
        <20180512175104.24797-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 12 May 2018 18:51:03 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> I announced the intent to drop some of these meter drivers
> on the IIO list last cycle. This device is obsolete and not easily
> obtained.  No one has come forward with suitable test hardware and
> the driver would need a lot of work to move out of staging.
> 
> As such I am dropping it.  We can always bring it back again
> if a user / tester emerges in the future.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied.
> ---
>  drivers/staging/iio/meter/Kconfig           |  12 -
>  drivers/staging/iio/meter/Makefile          |   4 -
>  drivers/staging/iio/meter/ade7758.h         | 183 ----
>  drivers/staging/iio/meter/ade7758_core.c    | 955 --------------------
>  drivers/staging/iio/meter/ade7758_ring.c    | 177 ----
>  drivers/staging/iio/meter/ade7758_trigger.c | 108 ---
>  6 files changed, 1439 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
> index d60f052415c8..451ac47bb0cc 100644
> --- a/drivers/staging/iio/meter/Kconfig
> +++ b/drivers/staging/iio/meter/Kconfig
> @@ -3,18 +3,6 @@
>  #
>  menu "Active energy metering IC"
>  
> -config ADE7758
> -	tristate "Analog Devices ADE7758 Poly Phase Multifunction Energy Metering IC Driver"
> -	depends on SPI
> -	select IIO_TRIGGER if IIO_BUFFER
> -	select IIO_KFIFO_BUF if IIO_BUFFER
> -	help
> -	  Say yes here to build support for Analog Devices ADE7758 Polyphase
> -	  Multifunction Energy Metering IC with Per Phase Information Driver.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ade7758.
> -
>  config ADE7759
>  	tristate "Analog Devices ADE7759 Active Energy Metering IC Driver"
>  	depends on SPI
> diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
> index 42f4157969de..a36ff1668275 100644
> --- a/drivers/staging/iio/meter/Makefile
> +++ b/drivers/staging/iio/meter/Makefile
> @@ -3,10 +3,6 @@
>  # Makefile for metering ic drivers
>  #
>  
> -ade7758-y             := ade7758_core.o
> -ade7758-$(CONFIG_IIO_BUFFER) += ade7758_ring.o ade7758_trigger.o
> -obj-$(CONFIG_ADE7758) += ade7758.o
> -
>  obj-$(CONFIG_ADE7759) += ade7759.o
>  obj-$(CONFIG_ADE7854) += ade7854.o
>  obj-$(CONFIG_ADE7854_I2C) += ade7854-i2c.o
> diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
> deleted file mode 100644
> index 2de81b53e786..000000000000
> --- a/drivers/staging/iio/meter/ade7758.h
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -/*
> - * ADE7758 Poly Phase Multifunction Energy Metering IC driver
> - *
> - * Copyright 2010-2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -
> -#ifndef _ADE7758_H
> -#define _ADE7758_H
> -
> -#define ADE7758_AWATTHR   0x01
> -#define ADE7758_BWATTHR   0x02
> -#define ADE7758_CWATTHR   0x03
> -#define ADE7758_AVARHR    0x04
> -#define ADE7758_BVARHR    0x05
> -#define ADE7758_CVARHR    0x06
> -#define ADE7758_AVAHR     0x07
> -#define ADE7758_BVAHR     0x08
> -#define ADE7758_CVAHR     0x09
> -#define ADE7758_AIRMS     0x0A
> -#define ADE7758_BIRMS     0x0B
> -#define ADE7758_CIRMS     0x0C
> -#define ADE7758_AVRMS     0x0D
> -#define ADE7758_BVRMS     0x0E
> -#define ADE7758_CVRMS     0x0F
> -#define ADE7758_FREQ      0x10
> -#define ADE7758_TEMP      0x11
> -#define ADE7758_WFORM     0x12
> -#define ADE7758_OPMODE    0x13
> -#define ADE7758_MMODE     0x14
> -#define ADE7758_WAVMODE   0x15
> -#define ADE7758_COMPMODE  0x16
> -#define ADE7758_LCYCMODE  0x17
> -#define ADE7758_MASK      0x18
> -#define ADE7758_STATUS    0x19
> -#define ADE7758_RSTATUS   0x1A
> -#define ADE7758_ZXTOUT    0x1B
> -#define ADE7758_LINECYC   0x1C
> -#define ADE7758_SAGCYC    0x1D
> -#define ADE7758_SAGLVL    0x1E
> -#define ADE7758_VPINTLVL  0x1F
> -#define ADE7758_IPINTLVL  0x20
> -#define ADE7758_VPEAK     0x21
> -#define ADE7758_IPEAK     0x22
> -#define ADE7758_GAIN      0x23
> -#define ADE7758_AVRMSGAIN 0x24
> -#define ADE7758_BVRMSGAIN 0x25
> -#define ADE7758_CVRMSGAIN 0x26
> -#define ADE7758_AIGAIN    0x27
> -#define ADE7758_BIGAIN    0x28
> -#define ADE7758_CIGAIN    0x29
> -#define ADE7758_AWG       0x2A
> -#define ADE7758_BWG       0x2B
> -#define ADE7758_CWG       0x2C
> -#define ADE7758_AVARG     0x2D
> -#define ADE7758_BVARG     0x2E
> -#define ADE7758_CVARG     0x2F
> -#define ADE7758_AVAG      0x30
> -#define ADE7758_BVAG      0x31
> -#define ADE7758_CVAG      0x32
> -#define ADE7758_AVRMSOS   0x33
> -#define ADE7758_BVRMSOS   0x34
> -#define ADE7758_CVRMSOS   0x35
> -#define ADE7758_AIRMSOS   0x36
> -#define ADE7758_BIRMSOS   0x37
> -#define ADE7758_CIRMSOS   0x38
> -#define ADE7758_AWAITOS   0x39
> -#define ADE7758_BWAITOS   0x3A
> -#define ADE7758_CWAITOS   0x3B
> -#define ADE7758_AVAROS    0x3C
> -#define ADE7758_BVAROS    0x3D
> -#define ADE7758_CVAROS    0x3E
> -#define ADE7758_APHCAL    0x3F
> -#define ADE7758_BPHCAL    0x40
> -#define ADE7758_CPHCAL    0x41
> -#define ADE7758_WDIV      0x42
> -#define ADE7758_VADIV     0x44
> -#define ADE7758_VARDIV    0x43
> -#define ADE7758_APCFNUM   0x45
> -#define ADE7758_APCFDEN   0x46
> -#define ADE7758_VARCFNUM  0x47
> -#define ADE7758_VARCFDEN  0x48
> -#define ADE7758_CHKSUM    0x7E
> -#define ADE7758_VERSION   0x7F
> -
> -#define ADE7758_READ_REG(a)    a
> -#define ADE7758_WRITE_REG(a) ((a) | 0x80)
> -
> -#define ADE7758_MAX_TX    8
> -#define ADE7758_MAX_RX    4
> -#define ADE7758_STARTUP_DELAY 1000
> -
> -#define AD7758_NUM_WAVSEL	5
> -#define AD7758_NUM_PHSEL	3
> -#define AD7758_NUM_WAVESRC	(AD7758_NUM_WAVSEL * AD7758_NUM_PHSEL)
> -
> -#define AD7758_PHASE_A		0
> -#define AD7758_PHASE_B		1
> -#define AD7758_PHASE_C		2
> -#define AD7758_CURRENT		0
> -#define AD7758_VOLTAGE		1
> -#define AD7758_ACT_PWR		2
> -#define AD7758_REACT_PWR	3
> -#define AD7758_APP_PWR		4
> -#define AD7758_WT(p, w)		(((w) << 2) | (p))
> -
> -/**
> - * struct ade7758_state - device instance specific data
> - * @us:			actual spi_device
> - * @trig:		data ready trigger registered with iio
> - * @tx:			transmit buffer
> - * @rx:			receive buffer
> - * @buf_lock:		mutex to protect tx, rx, read and write frequency
> - **/
> -struct ade7758_state {
> -	struct spi_device	*us;
> -	struct iio_trigger	*trig;
> -	u8			*tx;
> -	u8			*rx;
> -	struct mutex		buf_lock;
> -	struct spi_transfer	ring_xfer[4];
> -	struct spi_message	ring_msg;
> -	/*
> -	 * DMA (thus cache coherency maintenance) requires the
> -	 * transfer buffers to live in their own cache lines.
> -	 */
> -	unsigned char		rx_buf[8] ____cacheline_aligned;
> -	unsigned char		tx_buf[8];
> -
> -};
> -
> -#ifdef CONFIG_IIO_BUFFER
> -/* At the moment triggers are only used for ring buffer
> - * filling. This may change!
> - */
> -
> -void ade7758_remove_trigger(struct iio_dev *indio_dev);
> -int ade7758_probe_trigger(struct iio_dev *indio_dev);
> -
> -ssize_t ade7758_read_data_from_ring(struct device *dev,
> -				    struct device_attribute *attr, char *buf);
> -
> -int ade7758_configure_ring(struct iio_dev *indio_dev);
> -void ade7758_unconfigure_ring(struct iio_dev *indio_dev);
> -
> -int ade7758_set_irq(struct device *dev, bool enable);
> -
> -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val);
> -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val);
> -
> -#else /* CONFIG_IIO_BUFFER */
> -
> -static inline void ade7758_remove_trigger(struct iio_dev *indio_dev)
> -{
> -}
> -
> -static inline int ade7758_probe_trigger(struct iio_dev *indio_dev)
> -{
> -	return 0;
> -}
> -
> -static int ade7758_configure_ring(struct iio_dev *indio_dev)
> -{
> -	return 0;
> -}
> -
> -static inline void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
> -{
> -}
> -
> -static inline int ade7758_initialize_ring(struct iio_ring_buffer *ring)
> -{
> -	return 0;
> -}
> -
> -static inline void ade7758_uninitialize_ring(struct iio_dev *indio_dev)
> -{
> -}
> -
> -#endif /* CONFIG_IIO_BUFFER */
> -
> -#endif
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> deleted file mode 100644
> index 4e0dbf5c5705..000000000000
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ /dev/null
> @@ -1,955 +0,0 @@
> -/*
> - * ADE7758 Poly Phase Multifunction Energy Metering IC driver
> - *
> - * Copyright 2010-2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include "meter.h"
> -#include "ade7758.h"
> -
> -static int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -
> -	st->tx[0] = ADE7758_WRITE_REG(reg_address);
> -	st->tx[1] = val;
> -
> -	return spi_write(st->us, st->tx, 2);
> -}
> -
> -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> -{
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	ret = __ade7758_spi_write_reg_8(dev, reg_address, val);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int ade7758_spi_write_reg_16(struct device *dev, u8 reg_address,
> -				    u16 value)
> -{
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7758_WRITE_REG(reg_address);
> -	st->tx[1] = (value >> 8) & 0xFF;
> -	st->tx[2] = value & 0xFF;
> -
> -	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int ade7758_spi_write_reg_24(struct device *dev, u8 reg_address,
> -				    u32 value)
> -{
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 4,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7758_WRITE_REG(reg_address);
> -	st->tx[1] = (value >> 16) & 0xFF;
> -	st->tx[2] = (value >> 8) & 0xFF;
> -	st->tx[3] = value & 0xFF;
> -
> -	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 1,
> -			.delay_usecs = 4,
> -		},
> -		{
> -			.tx_buf = &st->tx[1],
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 1,
> -		},
> -	};
> -
> -	st->tx[0] = ADE7758_READ_REG(reg_address);
> -	st->tx[1] = 0;
> -
> -	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = st->rx[0];
> -
> -error_ret:
> -	return ret;
> -}
> -
> -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	ret = __ade7758_spi_read_reg_8(dev, reg_address, val);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int ade7758_spi_read_reg_16(struct device *dev, u8 reg_address,
> -				   u16 *val)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 1,
> -			.delay_usecs = 4,
> -		},
> -		{
> -			.tx_buf = &st->tx[1],
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 2,
> -		},
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7758_READ_REG(reg_address);
> -	st->tx[1] = 0;
> -	st->tx[2] = 0;
> -
> -	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -
> -	*val = (st->rx[0] << 8) | st->rx[1];
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> -}
> -
> -static int ade7758_spi_read_reg_24(struct device *dev, u8 reg_address,
> -				   u32 *val)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 1,
> -			.delay_usecs = 4,
> -		},
> -		{
> -			.tx_buf = &st->tx[1],
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		},
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7758_READ_REG(reg_address);
> -	st->tx[1] = 0;
> -	st->tx[2] = 0;
> -	st->tx[3] = 0;
> -
> -	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->us->dev, "problem when reading 24 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> -}
> -
> -static ssize_t ade7758_read_8bit(struct device *dev,
> -				 struct device_attribute *attr, char *buf)
> -{
> -	int ret;
> -	u8 val = 0;
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = ade7758_spi_read_reg_8(dev, this_attr->address, &val);
> -	if (ret)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t ade7758_read_16bit(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	int ret;
> -	u16 val = 0;
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = ade7758_spi_read_reg_16(dev, this_attr->address, &val);
> -	if (ret)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t ade7758_read_24bit(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	int ret;
> -	u32 val = 0;
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = ade7758_spi_read_reg_24(dev, this_attr->address, &val);
> -	if (ret)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val & 0xFFFFFF);
> -}
> -
> -static ssize_t ade7758_write_8bit(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t len)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int ret;
> -	u8 val;
> -
> -	ret = kstrtou8(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = ade7758_spi_write_reg_8(dev, this_attr->address, val);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static ssize_t ade7758_write_16bit(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t len)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int ret;
> -	u16 val;
> -
> -	ret = kstrtou16(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = ade7758_spi_write_reg_16(dev, this_attr->address, val);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static int ade7758_reset(struct device *dev)
> -{
> -	int ret;
> -	u8 val;
> -
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_OPMODE, &val);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to read opmode reg\n");
> -		return ret;
> -	}
> -	val |= BIT(6); /* Software Chip Reset */
> -	ret = ade7758_spi_write_reg_8(dev, ADE7758_OPMODE, val);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to write opmode reg\n");
> -	return ret;
> -}
> -
> -static IIO_DEV_ATTR_VPEAK(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_VPEAK);
> -static IIO_DEV_ATTR_IPEAK(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_VPEAK);
> -static IIO_DEV_ATTR_APHCAL(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_APHCAL);
> -static IIO_DEV_ATTR_BPHCAL(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_BPHCAL);
> -static IIO_DEV_ATTR_CPHCAL(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_CPHCAL);
> -static IIO_DEV_ATTR_WDIV(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_WDIV);
> -static IIO_DEV_ATTR_VADIV(0644,
> -		ade7758_read_8bit,
> -		ade7758_write_8bit,
> -		ADE7758_VADIV);
> -static IIO_DEV_ATTR_AIRMS(0444,
> -		ade7758_read_24bit,
> -		NULL,
> -		ADE7758_AIRMS);
> -static IIO_DEV_ATTR_BIRMS(0444,
> -		ade7758_read_24bit,
> -		NULL,
> -		ADE7758_BIRMS);
> -static IIO_DEV_ATTR_CIRMS(0444,
> -		ade7758_read_24bit,
> -		NULL,
> -		ADE7758_CIRMS);
> -static IIO_DEV_ATTR_AVRMS(0444,
> -		ade7758_read_24bit,
> -		NULL,
> -		ADE7758_AVRMS);
> -static IIO_DEV_ATTR_BVRMS(0444,
> -		ade7758_read_24bit,
> -		NULL,
> -		ADE7758_BVRMS);
> -static IIO_DEV_ATTR_CVRMS(0444,
> -		ade7758_read_24bit,
> -		NULL,
> -		ADE7758_CVRMS);
> -static IIO_DEV_ATTR_AIRMSOS(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_AIRMSOS);
> -static IIO_DEV_ATTR_BIRMSOS(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_BIRMSOS);
> -static IIO_DEV_ATTR_CIRMSOS(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_CIRMSOS);
> -static IIO_DEV_ATTR_AVRMSOS(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_AVRMSOS);
> -static IIO_DEV_ATTR_BVRMSOS(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_BVRMSOS);
> -static IIO_DEV_ATTR_CVRMSOS(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_CVRMSOS);
> -static IIO_DEV_ATTR_AIGAIN(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_AIGAIN);
> -static IIO_DEV_ATTR_BIGAIN(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_BIGAIN);
> -static IIO_DEV_ATTR_CIGAIN(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_CIGAIN);
> -static IIO_DEV_ATTR_AVRMSGAIN(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_AVRMSGAIN);
> -static IIO_DEV_ATTR_BVRMSGAIN(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_BVRMSGAIN);
> -static IIO_DEV_ATTR_CVRMSGAIN(0644,
> -		ade7758_read_16bit,
> -		ade7758_write_16bit,
> -		ADE7758_CVRMSGAIN);
> -
> -int ade7758_set_irq(struct device *dev, bool enable)
> -{
> -	int ret;
> -	u32 irqen;
> -
> -	ret = ade7758_spi_read_reg_24(dev, ADE7758_MASK, &irqen);
> -	if (ret)
> -		return ret;
> -
> -	if (enable)
> -		irqen |= BIT(16); /* Enables an interrupt when a data is
> -				   * present in the waveform register
> -				   */
> -	else
> -		irqen &= ~BIT(16);
> -
> -	ret = ade7758_spi_write_reg_24(dev, ADE7758_MASK, irqen);
> -
> -	return ret;
> -}
> -
> -/* Power down the device */
> -static int ade7758_stop_device(struct device *dev)
> -{
> -	int ret;
> -	u8 val;
> -
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_OPMODE, &val);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to read opmode reg\n");
> -		return ret;
> -	}
> -	val |= 7 << 3;  /* ADE7758 powered down */
> -	ret = ade7758_spi_write_reg_8(dev, ADE7758_OPMODE, val);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to write opmode reg\n");
> -	return ret;
> -}
> -
> -static int ade7758_initial_setup(struct iio_dev *indio_dev)
> -{
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	struct device *dev = &indio_dev->dev;
> -	int ret;
> -
> -	/* use low spi speed for init */
> -	st->us->mode = SPI_MODE_1;
> -	spi_setup(st->us);
> -
> -	/* Disable IRQ */
> -	ret = ade7758_set_irq(dev, false);
> -	if (ret) {
> -		dev_err(dev, "disable irq failed");
> -		goto err_ret;
> -	}
> -
> -	ade7758_reset(dev);
> -	usleep_range(ADE7758_STARTUP_DELAY, ADE7758_STARTUP_DELAY + 100);
> -
> -err_ret:
> -	return ret;
> -}
> -
> -static int ade7758_read_samp_freq(struct device *dev, int *val)
> -{
> -	int ret;
> -	u8 t;
> -
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &t);
> -	if (ret)
> -		return ret;
> -
> -	t = (t >> 5) & 0x3;
> -	*val = 26040 / (1 << t);
> -
> -	return 0;
> -}
> -
> -static int ade7758_write_samp_freq(struct device *dev, int val)
> -{
> -	int ret;
> -	u8 reg, t;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -
> -	switch (val) {
> -	case 26040:
> -		t = 0;
> -		break;
> -	case 13020:
> -		t = 1;
> -		break;
> -	case 6510:
> -		t = 2;
> -		break;
> -	case 3255:
> -		t = 3;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	mutex_lock(&st->buf_lock);
> -
> -	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> -	if (ret)
> -		goto out;
> -
> -	reg &= ~(5 << 3);
> -	reg |= t << 5;
> -
> -	ret = __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
> -
> -out:
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int ade7758_read_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int *val,
> -			    int *val2,
> -			    long mask)
> -{
> -	int ret;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -
> -		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
> -
> -		return ret;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
> -static int ade7758_write_raw(struct iio_dev *indio_dev,
> -			     struct iio_chan_spec const *chan,
> -			     int val, int val2, long mask)
> -{
> -	int ret;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val2)
> -			return -EINVAL;
> -
> -		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -
> -		return ret;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
> -static IIO_DEV_ATTR_TEMP_RAW(ade7758_read_8bit);
> -static IIO_CONST_ATTR(in_temp_offset, "129 C");
> -static IIO_CONST_ATTR(in_temp_scale, "4 C");
> -
> -static IIO_DEV_ATTR_AWATTHR(ade7758_read_16bit,
> -		ADE7758_AWATTHR);
> -static IIO_DEV_ATTR_BWATTHR(ade7758_read_16bit,
> -		ADE7758_BWATTHR);
> -static IIO_DEV_ATTR_CWATTHR(ade7758_read_16bit,
> -		ADE7758_CWATTHR);
> -static IIO_DEV_ATTR_AVARHR(ade7758_read_16bit,
> -		ADE7758_AVARHR);
> -static IIO_DEV_ATTR_BVARHR(ade7758_read_16bit,
> -		ADE7758_BVARHR);
> -static IIO_DEV_ATTR_CVARHR(ade7758_read_16bit,
> -		ADE7758_CVARHR);
> -static IIO_DEV_ATTR_AVAHR(ade7758_read_16bit,
> -		ADE7758_AVAHR);
> -static IIO_DEV_ATTR_BVAHR(ade7758_read_16bit,
> -		ADE7758_BVAHR);
> -static IIO_DEV_ATTR_CVAHR(ade7758_read_16bit,
> -		ADE7758_CVAHR);
> -
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26040 13020 6510 3255");
> -
> -static struct attribute *ade7758_attributes[] = {
> -	&iio_dev_attr_in_temp_raw.dev_attr.attr,
> -	&iio_const_attr_in_temp_offset.dev_attr.attr,
> -	&iio_const_attr_in_temp_scale.dev_attr.attr,
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> -	&iio_dev_attr_awatthr.dev_attr.attr,
> -	&iio_dev_attr_bwatthr.dev_attr.attr,
> -	&iio_dev_attr_cwatthr.dev_attr.attr,
> -	&iio_dev_attr_avarhr.dev_attr.attr,
> -	&iio_dev_attr_bvarhr.dev_attr.attr,
> -	&iio_dev_attr_cvarhr.dev_attr.attr,
> -	&iio_dev_attr_avahr.dev_attr.attr,
> -	&iio_dev_attr_bvahr.dev_attr.attr,
> -	&iio_dev_attr_cvahr.dev_attr.attr,
> -	&iio_dev_attr_vpeak.dev_attr.attr,
> -	&iio_dev_attr_ipeak.dev_attr.attr,
> -	&iio_dev_attr_aphcal.dev_attr.attr,
> -	&iio_dev_attr_bphcal.dev_attr.attr,
> -	&iio_dev_attr_cphcal.dev_attr.attr,
> -	&iio_dev_attr_wdiv.dev_attr.attr,
> -	&iio_dev_attr_vadiv.dev_attr.attr,
> -	&iio_dev_attr_airms.dev_attr.attr,
> -	&iio_dev_attr_birms.dev_attr.attr,
> -	&iio_dev_attr_cirms.dev_attr.attr,
> -	&iio_dev_attr_avrms.dev_attr.attr,
> -	&iio_dev_attr_bvrms.dev_attr.attr,
> -	&iio_dev_attr_cvrms.dev_attr.attr,
> -	&iio_dev_attr_aigain.dev_attr.attr,
> -	&iio_dev_attr_bigain.dev_attr.attr,
> -	&iio_dev_attr_cigain.dev_attr.attr,
> -	&iio_dev_attr_avrmsgain.dev_attr.attr,
> -	&iio_dev_attr_bvrmsgain.dev_attr.attr,
> -	&iio_dev_attr_cvrmsgain.dev_attr.attr,
> -	&iio_dev_attr_airmsos.dev_attr.attr,
> -	&iio_dev_attr_birmsos.dev_attr.attr,
> -	&iio_dev_attr_cirmsos.dev_attr.attr,
> -	&iio_dev_attr_avrmsos.dev_attr.attr,
> -	&iio_dev_attr_bvrmsos.dev_attr.attr,
> -	&iio_dev_attr_cvrmsos.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ade7758_attribute_group = {
> -	.attrs = ade7758_attributes,
> -};
> -
> -static const struct iio_chan_spec ade7758_channels[] = {
> -	{
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
> -		.scan_index = 0,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_CURRENT,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
> -		.scan_index = 1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "apparent",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
> -		.scan_index = 2,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "active",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
> -		.scan_index = 3,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "reactive",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
> -		.scan_index = 4,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 1,
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
> -		.scan_index = 5,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_CURRENT,
> -		.indexed = 1,
> -		.channel = 1,
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
> -		.scan_index = 6,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 1,
> -		.extend_name = "apparent",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
> -		.scan_index = 7,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 1,
> -		.extend_name = "active",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
> -		.scan_index = 8,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 1,
> -		.extend_name = "reactive",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
> -		.scan_index = 9,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 2,
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
> -		.scan_index = 10,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_CURRENT,
> -		.indexed = 1,
> -		.channel = 2,
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
> -		.scan_index = 11,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 2,
> -		.extend_name = "apparent",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
> -		.scan_index = 12,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 2,
> -		.extend_name = "active",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
> -		.scan_index = 13,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	}, {
> -		.type = IIO_POWER,
> -		.indexed = 1,
> -		.channel = 2,
> -		.extend_name = "reactive",
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address = AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
> -		.scan_index = 14,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> -	},
> -	IIO_CHAN_SOFT_TIMESTAMP(15),
> -};
> -
> -static const struct iio_info ade7758_info = {
> -	.attrs = &ade7758_attribute_group,
> -	.read_raw = &ade7758_read_raw,
> -	.write_raw = &ade7758_write_raw,
> -};
> -
> -static int ade7758_probe(struct spi_device *spi)
> -{
> -	int ret;
> -	struct ade7758_state *st;
> -	struct iio_dev *indio_dev;
> -
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	/* Allocate the comms buffers */
> -	st->rx = kcalloc(ADE7758_MAX_RX, sizeof(*st->rx), GFP_KERNEL);
> -	if (!st->rx)
> -		return -ENOMEM;
> -	st->tx = kcalloc(ADE7758_MAX_TX, sizeof(*st->tx), GFP_KERNEL);
> -	if (!st->tx) {
> -		ret = -ENOMEM;
> -		goto error_free_rx;
> -	}
> -	st->us = spi;
> -	mutex_init(&st->buf_lock);
> -
> -	indio_dev->name = spi->dev.driver->name;
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->info = &ade7758_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ade7758_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ade7758_channels);
> -
> -	ret = ade7758_configure_ring(indio_dev);
> -	if (ret)
> -		goto error_free_tx;
> -
> -	/* Get the device into a sane initial state */
> -	ret = ade7758_initial_setup(indio_dev);
> -	if (ret)
> -		goto error_unreg_ring_funcs;
> -
> -	if (spi->irq) {
> -		ret = ade7758_probe_trigger(indio_dev);
> -		if (ret)
> -			goto error_unreg_ring_funcs;
> -	}
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_remove_trigger;
> -
> -	return 0;
> -
> -error_remove_trigger:
> -	if (spi->irq)
> -		ade7758_remove_trigger(indio_dev);
> -error_unreg_ring_funcs:
> -	ade7758_unconfigure_ring(indio_dev);
> -error_free_tx:
> -	kfree(st->tx);
> -error_free_rx:
> -	kfree(st->rx);
> -	return ret;
> -}
> -
> -static int ade7758_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	ade7758_stop_device(&indio_dev->dev);
> -	ade7758_remove_trigger(indio_dev);
> -	ade7758_unconfigure_ring(indio_dev);
> -	kfree(st->tx);
> -	kfree(st->rx);
> -
> -	return 0;
> -}
> -
> -static const struct spi_device_id ade7758_id[] = {
> -	{"ade7758", 0},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(spi, ade7758_id);
> -
> -static struct spi_driver ade7758_driver = {
> -	.driver = {
> -		.name = "ade7758",
> -	},
> -	.probe = ade7758_probe,
> -	.remove = ade7758_remove,
> -	.id_table = ade7758_id,
> -};
> -module_spi_driver(ade7758_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADE7758 Polyphase Multifunction Energy Metering IC Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> deleted file mode 100644
> index 6d7444d6e880..000000000000
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -/*
> - * ADE7758 Poly Phase Multifunction Energy Metering IC driver
> - *
> - * Copyright 2010-2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -#include <linux/export.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <asm/unaligned.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include "ade7758.h"
> -
> -/**
> - * ade7758_spi_read_burst() - read data registers
> - * @indio_dev: the IIO device
> - **/
> -static int ade7758_spi_read_burst(struct iio_dev *indio_dev)
> -{
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = spi_sync(st->us, &st->ring_msg);
> -	if (ret)
> -		dev_err(&st->us->dev, "problem when reading WFORM value\n");
> -
> -	return ret;
> -}
> -
> -static int ade7758_write_waveform_type(struct device *dev, unsigned int type)
> -{
> -	int ret;
> -	u8 reg;
> -
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> -	if (ret)
> -		goto out;
> -
> -	reg &= ~0x1F;
> -	reg |= type & 0x1F;
> -
> -	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
> -out:
> -	return ret;
> -}
> -
> -/* Whilst this makes a lot of calls to iio_sw_ring functions - it is too device
> - * specific to be rolled into the core.
> - */
> -static irqreturn_t ade7758_trigger_handler(int irq, void *p)
> -{
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	s64 dat64[2];
> -	u32 *dat32 = (u32 *)dat64;
> -
> -	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
> -		if (ade7758_spi_read_burst(indio_dev) >= 0)
> -			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, dat64, pf->timestamp);
> -
> -	iio_trigger_notify_done(indio_dev->trig);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * ade7758_ring_preenable() setup the parameters of the ring before enabling
> - *
> - * The complex nature of the setting of the number of bytes per datum is due
> - * to this driver currently ensuring that the timestamp is stored at an 8
> - * byte boundary.
> - **/
> -static int ade7758_ring_preenable(struct iio_dev *indio_dev)
> -{
> -	unsigned int channel;
> -
> -	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
> -		return -EINVAL;
> -
> -	channel = find_first_bit(indio_dev->active_scan_mask,
> -				 indio_dev->masklength);
> -
> -	ade7758_write_waveform_type(&indio_dev->dev,
> -				    indio_dev->channels[channel].address);
> -
> -	return 0;
> -}
> -
> -static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
> -	.preenable = &ade7758_ring_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> -};
> -
> -void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
> -{
> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_kfifo_free(indio_dev->buffer);
> -}
> -
> -int ade7758_configure_ring(struct iio_dev *indio_dev)
> -{
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	struct iio_buffer *buffer;
> -	int ret = 0;
> -
> -	buffer = iio_kfifo_allocate();
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
> -	indio_dev->setup_ops = &ade7758_ring_setup_ops;
> -
> -	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
> -						 &ade7758_trigger_handler,
> -						 0,
> -						 indio_dev,
> -						 "ade7759_consumer%d",
> -						 indio_dev->id);
> -	if (!indio_dev->pollfunc) {
> -		ret = -ENOMEM;
> -		goto error_iio_kfifo_free;
> -	}
> -
> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> -
> -	st->tx_buf[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
> -	st->tx_buf[1] = 0;
> -	st->tx_buf[2] = 0;
> -	st->tx_buf[3] = 0;
> -	st->tx_buf[4] = ADE7758_READ_REG(ADE7758_WFORM);
> -	st->tx_buf[5] = 0;
> -	st->tx_buf[6] = 0;
> -	st->tx_buf[7] = 0;
> -
> -	/* build spi ring message */
> -	st->ring_xfer[0].tx_buf = &st->tx_buf[0];
> -	st->ring_xfer[0].len = 1;
> -	st->ring_xfer[0].bits_per_word = 8;
> -	st->ring_xfer[0].delay_usecs = 4;
> -	st->ring_xfer[1].rx_buf = &st->rx_buf[1];
> -	st->ring_xfer[1].len = 3;
> -	st->ring_xfer[1].bits_per_word = 8;
> -	st->ring_xfer[1].cs_change = 1;
> -
> -	st->ring_xfer[2].tx_buf = &st->tx_buf[4];
> -	st->ring_xfer[2].len = 1;
> -	st->ring_xfer[2].bits_per_word = 8;
> -	st->ring_xfer[2].delay_usecs = 1;
> -	st->ring_xfer[3].rx_buf = &st->rx_buf[5];
> -	st->ring_xfer[3].len = 3;
> -	st->ring_xfer[3].bits_per_word = 8;
> -
> -	spi_message_init(&st->ring_msg);
> -	spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
> -	spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
> -	spi_message_add_tail(&st->ring_xfer[2], &st->ring_msg);
> -	spi_message_add_tail(&st->ring_xfer[3], &st->ring_msg);
> -
> -	return 0;
> -
> -error_iio_kfifo_free:
> -	iio_kfifo_free(indio_dev->buffer);
> -	return ret;
> -}
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> deleted file mode 100644
> index 4f6b338cffeb..000000000000
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -/*
> - * ADE7758 Poly Phase Multifunction Energy Metering IC driver
> - *
> - * Copyright 2010-2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/export.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/trigger.h>
> -#include "ade7758.h"
> -
> -/**
> - * ade7758_data_rdy_trig_poll() the event handler for the data rdy trig
> - **/
> -static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
> -{
> -	disable_irq_nosync(irq);
> -	iio_trigger_poll(private);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
> - **/
> -static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -					      bool state)
> -{
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> -
> -	dev_dbg(&indio_dev->dev, "(%d)\n", state);
> -	return ade7758_set_irq(&indio_dev->dev, state);
> -}
> -
> -/**
> - * ade7758_trig_try_reen() try renabling irq for data rdy trigger
> - * @trig:	the datardy trigger
> - **/
> -static int ade7758_trig_try_reen(struct iio_trigger *trig)
> -{
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -
> -	enable_irq(st->us->irq);
> -	/* irq reenabled so success! */
> -	return 0;
> -}
> -
> -static const struct iio_trigger_ops ade7758_trigger_ops = {
> -	.set_trigger_state = &ade7758_data_rdy_trigger_set_state,
> -	.try_reenable = &ade7758_trig_try_reen,
> -};
> -
> -int ade7758_probe_trigger(struct iio_dev *indio_dev)
> -{
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	st->trig = iio_trigger_alloc("%s-dev%d",
> -				     spi_get_device_id(st->us)->name,
> -				     indio_dev->id);
> -	if (!st->trig) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -
> -	ret = request_irq(st->us->irq,
> -			  ade7758_data_rdy_trig_poll,
> -			  IRQF_TRIGGER_LOW,
> -			  spi_get_device_id(st->us)->name,
> -			  st->trig);
> -	if (ret)
> -		goto error_free_trig;
> -
> -	st->trig->dev.parent = &st->us->dev;
> -	st->trig->ops = &ade7758_trigger_ops;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	ret = iio_trigger_register(st->trig);
> -
> -	/* select default trigger */
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -	if (ret)
> -		goto error_free_irq;
> -
> -	return 0;
> -
> -error_free_irq:
> -	free_irq(st->us->irq, st->trig);
> -error_free_trig:
> -	iio_trigger_free(st->trig);
> -error_ret:
> -	return ret;
> -}
> -
> -void ade7758_remove_trigger(struct iio_dev *indio_dev)
> -{
> -	struct ade7758_state *st = iio_priv(indio_dev);
> -
> -	iio_trigger_unregister(st->trig);
> -	free_irq(st->us->irq, st->trig);
> -	iio_trigger_free(st->trig);
> -}

