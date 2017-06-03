Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdFCJpR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:45:17 -0400
Date: Sat, 3 Jun 2017 10:45:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: adc: twl4030: Fold twl4030-madc.h into driver
Message-ID: <20170603104243.65594ab2@jic23.retrosnub.co.uk>
In-Reply-To: <8139a4b1-92a9-02fa-c3fa-da4877e65ce4@kernel.org>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-8-sebastian.reichel@collabora.co.uk>
 <8139a4b1-92a9-02fa-c3fa-da4877e65ce4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 30 Apr 2017 17:38:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 27/04/17 16:30, Sebastian Reichel wrote:
> > twl4030-madc.h is no longer used by anything outside of
> > the iio driver, so it can be merged into the driver.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>  
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied.

Thanks

Jonathan
> > ---
> >  drivers/iio/adc/twl4030-madc.c   | 113 +++++++++++++++++++++++++++++++-
> >  include/linux/i2c/twl4030-madc.h | 137 ---------------------------------------
> >  2 files changed, 112 insertions(+), 138 deletions(-)
> >  delete mode 100644 include/linux/i2c/twl4030-madc.h
> > 
> > diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> > index 21df5b932bd1..bd3d37fc2144 100644
> > --- a/drivers/iio/adc/twl4030-madc.c
> > +++ b/drivers/iio/adc/twl4030-madc.c
> > @@ -36,7 +36,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/i2c/twl.h>
> > -#include <linux/i2c/twl4030-madc.h>
> >  #include <linux/module.h>
> >  #include <linux/stddef.h>
> >  #include <linux/mutex.h>
> > @@ -49,9 +48,121 @@
> >  
> >  #include <linux/iio/iio.h>
> >  
> > +#define TWL4030_MADC_MAX_CHANNELS 16
> > +
> > +#define TWL4030_MADC_CTRL1		0x00
> > +#define TWL4030_MADC_CTRL2		0x01
> > +
> > +#define TWL4030_MADC_RTSELECT_LSB	0x02
> > +#define TWL4030_MADC_SW1SELECT_LSB	0x06
> > +#define TWL4030_MADC_SW2SELECT_LSB	0x0A
> > +
> > +#define TWL4030_MADC_RTAVERAGE_LSB	0x04
> > +#define TWL4030_MADC_SW1AVERAGE_LSB	0x08
> > +#define TWL4030_MADC_SW2AVERAGE_LSB	0x0C
> > +
> > +#define TWL4030_MADC_CTRL_SW1		0x12
> > +#define TWL4030_MADC_CTRL_SW2		0x13
> > +
> > +#define TWL4030_MADC_RTCH0_LSB		0x17
> > +#define TWL4030_MADC_GPCH0_LSB		0x37
> > +
> > +#define TWL4030_MADC_MADCON	(1 << 0)	/* MADC power on */
> > +#define TWL4030_MADC_BUSY	(1 << 0)	/* MADC busy */
> > +/* MADC conversion completion */
> > +#define TWL4030_MADC_EOC_SW	(1 << 1)
> > +/* MADC SWx start conversion */
> > +#define TWL4030_MADC_SW_START	(1 << 5)
> > +#define TWL4030_MADC_ADCIN0	(1 << 0)
> > +#define TWL4030_MADC_ADCIN1	(1 << 1)
> > +#define TWL4030_MADC_ADCIN2	(1 << 2)
> > +#define TWL4030_MADC_ADCIN3	(1 << 3)
> > +#define TWL4030_MADC_ADCIN4	(1 << 4)
> > +#define TWL4030_MADC_ADCIN5	(1 << 5)
> > +#define TWL4030_MADC_ADCIN6	(1 << 6)
> > +#define TWL4030_MADC_ADCIN7	(1 << 7)
> > +#define TWL4030_MADC_ADCIN8	(1 << 8)
> > +#define TWL4030_MADC_ADCIN9	(1 << 9)
> > +#define TWL4030_MADC_ADCIN10	(1 << 10)
> > +#define TWL4030_MADC_ADCIN11	(1 << 11)
> > +#define TWL4030_MADC_ADCIN12	(1 << 12)
> > +#define TWL4030_MADC_ADCIN13	(1 << 13)
> > +#define TWL4030_MADC_ADCIN14	(1 << 14)
> > +#define TWL4030_MADC_ADCIN15	(1 << 15)
> > +
> > +/* Fixed channels */
> > +#define TWL4030_MADC_BTEMP	TWL4030_MADC_ADCIN1
> > +#define TWL4030_MADC_VBUS	TWL4030_MADC_ADCIN8
> > +#define TWL4030_MADC_VBKB	TWL4030_MADC_ADCIN9
> > +#define TWL4030_MADC_ICHG	TWL4030_MADC_ADCIN10
> > +#define TWL4030_MADC_VCHG	TWL4030_MADC_ADCIN11
> > +#define TWL4030_MADC_VBAT	TWL4030_MADC_ADCIN12
> > +
> > +/* Step size and prescaler ratio */
> > +#define TEMP_STEP_SIZE          147
> > +#define TEMP_PSR_R              100
> > +#define CURR_STEP_SIZE		147
> > +#define CURR_PSR_R1		44
> > +#define CURR_PSR_R2		88
> > +
> > +#define TWL4030_BCI_BCICTL1	0x23
> > +#define TWL4030_BCI_CGAIN	0x020
> > +#define TWL4030_BCI_MESBAT	(1 << 1)
> > +#define TWL4030_BCI_TYPEN	(1 << 4)
> > +#define TWL4030_BCI_ITHEN	(1 << 3)
> > +
> > +#define REG_BCICTL2             0x024
> > +#define TWL4030_BCI_ITHSENS	0x007
> > +
> > +/* Register and bits for GPBR1 register */
> > +#define TWL4030_REG_GPBR1		0x0c
> > +#define TWL4030_GPBR1_MADC_HFCLK_EN	(1 << 7)
> > +
> >  #define TWL4030_USB_SEL_MADC_MCPC	(1<<3)
> >  #define TWL4030_USB_CARKIT_ANA_CTRL	0xBB
> >  
> > +struct twl4030_madc_conversion_method {
> > +	u8 sel;
> > +	u8 avg;
> > +	u8 rbase;
> > +	u8 ctrl;
> > +};
> > +
> > +/**
> > + * struct twl4030_madc_request - madc request packet for channel conversion
> > + * @channels:	16 bit bitmap for individual channels
> > + * @do_avg:	sample the input channel for 4 consecutive cycles
> > + * @method:	RT, SW1, SW2
> > + * @type:	Polling or interrupt based method
> > + * @active:	Flag if request is active
> > + * @result_pending: Flag from irq handler, that result is ready
> > + * @raw:	Return raw value, do not convert it
> > + * @rbuf:	Result buffer
> > + */
> > +struct twl4030_madc_request {
> > +	unsigned long channels;
> > +	bool do_avg;
> > +	u16 method;
> > +	u16 type;
> > +	bool active;
> > +	bool result_pending;
> > +	bool raw;
> > +	int rbuf[TWL4030_MADC_MAX_CHANNELS];
> > +};
> > +
> > +enum conversion_methods {
> > +	TWL4030_MADC_RT,
> > +	TWL4030_MADC_SW1,
> > +	TWL4030_MADC_SW2,
> > +	TWL4030_MADC_NUM_METHODS
> > +};
> > +
> > +enum sample_type {
> > +	TWL4030_MADC_WAIT,
> > +	TWL4030_MADC_IRQ_ONESHOT,
> > +	TWL4030_MADC_IRQ_REARM
> > +};
> > +
> >  /**
> >   * struct twl4030_madc_data - a container for madc info
> >   * @dev:		Pointer to device structure for madc
> > diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
> > deleted file mode 100644
> > index 34e94747b61e..000000000000
> > --- a/include/linux/i2c/twl4030-madc.h
> > +++ /dev/null
> > @@ -1,137 +0,0 @@
> > -/*
> > - * twl4030_madc.h - Header for TWL4030 MADC
> > - *
> > - * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> > - * J Keerthy <j-keerthy@ti.com>
> > - *
> > - * This program is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU General Public License
> > - * version 2 as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful, but
> > - * WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program; if not, write to the Free Software
> > - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> > - * 02110-1301 USA
> > - *
> > - */
> > -
> > -#ifndef _TWL4030_MADC_H
> > -#define _TWL4030_MADC_H
> > -
> > -struct twl4030_madc_conversion_method {
> > -	u8 sel;
> > -	u8 avg;
> > -	u8 rbase;
> > -	u8 ctrl;
> > -};
> > -
> > -#define TWL4030_MADC_MAX_CHANNELS 16
> > -
> > -
> > -/*
> > - * twl4030_madc_request- madc request packet for channel conversion
> > - * @channels:	16 bit bitmap for individual channels
> > - * @do_avgP:	sample the input channel for 4 consecutive cycles
> > - * @method:	RT, SW1, SW2
> > - * @type:	Polling or interrupt based method
> > - * @raw:	Return raw value, do not convert it
> > - */
> > -
> > -struct twl4030_madc_request {
> > -	unsigned long channels;
> > -	bool do_avg;
> > -	u16 method;
> > -	u16 type;
> > -	bool active;
> > -	bool result_pending;
> > -	bool raw;
> > -	int rbuf[TWL4030_MADC_MAX_CHANNELS];
> > -};
> > -
> > -enum conversion_methods {
> > -	TWL4030_MADC_RT,
> > -	TWL4030_MADC_SW1,
> > -	TWL4030_MADC_SW2,
> > -	TWL4030_MADC_NUM_METHODS
> > -};
> > -
> > -enum sample_type {
> > -	TWL4030_MADC_WAIT,
> > -	TWL4030_MADC_IRQ_ONESHOT,
> > -	TWL4030_MADC_IRQ_REARM
> > -};
> > -
> > -#define TWL4030_MADC_CTRL1		0x00
> > -#define TWL4030_MADC_CTRL2		0x01
> > -
> > -#define TWL4030_MADC_RTSELECT_LSB	0x02
> > -#define TWL4030_MADC_SW1SELECT_LSB	0x06
> > -#define TWL4030_MADC_SW2SELECT_LSB	0x0A
> > -
> > -#define TWL4030_MADC_RTAVERAGE_LSB	0x04
> > -#define TWL4030_MADC_SW1AVERAGE_LSB	0x08
> > -#define TWL4030_MADC_SW2AVERAGE_LSB	0x0C
> > -
> > -#define TWL4030_MADC_CTRL_SW1		0x12
> > -#define TWL4030_MADC_CTRL_SW2		0x13
> > -
> > -#define TWL4030_MADC_RTCH0_LSB		0x17
> > -#define TWL4030_MADC_GPCH0_LSB		0x37
> > -
> > -#define TWL4030_MADC_MADCON	(1 << 0)	/* MADC power on */
> > -#define TWL4030_MADC_BUSY	(1 << 0)	/* MADC busy */
> > -/* MADC conversion completion */
> > -#define TWL4030_MADC_EOC_SW	(1 << 1)
> > -/* MADC SWx start conversion */
> > -#define TWL4030_MADC_SW_START	(1 << 5)
> > -#define TWL4030_MADC_ADCIN0	(1 << 0)
> > -#define TWL4030_MADC_ADCIN1	(1 << 1)
> > -#define TWL4030_MADC_ADCIN2	(1 << 2)
> > -#define TWL4030_MADC_ADCIN3	(1 << 3)
> > -#define TWL4030_MADC_ADCIN4	(1 << 4)
> > -#define TWL4030_MADC_ADCIN5	(1 << 5)
> > -#define TWL4030_MADC_ADCIN6	(1 << 6)
> > -#define TWL4030_MADC_ADCIN7	(1 << 7)
> > -#define TWL4030_MADC_ADCIN8	(1 << 8)
> > -#define TWL4030_MADC_ADCIN9	(1 << 9)
> > -#define TWL4030_MADC_ADCIN10	(1 << 10)
> > -#define TWL4030_MADC_ADCIN11	(1 << 11)
> > -#define TWL4030_MADC_ADCIN12	(1 << 12)
> > -#define TWL4030_MADC_ADCIN13	(1 << 13)
> > -#define TWL4030_MADC_ADCIN14	(1 << 14)
> > -#define TWL4030_MADC_ADCIN15	(1 << 15)
> > -
> > -/* Fixed channels */
> > -#define TWL4030_MADC_BTEMP	TWL4030_MADC_ADCIN1
> > -#define TWL4030_MADC_VBUS	TWL4030_MADC_ADCIN8
> > -#define TWL4030_MADC_VBKB	TWL4030_MADC_ADCIN9
> > -#define TWL4030_MADC_ICHG	TWL4030_MADC_ADCIN10
> > -#define TWL4030_MADC_VCHG	TWL4030_MADC_ADCIN11
> > -#define TWL4030_MADC_VBAT	TWL4030_MADC_ADCIN12
> > -
> > -/* Step size and prescaler ratio */
> > -#define TEMP_STEP_SIZE          147
> > -#define TEMP_PSR_R              100
> > -#define CURR_STEP_SIZE		147
> > -#define CURR_PSR_R1		44
> > -#define CURR_PSR_R2		88
> > -
> > -#define TWL4030_BCI_BCICTL1	0x23
> > -#define TWL4030_BCI_CGAIN	0x020
> > -#define TWL4030_BCI_MESBAT	(1 << 1)
> > -#define TWL4030_BCI_TYPEN	(1 << 4)
> > -#define TWL4030_BCI_ITHEN	(1 << 3)
> > -
> > -#define REG_BCICTL2             0x024
> > -#define TWL4030_BCI_ITHSENS	0x007
> > -
> > -/* Register and bits for GPBR1 register */
> > -#define TWL4030_REG_GPBR1		0x0c
> > -#define TWL4030_GPBR1_MADC_HFCLK_EN	(1 << 7)
> > -
> > -#endif
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

