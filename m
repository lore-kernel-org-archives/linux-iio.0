Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeGURPm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:15:42 -0400
Date: Sat, 21 Jul 2018 17:22:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manish Narani <manish.narani@xilinx.com>
Cc: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <michal.simek@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudh@xilinx.com>,
        <sgoud@xilinx.com>
Subject: Re: [PATCH 2/4] iio: adc: xilinx: Remove dead code from
 xadc_zynq_setup
Message-ID: <20180721172221.7851fb25@archlinux>
In-Reply-To: <1531912331-26431-3-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Jul 2018 16:42:09 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> This patch removes dead code from xadc_zynq_setup. The condition
> "if (tck_rate > XADC_ZYNQ_TCK_RATE_MAX)" cannot be true at any point of
> time. There is also an incompatible parameter used in the code.
> This patch fixes the same reported by coverity.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to try and break it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 27b45df..248cffa 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -341,8 +341,6 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  
>  	pcap_rate = clk_get_rate(xadc->clk);
>  
> -	if (tck_rate > XADC_ZYNQ_TCK_RATE_MAX)
> -		tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
>  	if (tck_rate > pcap_rate / 2) {
>  		div = 2;
>  	} else {
> @@ -1045,7 +1043,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	unsigned int num_channels;
>  	const char *external_mux;
>  	u32 ext_mux_chan;
> -	int reg;
> +	u32 reg;
>  	int ret;
>  
>  	*conf = 0;

