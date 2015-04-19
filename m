Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39082 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbbDSMwK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 08:52:10 -0400
Message-ID: <5533A4F8.50209@kernel.org>
Date: Sun, 19 Apr 2015 13:52:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas Betker <thomas.betker@freenet.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [PATCH 4/5] iio: adc: xilinx: Fix VREFN sign
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-5-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-5-git-send-email-thomas.betker@freenet.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 20:11, Thomas Betker wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> The VREFN channel is bipolar, not unipolar. Small negative values do
> occur (e.g., -1mV), and unsigned conversion maps them incorrectly to
> large positive values (about +1V), so fix this.
> 
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
Applied to the fixes-togreg branch of iio.git. Marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 6fa629b..ce93bd8 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -997,7 +997,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
>  	.num_event_specs = (_alarm) ? ARRAY_SIZE(xadc_voltage_events) : 0, \
>  	.scan_index = (_scan_index), \
>  	.scan_type = { \
> -		.sign = 'u', \
> +		.sign = ((_addr) == XADC_REG_VREFN) ? 's' : 'u', \
>  		.realbits = 12, \
>  		.storagebits = 16, \
>  		.shift = 4, \
> 

