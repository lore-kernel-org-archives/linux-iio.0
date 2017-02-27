Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33519 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdB0RuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 12:50:12 -0500
Received: by mail-pf0-f194.google.com with SMTP id p185so869812pfb.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2017 09:50:12 -0800 (PST)
Date: Mon, 27 Feb 2017 09:50:10 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: iio: ad7192: Move
 contents of header file to source file
Message-ID: <20170227175009.GB1549@d830.WORKGROUP>
References: <20170226213557.GA4483@sayli-HP-15-Notebook-PC>
 <38e67a95-05ee-9a14-e6c7-83bfc68cd517@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38e67a95-05ee-9a14-e6c7-83bfc68cd517@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 27, 2017 at 10:18:58AM +0100, Lars-Peter Clausen wrote:
> On 02/26/2017 10:35 PM, sayli karnik wrote:
> > The contents of the header file are used only by this single
> > source file. Move content into .c and delete .h.
> 
> Hi,
> 
> Thanks for the patch, but this separation is on purpose. The header file
> contains the platform data struct which is supposed to be supplied to the
> driver form somewhere else. When the driver is moved out of staging the
> header will go into the global include/linux/platform_data/ folder.

Lars - Thanks on all of these!  I am updating the task description to
include this platform data exception you've described. 
alisons

> 
> > 
> > Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 38 ++++++++++++++++++++++++++++++--
> >  drivers/staging/iio/adc/ad7192.h | 47 ----------------------------------------
> >  2 files changed, 36 insertions(+), 49 deletions(-)
> >  delete mode 100644 drivers/staging/iio/adc/ad7192.h
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index 1fb68c0..a13e79d 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -25,8 +25,6 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/adc/ad_sigma_delta.h>
> >  
> > -#include "ad7192.h"
> > -
> >  /* Registers */
> >  #define AD7192_REG_COMM		0 /* Communications Register (WO, 8-bit) */
> >  #define AD7192_REG_STAT		0 /* Status Register	     (RO, 8-bit) */
> > @@ -166,6 +164,42 @@ struct ad7192_state {
> >  	struct ad_sigma_delta		sd;
> >  };
> >  
> > +/*
> > + * TODO: struct ad7192_platform_data needs to go into include/linux/iio
> > + */
> > +
> > +/**
> > + * struct ad7192_platform_data - platform/board specific information
> > + * @vref_mv:		the external reference voltage in millivolt
> > + * @clock_source_sel:	[0..3]
> > + *			0 External 4.92 MHz clock connected from MCLK1 to MCLK2
> > + *			1 External Clock applied to MCLK2
> > + *			2 Internal 4.92 MHz Clock not available at the MCLK2 pin
> > + *			3 Internal 4.92 MHz Clock available at the MCLK2 pin
> > + * @ext_clk_Hz:		the external clock frequency in Hz, if not set
> > + *			the driver uses the internal clock (16.776 MHz)
> > + * @refin2_en:		REFIN1/REFIN2 Reference Select (AD7190/2 only)
> > + * @rej60_en:		50/60Hz notch filter enable
> > + * @sinc3_en:		SINC3 filter enable (default SINC4)
> > + * @chop_en:		CHOP mode enable
> > + * @buf_en:		buffered input mode enable
> > + * @unipolar_en:	unipolar mode enable
> > + * @burnout_curr_en:	constant current generators on AIN(+|-) enable
> > + */
> > +
> > +struct ad7192_platform_data {
> > +	u16		vref_mv;
> > +	u8		clock_source_sel;
> > +	u32		ext_clk_hz;
> > +	bool		refin2_en;
> > +	bool		rej60_en;
> > +	bool		sinc3_en;
> > +	bool		chop_en;
> > +	bool		buf_en;
> > +	bool		unipolar_en;
> > +	bool		burnout_curr_en;
> > +};
> > +
> >  static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
> >  {
> >  	return container_of(sd, struct ad7192_state, sd);
> > diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> > deleted file mode 100644
> > index 7433a43..0000000
> > --- a/drivers/staging/iio/adc/ad7192.h
> > +++ /dev/null
> > @@ -1,47 +0,0 @@
> > -/*
> > - * AD7190 AD7192 AD7195 SPI ADC driver
> > - *
> > - * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> > - */
> > -#ifndef IIO_ADC_AD7192_H_
> > -#define IIO_ADC_AD7192_H_
> > -
> > -/*
> > - * TODO: struct ad7192_platform_data needs to go into include/linux/iio
> > - */
> > -
> > -/**
> > - * struct ad7192_platform_data - platform/board specific information
> > - * @vref_mv:		the external reference voltage in millivolt
> > - * @clock_source_sel:	[0..3]
> > - *			0 External 4.92 MHz clock connected from MCLK1 to MCLK2
> > - *			1 External Clock applied to MCLK2
> > - *			2 Internal 4.92 MHz Clock not available at the MCLK2 pin
> > - *			3 Internal 4.92 MHz Clock available at the MCLK2 pin
> > - * @ext_clk_Hz:		the external clock frequency in Hz, if not set
> > - *			the driver uses the internal clock (16.776 MHz)
> > - * @refin2_en:		REFIN1/REFIN2 Reference Select (AD7190/2 only)
> > - * @rej60_en:		50/60Hz notch filter enable
> > - * @sinc3_en:		SINC3 filter enable (default SINC4)
> > - * @chop_en:		CHOP mode enable
> > - * @buf_en:		buffered input mode enable
> > - * @unipolar_en:	unipolar mode enable
> > - * @burnout_curr_en:	constant current generators on AIN(+|-) enable
> > - */
> > -
> > -struct ad7192_platform_data {
> > -	u16		vref_mv;
> > -	u8		clock_source_sel;
> > -	u32		ext_clk_hz;
> > -	bool		refin2_en;
> > -	bool		rej60_en;
> > -	bool		sinc3_en;
> > -	bool		chop_en;
> > -	bool		buf_en;
> > -	bool		unipolar_en;
> > -	bool		burnout_curr_en;
> > -};
> > -
> > -#endif /* IIO_ADC_AD7192_H_ */
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/38e67a95-05ee-9a14-e6c7-83bfc68cd517%40metafoo.de.
> For more options, visit https://groups.google.com/d/optout.
