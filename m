Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39070 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbDSMvP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 08:51:15 -0400
Message-ID: <5533A4C1.3030902@kernel.org>
Date: Sun, 19 Apr 2015 13:51:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas Betker <thomas.betker@freenet.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [PATCH 2/5] iio: adc: xilinx: Fix "vccaux" channel .address
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-3-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-3-git-send-email-thomas.betker@freenet.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 20:11, Thomas Betker wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> For the "vccaux" channel, read the VCCAUX register, not VCCINT.
> 
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
Applied to the fixes-togreg branch of iio.git. Marked for stable
Thanks
> ---
>  drivers/iio/adc/xilinx-xadc-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index a221f73..0ad7b50 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1008,7 +1008,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
>  static const struct iio_chan_spec xadc_channels[] = {
>  	XADC_CHAN_TEMP(0, 8, XADC_REG_TEMP),
>  	XADC_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
> -	XADC_CHAN_VOLTAGE(1, 10, XADC_REG_VCCINT, "vccaux", true),
> +	XADC_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
>  	XADC_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
>  	XADC_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpint", true),
>  	XADC_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpaux", true),
> 

