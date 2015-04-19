Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39074 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbDSMvd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 08:51:33 -0400
Message-ID: <5533A4D4.2070604@kernel.org>
Date: Sun, 19 Apr 2015 13:51:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas Betker <thomas.betker@freenet.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [PATCH 3/5] iio: adc: xilinx: Fix VREFP scale
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-4-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-4-git-send-email-thomas.betker@freenet.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 20:11, Thomas Betker wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> The scaling factor for VREFP is 3.0/4096, not 1.0/4096; fix this to get
> correct readings.
> 
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
Applied to the fixes-togreg branch of iio.git.  Marked for stable.

Thanks,
> ---
>  drivers/iio/adc/xilinx-xadc-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0ad7b50..6fa629b 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -856,6 +856,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  			switch (chan->address) {
>  			case XADC_REG_VCCINT:
>  			case XADC_REG_VCCAUX:
> +			case XADC_REG_VREFP:
>  			case XADC_REG_VCCBRAM:
>  			case XADC_REG_VCCPINT:
>  			case XADC_REG_VCCPAUX:
> 

