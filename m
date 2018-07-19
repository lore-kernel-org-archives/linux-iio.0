Return-Path: <SRS0=dn2Z=KD=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
To: Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: anirudh@xilinx.com, sgoud@xilinx.com
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
Date: Thu, 19 Jul 2018 18:40:26 +0200
MIME-Version: 1.0
In-Reply-To: <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 07/18/2018 01:12 PM, Manish Narani wrote:
> This patch adds check for return values from clock related functions.
> This was reported by static code analysis tool.

This patch seems to do something else.

> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 248cffa..47eb364 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -322,6 +322,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>  
>  #define XADC_ZYNQ_TCK_RATE_MAX 50000000
>  #define XADC_ZYNQ_IGAP_DEFAULT 20
> +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
>  
>  static int xadc_zynq_setup(struct platform_device *pdev,
>  	struct iio_dev *indio_dev, int irq)
> @@ -332,6 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  	unsigned int div;
>  	unsigned int igap;
>  	unsigned int tck_rate;
> +	int ret;
>  
>  	/* TODO: Figure out how to make igap and tck_rate configurable */
>  	igap = XADC_ZYNQ_IGAP_DEFAULT;
> @@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  
>  	pcap_rate = clk_get_rate(xadc->clk);
>  
> +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> +		ret = clk_set_rate(xadc->clk,
> +				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (tck_rate > pcap_rate / 2) {
>  		div = 2;
>  	} else {
> @@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
>  			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
>  
> +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> +		ret = clk_set_rate(xadc->clk, pcap_rate);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
>  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
>  	unsigned int div;
>  
> +	if (!clk_rate)
> +		return -EINVAL;
> +
>  	if (info != IIO_CHAN_INFO_SAMP_FREQ)
>  		return -EINVAL;
>  
> @@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  
>  	/* Disable all alarms */
> -	xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> -		XADC_CONF1_ALARM_MASK);
> +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> +				  XADC_CONF1_ALARM_MASK);
> +	if (ret)
> +		goto err_free_irq;
>  
>  	/* Set thresholds to min/max */
>  	for (i = 0; i < 16; i++) {
> 
