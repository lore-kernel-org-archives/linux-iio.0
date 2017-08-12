Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdHLMgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:36:40 -0400
Date: Sat, 12 Aug 2017 13:11:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iio: adc: Fix coding style violations
Message-ID: <20170812131135.02d90fce@archlinux>
In-Reply-To: <4d8fa659c811106d57122b24ae8e9c075dc8843a.1502346616.git.michal.simek@xilinx.com>
References: <4d8fa659c811106d57122b24ae8e9c075dc8843a.1502346616.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 Aug 2017 08:30:20 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> 
> This patch fix following checkpatch warnings in xadc driver
> 1. prefer 'unsigned int' to bare use of 'unsigned'.
> 2. else is not generally useful after a break or return.
> 3. fill all function definition arguments with identifier name
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmis@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
I've added the driver name to the title. Would have preferred it
as 3 patches fixing one issue each, but this is fine...

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
> Changes in v2:
> - Fix all functions definition arguments in header with identifier name
> - Change commit message to reflect v2 changes
>   both reported by: Joe Perches
> 
>  drivers/iio/adc/xilinx-xadc-events.c | 38 +++++++++++++++++-------------------
>  drivers/iio/adc/xilinx-xadc.h        | 10 +++++-----
>  2 files changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index 6d5c2a6f4e6e..dc0670308253 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -68,7 +68,7 @@ void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events)
>  		xadc_handle_event(indio_dev, i);
>  }
>  
> -static unsigned xadc_get_threshold_offset(const struct iio_chan_spec *chan,
> +static unsigned int xadc_get_threshold_offset(const struct iio_chan_spec *chan,
>  	enum iio_event_direction dir)
>  {
>  	unsigned int offset;
> @@ -90,26 +90,24 @@ static unsigned xadc_get_threshold_offset(const struct iio_chan_spec *chan,
>  
>  static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
>  {
> -	if (chan->type == IIO_TEMP) {
> +	if (chan->type == IIO_TEMP)
>  		return XADC_ALARM_OT_MASK;
> -	} else {
> -		switch (chan->channel) {
> -		case 0:
> -			return XADC_ALARM_VCCINT_MASK;
> -		case 1:
> -			return XADC_ALARM_VCCAUX_MASK;
> -		case 2:
> -			return XADC_ALARM_VCCBRAM_MASK;
> -		case 3:
> -			return XADC_ALARM_VCCPINT_MASK;
> -		case 4:
> -			return XADC_ALARM_VCCPAUX_MASK;
> -		case 5:
> -			return XADC_ALARM_VCCODDR_MASK;
> -		default:
> -			/* We will never get here */
> -			return 0;
> -		}
> +	switch (chan->channel) {
> +	case 0:
> +		return XADC_ALARM_VCCINT_MASK;
> +	case 1:
> +		return XADC_ALARM_VCCAUX_MASK;
> +	case 2:
> +		return XADC_ALARM_VCCBRAM_MASK;
> +	case 3:
> +		return XADC_ALARM_VCCPINT_MASK;
> +	case 4:
> +		return XADC_ALARM_VCCPAUX_MASK;
> +	case 5:
> +		return XADC_ALARM_VCCODDR_MASK;
> +	default:
> +		/* We will never get here */
> +		return 0;
>  	}
>  }
>  
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index f6f081965647..62edbdae1244 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -71,13 +71,13 @@ struct xadc {
>  };
>  
>  struct xadc_ops {
> -	int (*read)(struct xadc *, unsigned int, uint16_t *);
> -	int (*write)(struct xadc *, unsigned int, uint16_t);
> +	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
> +	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
>  	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
>  			int irq);
> -	void (*update_alarm)(struct xadc *, unsigned int);
> -	unsigned long (*get_dclk_rate)(struct xadc *);
> -	irqreturn_t (*interrupt_handler)(int, void *);
> +	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
> +	unsigned long (*get_dclk_rate)(struct xadc *xadc);
> +	irqreturn_t (*interrupt_handler)(int irq, void *devid);
>  
>  	unsigned int flags;
>  };

