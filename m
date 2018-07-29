Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeG2OBO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jul 2018 10:01:14 -0400
Date: Sun, 29 Jul 2018 13:30:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manish Narani <manish.narani@xilinx.com>
Cc: <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: adc: xilinx: Move request_irq before
 enabling interrupts
Message-ID: <20180729133050.0c5a38bf@archlinux>
In-Reply-To: <1532358123-23485-5-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-5-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Jul 2018 20:32:03 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> Enabling the Interrupts before registering the irq handler is a bad
> idea. This patch corrects the same for XADC driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 44a2519..3f6be5a 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1226,15 +1226,15 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_samplerate_trigger;
>  
> -	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
> -	if (ret)
> -		goto err_clk_disable_unprepare;
> -
>  	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
>  			dev_name(&pdev->dev), indio_dev);
>  	if (ret)
>  		goto err_clk_disable_unprepare;
>  
> +	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
> +	if (ret)
> +		goto err_free_irq;
> +
>  	for (i = 0; i < 16; i++)
>  		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
>  			&xadc->threshold[i]);

