Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeG2NSn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jul 2018 09:18:43 -0400
Date: Sun, 29 Jul 2018 12:48:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manish Narani <manish.narani@xilinx.com>
Cc: <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio: adc: xilinx: Check for return values in clk
 related functions
Message-ID: <20180729124826.74784bf2@archlinux>
In-Reply-To: <1532358123-23485-2-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Jul 2018 20:32:00 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> This patch adds check for return values from clock related functions.
> This was reported by static code analysis tool.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0127e85..23395fc 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -340,6 +340,8 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  	xadc->zynq_intmask = ~0;
>  
>  	pcap_rate = clk_get_rate(xadc->clk);
> +	if (!pcap_rate)
> +		return -EINVAL;
>  
>  	if (tck_rate > pcap_rate / 2) {
>  		div = 2;
> @@ -887,6 +889,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
>  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
>  	unsigned int div;
>  
> +	if (!clk_rate)
> +		return -EINVAL;
> +
>  	if (info != IIO_CHAN_INFO_SAMP_FREQ)
>  		return -EINVAL;
>  
> @@ -1237,8 +1242,10 @@ static int xadc_probe(struct platform_device *pdev)
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

