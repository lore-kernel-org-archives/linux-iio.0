Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeG2NVY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jul 2018 09:21:24 -0400
Date: Sun, 29 Jul 2018 12:51:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manish Narani <manish.narani@xilinx.com>
Cc: <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency
 value
Message-ID: <20180729125106.05692a44@archlinux>
In-Reply-To: <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Jul 2018 20:32:01 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> This patch limits the xadc pcap clock frequency value to be less than
> 200MHz. This fixes the issue when zynq is booted at higher frequency
> values, pcap crosses the maximum limit of 200MHz(Fmax) as it is derived
> from IOPLL.
> If this limit is crossed it is required to alter the WEDGE and REDGE
> bits of XADC_CFG register to make timings better in the interface. So to
> avoid alteration of these bits every time, the pcap value should not
> cross the Fmax limit.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Applied, to the togreg branch of iio.git.  If you want this backported
to stable, then request it once this patch is upstream.  It may be
sometime given we've probably just missed the coming merge window.

If you do need it faster then let me know and I'll look at moving
it over to the branch of fixes during the RC phases.

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 23395fc..0dd306d 100644
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
> @@ -343,6 +345,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  	if (!pcap_rate)
>  		return -EINVAL;
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
> @@ -368,6 +377,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
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

